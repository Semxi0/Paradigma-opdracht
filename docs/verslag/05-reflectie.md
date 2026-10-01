# Reflectie

## Wat heb ik geleerd?

Tijdens deze opdracht heb ik voor het eerst uitgebreid gewerkt met Haskell en het functionele programmeerparadigma. In het begin moest ik wennen aan de syntax en de manier waarop functies in Haskell worden geschreven.

Door het ontwikkelen van de JSON-parser heb ik meer inzicht gekregen in recursie, pattern matching en het gebruik van `Either` om onderscheid te maken tussen een geslaagd resultaat en een foutmelding.

## Wat ging goed en wat vond ik lastig?

Het opdelen van de JSON-parser in kleinere functies vond ik prettig werken. Hierdoor kon ik bijvoorbeeld eerst `parseChar` en `parseString` maken en testen, voordat ik verderging met ingewikkeldere onderdelen zoals arrays en objecten.

Wat ik lastiger vond, was het begrijpen van higher-order functions. Ik begreep dat een functie een andere functie als argument kan ontvangen of als resultaat kan teruggeven. Wat ik in het begin niet goed begreep, was hoe een functie nog als resultaat kon worden teruggegeven wanneer ik direct een uitkomst zag. Ik dacht dat de teruggegeven functie dan al volledig was uitgevoerd. Door verschillende voorbeelden van higher-order functions te bekijken en hiermee te oefenen, begreep ik beter hoe een functie een andere functie kan teruggeven.

Ook moest ik weer wennen aan recursie. Ik was even vergeten hoe de uitvoering van recursieve functieaanroepen verloopt. Wanneer een functie zichzelf opnieuw aanroept, wordt de huidige aanroep tijdelijk onderbroken totdat de nieuwe aanroep een resultaat teruggeeft. Daarna kan de eerdere aanroep verdergaan met dat resultaat. Dit moest ik opnieuw goed begrijpen om de recursieve verwerking van de JSON-parser te kunnen volgen.

## Vergelijking met andere programmeerparadigma's

Bij het programmeren in Java ben ik gewend om onder andere imperatief en objectgeoriënteerd te werken, bijvoorbeeld met variabelen, objecten en loops. In Haskell heb ik vergelijkbare problemen op een andere manier moeten oplossen.

Zo gebruik ik in mijn JSON-parser recursie om meerdere tekens of array-elementen te verwerken, in plaats van een `for`- of `while`-loop. Ook wordt de invoer niet aangepast, maar geven de parserfuncties de resterende invoer terug als onderdeel van hun resultaat.

Het teruggeven van een waarde is op zichzelf niet nieuw voor mij, omdat ik in Java ook met `return` heb gewerkt. Daarnaast heb ik in Java al ervaring opgedaan met pure functions en immutability. Het verschil zat voor mij daarom vooral in de manier waarop ik deze concepten in Haskell heb toegepast en gecombineerd met recursie en pattern matching.

Door deze opdracht heb ik geleerd dat functioneel programmeren een andere manier biedt om software op te bouwen. Hoewel ik nog niet alle mogelijkheden van Haskell beheers, begrijp ik nu beter hoe ik recursie, pattern matching en pure functions in een eigen programma kan toepassen.