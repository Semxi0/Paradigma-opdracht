module Main where

-- Een type-signature beschrijft de invoer en uitvoer van een functie.
-- Deze functie ontvangt een Int en geeft een Int terug.
double :: Int -> Int
double number = number * 2


-- Met -> worden meerdere parameters en het resultaat aangegeven.
-- Deze functie ontvangt twee Strings en geeft één String terug.
makeFullName :: String -> String -> String
makeFullName firstName lastName = firstName ++ " " ++ lastName


-- Een String is in Haskell een lijst van Char-waarden.
-- "Hallo" is dus vergelijkbaar met ['H', 'a', 'l', 'l', 'o'].
-- Met pattern matching controleren we de vorm van de lijst.
firstCharacter :: String -> Maybe Char
firstCharacter [] = Nothing
firstCharacter (first : _) = Just first


-- [] is een lege lijst.
-- (_ : _) betekent een lijst met minimaal één element.
-- De underscores betekenen dat we de waarden niet nodig hebben.
describeList :: [a] -> String
describeList [] = "De lijst is leeg"
describeList (_ : _) = "De lijst bevat minimaal een element"


-- Guards beginnen met een | en controleren voorwaarden van boven naar beneden.
describeNumber :: Int -> String
describeNumber number
    | number < 0 = "Het getal is negatief"
    | number == 0 = "Het getal is nul"
    | otherwise = "Het getal is positief"


-- Een eigen datatype kan uit meerdere constructors bestaan.
data Light
    = LightOn
    | LightOff
    deriving (Show, Eq)


-- Pattern matching kan ook op constructors van een datatype worden gebruikt.
toggleLight :: Light -> Light
toggleLight LightOn = LightOff
toggleLight LightOff = LightOn


-- Recursieve functie voor het berekenen van de lengte van een lijst.
listLength :: [a] -> Int

-- Stopconditie: een lege lijst bevat nul elementen.
listLength [] = 0

-- Recursieve stap:
-- negeer het eerste element, tel 1 en verwerk de resterende lijst.
listLength (_ : rest) = 1 + listLength rest


-- Deze functie verwijdert alleen spaties aan het begin van een String.
-- Ook dit gebruikt pattern matching en recursie.
removeLeadingSpaces :: String -> String

-- Stopconditie: bij lege invoer is het resultaat ook leeg.
removeLeadingSpaces [] = []

-- Als het eerste teken een spatie is, wordt de functie opnieuw
-- aangeroepen met de rest van de invoer.
removeLeadingSpaces (' ' : rest) = removeLeadingSpaces rest

-- Als het eerste teken geen spatie is, geven we de volledige
-- overgebleven invoer terug.
removeLeadingSpaces input = input


-- Maybe wordt gebruikt wanneer een resultaat wel of niet aanwezig kan zijn.
-- Just bevat een gevonden waarde.
-- Nothing betekent dat er geen waarde gevonden is.
findFirstEven :: [Int] -> Maybe Int
findFirstEven [] = Nothing
findFirstEven (number : rest)
    | even number = Just number
    | otherwise = findFirstEven rest


-- Either kan een fout of een succesvol resultaat bevatten.
-- Left gebruiken we hier voor een foutmelding.
-- Right gebruiken we voor het succesvolle resultaat.
safeDivide :: Double -> Double -> Either String Double
safeDivide _ 0 = Left "Delen door nul is niet toegestaan"
safeDivide numerator denominator =
    Right (numerator / denominator)


-- Een higher-order function ontvangt hier een andere functie als parameter.
-- De parameter function heeft zelf het type a -> a.
-- applyTwice voert deze functie twee keer uit.
applyTwice :: (a -> a) -> a -> a
applyTwice function value = function (function value)


-- map voert een functie uit op ieder element van een lijst.
-- doubleAll verdubbelt daardoor ieder getal.
doubleAll :: [Int] -> [Int]
doubleAll numbers = map double numbers


-- filter bewaart alleen elementen die aan een voorwaarde voldoen.
-- (> 0) is een functie die controleert of een getal positief is.
onlyPositive :: [Int] -> [Int]
onlyPositive numbers = filter (> 0) numbers


-- main wordt uitgevoerd wanneer we het bestand starten.
main :: IO ()
main = do
    print (double 5)
    print (makeFullName "Alex" "Jansen")
    print (firstCharacter "Hallo")
    print (firstCharacter "")
    print (describeList [1, 2, 3])
    print (describeNumber (-4))
    print (toggleLight LightOn)
    print (listLength ["a", "b", "c"])
    print (removeLeadingSpaces "   true")
    print (findFirstEven [1, 3, 6, 7])
    print (safeDivide 10 2)
    print (safeDivide 10 0)
    print (applyTwice double 3)
    print (doubleAll [1, 2, 3])
    print (onlyPositive [-2, 0, 3, 5])