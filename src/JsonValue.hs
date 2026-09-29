module JsonValue where

-- JsonValue beschrijft alle soorten waarden die in JSON kunnen voorkomen
data JsonValue 
    -- De JSON-waarde null bevat geen waarde
    = JsonNull
    -- JSON-booleaan koppelen aan een Haskell Bool
    | JsonBoolean Bool
    -- JSON-getal koppelen aan een Haskell Double
    | JsonNumber Double
    -- JSON-string koppelen aan een Haskell String
    | JsonString String
    -- JSON-array koppelen aan een Haskell-lijst van JsonValue
    -- JsonArray is recursief, want JsonValue zit erin
    | JsonArray [JsonValue]
    -- JSON-object bevat een lijst met sleutel-waardeparen
    -- De sleutel is een String en de waarde kan iedere JsonValue zijn
    | JsonObject [(String, JsonValue)]
    -- JsonValue kan worden weergegeven als een String door Show en het kan vergeleken met andere JsonValue met Eq
    deriving (Show, Eq)



