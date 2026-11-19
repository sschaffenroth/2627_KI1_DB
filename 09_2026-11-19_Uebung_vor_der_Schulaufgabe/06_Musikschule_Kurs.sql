-- ============================================================
--  Ferienuebung · Stunde 09 · 19.11.2026
--  Die Tabelle kurs der Musikschule Klangwerk - zum Nachpruefen.
--  Reiter "SQL ausfuehren" einer leeren Datenbank, F5.
--  Alles ausgedacht.
-- ============================================================

CREATE TABLE kurs (
    kurs_nr       INTEGER,
    titel         TEXT,
    instrument    TEXT,          -- leer bei Kursen ohne festes Instrument
    wochentag     TEXT,
    gebuehr       REAL,          -- Euro im Monat
    max_plaetze   INTEGER,
    lehrkraft_nr  INTEGER,
    PRIMARY KEY (kurs_nr)
) STRICT;

INSERT INTO kurs VALUES
    (1, 'Gitarre für Einsteiger',    'Gitarre',    'Montag',     45.00,  6, 1),
    (2, 'Klavier Grundstufe',        'Klavier',    'Dienstag',   60.00,  4, 2),
    (3, 'Band-Workshop',             NULL,         'Freitag',    35.00, 10, 1),
    (4, 'Klavier Mittelstufe',       'Klavier',    'Donnerstag', 65.00,  4, 2),
    (5, 'Schlagzeug',                'Schlagzeug', 'Mittwoch',   55.00,  3, 3),
    (6, 'Gitarre Fortgeschrittene',  'Gitarre',    'Donnerstag', 50.00,  6, 1),
    (7, 'Gesang',                    'Gesang',     'Montag',     40.00,  8, 4),
    (8, 'Musiktheorie',              NULL,         'Samstag',    20.00, 12, 2);
