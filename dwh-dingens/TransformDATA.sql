--wahl
INSERT INTO WAHL(WAHL_DATUM) SELECT to_date("erste Eingabe Datum", 'dd.mm.yy') from STAGEING_STAT_DOWNLOAD_NR02_NEW FETCH FIRST 1 ROWS ONLY;
INSERT INTO WAHL(WAHL_DATUM) SELECT to_date("erste Eingabe Datum") from STAGEING_STAT_DOWNLOAD_NR06_NEW FETCH FIRST 1 ROWS ONLY;
INSERT INTO WAHL(WAHL_DATUM) SELECT to_date("erste Eingabe Datum",'mm-dd-yy') from STAGEING_STAT_DOWNLOAD_NR08_NEW FETCH FIRST 1 ROWS ONLY;
INSERT INTO WAHL(WAHL_DATUM) SELECT to_date("erste Eingabe Datum",'mm-dd-yy') from STAGEING_STAT_DOWNLOAD_NR13_NEW FETCH FIRST 1 ROWS ONLY;
INSERT INTO WAHL(WAHL_DATUM) SELECT to_date("erste Eingabe Datum") from STAGEING_STAT_DOWNLOAD_NR17_NEW FETCH FIRST 1 ROWS ONLY;
INSERT INTO WAHL(WAHL_DATUM) SELECT to_date("erste Eingabe Datum") from STAGEING_STAT_DOWNLOAD_NR19_NEW FETCH FIRST 1 ROWS ONLY;


-- wahlkreise
INSERT ALL INTO WAHLKREISE (NR, NAME, VON)
SELECT "Nr. ", "Name ", to_date("erste Eingabe Datum", 'dd.mm.yy') FROM STAGEING_STAT_DOWNLOAD_NR02_NEW WHERE "Nr. " is not null;

INSERT ALL INTO WAHLKREISE (NR, NAME, VON, VORGÄNGER)
SELECT "Nr. ", n."Name ", to_date("erste Eingabe Datum") FROM STAGEING_STAT_DOWNLOAD_NR06_NEW n WHERE "Nr. " is not null;

INSERT ALL INTO WAHLKREISE (NR, NAME, VON)
SELECT "Nr. ", "Name ", to_date("erste Eingabe Datum",'mm-dd-yy') FROM STAGEING_STAT_DOWNLOAD_NR08_NEW n WHERE "Nr. " is not null;

INSERT ALL INTO WAHLKREISE (NR, NAME, VON)
SELECT "Nr. ", "Name ", to_date("erste Eingabe Datum",'mm-dd-yy') FROM STAGEING_STAT_DOWNLOAD_NR13_NEW n WHERE "Nr. " is not null;

INSERT ALL INTO WAHLKREISE (NR, NAME, VON)
SELECT "Nr. ", "Name ", to_date("erste Eingabe Datum") FROM STAGEING_STAT_DOWNLOAD_NR17_NEW n WHERE "Nr. " is not null;

INSERT ALL INTO WAHLKREISE (NR, NAME, VON)
SELECT "Nr. ", "Name ", to_date("erste Eingabe Datum") FROM STAGEING_STAT_DOWNLOAD_NR19_NEW n WHERE "Nr. " is not null;

UPDATE WAHLKREISE o
   SET VORGÄNGER = (SELECT ID from WAHLKREISE n WHERE n.NAME LIKE '%' || o.NAME || '%' AND o.ID != n.ID AND o.VON != n.VON FETCH FIRST 1 ROWS ONLY)
   WHERE VORGÄNGER is null AND VON != to_date('2002-11-24', 'yyyy-mm-dd');


-- partei
INSERT INTO PARTEI (NAME, VON, BIS)
SELECT replace(COLUMN_NAME, ' Stimmen') as partei, (SELECT WAHL_DATUM FROM WAHL WHERE extract(YEAR FROM WAHL_DATUM) = '2002'),
       (SELECT WAHL_DATUM FROM WAHL WHERE extract(YEAR FROM WAHL_DATUM) = '2008')
FROM all_tab_cols
 WHERE table_name = 'STAGEING_STAT_DOWNLOAD_NR02_NEW' AND (column_name LIKE '%Stimmen%') AND replace(COLUMN_NAME, ' Stimmen') not in ('leer', 'ungültige', 'gültige', 'abgegeb.') order by partei;

INSERT INTO PARTEI (NAME, VON, BIS)
SELECT replace(COLUMN_NAME, ' Stimmen') as partei, (SELECT WAHL_DATUM FROM WAHL WHERE extract(YEAR FROM WAHL_DATUM) = '2006'),
       (SELECT WAHL_DATUM FROM WAHL WHERE extract(YEAR FROM WAHL_DATUM) = '2008')
FROM all_tab_cols
 WHERE table_name = 'STAGEING_STAT_DOWNLOAD_NR06_NEW' AND (column_name LIKE '%Stimmen%') AND replace(COLUMN_NAME, ' Stimmen') not in ('leer', 'ungültige', 'gültige', 'abgegeb.') order by partei;

INSERT INTO PARTEI (NAME, VON, BIS)
SELECT replace(COLUMN_NAME, ' Stimmen') as partei, (SELECT WAHL_DATUM FROM WAHL WHERE extract(YEAR FROM WAHL_DATUM) = '2008'),
       (SELECT WAHL_DATUM FROM WAHL WHERE extract(YEAR FROM WAHL_DATUM) = '2017')
FROM all_tab_cols
 WHERE table_name = 'STAGEING_STAT_DOWNLOAD_NR08_NEW' AND (column_name LIKE '%Stimmen%') AND replace(COLUMN_NAME, ' Stimmen') not in ('leer', 'ungültige', 'gültige', 'abgegeb.') order by partei;

INSERT INTO PARTEI (NAME, VON, BIS)
SELECT replace(COLUMN_NAME, ' Stimmen') as partei, (SELECT WAHL_DATUM FROM WAHL WHERE extract(YEAR FROM WAHL_DATUM) = '2013'),
       (SELECT WAHL_DATUM FROM WAHL WHERE extract(YEAR FROM WAHL_DATUM) = '2017')
FROM all_tab_cols
 WHERE table_name = 'STAGEING_STAT_DOWNLOAD_NR13_NEW' AND (column_name LIKE '%Stimmen%') AND replace(COLUMN_NAME, ' Stimmen') not in ('leer', 'ungültige', 'gültige', 'abgegeb.') order by partei;

INSERT INTO PARTEI (NAME, VON, BIS)
SELECT replace(COLUMN_NAME, ' Stimmen') as partei, (SELECT WAHL_DATUM FROM WAHL WHERE extract(YEAR FROM WAHL_DATUM) = '2017'),
       (SELECT WAHL_DATUM FROM WAHL WHERE extract(YEAR FROM WAHL_DATUM) = '2019')
FROM all_tab_cols
 WHERE table_name = 'STAGEING_STAT_DOWNLOAD_NR17_NEW' AND (column_name LIKE '%Stimmen%') AND replace(COLUMN_NAME, ' Stimmen') not in ('leer', 'ungültige', 'gültige', 'abgegeb.') order by partei;

INSERT INTO PARTEI (NAME, VON)
SELECT replace(COLUMN_NAME, ' Stimmen') as partei, (SELECT WAHL_DATUM FROM WAHL WHERE extract(YEAR FROM WAHL_DATUM) = '2019')
FROM all_tab_cols
 WHERE table_name = 'STAGEING_STAT_DOWNLOAD_NR19_NEW' AND (column_name LIKE '%Stimmen%') AND replace(COLUMN_NAME, ' Stimmen') not in ('leer', 'ungültige', 'gültige', 'abgegeb.') order by partei;

UPDATE PARTEI p
   SET VORGÄNGER = (SELECT ID from PARTEI n WHERE n.NAME LIKE '%' || p.NAME || '%' AND p.ID != n.ID AND p.VON != n.VON FETCH FIRST 1 ROWS ONLY)
   WHERE VORGÄNGER is null AND VON != to_date('2002-11-24', 'yyyy-mm-dd');

-- wahl_brerechtigte
--CREATE OR REPLACE PROCEDURE GetWahlkreisID(nr IN clob, von IN date, id_out OUT NUMBER)
--AS BEGIN
  --  SELECT id into id_out FROM wahlkreise k WHERE k.NR = to_char(nr) AND VON = von;
--END;

INSERT INTO WAHL_BERECHTIGTE (WAHLKREIS, BERECHTIGTE, ABGEGEBEN, WAHLBETEILIGUNG, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), "Wahlbe rechtigte", "abgegeb. Stimmen", "Wahlbet. in %", w.ID FROM STAGEING_STAT_DOWNLOAD_NR02_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'dd.mm.yy');

INSERT INTO WAHL_BERECHTIGTE (WAHLKREIS, BERECHTIGTE, ABGEGEBEN, WAHLBETEILIGUNG, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), "Wahlbe rechtigte", "abgegeb. Stimmen", "Wahlbet. in %", w.ID FROM STAGEING_STAT_DOWNLOAD_NR06_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum");

INSERT INTO WAHL_BERECHTIGTE (WAHLKREIS, BERECHTIGTE, ABGEGEBEN, WAHLBETEILIGUNG, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), "Wahlbe rechtigte", "abgegeb. Stimmen", "Wahlbet. in %", w.ID FROM STAGEING_STAT_DOWNLOAD_NR08_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy');

INSERT INTO WAHL_BERECHTIGTE (WAHLKREIS, BERECHTIGTE, ABGEGEBEN, WAHLBETEILIGUNG, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), "Wahlbe rechtigte", "abgegeb. Stimmen", "Wahlbet. in %", w.ID FROM STAGEING_STAT_DOWNLOAD_NR13_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy');

INSERT INTO WAHL_BERECHTIGTE (WAHLKREIS, BERECHTIGTE, ABGEGEBEN, WAHLBETEILIGUNG, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), "Wahlbe rechtigte", "abgegeb. ", "Wahlbet. in %", w.ID FROM STAGEING_STAT_DOWNLOAD_NR17_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum");

INSERT INTO WAHL_BERECHTIGTE (WAHLKREIS, BERECHTIGTE, ABGEGEBEN, WAHLBETEILIGUNG, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), "Wahlbe rechtigte", "abgegeb. ", "Wahlbet. in %", w.ID FROM STAGEING_STAT_DOWNLOAD_NR19_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum");


INSERT INTO WAHLKREIS_STIMMEN (WAHLKREIS, STIMMEN, PROZENT, PARTEI, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char('') AND VON = to_date('')), '', '', '', (SELECT w.ID FROM WAHL w WHERE WAHL_DATUM = to_date('')) FROM dual;

INSERT INTO WAHLKREIS_STIMMEN (WAHLKREIS, STIMMEN, PROZENT, PARTEI, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), s."ungültige Stimmen", s."ungültige Stimmen in %", (SELECT id FROM partei p WHERE p.NAME = 'ungültige' AND p.VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR02_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'dd.mm.yy');


--TRUNCATE TABLE WAHLKREIS_STIMMEN;

-- Stimmen
INSERT INTO WAHLKREIS_STIMMEN (WAHLKREIS, STIMMEN, PROZENT, PARTEI, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), s."FPÖ Stimmen", s."FPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'FPÖ' AND p.VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR02_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'dd.mm.yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), s."GRÜNE Stimmen", s."GRÜNE Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'GRÜNE' AND p.VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR02_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'dd.mm.yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), s."ÖVP Stimmen", s."ÖVP Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'ÖVP' AND p.VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR02_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'dd.mm.yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), s."SPÖ Stimmen", s."SPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'SPÖ' AND p.VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR02_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'dd.mm.yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), s."LIF Stimmen", s."LIF Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'LIF' AND p.VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR02_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'dd.mm.yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), s."KPÖ Stimmen", s."KPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'KPÖ' AND p.VON = to_date("erste Eingabe Datum", 'dd.mm.yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR02_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'dd.mm.yy')
;

INSERT INTO WAHLKREIS_STIMMEN (WAHLKREIS, STIMMEN, PROZENT, PARTEI, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."FPÖ Stimmen", s."FPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'FPÖ' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR08_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."GRÜNE Stimmen", s."GRÜNE Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'GRÜNE' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR08_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."ÖVP Stimmen", s."ÖVP Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'ÖVP' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR08_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."SPÖ Stimmen", s."SPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'SPÖ' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR08_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."LIF Stimmen", s."LIF Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'LIF' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR08_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."KPÖ Stimmen", s."KPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'KPÖ' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR08_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."LINKE Stimmen", s."LINKE Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'LINKE' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR08_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."RETTÖ Stimmen", s."RETTÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'RETTÖ' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR08_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."BZÖ Stimmen", s."BZÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'BZÖ' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR08_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."DC Stimmen", s."DC Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'DC' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR08_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."FRITZ Stimmen", s."FRITZ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'FRITZ' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR08_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
;

INSERT INTO WAHLKREIS_STIMMEN (WAHLKREIS, STIMMEN, PROZENT, PARTEI, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."FPÖ Stimmen", s."FPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'FPÖ' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR13_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."GRÜNE Stimmen", s."GRÜNE Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'GRÜNE' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR13_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."ÖVP Stimmen", s."ÖVP Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'ÖVP' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR13_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."SPÖ Stimmen", s."SPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'SPÖ' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR13_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."NEOS Stimmen", s."NEOS Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'NEOS' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR13_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."KPÖ Stimmen", s."KPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'KPÖ' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR13_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."CPÖ Stimmen", s."CPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'CPÖ' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR13_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."BZÖ Stimmen", s."BZÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'BZÖ' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR13_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."FRANK Stimmen", s."FRANK Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'FRANK' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR13_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."PIRAT Stimmen", s."PIRAT Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'PIRAT' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR13_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), s."WANDL Stimmen", s."WANDL Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'WANDL' AND p.VON = to_date("erste Eingabe Datum", 'mm-dd-yy')), w.ID FROM STAGEING_STAT_DOWNLOAD_NR13_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'mm-dd-yy')
;

INSERT INTO WAHLKREIS_STIMMEN (WAHLKREIS, STIMMEN, PROZENT, PARTEI, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."FPÖ Stimmen", s."FPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'FPÖ' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR17_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."GRÜNE Stimmen", s."GRÜNE Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'GRÜNE' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR17_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."ÖVP Stimmen", s."ÖVP Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'ÖVP' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR17_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."SPÖ Stimmen", s."SPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'SPÖ' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR17_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."FLÖ Stimmen", s."FLÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'FLÖ' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR17_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."KPÖ Stimmen", s."KPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'KPÖ' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR17_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."NEOS Stimmen", s."NEOS Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'NEOS' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR17_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."GILT Stimmen", s."GILT Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'GILT' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR17_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."PILZ Stimmen", s."PILZ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'PILZ' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR17_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."SLP Stimmen", s."SLP Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'SLP' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR17_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."WEIßE Stimmen", s."WEIßE Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'WEIßE' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR17_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
;

INSERT INTO WAHLKREIS_STIMMEN (WAHLKREIS, STIMMEN, PROZENT, PARTEI, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."FPÖ Stimmen", s."FPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'FPÖ' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR19_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."GRÜNE Stimmen", s."GRÜNE Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'GRÜNE' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR19_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."ÖVP Stimmen", s."ÖVP Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'ÖVP' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR19_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."SPÖ Stimmen", s."SPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'SPÖ' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR19_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."JETZT Stimmen", s."JETZT Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'JETZT' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR19_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."KPÖ Stimmen", s."KPÖ Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'KPÖ' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR19_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."NEOS Stimmen", s."NEOS Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'NEOS' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR19_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."WANDL Stimmen", s."WANDL Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'WANDL' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR19_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
UNION ALL
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = to_char(s."Nr. ") AND VON = to_date("erste Eingabe Datum")), s."SLP Stimmen", s."SLP Ant. %", (SELECT id FROM PARTEI p WHERE p.NAME LIKE 'SLP' AND p.VON = to_date("erste Eingabe Datum")), w.ID FROM STAGEING_STAT_DOWNLOAD_NR19_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum")
;

SELECT NAME, VON from PARTEI WHERE extract(YEAR FROM VON) = '2013';