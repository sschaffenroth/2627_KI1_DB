-- ============================================================
--  Probe-Schulaufgabe · Teil B (am Rechner) · Do 19.11.2026
--  Kfz-Werkstatt Rademacher — die ganze Datenbank
--
--  So geht's:
--    1. DB Browser for SQLite: Neue Datenbank -> werkstatt_Nachname.db
--       (den Dialog "Tabelle erstellen" einfach abbrechen)
--    2. Reiter "SQL ausfuehren": diese Datei oeffnen, F5
--    3. Strg+S (Aenderungen schreiben)
--  Alle Namen, Kennzeichen und Daten sind ausgedacht.
-- ============================================================

CREATE TABLE fahrzeug (
    kennzeichen     TEXT    NOT NULL,
    marke           TEXT,
    modell          TEXT,
    baujahr         INTEGER,       -- bei zwei Fahrzeugen nicht eingetragen
    PRIMARY KEY (kennzeichen)
) STRICT;

CREATE TABLE werkzeugwagen (
    wagennummer     INTEGER NOT NULL,
    standplatz      TEXT,
    PRIMARY KEY (wagennummer)
) STRICT;

CREATE TABLE mechaniker (
    personalnummer  INTEGER NOT NULL,
    name            TEXT,
    fachgebiet      TEXT,
    wagennummer     INTEGER NOT NULL UNIQUE REFERENCES werkzeugwagen (wagennummer),
    PRIMARY KEY (personalnummer)
) STRICT;

CREATE TABLE auftrag (
    auftrag_nr      INTEGER NOT NULL,
    datum           TEXT,
    beschreibung    TEXT,
    status          TEXT,          -- 'offen' oder 'fertig'
    kennzeichen     TEXT    NOT NULL REFERENCES fahrzeug (kennzeichen),
    personalnummer  INTEGER NOT NULL REFERENCES mechaniker (personalnummer),
    PRIMARY KEY (auftrag_nr)
) STRICT;

CREATE TABLE ersatzteil (
    teilenummer     TEXT    NOT NULL,
    bezeichnung     TEXT,
    preis           REAL,
    PRIMARY KEY (teilenummer)
) STRICT;

CREATE TABLE verbaut (
    auftrag_nr      INTEGER NOT NULL REFERENCES auftrag (auftrag_nr),
    teilenummer     TEXT    NOT NULL REFERENCES ersatzteil (teilenummer),
    menge           INTEGER,
    PRIMARY KEY (auftrag_nr, teilenummer)
) STRICT;

INSERT INTO fahrzeug VALUES
    ('M-AB 123',  'VW',     'Golf',    2018),
    ('M-LH 77',   'Opel',   'Corsa',   2015),
    ('M-CK 450',  'BMW',    '320d',    2020),
    ('M-EB 9',    'Skoda',  'Octavia', 2012),
    ('M-RS 310',  'VW',     'Polo',    2014),
    ('M-TK 88',   'Opel',   'Astra',   2019),
    ('M-NW 512',  'VW',     'Passat',  2021),
    ('M-HF 64',   'Skoda',  'Fabia',   2016),
    ('M-GP 207',  'Ford',   'Fiesta',  2017),
    ('M-KL 33',   'Audi',   'A4',      2022),
    ('M-DW 1960', 'VW',     'Käfer',   NULL),
    ('M-SB 742',  'Ford',   'Focus',   2013),
    ('M-ZA 15',   'Toyota', 'Yaris',   2011),
    ('M-PE 480',  'Audi',   'A3',      NULL),
    ('M-OL 6',    'Opel',   'Zafira',  2010);

INSERT INTO werkzeugwagen VALUES
    (1, 'Halle A'), (2, 'Halle A'), (3, 'Halle B'), (4, 'Halle B'),
    (5, 'Halle C'), (6, 'Lager'),   (7, 'Lager');

INSERT INTO mechaniker VALUES
    (11, 'J. Ott',     'Motor',                1),
    (12, 'T. Lindner', 'Bremsen und Fahrwerk', 2),
    (13, 'A. Demir',   'Elektrik und Klima',   3),
    (14, 'M. Huber',   'Motor',                4),
    (15, 'S. Kaya',    'Karosserie',           5);

INSERT INTO auftrag VALUES
    (1001, '2026-09-02', 'Ölwechsel',                   'fertig', 'M-AB 123',  11),
    (1002, '2026-09-04', 'Bremsbeläge vorne',           'fertig', 'M-LH 77',   12),
    (1003, '2026-09-07', 'Inspektion',                  'fertig', 'M-NW 512',  13),
    (1004, '2026-09-10', 'Zündkerzen wechseln',         'fertig', 'M-SB 742',  14),
    (1005, '2026-09-14', 'Handbremse einstellen',       'fertig', 'M-OL 6',    12),
    (1006, '2026-09-16', 'Delle Tür hinten links',      'fertig', 'M-GP 207',  15),
    (1007, '2026-09-21', 'Bremsscheiben hinten',        'fertig', 'M-CK 450',  12),
    (1008, '2026-09-24', 'Klimaanlage prüfen',          'fertig', 'M-TK 88',   13),
    (1009, '2026-09-29', 'Ölwechsel',                   'fertig', 'M-DW 1960', 11),
    (1010, '2026-10-01', 'Zahnriemen wechseln',         'fertig', 'M-KL 33',   14),
    (1011, '2026-10-05', 'Bremsen prüfen',              'fertig', 'M-HF 64',   12),
    (1012, '2026-10-06', 'Reifenwechsel',               'fertig', 'M-LH 77',   11),
    (1013, '2026-10-08', 'Batterie ersetzen',           'fertig', 'M-ZA 15',   13),
    (1014, '2026-10-12', 'Stoßfänger lackieren',        'fertig', 'M-PE 480',  15),
    (1015, '2026-10-14', 'Bremsflüssigkeit wechseln',   'fertig', 'M-AB 123',  12),
    (1016, '2026-10-19', 'Inspektion',                  'fertig', 'M-RS 310',  14),
    (1017, '2026-10-21', 'Bremsleitung erneuern',       'offen',  'M-EB 9',    12),
    (1018, '2026-10-22', 'Scheinwerfer einstellen',     'fertig', 'M-GP 207',  13),
    (1019, '2026-10-26', 'Ölwechsel',                   'fertig', 'M-CK 450',  11),
    (1020, '2026-10-28', 'Kühlmittel nachfüllen',       'fertig', 'M-NW 512',  14),
    (1021, '2026-10-30', 'Reifenwechsel',               'fertig', 'M-TK 88',   11),
    (1022, '2026-11-03', 'Klimaanlage prüfen',          'offen',  'M-KL 33',   13),
    (1023, '2026-11-05', 'Bremsbeläge hinten',          'fertig', 'M-OL 6',    12),
    (1024, '2026-11-09', 'Wischerblätter tauschen',     'fertig', 'M-HF 64',   15),
    (1025, '2026-11-10', 'Inspektion',                  'offen',  'M-SB 742',  14),
    (1026, '2026-11-12', 'Rost an der Schwelle entfernen', 'offen', 'M-DW 1960', 15),
    (1027, '2026-11-13', 'Bremsscheiben vorne',         'offen',  'M-ZA 15',   12),
    (1028, '2026-11-16', 'Ölwechsel',                   'offen',  'M-AB 123',  11),
    (1029, '2026-11-17', 'Fehlerspeicher auslesen',     'offen',  'M-PE 480',  13),
    (1030, '2026-11-18', 'Reifenwechsel',               'offen',  'M-RS 310',  11);

INSERT INTO ersatzteil VALUES
    ('T-11', 'Luftfilter',                       18.40),
    ('T-17', 'Ölfilter',                         12.90),
    ('T-19', 'Zündkerze',                         8.75),
    ('T-23', 'Bremsbelagsatz vorne',             79.00),
    ('T-24', 'Bremsbelagsatz hinten',            64.50),
    ('T-27', 'Bremsscheibe',                     58.00),
    ('T-31', 'Bremsflüssigkeit DOT 4, 1 Liter',  14.20),
    ('T-35', 'Wischerblatt',                     22.90),
    ('T-41', 'Motoröl 5W-30, 1 Liter',            9.50),
    ('T-44', 'Kühlmittel, 1 Liter',               7.80),
    ('T-52', 'Innenraumfilter',                  26.30),
    ('T-58', 'Kältemittel, 100 g',               34.00),
    ('T-63', 'Batterie 70 Ah',                  129.00),
    ('T-71', 'Glühlampe H7',                      6.40),
    ('T-88', 'Zahnriemensatz',                  189.00);

INSERT INTO verbaut VALUES
    (1001, 'T-17', 1), (1001, 'T-41', 5),
    (1002, 'T-23', 1),
    (1003, 'T-17', 1), (1003, 'T-41', 5), (1003, 'T-11', 1), (1003, 'T-52', 1),
    (1004, 'T-19', 4),
    (1007, 'T-27', 2), (1007, 'T-24', 1),
    (1008, 'T-58', 5),
    (1009, 'T-17', 1), (1009, 'T-41', 4),
    (1010, 'T-88', 1), (1010, 'T-44', 3),
    (1013, 'T-63', 1),
    (1015, 'T-31', 1),
    (1016, 'T-17', 1), (1016, 'T-41', 5), (1016, 'T-11', 1), (1016, 'T-35', 2),
    (1017, 'T-31', 1),
    (1018, 'T-71', 2),
    (1019, 'T-17', 1), (1019, 'T-41', 5),
    (1020, 'T-44', 2),
    (1022, 'T-58', 6),
    (1023, 'T-24', 1),
    (1024, 'T-35', 2),
    (1025, 'T-17', 1), (1025, 'T-41', 4), (1025, 'T-52', 1),
    (1027, 'T-27', 2), (1027, 'T-23', 1),
    (1028, 'T-17', 1), (1028, 'T-41', 5);
