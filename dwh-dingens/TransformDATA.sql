INSERT INTO WAHL(WAHL_DATUM) SELECT to_date("erste Eingabe Datum", 'dd.mm.yy') from STAGEING_STAT_DOWNLOAD_NR02_NEW FETCH FIRST 1 ROWS ONLY;
INSERT INTO WAHL(WAHL_DATUM) SELECT to_date("erste Eingabe Datum") from STAGEING_STAT_DOWNLOAD_NR06_NEW FETCH FIRST 1 ROWS ONLY;
INSERT INTO WAHL(WAHL_DATUM) SELECT to_date("erste Eingabe Datum",'mm-dd-yy') from STAGEING_STAT_DOWNLOAD_NR08_NEW FETCH FIRST 1 ROWS ONLY;
INSERT INTO WAHL(WAHL_DATUM) SELECT to_date("erste Eingabe Datum",'mm-dd-yy') from STAGEING_STAT_DOWNLOAD_NR13_NEW FETCH FIRST 1 ROWS ONLY;
INSERT INTO WAHL(WAHL_DATUM) SELECT to_date("erste Eingabe Datum") from STAGEING_STAT_DOWNLOAD_NR17_NEW FETCH FIRST 1 ROWS ONLY;
INSERT INTO WAHL(WAHL_DATUM) SELECT to_date("erste Eingabe Datum") from STAGEING_STAT_DOWNLOAD_NR19_NEW FETCH FIRST 1 ROWS ONLY;


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

SELECT * FROM wahlkreise;

INSERT INTO WAHL_BERECHTIGTE (WAHLKREIS, BERECHTIGTE, ABGEGEBEN, WAHLBETEILIGUNG, WAHL)
SELECT (SELECT id FROM wahlkreise k WHERE k.NR = s."Nr. " ), "Wahlbe rechtigte", "abgegeb. Stimmen", "Wahlbet. in %", w.ID FROM STAGEING_STAT_DOWNLOAD_NR02_NEW s JOIN WAHL w ON WAHL_DATUM = to_date("erste Eingabe Datum", 'dd.mm.yy');
