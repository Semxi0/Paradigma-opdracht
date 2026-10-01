# Challenge

## Wat is een JSON-parser?

JSON (JavaScript Object Notation) is een tekstformaat waarmee gestructureerde gegevens kunnen worden opgeslagen en uitgewisseld.

Een JSON-parser leest JSON als tekst en probeert deze om te zetten naar een datastructuur waarmee een programma verder kan werken. Hierbij controleert de parser of de invoer voldoet aan de regels van JSON.

Een voorbeeld van JSON is:

```json
{
  "naam": "Ned",
  "leeftijd": 20
}
```

Mijn parser zet deze tekst om naar een Haskell-datastructuur. Hierbij wordt de waarde "Ned" opgeslagen als een `JsonString` en de waarde 20 als een `JsonNumber`, beide binnen een `JsonObject`.

## Waarom deze uitdaging?

Ik heb gekozen voor een JSON-parser, omdat deze uitdaging mij het nuttigst leek. Ik vond het moeilijk om zelf een challenge te bedenken en sommige voorbeelden, zoals een boekingssysteem voor een bioscoop en een Markdown-to-HTML-converter, interesseerden mij minder.

Er waren ook andere voorbeelden die mij interessant leken, zoals Tic-Tac-Toe AI, een chatbot met higher-order functions en pathfinding met lazy evaluation. Ik heb deze uitdagingen oppervlakkig bekeken, maar verwachtte dat ik in de praktijk eerder iets met een JSON-parser zou doen.

Daarom heb ik uiteindelijk voor de JSON-parser gekozen. Ik realiseer me wel dat ik met de andere uitdagingen waarschijnlijk weer andere dingen over functioneel programmeren had geleerd.

## Functionaliteit en beperkingen

Voor mijn JSON-parser heb ik als doel gesteld om de verschillende soorten JSON-waarden te kunnen herkennen en omzetten naar een Haskell-datastructuur.

De parser ondersteunt de volgende JSON-waarden:

- **Null:** `null`
- **Booleans:** `true` en `false`
- **Getallen:** bijvoorbeeld `42`, `-3` en `2.5`
- **Strings:** bijvoorbeeld `"Hello World"`
- **Arrays:** bijvoorbeeld `[1, 2, 3]`
- **Objecten:** bijvoorbeeld `{"naam": "Ned"}`

Daarnaast ondersteunt de parser geneste arrays en objecten. Een object kan bijvoorbeeld een array bevatten en die array kan weer andere objecten bevatten.

De parser kan ook verschillende vormen van ongeldige invoer herkennen. Wanneer het parsen mislukt, wordt een foutmelding teruggegeven. Ook wordt gecontroleerd of er na het verwerken van een JSON-waarde nog onverwachte tekens overblijven.

### Beperkingen

Mijn implementatie is een vereenvoudigde JSON-parser en ondersteunt niet alle onderdelen van de JSON-standaard.

Zo worden getallen met exponentnotatie, zoals `1e3`, niet ondersteund. Ook worden niet alle escape-tekens in strings correct verwerkt. Daarnaast worden sommige ongeldige getalnotaties, zoals `01`, nog geaccepteerd.

De parser is daarom bedoeld als een oefening in functioneel programmeren en niet als een volledige implementatie van de JSON-standaard.