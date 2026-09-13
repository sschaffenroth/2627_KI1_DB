-- ============================================================
--  Beispieldatenbank "Stadtbibliothek"
--  Fachschule für KI · Datenbanken · 1. Schuljahr · 2026/27
--  Zielsystem: SQLite (DB Browser for SQLite)
--
--  Verwendung: Neue Datenbank anlegen -> Ausführen -> Speichern.
--  Diese Datenbank begleitet die Stunden 06 bis 13.
-- ============================================================

PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS ausleihe;
DROP TABLE IF EXISTS exemplar;
DROP TABLE IF EXISTS buch_autor;
DROP TABLE IF EXISTS buch;
DROP TABLE IF EXISTS autor;
DROP TABLE IF EXISTS verlag;
DROP TABLE IF EXISTS leser;

-- ------------------------------------------------------------
-- Tabellen
-- ------------------------------------------------------------

CREATE TABLE verlag (
    verlag_id   INTEGER PRIMARY KEY,
    name        TEXT    NOT NULL UNIQUE,
    ort         TEXT    NOT NULL
);

CREATE TABLE autor (
    autor_id      INTEGER PRIMARY KEY,
    nachname      TEXT    NOT NULL,
    vorname       TEXT    NOT NULL,
    geburtsjahr   INTEGER,
    nationalitaet TEXT
);

CREATE TABLE buch (
    buch_id          INTEGER PRIMARY KEY,
    isbn             TEXT    NOT NULL UNIQUE,
    titel            TEXT    NOT NULL,
    erscheinungsjahr INTEGER NOT NULL CHECK (erscheinungsjahr > 1450),
    seitenzahl       INTEGER CHECK (seitenzahl > 0),
    verlag_id        INTEGER NOT NULL REFERENCES verlag(verlag_id)
);

-- Auflösung der n:m-Beziehung Buch <-> Autor
CREATE TABLE buch_autor (
    buch_id   INTEGER NOT NULL REFERENCES buch(buch_id),
    autor_id  INTEGER NOT NULL REFERENCES autor(autor_id),
    PRIMARY KEY (buch_id, autor_id)
);

CREATE TABLE exemplar (
    exemplar_id    INTEGER PRIMARY KEY,
    inventarnummer TEXT    NOT NULL UNIQUE,
    buch_id        INTEGER NOT NULL REFERENCES buch(buch_id),
    zustand        TEXT    NOT NULL DEFAULT 'gut'
                   CHECK (zustand IN ('neu','gut','abgenutzt','defekt')),
    standort       TEXT    NOT NULL
);

CREATE TABLE leser (
    leser_id       INTEGER PRIMARY KEY,
    nachname       TEXT    NOT NULL,
    vorname        TEXT    NOT NULL,
    email          TEXT    UNIQUE,
    ort            TEXT    NOT NULL,
    eintrittsdatum TEXT    NOT NULL
);

CREATE TABLE ausleihe (
    ausleihe_id    INTEGER PRIMARY KEY,
    exemplar_id    INTEGER NOT NULL REFERENCES exemplar(exemplar_id),
    leser_id       INTEGER NOT NULL REFERENCES leser(leser_id),
    ausleihdatum   TEXT    NOT NULL,
    rueckgabe_soll TEXT    NOT NULL,
    rueckgabe_ist  TEXT             -- NULL = noch nicht zurückgegeben
);

-- ------------------------------------------------------------
-- Daten
-- ------------------------------------------------------------

INSERT INTO verlag (verlag_id, name, ort) VALUES
 (1,'Hanser','München'),
 (2,'dtv','München'),
 (3,'Suhrkamp','Berlin'),
 (4,'Rowohlt','Hamburg'),
 (5,'O''Reilly','Heidelberg'),
 (6,'Springer','Berlin');

INSERT INTO autor (autor_id, nachname, vorname, geburtsjahr, nationalitaet) VALUES
 (1,'Kehlmann','Daniel',1975,'DE'),
 (2,'Zeh','Juli',1974,'DE'),
 (3,'Erpenbeck','Jenny',1967,'DE'),
 (4,'Stanisic','Sasa',1978,'DE'),
 (5,'Lutz','Mark',1961,'US'),
 (6,'Kleppmann','Martin',1985,'GB'),
 (7,'Beazley','David',1971,'US'),
 (8,'Weidner','Heike',1980,'DE');

INSERT INTO buch (buch_id, isbn, titel, erscheinungsjahr, seitenzahl, verlag_id) VALUES
 (1,'978-3-498-00310-1','Die Vermessung der Welt',2005,302,4),
 (2,'978-3-499-27133-2','Tyll',2017,480,4),
 (3,'978-3-630-87487-6','Unterleuten',2016,640,2),
 (4,'978-3-630-87663-4','Über Menschen',2021,416,2),
 (5,'978-3-518-42653-6','Gehen, ging, gegangen',2015,352,3),
 (6,'978-3-518-42824-0','Kairos',2021,384,3),
 (7,'978-3-630-87473-9','Herkunft',2019,368,2),
 (8,'978-1-449-35573-9','Learning Python',2013,1648,5),
 (9,'978-1-491-95004-6','Python Cookbook',2013,706,5),
 (10,'978-1-449-37332-0','Designing Data-Intensive Applications',2017,616,5),
 (11,'978-3-446-46884-1','Datenbanken kompakt',2022,288,1),
 (12,'978-3-662-63444-4','Grundkurs Datenbankentwurf',2021,344,6),
 (13,'978-3-630-87708-2','Zwischen Welten',2023,448,2);

INSERT INTO buch_autor (buch_id, autor_id) VALUES
 (1,1),(2,1),
 (3,2),(4,2),
 (5,3),(6,3),
 (7,4),
 (8,5),(9,7),(9,5),
 (10,6),
 (11,8),(12,8),
 (13,2);

INSERT INTO exemplar (exemplar_id, inventarnummer, buch_id, zustand, standort) VALUES
 (1 ,'INV-0001',1 ,'gut'      ,'Belletristik A'),
 (2 ,'INV-0002',1 ,'abgenutzt','Belletristik A'),
 (3 ,'INV-0003',2 ,'neu'      ,'Belletristik A'),
 (4 ,'INV-0004',3 ,'gut'      ,'Belletristik B'),
 (5 ,'INV-0005',3 ,'gut'      ,'Belletristik B'),
 (6 ,'INV-0006',3 ,'defekt'   ,'Magazin'),
 (7 ,'INV-0007',4 ,'neu'      ,'Belletristik B'),
 (8 ,'INV-0008',5 ,'gut'      ,'Belletristik C'),
 (9 ,'INV-0009',6 ,'neu'      ,'Belletristik C'),
 (10,'INV-0010',7 ,'gut'      ,'Belletristik C'),
 (11,'INV-0011',7 ,'gut'      ,'Belletristik C'),
 (12,'INV-0012',8 ,'abgenutzt','Informatik 1'),
 (13,'INV-0013',8 ,'gut'      ,'Informatik 1'),
 (14,'INV-0014',8 ,'neu'      ,'Informatik 1'),
 (15,'INV-0015',9 ,'gut'      ,'Informatik 1'),
 (16,'INV-0016',10,'neu'      ,'Informatik 2'),
 (17,'INV-0017',10,'gut'      ,'Informatik 2'),
 (18,'INV-0018',11,'neu'      ,'Informatik 2'),
 (19,'INV-0019',11,'gut'      ,'Informatik 2'),
 (20,'INV-0020',12,'gut'      ,'Informatik 2'),
 (21,'INV-0021',12,'gut'      ,'Magazin'),
 (22,'INV-0022',2 ,'gut'      ,'Magazin'),
 (23,'INV-0023',5 ,'abgenutzt','Magazin'),
 (24,'INV-0024',6 ,'gut'      ,'Belletristik C'),
 (25,'INV-0025',9 ,'neu'      ,'Informatik 1'),
 (26,'INV-0026',13,'neu'      ,'Belletristik B');   -- noch nie ausgeliehen

INSERT INTO leser (leser_id, nachname, vorname, email, ort, eintrittsdatum) VALUES
 (1 ,'Bauer'   ,'Anna'   ,'anna.bauer@example.org'   ,'München'  ,'2023-09-14'),
 (2 ,'Huber'   ,'Lukas'  ,'lukas.huber@example.org'  ,'München'  ,'2024-01-08'),
 (3 ,'Wagner'  ,'Sofia'  ,'sofia.wagner@example.org' ,'Dachau'   ,'2024-03-22'),
 (4 ,'Schmid'  ,'Elias'  ,'elias.schmid@example.org' ,'München'  ,'2024-06-02'),
 (5 ,'Fischer' ,'Mia'    ,'mia.fischer@example.org'  ,'Freising' ,'2024-09-30'),
 (6 ,'Weber'   ,'Noah'   ,'noah.weber@example.org'   ,'München'  ,'2025-01-15'),
 (7 ,'Meyer'   ,'Emma'   ,'emma.meyer@example.org'   ,'Dachau'   ,'2025-02-11'),
 (8 ,'Koch'    ,'Jonas'  ,'jonas.koch@example.org'   ,'München'  ,'2025-04-07'),
 (9 ,'Richter' ,'Lina'   ,'lina.richter@example.org' ,'Erding'   ,'2025-05-19'),
 (10,'Klein'   ,'Paul'   ,NULL                       ,'München'  ,'2025-09-01'),
 (11,'Wolf'    ,'Clara'  ,'clara.wolf@example.org'   ,'Freising' ,'2026-01-12'),
 (12,'Neumann' ,'Felix'  ,'felix.neumann@example.org','München'  ,'2026-03-03');

INSERT INTO ausleihe (ausleihe_id, exemplar_id, leser_id, ausleihdatum, rueckgabe_soll, rueckgabe_ist) VALUES
 (1 ,1 ,1 ,'2026-03-02','2026-03-30','2026-03-25'),
 (2 ,4 ,1 ,'2026-03-02','2026-03-30','2026-04-06'),
 (3 ,12,2 ,'2026-03-05','2026-04-02','2026-03-31'),
 (4 ,16,2 ,'2026-04-10','2026-05-08','2026-05-04'),
 (5 ,8 ,3 ,'2026-04-12','2026-05-10','2026-05-10'),
 (6 ,3 ,4 ,'2026-04-15','2026-05-13','2026-05-20'),
 (7 ,10,5 ,'2026-05-04','2026-06-01','2026-05-28'),
 (8 ,13,5 ,'2026-05-04','2026-06-01','2026-06-15'),
 (9 ,18,6 ,'2026-05-18','2026-06-15','2026-06-10'),
 (10,20,6 ,'2026-05-18','2026-06-15','2026-06-10'),
 (11,5 ,7 ,'2026-06-02','2026-06-30','2026-06-29'),
 (12,9 ,8 ,'2026-06-08','2026-07-06','2026-07-02'),
 (13,15,9 ,'2026-06-15','2026-07-13','2026-07-13'),
 (14,17,1 ,'2026-06-22','2026-07-20','2026-07-18'),
 (15,1 ,3 ,'2026-06-29','2026-07-27','2026-07-24'),
 (16,7 ,4 ,'2026-07-06','2026-08-03','2026-08-01'),
 (17,11,5 ,'2026-07-06','2026-08-03','2026-08-10'),
 (18,14,2 ,'2026-07-13','2026-08-10','2026-08-05'),
 (19,19,8 ,'2026-07-20','2026-08-17','2026-08-14'),
 (20,21,9 ,'2026-07-27','2026-08-24','2026-08-20'),
 (21,2 ,11,'2026-08-03','2026-08-31','2026-08-27'),
 (22,22,12,'2026-08-10','2026-09-07','2026-09-01'),
 (23,24,7 ,'2026-08-17','2026-09-14','2026-09-09'),
 (24,25,6 ,'2026-08-24','2026-09-21','2026-09-15'),
 (25,12,1 ,'2026-08-31','2026-09-28',NULL),
 (26,16,3 ,'2026-09-01','2026-09-29',NULL),
 (27,4 ,5 ,'2026-09-02','2026-09-30',NULL),
 (28,13,8 ,'2026-09-03','2026-10-01',NULL),
 (29,10,11,'2026-09-03','2026-10-01',NULL),
 (30,18,2 ,'2026-08-05','2026-09-02',NULL),
 (31,3 ,9 ,'2026-08-06','2026-09-03',NULL),
 (32,15,12,'2026-09-04','2026-10-02',NULL);
