#  Onderzoeksnotities

## Wat is een parser?
Een parser is een programma of functie die invoer leest en deze volgens bepaalde regels probeert om te zetten naar een bruikbare structuur. De invoer is meestal tekst of een reeks tekens. De parser controleert of de invoer voldoet aan de regels van het formaat dat verwerkt moet worden.

Wanneer de invoer geldig is, geeft de parser een resultaat terug waarmee het programma verder kan werken. Wanneer de invoer niet geldig is, moet de parser aangeven dat er een fout is gevonden.

Een voorbeeld is de tekst "42". Deze invoer bestaat eerst uit twee losse tekens. Een parser kan herkennen dat deze tekens samen een getal vormen en vervolgens het getal 42 teruggeven.

Een parser hoeft niet altijd de volledige invoer tegelijk te verwerken. Een kleinere parser kan een onderdeel herkennen en daarna het resultaat en de resterende invoer teruggeven. Een volgende parser kan vervolgens verdergaan met de overgebleven invoer.

## Wat is JSON?

Een tekstformaat voor het opslaan en uitwisselen van gestructureerde gegevens.

## Wat is een JSON-parser?

Een JSON-parser is een parser die specifiek de regels van JSON gebruikt. Een algemene parser kan allerlei soorten invoer verwerken. Een JSON-parser is dus een parser die gespecialiseerd is in het verwerken van JSON.

De JSON-parser ontvangt JSON als tekst en zet deze om naar een datastructuur die door het programma gebruikt kan worden. Daarbij controleert de parser of de tekst geldige JSON is.

Voorbeeld:
```
JSON:
{ 
    "name": "Alex",
    "active": true 
}
```
Omgezet in naar..
```
Object:
[
    ("name", String "Alex"),
    ("active", Boolean True)
]
```

Wanneer er bijvoorbeeld een afsluitende accolade ontbreekt, een string niet wordt afgesloten of een ongeldige waarde wordt gebruikt, moet de parser de invoer afwijzen en een fout teruggeven.

## Onderdelen van de JSON-parser

De parser moet de verschillende soorten JSON-waarden kunnen herkennen en omzetten.

De waarden die de JSON-parser moet herkennen en omzetten:
- Null - `null`
- Boolean - `true` of `false`
- Getallen - 42, -3, 2.5
- Strings - "Hello world"
- Arrays - [1, 2, 3]
- Objecten - {"name": "Alex"}
- Geneste waarde - {"scores": [1, 2]}
- Whitespace - ` true `

De parser moet ook ongeldige invoer kunnen herkennen. Voorbeelden zijn:
- nul
- True
- [1, 2, 
- "String
- {"name" "Alex"}

Arrays en objecten zijn ingewikkelder dan null en booleans. Ze kunnen meerdere waarden bevatten en deze waarden kunnen zelf opnieuw arrays of objecten zijn. **Daarom is recursie nodig!** De parser voor een array of object kan opnieuw de algemene parser voor een JSON-waarde aanroepen.

## Wat zijn parser-combinators?

Een ingewikkelde parser kan worden opgebouwd uit meerdere kleine parserfuncties. Een parser kan bijvoorbeeld een teken herkennen. Een andere parser kan een vaste tekst zoals 'null' herkennen. Deze kleine parsers kunnen daarna worden gecombineerd om ingewikkeldere waarden te verwerken.

Een parser-combinator is een functie waarmee parsers worden gemaakt of gecombineerd. Een combinator kan bijvoorbeeld:

- 2 parsers na elkaar uitvoeren
- Een keuze maken tussen verschillende parsers
- Een parser meerdere keren uitvoeren
- Het resultaat van een parser omzetten

Voor een JSON-object kunnen bijvoorbeeld kleinere parsers achtereenvolgens een '{', een sleutel, een ':', een JSON-waarde en een '}' herkennen.

Parser-combinators passen bij functioneel programmeren omdat parsers als functies kunnen worden behandeld. Functies kunnen andere parserfuncties ontvangen en daar een nieuwe parser van maken.

## Waarom Haskell?

Haskell is een puur functionele programmeertaal. Een Haskell-programma wordt voornamelijk opgebouwd uit functies en waarden. Bestaande waarden worden normaal gesproken niet gewijzigd. In plaats daarvan geeft een functie een nieuwe waarde als resultaat terug.

Haskell is geschikt voor een JSON-parser omdat de parser uit kleine functies kan worden opgebouwd. Iedere functie ontvangt invoer en geeft een resultaat terug zonder de oorspronkelijke invoer te veranderen.

Daarnaast ondersteunt Haskell pattern matching en recursie. Pattern matching kan worden gebruikt om verschillende vormen van invoer en verschillende JSON-waarden te herkennen. Recursie kan worden gebruikt om lijsten en geneste JSON-structuren te verwerken.

Voordat ik dit allemaal wist, koos ik voor Haskell omdat het er ingewikkeld uitzag. Maar eigenlijk ziet het er best herkenbaar uit met dingen die ik al eerder heb gezien. Ik vond het een leuk idee om zeer ingewikkeld uitziende code te laten zien aan vrienden die niks of weinig weten van coderen om te "flexen".

## Functionele concepten

### Pure functions

Geeft bij dezelfde invoer altijd dezelfde uitvoer en veroorzaakt geen veranderingen buiten de functie.

De parserlogica kan grotendeels uit pure functions bestaan. Een functie ontvangt JSON-tekst en geeft steeds hetzelfde parserresultaat terug. Dit maakt functies gemakkelijker afzonderlijk te testen.

### First-class functions

First-class functions betekent dat functies als gewone waarden kunnen worden behandeld. Een functie kan worden opgeslagen, als parameter worden meegegeven of als resultaat worden teruggegeven.

Dit is bruikbaar bij parser-combinators, omdat een parserfunctie aan een andere functie kan worden doorgegeven.

### Higher-order functions

Een higher-order function is een functie die een andere functie ontvangt of teruggeeft.

Een algemene parser kan bijvoorbeeld een controlefunctie ontvangen die bepaalt welke tekens toegestaan zijn. Hierdoor kan dezelfde parser worden gebruikt voor verschillende soorten tekens. Ook een functie die twee parsers combineert is een higher-order function.

### Immutability

Immutability betekent dat bestaande waarden niet worden aangepast. In plaats daarvan wordt een nieuwe waarde gemaakt.

De parser verandert de oorspronkelijke invoerstring niet. Na het verwerken van een gedeelte kan de parser een resultaat en de resterende invoer teruggeven.

### Recursie

Functie roept zichzelf direct of indirect opnieuw aan (Stopconditie niet vergeten!).

Recursie kan worden gebruikt om meerdere elementen van een array of object te verwerken. Het is ook nodig voor geneste JSON. Een object kan een array bevatten en die array kan opnieuw objecten bevatten.

### Lazy evaluation

Haskell gebruikt dit. Het betekent gewoon dat een berekening pas wordt uitgevoerd wanneer het resultaat nodig is.

Lazy evaluation is een eigenschap van Haskell, maar het is nog niet zo duidelijk voor mij hoe het gaat werken met de parser.

### Pattern matching

Een functie kan reageren op de vorm van een waarde.

Bij een lijst kan bijvoorbeeld onderscheid worden gemaakt tussen een lege lijst en een lijst met een eerste element en een resterend gedeelte. Bij het JSON-datatype kan pattern matching onderscheid maken tussen een string, getal, boolean, array, object en nullwaarde.

Pattern matching maakt de verschillende mogelijkheden duidelijk zichtbaar in de code.

### Zelf notities
cabal lijkt een beetje op maven met de commandos.