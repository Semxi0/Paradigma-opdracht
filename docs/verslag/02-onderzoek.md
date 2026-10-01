# Onderzoek

## Haskell
Haskell is een puur functionele programmeertaal. Dit betekent dat programmeren voornamelijk gebeurt met functies en waarden, in plaats van het aanpassen van variabelen zoals bij imperatieve programmeertalen.

In Haskell zijn waarden standaard immutable. Dit houdt in dat bestaande waarden niet worden aangepast. In plaats daarvan geven functies nieuwe waarden terug. Daarnaast ondersteunt Haskell onder andere recursie, pattern matching en lazy evaluation.

Deze eigenschappen maken Haskell geschikt voor het ontwikkelen van een JSON-parser. Een parser kan namelijk worden opgebouwd uit kleinere functies die ieder een gedeelte van de invoer verwerken en een resultaat teruggeven. De oorspronkelijke invoer wordt hierbij niet aangepast.

## Pure functions
Een pure function is een functie die bij dezelfde invoer altijd dezelfde uitvoer teruggeeft en geen bijwerkingen veroorzaakt. Dit betekent bijvoorbeeld dat de functie geen gegevens buiten zichzelf aanpast.

In Haskell zijn functies standaard puur. Hierdoor kun je een functie afzonderlijk testen, omdat het resultaat niet afhankelijk is van veranderingen buiten de functie.

Een voorbeeld van een pure function in Haskell is:
```haskell
verdubbel :: Int -> Int
verdubbel x = x * 2
```
De functie verdubbel ontvangt een getal en geeft het dubbele terug. Wanneer de invoer 5 is, zal de uitvoer altijd 10 zijn. De functie verandert verder niets buiten zichzelf.

## First-class functions

First-class functions betekent dat functies als gewone waarden kunnen worden behandeld. In Haskell kun je een functie bijvoorbeeld als argument meegeven aan een andere functie, opslaan onder een naam of teruggeven als resultaat van een functie.

Hierdoor kun je functies hergebruiken en combineren zonder dezelfde logica telkens opnieuw te schrijven.

Een voorbeeld in Haskell is:

```haskell
verdubbel :: Int -> Int
verdubbel x = x * 2

bereken :: (Int -> Int) -> Int -> Int
bereken functie getal = functie getal
```

De functie `bereken` ontvangt een andere functie als argument. Wanneer je `bereken verdubbel 5` uitvoert, wordt de functie `verdubbel` toegepast op het getal `5`. Het resultaat is `10`.

## Higher-order functions

Een higher-order function is een functie die een andere functie als argument ontvangt of een functie als resultaat teruggeeft.

In Haskell kunnen higher-order functions worden gebruikt om bestaande functies te hergebruiken. Een voorbeeld hiervan is de ingebouwde functie `map`, waarmee een functie op ieder element van een lijst wordt toegepast.

```haskell
verdubbel :: Int -> Int
verdubbel x = x * 2

getallen = map verdubbel [1, 2, 3]
```

Hier ontvangt `map` de functie `verdubbel` en de lijst `[1, 2, 3]`. Vervolgens wordt `verdubbel` op ieder element toegepast. Het resultaat is `[2, 4, 6]`.

Het verschil met first-class functions is dat first-class functions beschrijft dat functies als waarden behandeld kunnen worden. Higher-order functions zijn functies die hiervan gebruikmaken door andere functies te ontvangen of terug te geven.

## Immutability

Immutability betekent dat bestaande waarden niet worden aangepast. In Haskell zijn waarden standaard immutable. Wanneer je een andere waarde nodig hebt, maak je een nieuwe waarde aan in plaats van de oorspronkelijke waarde te veranderen.

Een voorbeeld in Haskell is:

```haskell
getallen = [1, 2, 3]
nieuweGetallen = 0 : getallen
```

Hier wordt met de operator `:` een nieuwe lijst gemaakt waarin `0` vooraan staat. De oorspronkelijke lijst `getallen` blijft `[1, 2, 3]`, terwijl `nieuweGetallen` de lijst `[0, 1, 2, 3]` bevat.

Immutability maakt het gemakkelijker om te begrijpen wat een functie doet, omdat bestaande waarden niet onverwacht kunnen veranderen.

## Recursie

Recursie betekent dat een functie zichzelf direct of indirect opnieuw aanroept. Hierbij is een stopconditie belangrijk, zodat de functie niet oneindig doorgaat.

In Haskell wordt recursie vaak gebruikt om lijsten te verwerken. Een voorbeeld hiervan is:

```haskell
telOp :: [Int] -> Int
telOp [] = 0
telOp (x : xs) = x + telOp xs
```

De functie `telOp` telt alle getallen in een lijst bij elkaar op. Wanneer de lijst leeg is (`[]`), geeft de functie `0` terug. Dit is de stopconditie.

Wanneer de lijst niet leeg is, wordt deze met `(x : xs)` opgesplitst in het eerste element (`x`) en de rest van de lijst (`xs`). Vervolgens wordt de functie opnieuw aangeroepen met de resterende elementen.

Bijvoorbeeld: `telOp [1, 2, 3]` geeft als resultaat `6`.

## Lazy evaluation

Lazy evaluation betekent dat een berekening pas wordt uitgevoerd wanneer het resultaat nodig is. Haskell gebruikt standaard lazy evaluation, waardoor niet altijd alle onderdelen van een expressie direct berekend hoeven te worden.

Een voorbeeld in Haskell is:

```haskell
eersteGetal = head [1..]
```

De expressie `[1..]` stelt een oneindige lijst met getallen voor. Toch kan Haskell met `head` het eerste getal teruggeven, omdat alleen het eerste element nodig is. Het resultaat is `1`.

Lazy evaluation kan voorkomen dat onnodige berekeningen worden uitgevoerd. Het maakt het ook mogelijk om met oneindige lijsten te werken, zolang het programma maar een eindig gedeelte daarvan nodig heeft.

## Pattern matching

Pattern matching betekent dat een functie verschillende vormen van invoer kan herkennen en daar verschillend op kan reageren. Hierbij kunnen ook direct onderdelen uit de invoer worden gehaald, zoals het eerste element van een lijst. In Haskell wordt dit bijvoorbeeld gebruikt om onderscheid te maken tussen een lege lijst en een lijst met elementen.

Een voorbeeld in Haskell is:

```haskell
eersteTeken :: String -> String
eersteTeken [] = "De lijst is leeg"
eersteTeken (x : xs) = "Het eerste teken is: " ++ [x]
```

Wanneer de invoer een lege lijst (`[]`) is, geeft de functie een melding terug. Wanneer de lijst wel elementen bevat, wordt deze met `(x : xs)` opgesplitst in het eerste element (`x`) en de resterende elementen (`xs`).

Bijvoorbeeld: `eersteTeken "Hallo"` geeft als resultaat `"Het eerste teken is: H"`.

Pattern matching maakt de code overzichtelijk doordat je voor verschillende vormen van invoer afzonderlijk kunt beschrijven wat er moet gebeuren.