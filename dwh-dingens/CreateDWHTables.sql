create table partei
(
    id         int GENERATED by default on null as IDENTITY
        primary key,
    name       varchar(255)           not null,
    von        date default current_date null,
    bis        date                   null,
    vorgänger int                    null,
    constraint partei_partei_id_fk
        foreign key (vorgänger) references partei (id)
);

create table wahl
(
    id         int GENERATED by default on null as IDENTITY
        primary key,
    wahl_datum date not null
);

create table wahlkreise
(
    id         int GENERATED by default on null as IDENTITY
        primary key,
    nr         varchar2(255) not null,
    name       varchar2(255)           not null,
    von        date default current_date null,
    bis        date                   null,
    vorgänger int                  null,
    constraint wahlkreise_wahlkreise_id_fk
        foreign key (vorgänger) references wahlkreise (id)
);

create table wahl_berechtigte
(
    wahlkreis       int          not null,
    berechtigte     int default 0 not null,
    abgegeben       int           null,
    wahl            int           null,
    wahlbeteiligung int           null,
    constraint wahl_berechtigte_wahl_null_fk
        foreign key (wahl) references wahl (id),
    constraint wahl_berechtigte_wahlkreise_null_fk
        foreign key (wahlkreis) references wahlkreise (id)
);

create table wahlkreis_stimmen
(
    wahlkreis int           not null,
    stimmen   int default 0 not null,
    prozent   int default 0 null,
    wahl      int           null,
    partei    int           null,
    constraint wahlkreis_stimmen_partei_null_fk
        foreign key (partei) references partei (id),
    constraint wahlkreis_stimmen_wahl_null_fk
        foreign key (wahl) references wahl (id),
    constraint wahlkreis_stimmen_wahlkreise_null_fk
        foreign key (wahlkreis) references wahlkreise (id)
);

/*
DROP TABLE PARTEI CASCADE CONSTRAINTS;
DROP TABLE WAHL_BERECHTIGTE CASCADE CONSTRAINTS ;
DROP TABLE WAHL CASCADE CONSTRAINTS;
DROP TABLE WAHLKREISE CASCADE CONSTRAINTS ;
DROP TABLE WAHLKREIS_STIMMEN CASCADE CONSTRAINTS ;
*/

/*RENAME STAT_DOWNLOAD_NR02_NEW TO STAGEING_STAT_DOWNLOAD_NR02_NEW;
RENAME STAT_DOWNLOAD_NR06_NEW TO STAGEING_STAT_DOWNLOAD_NR06_NEW;
RENAME STAT_DOWNLOAD_NR08_NEW TO STAGEING_STAT_DOWNLOAD_NR08_NEW;
RENAME STAT_DOWNLOAD_NR13_NEW TO STAGEING_STAT_DOWNLOAD_NR13_NEW;
RENAME STAT_DOWNLOAD_NR17_NEW TO STAGEING_STAT_DOWNLOAD_NR17_NEW;
RENAME STAT_DOWNLOAD_NR19_NEW TO STAGEING_STAT_DOWNLOAD_NR19_NEW;*/