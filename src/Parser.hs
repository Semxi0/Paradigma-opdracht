module Parser where

import JsonValue

-- ParseResult is een mogelijk resultaat van een parser
-- Left bevat een foutmelding en right bevat het gevonden resultaat en resterende invoer
type ParseResult a = Either String (a, String)

-- Parser is een functie die een String als invoer krijgt en een ParseResult teruggeeft
type Parser a = String -> ParseResult a

-- parseChar ontvangt het verwachte teken en geeft een parser terug
parseChar :: Char -> Parser Char

-- Een lege invoer kan nooit het verwachte resultaat bevatten
parseChar expected [] =
    Left ("Verwacht teken '" ++ [expected] ++ "', maar de invoer is leeg.")

-- Pattern matching gebruikt om de invoer te splitsen
parseChar expected (actual : rest)
-- Als het eerste teken klopt, geven we het teken en de rest terug
    | actual == expected = Right (actual, rest)
-- Anders een foutmelding 
    | otherwise = 
        Left ("Verwacht teken '" ++ [expected] ++ "', maar vond '" ++ [actual] ++ "'.")
        
-- parseString ontvangt een verwachte String en geeft een parser terug
parseString :: String -> Parser String

-- Dit is de stopconditie
-- Als er geen verwachte tekens meer zijn, is de volledige verwachte String gevonden
parseString [] input = Right ("", input)

-- Pattern matching splitst verwachte String op
parseString (expected : restExpected) input =
    case parseChar expected input of
        -- Als er iets niet klopt geef foutmelding van parseChar
        Left errorMsg -> Left errorMsg

-- Als het klopt gebruik gevonden teken en de rest
        Right (parsedChar, restInput) ->
            -- recursief aanroepen met overgebleven waardes
            case parseString restExpected restInput of
                Left errorMsg -> Left errorMsg

-- Als alles klopt, bouw de gevonden String op
-- en geef overgebleven String terug
                Right (actualRest, finalInput) ->
                    Right (parsedChar : actualRest, finalInput)


parseNull :: Parser JsonValue
parseNull input =
    case parseString "null" input of
        Left errorMsg -> Left errorMsg

-- Verander JSON null naar JsonNull en geef rest waarde terug
        Right (_, restInput) -> Right (JsonNull, restInput)


parseBoolean :: Parser JsonValue
parseBoolean input =
    case parseString "true" input of
        -- Verander JSON true naar JsonBoolean True en geef rest waarde terug
        Right (_, restInput) -> Right (JsonBoolean True, restInput)

-- Negeer fout voor nu en kijk of het misschien false is
        Left _ ->
            case parseString "false" input of
                -- Verander JSON false naar JsonBoolean False en geef rest waarde terug
                Right (_, restInput) -> Right (JsonBoolean False, restInput)
                Left errorMsg -> Left errorMsg