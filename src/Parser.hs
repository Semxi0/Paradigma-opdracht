module Parser where

-- ParseResult is een mogelijke resultaat van een parser
-- Left bevat een foutmelding en right bevat het gevonden resultaat en resterende invoer
type ParseResult a = Either String (a, String)

-- Parser is een functie die een string als invoer krijgt en een ParseResult teruggeeft
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
        