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

-- Leest tekens totdat het een " raakt
parseStringContent :: Parser String
-- 1e stopconditie voor als invoer leeg is 
parseStringContent [] = Left "String isn't closed with a quote."

-- 2e stopconditie als het eerste teken een " is"
parseStringContent ( '"' : rest) = Right ("", rest)

-- Eerste teken wordt bewaard en de rest word recursief verwerkt
parseStringContent (char : rest) =
    case parseStringContent rest of
        Left errorMsg -> Left errorMsg
        Right (parsedRest, finalInput) -> Right (char : parsedRest, finalInput)

-- Haalt alle cijfers uit de invoer en geeft de rest terug
parseDigits :: Parser String
-- Stopconditie voor als invoer leeg is
parseDigits [] = Right ("", "")

-- Bewaar de volledige invoer als input en splits het op
parseDigits input@(char : rest)
    | char >= '0' && char <= '9' =
        case parseDigits rest of
            Left errorMsg -> Left errorMsg
            Right (parsedRest, finalInput) -> Right (char : parsedRest, finalInput)

    | otherwise = Right ("", input)

-- Leest de tekst van een getal en geeft rest invoer terug
readNumberText :: String -> (String, String)

-- Als getal negatief, bewaar - en ga verder
readNumberText ('-' : rest) =
    let (digits, restInput) = readNumberText rest
    in ('-' : digits, restInput)

readNumberText input =
    case parseDigits input of
        Left _ -> ("", input)
        Right (digits, restInput) ->
            -- Kijk of er decimale cijfers zijn
            case restInput of
                ('.' : afterDot) ->
                    case parseDigits afterDot of
                        Left _ -> (digits, restInput) 
                        Right (decimalDigits, finalInput) ->
                            if decimalDigits == ""
                                then (digits, restInput) -- Geen decimale cijfers, dus geef alleen de cijfers terug (en rest)
                                else (digits ++ "." ++ decimalDigits, finalInput)
                -- Geen punt, dus geef cijfers en rest terug
                _ -> (digits, restInput)

-- parsed de waarden binnen een JSON array
parseArrayValues :: Parser [JsonValue]
parseArrayValues input =
    -- parsed eerste waarde
    case parseJsonValue (skipWhitespace input) of
        Left errorMsg -> Left errorMsg

        Right (value, restInput) ->
            let cleanInput = skipWhitespace restInput
            in
                case cleanInput of
                    -- einde van array gevonden
                    (']' : rest) ->
                        Right ([value], rest)

                    -- er zijn meer waardes in de array
                    (',' : rest) ->
                        case parseArrayValues rest of
                            Left errorMsg -> Left errorMsg

                            Right (values, finalInput) ->
                                Right (value : values, finalInput)

                    -- bij ongeldige JSON array
                    _ ->
                        Left "Expected ',' or ']' in array."

-- parsed een JSON null naar JsonNull
parseNull :: Parser JsonValue
parseNull input =
    case parseString "null" input of
        Left errorMsg -> Left errorMsg

-- Verander JSON null naar JsonNull en geef rest waarde terug
        Right (_, restInput) -> Right (JsonNull, restInput)

-- parsed een JSON String naar JsonString
parseJsonString :: Parser JsonValue
parseJsonString input =
    case parseChar '"' input of
        Left errorMsg -> Left errorMsg

        Right (_, restInput) ->
            case parseStringContent restInput of
                Left errorMsg -> Left errorMsg

-- Zet de gevonden inhoud om naar JsonString en geef de rest terug
                Right (content, finalInput) -> Right (JsonString content, finalInput)

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

-- Parsed een getal naar JsonNumber
parseNumber :: Parser JsonValue
parseNumber input = 
    -- Haalt getal als tekst en resterende invoer op
    let (numberText, restInput) = readNumberText input
    in
        if numberText == "" || numberText == "-"
            then Left "Invalid number."
            -- Zet tekst om naar double, dan naar JsonNumber
            else Right (JsonNumber (read numberText), restInput)

-- parsed een JSON array
parseArray :: Parser JsonValue
parseArray input =
    case parseChar '[' input of
        Left errorMsg -> Left errorMsg

        Right (_, restInput) ->
            let cleanInput = skipWhitespace restInput
            in
                case cleanInput of
                    -- lege array
                    (']' : rest) ->
                        Right (JsonArray [], rest)
                    
                    -- array met een of meerdere waarden
                    _ ->
                        case parseArrayValues cleanInput of
                            Left errorMsg -> Left errorMsg

                            Right (values, finalInput) ->
                                Right (JsonArray values, finalInput)

-- Haalt whitespaces weg aan begin
skipWhitespace :: String -> String
-- Stopconditie. Als invoer leeg, geef leeg terug
skipWhitespace [] = []
-- Check of het een spatie, nieuwe regel of tab is
skipWhitespace (char : rest)
    | char == ' ' || char == '\n' || char == '\t' = skipWhitespace rest

    | otherwise = char : rest

-- Kiest welke JSON-parser gebruikt moet worden
parseJsonValue :: Parser JsonValue
parseJsonValue input =
    -- Haalt whitespaces weg (bij begin)
    let cleanInput = skipWhitespace input
    in 
        -- Probeert alle parsers
        -- Negeer fout, want het kan voor een andere parser zijn
        case parseNull cleanInput of
            Right result -> Right result
            Left _ ->
                case parseBoolean cleanInput of
                    Right result -> Right result
                    Left _ ->
                        case parseJsonString cleanInput of
                            Right result -> Right result
                            Left _ ->
                                case parseNumber cleanInput of
                                    Right result -> Right result
                                    Left _ ->
                                        case parseArray cleanInput of
                                            Right result -> Right result
                                            Left _ -> Left "Invalid JSON value"

