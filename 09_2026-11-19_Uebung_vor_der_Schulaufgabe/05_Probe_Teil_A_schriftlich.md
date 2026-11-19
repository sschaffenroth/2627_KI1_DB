<!-- leistungsnachweis titel="Probe-Schulaufgabe Datenbanken, Teil A (schriftlich)" punkte="30" -->
# Probe-Schulaufgabe · Datenbanken · Teil A (schriftlich)

**Dauer** 30 Minuten · **Hilfsmittel** keine

---

## Der Sachtext: Kfz-Werkstatt Rademacher

> Die Kfz-Werkstatt Rademacher will ihre Aufträge nicht mehr auf Papier führen.
>
> Jedes Fahrzeug, das in die Werkstatt kommt, wird mit seinem amtlichen Kennzeichen erfasst, dazu Marke, Modell und Baujahr. Für ein Fahrzeug werden im Lauf der Zeit viele Aufträge angelegt — ein Ölwechsel im Frühjahr, eine Inspektion im Herbst. Jeder Auftrag hat eine Auftragsnummer, ein Datum, eine Beschreibung und einen Status (offen oder fertig) und gehört zu genau einem Fahrzeug.
>
> In der Werkstatt arbeiten Mechanikerinnen und Mechaniker mit Personalnummer, Name und Fachgebiet. Jeder Auftrag wird von genau einer Person bearbeitet; wer in der Werkstatt arbeitet, bearbeitet viele Aufträge.
>
> Jede Mechanikerin und jeder Mechaniker hat genau einen eigenen Werkzeugwagen mit einer Wagennummer und einem Standplatz in der Halle. Daneben stehen zwei Reservewagen im Lager, die niemandem gehören.
>
> Für einen Auftrag werden oft mehrere Ersatzteile gebraucht, und dasselbe Ersatzteil wird in vielen Aufträgen verbaut. Jedes Ersatzteil hat eine Teilenummer, eine Bezeichnung und einen Preis. Zu jedem verbauten Teil wird festgehalten, in welcher Menge es in den Auftrag eingeflossen ist.

<!-- seitenumbruch -->

## Aufgabe A1 — ER-Modell (14 Punkte)

*Zeichnen Sie das ER-Modell zum Sachtext. Stellen Sie alle Entitäten mit ihren Merkmalen dar und unterstreichen Sie jeweils das ID-Merkmal. Benennen Sie jede Beziehung und tragen Sie die Anzahlangaben ein.*

*Begründen Sie bei jeder 1:1-Beziehung, auf welche Seite das ID-Merkmal der anderen Entität kommt.*

**Hinweis:** Bilden Sie genau das ab, was der Sachtext verlangt — keine Entitäten, Merkmale oder Beziehungen, die dort nicht genannt sind. Zusätzliches bringt keine Punkte.

<!-- karo 31 -->

<!-- linien 3 -->

<!-- seitenumbruch -->

## Aufgabe A2 — Überführung (8 Punkte)

*Überführen Sie Ihr ER-Modell in Tabellen. Geben Sie für jede Tabelle den Namen und die Kopfzeile an, unterstreichen Sie den Primärschlüssel und markieren Sie Fremdschlüssel mit ↑.*

<!-- karo 40 -->

<!-- seitenumbruch -->

## Aufgabe A3 — SQL lesen (6 Punkte)

Für A3 und A4 gilt dieser Ausschnitt der Tabelle `fahrzeug`:

| kennzeichen | marke | modell | baujahr |
|---|---|---|---|
| M-AB 123 | VW | Golf | 2018 |
| M-LH 77 | Opel | Corsa | 2015 |
| M-CK 450 | BMW | 320d | 2020 |
| M-EB 9 | Skoda | Octavia | 2012 |
| M-RS 310 | VW | Polo | 2014 |
| M-TK 88 | Opel | Astra | 2019 |
| M-NW 512 | VW | Passat | 2021 |
| M-HF 64 | Skoda | Fabia | 2016 |

a) *Geben Sie die Zeilen an, die diese Abfrage ausgibt — in der Reihenfolge der Ausgabe.* (2 P)

```sql
SELECT kennzeichen, modell
FROM   fahrzeug
WHERE  marke = 'VW'
ORDER BY baujahr DESC;
```

<!-- linien 2 -->

b) *Beschreiben Sie in einem Satz, welche Frage diese Abfrage beantwortet.* (2 P)

```sql
SELECT kennzeichen, marke, modell
FROM   fahrzeug
WHERE  baujahr < 2016
ORDER BY baujahr;
```

<!-- linien 1 -->

c) *Geben Sie das Ergebnis dieser Abfrage einschließlich der Spaltenüberschriften an.* (2 P)

```sql
SELECT COUNT(*) AS anzahl, MIN(baujahr) AS aeltestes
FROM   fahrzeug
WHERE  marke = 'Opel';
```

<!-- linien 1 -->

---

## Aufgabe A4 — Schlüssel (2 Punkte)

*Entscheiden Sie, ob `marke` der Primärschlüssel der Tabelle `fahrzeug` sein könnte. Begründen Sie Ihre Entscheidung mit den Daten der Tabelle.*

<!-- linien 2 -->
