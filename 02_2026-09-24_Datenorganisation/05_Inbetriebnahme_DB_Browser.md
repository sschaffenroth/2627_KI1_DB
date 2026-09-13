# DB Browser for SQLite in Betrieb nehmen

**Datenbanken · Fachschule für Künstliche Intelligenz · Handreichung, gilt das ganze Schuljahr**

Dieses Blatt brauchen Sie einmal — am 24.09.2026 — und danach nur noch, wenn etwas klemmt.
Heben Sie es auf. Der letzte Abschnitt ist eine Störungsliste.

---

## 1 · Was Sie installieren, und warum gerade das

**SQLite** ist die Datenbank. Sie ist kein Programm, das läuft, sondern eine **einzige Datei**
auf der Platte. Kein Server, kein Dienst, kein Passwort. Wer die Datei kopiert, hat die
Datenbank kopiert.

**DB Browser for SQLite** (kurz: DB4S) ist die Oberfläche dazu — das Fenster, durch das Sie in
die Datei schauen und mit ihr arbeiten. SQLite selbst ist im DB Browser schon eingebaut; Sie
installieren also **ein** Programm, nicht zwei.

> **Der Unterschied, der oft verwirrt:** SQLite ist die Datenbank, DB Browser ist das
> Werkzeug. So wie ein PDF die Datei ist und der Acrobat Reader das Programm, mit dem man
> hineinsieht. Man kann dieselbe `.db`-Datei auch mit einem anderen Werkzeug öffnen — und ab
> Februar tun wir das, dann mit Python.

---

## 2 · Herunterladen

Alles auf **https://sqlitebrowser.org/dl/** unter *Windows*. Die aktuelle Fassung ist
**3.13.1**. Dort stehen mehrere Dateien — Sie brauchen genau eine, und welche, hängt nur an
einer Frage:

### Dürfen Sie auf dem Rechner Software installieren?

| | Datei | Was damit passiert |
|---|---|---|
| **Ja** (eigener Rechner, Adminrechte) | `DB.Browser.for.SQLite-v3.13.1-win64.msi` | Doppelklick, Assistent durchklicken, fertig. Das Programm steht danach im Startmenü |
| **Nein** (Schulrechner, gesperrter Firmenrechner) | `DB.Browser.for.SQLite-v3.13.1-win64.zip` | Nichts wird installiert. ZIP entpacken, Programm aus dem Ordner starten |
| Sie wollen es auf den USB-Stick | `SQLiteDatabaseBrowserPortable_3.13.1.paf.exe` | PortableApps-Fassung, nimmt alle Einstellungen mit auf den Stick |

**Für die Schule ist die ZIP-Fassung der sichere Weg.** Sie braucht keine Adminrechte, keine
Freigabe, keinen Neustart — und wenn ein Rechner sie verliert, entpacken Sie sie in zwei
Minuten neu.

*32-Bit-Rechner nehmen `win32` statt `win64`. Für Windows auf ARM gibt es eine `arm64`-Fassung,
aber keine portable.*

---

## 3 · Einrichten ohne Installation (der Schulweg)

1. **ZIP entpacken.** Rechtsklick auf die heruntergeladene Datei → *Alle extrahieren*. Als
   Ziel einen Ordner wählen, auf den Sie schreiben dürfen — Ihr Laufwerk `H:`, `Dokumente`
   oder den USB-Stick. **Nicht** nach `C:\Programme`, da dürfen Sie nicht hin.
2. **In den entpackten Ordner gehen** und `DB Browser for SQLite.exe` doppelklicken.
3. Kommt eine Warnung *„Der Computer wurde durch Windows geschützt"*: auf **Weitere
   Informationen** klicken, dann **Trotzdem ausführen**. Das ist der SmartScreen-Filter, der
   jedes Programm ohne teures Zertifikat anmeckert.
4. **Verknüpfung anlegen:** Rechtsklick auf die `.exe` → *Senden an* → *Desktop*. Sonst suchen
   Sie sie jede Woche neu.

Es gibt kein Setup, keine Registrierung, kein Konto. Das Programm ist jetzt betriebsbereit.

---

## 4 · Die eine Einstellung, die Sie sofort setzen müssen

**Menü *Bearbeiten* → *Einstellungen…* → Reiter *Datenbank* → Häkchen bei
*Fremdschlüssel* (englisch: *Foreign keys*).**

Ohne dieses Häkchen prüft SQLite die Verbindungen zwischen Tabellen **nicht**. Ein Verlag
lässt sich dann löschen, obwohl noch Bücher auf ihn zeigen — die Bücher verweisen danach ins
Leere, und niemand bekommt eine Meldung. In mindestens vier Stunden dieses Halbjahres läuft
eine Aufgabe darauf hinaus, dass Sie eine Fehlermeldung sehen *sollen*. Fehlt das Häkchen,
bleibt sie aus, und die Aufgabe lehrt das Gegenteil.

**Kontrolle** — im Reiter *SQL ausführen* eingeben und mit **F5** starten:

```sql
PRAGMA foreign_keys;
```

Ergebnis muss `1` sein. Steht dort `0`, ist das Häkchen nicht gesetzt oder die Datenbank war
beim Setzen schon offen — dann Datenbank schließen und neu öffnen.

**Zweite Kontrolle**, einmalig, für später wichtig:

```sql
SELECT sqlite_version();
```

Ab **3.37** funktioniert alles, was wir dieses Jahr machen. Die Fassung 3.13.1 des DB Browser
bringt SQLite **3.46.1** mit, liegt also weit darüber.

---

## 5 · Die Bibliotheksdatenbank aus dem SQL-Skript aufbauen

**Wann Sie diesen Abschnitt brauchen:** In Stunde 02 bekommen Sie eine fertige `bibliothek.db`
und speichern sie nur unter Ihrem eigenen Namen ab — der Weg hier ist dafür nicht nötig. Sie
brauchen ihn, wenn Ihre Datei verlorengeht, wenn ein Experiment schiefgelaufen ist, oder wenn
Sie zu Hause noch einmal bei null anfangen wollen. **Er stellt jederzeit den Ursprungszustand
wieder her** — heben Sie ihn deshalb auf.

Sie bekommen die Datei `bibliothek.sql` — ein Textdokument voller SQL-Anweisungen, das die
Beispieldatenbank aufbaut. Daraus machen Sie Ihre eigene Datenbank:

1. **Neue Datenbank** anklicken. Als Namen `bibliothek_<IhrNachname>.db` wählen, gespeichert
   in Ihrem eigenen Ordner. Nicht auf dem Desktop eines Schulrechners — der wird geleert.
2. Der Dialog *Tabelle definieren* springt auf. **Abbrechen** — die Tabellen kommen gleich
   aus der Datei.
3. Reiter **SQL ausführen** → das Ordnersymbol *SQL-Datei öffnen* → `bibliothek.sql` wählen.
4. **F5** oder der Pfeil ▶ — jetzt läuft das ganze Skript durch.
5. **Änderungen schreiben** (Strg+S). **Ohne diesen Klick ist nichts gespeichert.**

**Kontrolle:** Reiter *Datenbankstruktur* zeigt sieben Tabellen —
`verlag`, `autor`, `buch`, `buch_autor`, `exemplar`, `leser`, `ausleihe`.
Reiter *Daten durchsuchen* → Tabelle `buch` → 13 Datensätze.

Diese Datei begleitet Sie bis Juli. Sie wächst mit, Sie nehmen sie mit nach Hause, und sie
gehört Ihnen.

---

## 6 · Die vier Reiter

| Reiter | Wofür |
|---|---|
| **Datenbankstruktur** | Der Bauplan: welche Tabellen, welche Spalten, welche Typen, welche Regeln. Hier sehen Sie auch die `CREATE TABLE`-Anweisung jeder Tabelle im Wortlaut |
| **Daten durchsuchen** | Der Inhalt, wie in Excel. Zellen lassen sich direkt anklicken und ändern — bequem und gefährlich zugleich |
| **Datenbankzellen bearbeiten** | Seitenfenster für den Inhalt *einer* Zelle. Praktisch bei langen Texten |
| **SQL ausführen** | Die Kommandozeile der Datenbank. Ab Stunde 04 arbeiten wir fast nur noch hier |

---

## 7 · Die Gewohnheit, die Sie sich angewöhnen müssen

> **Änderungen schreiben.** Strg+S. Nach jedem Arbeitsschritt.

DB Browser sammelt Ihre Änderungen zunächst nur im Arbeitsspeicher. Geänderte Zellen stehen
**fett und kursiv** da — das heißt: noch nicht in der Datei. Wer das Programm schließt, ohne
zu speichern, verliert alles seit dem letzten Speichern.

Das hat aber auch eine gute Seite: **Bearbeiten → Änderungen zurücksetzen** macht alles
rückgängig, was seit dem letzten Speichern passiert ist. Nach einem missglückten Experiment
ist das der Rettungsknopf.

**Und trotzdem, einmal pro Monat:** Die `.db`-Datei im Explorer kopieren und die Kopie
`bibliothek_<Name>_sicherung_JJJJ-MM-TT.db` nennen. Eine Datenbank ist eine Datei — eine
Sicherung ist eine zweite Datei. Mehr braucht es nicht.

---

## 8 · Wenn etwas klemmt

| Problem | Ursache | Abhilfe |
|---|---|---|
| „Windows hat den Start verhindert" | SmartScreen, kein Zertifikat | *Weitere Informationen* → *Trotzdem ausführen* |
| Programm startet nicht, keine Meldung | ZIP nicht entpackt, direkt aus dem Archiv gestartet | Wirklich entpacken, dann aus dem Ordner starten |
| „database is locked" | Dieselbe Datei ist noch in einem zweiten Fenster offen | Alle DB-Browser-Fenster schließen, eines neu öffnen |
| Keine Fehlermeldung beim Löschen, obwohl eine kommen sollte | Fremdschlüsselprüfung aus | Abschnitt 4. `PRAGMA foreign_keys;` muss `1` sein |
| Änderungen sind nach dem Neustart weg | *Änderungen schreiben* vergessen | Abschnitt 7. Kein Weg zurück — nur neu machen |
| Umlaute erscheinen als `Ã¤` | Datei nicht als UTF-8 eingelesen | Beim Import *UTF-8* wählen. Bei `bibliothek.sql` passiert das automatisch |
| Datei lässt sich nicht speichern | Datenbank liegt in einem schreibgeschützten Ordner | Datei in Ihr eigenes Laufwerk kopieren und von dort öffnen |
| Alles weg nach einem Experiment | — | `bibliothek.sql` noch einmal vollständig ausführen. Danach steht der Ursprungszustand wieder da |

---

## 9 · Nur zur Einordnung: Was SQLite nicht kann

Damit Sie es gehört haben, bevor es jemand fragt. SQLite hat **keine Benutzerverwaltung** —
keine Namen, keine Passwörter, keine Rechte. Wer die Datei lesen darf, darf alles darin.
Auch echtes gleichzeitiges Arbeiten mehrerer Leute ist nicht vorgesehen.

Das ist kein Mangel, sondern der Zweck: SQLite ist die meistverbreitete Datenbank der Welt,
weil sie *in* Programmen steckt — in jedem Android-Handy, in jedem Browser, in Ihrem Auto.

Ab **April** arbeiten wir zusätzlich mit **PostgreSQL**, einem echten Datenbankserver mit
Benutzern und Rechten. Bis dahin brauchen wir das nicht — und die Zeit, die wir mit
Serverinstallation *nicht* verbringen, verbringen wir mit Datenbanken.
