# Implementatie

## Opbouw van het project

Voor de implementatie van mijn JSON-parser heb ik het project opgesplitst in verschillende Haskell-modules.

- `JsonValue.hs`: bevat de datastructuur waarin de verschillende JSON-waarden worden opgeslagen.
- `Parser.hs`: bevat de functies die JSON-tekst verwerken en omzetten naar een `JsonValue`.
- `Main.hs`: bevat het startpunt van het programma, waarin ik JSON kan invoeren en het resultaat wordt getoond.

Door deze onderdelen te scheiden, blijft de parserlogica losstaan van het inlezen en tonen van gegevens.

## JSON-datastructuur

Om de verschillende JSON-waarden op te slaan, heb ik in `JsonValue.hs` een eigen datatype gemaakt:

```haskell
data JsonValue
    = JsonNull
    | JsonBoolean Bool
    | JsonNumber Double
    | JsonString String
    | JsonArray [JsonValue]
    | JsonObject [(String, JsonValue)]
    deriving (Show, Eq)
```

Met dit datatype kan ik de zes verschillende soorten JSON-waarden vertegenwoordigen. Een `JsonBoolean` bevat bijvoorbeeld een `Bool` en een `JsonNumber` bevat een `Double`.

Bij `JsonArray` wordt een lijst met `JsonValue`-waarden opgeslagen. Bij `JsonObject` wordt een lijst met sleutel-waardeparen opgeslagen, waarbij iedere sleutel een `String` is en iedere waarde opnieuw een `JsonValue`.

Omdat `JsonArray` en `JsonObject` opnieuw `JsonValue` kunnen bevatten, is dit een recursief datatype. Hierdoor kunnen ook geneste JSON-structuren worden opgeslagen.

## Parsertypes

In `Parser.hs` heb ik twee type-aliases gemaakt die door de verschillende parserfuncties worden gebruikt:

```haskell
type ParseResult a = Either String (a, String)
type Parser a = String -> ParseResult a
```

`ParseResult a` beschrijft het resultaat van een parser. Met `Either` kan een functie twee soorten resultaten teruggeven:

- `Left String`: het parsen is mislukt en er wordt een foutmelding teruggegeven.
- `Right (a, String)`: het parsen is gelukt. Hierbij wordt de geparste waarde (`a`) samen met de resterende invoer (`String`) teruggegeven.

De `a` is een typeparameter. Hierdoor kan hetzelfde resultaattype worden gebruikt voor verschillende soorten waarden, zoals een `Char`, `String` of `JsonValue`.

`Parser a` beschrijft een functie die een `String` ontvangt en een `ParseResult a` teruggeeft.

Een voorbeeld hiervan is:

```haskell
parseChar 'a' "abc"
-- Right ('a', "bc")
```

De parser herkent het eerste teken `a` en geeft dit terug samen met de resterende invoer `"bc"`.

Door de resterende invoer terug te geven, kan een volgende parser verdergaan waar de vorige parser is gestopt. Hierdoor kunnen kleinere parserfuncties samenwerken om ingewikkeldere JSON-waarden te verwerken.

## Basisfuncties

De JSON-parser is opgebouwd uit kleinere functies die ieder een gedeelte van de invoer verwerken. Twee van deze functies zijn parseChar en parseString. 

De functie parseChar controleert of het eerste teken van de invoer overeenkomt met een verwacht teken. Wanneer dit klopt, geeft de functie het gevonden teken en de resterende invoer terug. Wanneer het teken niet overeenkomt of de invoer leeg is, wordt een foutmelding teruggegeven.

De functie parseString gebruikt parseChar om een reeks verwachte tekens te controleren. Dit gebeurt recursief. Na ieder gevonden teken roept de functie zichzelf aan met de resterende tekens en invoer. Wanneer alle verwachte tekens zijn gevonden, stopt de recursie.

Deze functies worden bijvoorbeeld gebruikt om vaste JSON-waarden zoals null, true en false te herkennen.

Hierbij pas ik recursie toe in parseString en pattern matching om verschillende resultaten van de parser af te handelen. Daarnaast zijn beide functies puur, ze verwerken hun invoer en geven een resultaat terug zonder de oorspronkelijke invoer aan te passen.

## JSON-waarden herkennen

De functie `parseJsonValue` probeert te bepalen welk type JSON-waarde aan het begin van de invoer staat.

Hiervoor probeert de functie verschillende parsers, zoals `parseNull`, `parseBoolean`, `parseJsonString`, `parseNumber`, `parseArray` en `parseObject`.

Wanneer een parser succesvol is, wordt het resultaat teruggegeven. Wanneer een parser mislukt, wordt de volgende geprobeerd. Als geen van de parsers de invoer kan verwerken, geeft de functie een foutmelding terug.

Hierbij maak ik gebruik van `case`-expressies en pattern matching om onderscheid te maken tussen een geslaagd resultaat (`Right`) en een foutmelding (`Left`).

Doordat iedere JSON-waarde een eigen parserfunctie heeft, kan ik de verwerking opdelen in kleinere onderdelen. De functie `parseJsonValue` brengt deze onderdelen vervolgens samen.

Naast `parseJsonValue` heb ik ook de functie `parseJson` gemaakt. Deze functie roept `parseJsonValue` aan en controleert vervolgens of er nog onverwachte tekens overblijven. Hierdoor wordt bijvoorbeeld voorkomen dat een geldige JSON-waarde gevolgd door extra tekst toch als volledig geldige invoer wordt beschouwd.

## Recursie bij arrays en objecten

Voor het verwerken van arrays en objecten maak ik gebruik van recursie. Een array kan meerdere JSON-waarden bevatten en een object kan meerdere sleutel-waardeparen bevatten.

De functie `parseArrayValues` verwerkt de elementen van een array. Na het verwerken van een element controleert de functie of er nog een volgend element komt. Als dat zo is, wordt de functie opnieuw aangeroepen met de resterende invoer. Dit gaat door totdat het afsluitende teken `]` wordt gevonden.

Voor objecten gebruik ik `parseObjectPair` om een sleutel en de bijbehorende waarde te verwerken. De functie `parseObjectPairs` verwerkt vervolgens recursief de overige sleutel-waardeparen, totdat het afsluitende teken `}` wordt gevonden.

Bij het verwerken van een waarde wordt opnieuw `parseJsonValue` aangeroepen. Hierdoor kan een array bijvoorbeeld een object bevatten en kan dat object weer een andere array bevatten.

Een voorbeeld hiervan is:

```json
{
  "persoon": {
    "naam": "Ned",
    "getallen": [1, 2, 3]
  }
}
```

De parser verwerkt eerst het buitenste object en roept vervolgens de benodigde parserfuncties aan voor het binnenste object en de array.

Hierbij pas ik recursie toe om meerdere elementen te verwerken en om geneste JSON-structuren te ondersteunen. Ook gebruik ik pattern matching om te bepalen of er nog elementen volgen of dat het einde van een array of object is bereikt.

## Toepassing van functionele concepten

Tijdens het ontwikkelen van de JSON-parser heb ik verschillende functionele programmeerconcepten toegepast.

**Pure functions en immutability**

De parserfuncties ontvangen een invoerstring en geven een resultaat terug. Ze passen de oorspronkelijke invoer niet aan, maar geven de resterende tekst terug als onderdeel van het resultaat. Hierdoor kan iedere parserfunctie afzonderlijk worden getest.

**Recursie en pattern matching**

Recursie gebruik ik onder andere in `parseString`, `parseArrayValues` en `parseObjectPairs`. Hiermee kan ik meerdere tekens, array-elementen en sleutel-waardeparen verwerken.

Pattern matching gebruik ik om onderscheid te maken tussen verschillende vormen van invoer en resultaten. Bijvoorbeeld bij het controleren of een parser `Left` of `Right` teruggeeft.

**First-class functions en higher-order functions**

Een voorbeeld hiervan is `parseChar`, met het type:

```haskell
parseChar :: Char -> Parser Char
```

Deze functie ontvangt een verwacht teken en geeft een parserfunctie terug. Zo levert `parseChar 'a'` een functie op die controleert of de invoer met het teken `a` begint.

Dit laat zien dat functies in Haskell als waarden kunnen worden behandeld. De teruggegeven parserfunctie kan bijvoorbeeld onder een naam worden opgeslagen en later worden uitgevoerd. Omdat `parseChar` een functie teruggeeft, is het ook een higher-order function.

**Lazy evaluation**

Haskell gebruikt standaard lazy evaluation. Mijn parser maakt gebruik van Haskell, maar ik heb lazy evaluation niet bewust ingezet voor een specifieke optimalisatie.

## Invoer, uitvoer en testen

In `Main.hs` heb ik een eenvoudig programma gemaakt waarmee ik JSON kan invoeren. Met `getLine` wordt de invoer gelezen en vervolgens doorgegeven aan `parseJson`. Het resultaat wordt met `print` weergegeven.

```haskell
main :: IO ()
main = do
    putStrLn "Voer JSON in:"
    input <- getLine
    print (parseJson input)
```

Hierbij blijft de invoer en uitvoer gescheiden van de parserlogica. `Main.hs` gebruikt `IO` voor het verwerken van gebruikersinvoer en het tonen van resultaten, terwijl de parserfuncties zelf puur blijven.

Om de parser te testen, heb ik verschillende invoeren uitgevoerd via `cabal repl`. Hierbij heb ik onder andere getest of de parser losse JSON-waarden, arrays, objecten en geneste structuren kan verwerken.

Ook heb ik ongeldige invoer getest, zoals een array zonder afsluitend haakje en onverwachte tekens na een JSON-waarde. In deze gevallen geeft de parser een `Left` met een foutmelding terug.

De uitgevoerde tests laten zien dat de ondersteunde JSON-waarden verwerkt kunnen worden en dat verschillende vormen van ongeldige invoer worden herkend. Zoals eerder beschreven, ondersteunt mijn parser niet alle regels van de JSON-standaard.

Voorbeeld van een test:
```haskell
parseJson "[1, true, null]" 

geeft ->

-- Right (JsonArray [JsonNumber 1.0, JsonBoolean True, JsonNull])
```

Voorbeeld van ongeldige input:
```haskell
parseJson "[1, 2"

geeft ->

-- Left "Invalid JSON value"
```