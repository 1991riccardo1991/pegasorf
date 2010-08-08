--
-- PostgreSQL database dump
--

-- Started on 2010-08-08 18:43:17

SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- TOC entry 1 (class 2615 OID 34615)
-- Name: doc; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA doc;


ALTER SCHEMA doc OWNER TO postgres;

--
-- TOC entry 2043 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 358 (class 2612 OID 16386)
-- Name: plpgsql; Type: PROCEDURAL LANGUAGE; Schema: -; Owner: postgres
--

CREATE PROCEDURAL LANGUAGE plpgsql;


SET search_path = doc, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1363 (class 1259 OID 34616)
-- Dependencies: 1
-- Name: acconto; Type: TABLE; Schema: doc; Owner: postgres; Tablespace: 
--

CREATE TABLE acconto (
    id bigint NOT NULL,
    data date,
    totale double precision,
    note character varying,
    fattura bigint
);


ALTER TABLE doc.acconto OWNER TO postgres;

--
-- TOC entry 1364 (class 1259 OID 34621)
-- Dependencies: 1
-- Name: bolla; Type: TABLE; Schema: doc; Owner: postgres; Tablespace: 
--

CREATE TABLE bolla (
    id bigint NOT NULL
);


ALTER TABLE doc.bolla OWNER TO postgres;

--
-- TOC entry 1365 (class 1259 OID 34623)
-- Dependencies: 1
-- Name: consegna; Type: TABLE; Schema: doc; Owner: postgres; Tablespace: 
--

CREATE TABLE consegna (
    id bigint NOT NULL,
    descrizione character varying
);


ALTER TABLE doc.consegna OWNER TO postgres;

--
-- TOC entry 1366 (class 1259 OID 34628)
-- Dependencies: 1
-- Name: ddt; Type: TABLE; Schema: doc; Owner: postgres; Tablespace: 
--

CREATE TABLE ddt (
    id bigint NOT NULL,
    serie character(3),
    sconto double precision,
    spese_trasporto double precision,
    spese_incasso double precision,
    causale bigint,
    riferimento character varying,
    consegna_a_mezzo bigint,
    porto bigint,
    pagamento bigint,
    colli integer,
    destinazione bigint
);


ALTER TABLE doc.ddt OWNER TO postgres;

--
-- TOC entry 1367 (class 1259 OID 34633)
-- Dependencies: 1761 1762 1763 1
-- Name: dettaglio_documento; Type: TABLE; Schema: doc; Owner: postgres; Tablespace: 
--

CREATE TABLE dettaglio_documento (
    id bigint NOT NULL,
    descrizione character varying,
    um character(1),
    iva bigint,
    quantita double precision DEFAULT 0,
    imponibile double precision DEFAULT 0,
    sconto integer DEFAULT 0,
    documento bigint
);


ALTER TABLE doc.dettaglio_documento OWNER TO postgres;

--
-- TOC entry 1368 (class 1259 OID 34641)
-- Dependencies: 1
-- Name: documento; Type: TABLE; Schema: doc; Owner: postgres; Tablespace: 
--

CREATE TABLE documento (
    id bigint NOT NULL,
    data_emissione date,
    tipo_documento smallint,
    cliente bigint,
    note character varying,
    numero_documento bigint
);


ALTER TABLE doc.documento OWNER TO postgres;

--
-- TOC entry 1369 (class 1259 OID 34646)
-- Dependencies: 1
-- Name: fattura; Type: TABLE; Schema: doc; Owner: postgres; Tablespace: 
--

CREATE TABLE fattura (
    id bigint NOT NULL,
    spese_trasporto double precision,
    spese_incasso double precision,
    pagamento bigint,
    note_pagamento character varying,
    serie character(1),
    sconto double precision,
    banca_abi character(5),
    banca_cab character(5),
    banca_iban character varying(1)
);


ALTER TABLE doc.fattura OWNER TO postgres;

--
-- TOC entry 1370 (class 1259 OID 34656)
-- Dependencies: 1764 1765 1766 1
-- Name: ordine; Type: TABLE; Schema: doc; Owner: postgres; Tablespace: 
--

CREATE TABLE ordine (
    id bigint NOT NULL,
    sconto integer DEFAULT 0,
    spese_trasporto double precision DEFAULT 0,
    spese_incasso double precision DEFAULT 0,
    annotazioni character varying,
    pagamento bigint,
    note_pagamento character varying,
    banca_abi character(5),
    banca_cab character(5),
    banca_iban character varying,
    stato bigint,
    convertito integer,
    tipo_documento character(3)
);


ALTER TABLE doc.ordine OWNER TO postgres;

--
-- TOC entry 1371 (class 1259 OID 34664)
-- Dependencies: 1
-- Name: porto; Type: TABLE; Schema: doc; Owner: postgres; Tablespace: 
--

CREATE TABLE porto (
    id bigint NOT NULL,
    descrizione character varying
);


ALTER TABLE doc.porto OWNER TO postgres;

--
-- TOC entry 1372 (class 1259 OID 34669)
-- Dependencies: 1
-- Name: ricevuta; Type: TABLE; Schema: doc; Owner: postgres; Tablespace: 
--

CREATE TABLE ricevuta (
    id bigint NOT NULL,
    spese_trasporto double precision,
    spese_incasso double precision,
    pagamento bigint,
    note_pagamento character varying,
    serie character(3),
    sconto double precision,
    banca_abi character(5),
    banca_cab character(5),
    banca_iban character varying(1)
);


ALTER TABLE doc.ricevuta OWNER TO postgres;

--
-- TOC entry 1373 (class 1259 OID 34674)
-- Dependencies: 1
-- Name: stato; Type: TABLE; Schema: doc; Owner: postgres; Tablespace: 
--

CREATE TABLE stato (
    id bigint NOT NULL,
    descrizione character varying
);


ALTER TABLE doc.stato OWNER TO postgres;

SET search_path = public, pg_catalog;

--
-- TOC entry 1408 (class 1259 OID 35767)
-- Dependencies: 6
-- Name: articoli; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE articoli (
    idarticolo bigint NOT NULL,
    um bigint,
    idfornitore bigint,
    idreparto bigint,
    idpannello bigint,
    codfornitore character varying(40),
    codbarre character varying(40),
    descrizione character varying(100) NOT NULL,
    prezzo_acquisto double precision,
    iva bigint,
    prezzo_dettaglio double precision,
    prezzo_ingrosso double precision,
    imballo character varying(50),
    peso double precision,
    sconto bigint,
    colore character varying(40),
    scorta_minima bigint,
    note character varying(200),
    data_inserimento date,
    carico_iniziale bigint,
    scorta_massima bigint,
    numero_pacchetti integer,
    qta_infinita boolean NOT NULL
);


ALTER TABLE public.articoli OWNER TO postgres;

--
-- TOC entry 1374 (class 1259 OID 34679)
-- Dependencies: 1767 1768 6
-- Name: articolo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE articolo (
    idarticolo bigint NOT NULL,
    codfornitore character varying(40),
    codbarre character varying(40),
    descrizione character varying(100) NOT NULL,
    prezzo_acquisto double precision,
    iva bigint,
    um bigint,
    prezzo_dettaglio double precision,
    prezzo_ingrosso double precision,
    imballo character varying(50),
    peso double precision,
    sconto bigint,
    idreparto bigint,
    colore character varying(40),
    scorta_minima bigint,
    note character varying(200),
    data_inserimento date,
    carico_iniziale bigint,
    scorta_massima bigint,
    numero_pacchetti integer DEFAULT 0,
    idpannello bigint,
    qta_infinita boolean DEFAULT false
);


ALTER TABLE public.articolo OWNER TO postgres;

--
-- TOC entry 1375 (class 1259 OID 34686)
-- Dependencies: 1769 1770 1771 1772 1773 6
-- Name: carico; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE carico (
    idcarico bigint NOT NULL,
    idfornitore bigint,
    data_carico date,
    ora_carico time without time zone,
    note character varying(200),
    iddocumento bigint,
    num_documento character varying,
    data_documento date,
    totale_documento double precision,
    sospeso integer DEFAULT 0,
    rif_doc integer DEFAULT -1,
    sconto integer DEFAULT 0,
    iva_documento integer DEFAULT -1,
    ins_pn integer DEFAULT 0,
    riferimento_ordine bigint
);


ALTER TABLE public.carico OWNER TO postgres;

--
-- TOC entry 1376 (class 1259 OID 34696)
-- Dependencies: 1774 6
-- Name: dettaglio_carico; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dettaglio_carico (
    idarticolo bigint NOT NULL,
    idcarico bigint NOT NULL,
    qta double precision NOT NULL,
    prezzo_acquisto double precision,
    sconto integer DEFAULT 0
);


ALTER TABLE public.dettaglio_carico OWNER TO postgres;

--
-- TOC entry 1377 (class 1259 OID 34699)
-- Dependencies: 6
-- Name: fornitore; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE fornitore (
    idfornitore bigint NOT NULL,
    data_inserimento date,
    nome character varying(100) NOT NULL,
    piva character varying(40),
    codfisc character varying(40),
    via character varying(40),
    cap character varying(40),
    citta character varying(40),
    tel character varying(40),
    cell character varying(40),
    fax character varying(40),
    email character varying(40),
    website character varying(40),
    note character varying(200),
    codbarre character varying,
    provincia bigint
);


ALTER TABLE public.fornitore OWNER TO postgres;

--
-- TOC entry 1378 (class 1259 OID 34704)
-- Dependencies: 6
-- Name: um; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE um (
    idum bigint NOT NULL,
    nome character varying(40) NOT NULL,
    descrizione character varying(100)
);


ALTER TABLE public.um OWNER TO postgres;

--
-- TOC entry 1379 (class 1259 OID 34706)
-- Dependencies: 1499 6
-- Name: articoli_caricati_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW articoli_caricati_view AS
    SELECT d.idarticolo, d.idcarico, a.codbarre, a.descrizione, a.iva, u.nome AS um, d.qta, d.prezzo_acquisto, d.sconto FROM articolo a, carico c, dettaglio_carico d, fornitore f, um u WHERE ((((a.idarticolo = d.idarticolo) AND (c.idcarico = d.idcarico)) AND (c.idfornitore = f.idfornitore)) AND (u.idum = a.um));


ALTER TABLE public.articoli_caricati_view OWNER TO postgres;

--
-- TOC entry 1380 (class 1259 OID 34709)
-- Dependencies: 6
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE cliente (
    idcliente bigint NOT NULL,
    data_inserimento date,
    nome character varying(40) NOT NULL,
    cognome character varying(40) NOT NULL,
    piva character varying(40),
    codfisc character varying(40),
    via character varying(40),
    cap character varying(40),
    citta character varying(40),
    tel character varying(40),
    cell character varying(40),
    fax character varying(40),
    email character varying(50),
    website character varying(40),
    note character varying(200),
    data_nascita date,
    num_doc character varying,
    rilasciato_il date,
    nato_a character varying,
    intestazione character varying,
    provincia bigint,
    documento bigint,
    rilasciato_da bigint,
    nazionalita bigint,
    rilasciato_di character varying
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 1381 (class 1259 OID 34714)
-- Dependencies: 6
-- Name: dettaglio_scarico; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dettaglio_scarico (
    idordine bigint NOT NULL,
    idarticolo bigint NOT NULL,
    qta double precision NOT NULL,
    sconto bigint,
    prezzo_acquisto double precision,
    prezzo_vendita double precision,
    iva integer
);


ALTER TABLE public.dettaglio_scarico OWNER TO postgres;

--
-- TOC entry 1382 (class 1259 OID 34716)
-- Dependencies: 1775 1776 1777 1778 1779 1780 6
-- Name: scarico; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE scarico (
    idordine bigint NOT NULL,
    idcliente bigint,
    data_ordine date,
    ora_ordine time without time zone,
    note character varying(200),
    tipo_documento bigint,
    num_documento character varying,
    data_documento date,
    totale_documento double precision,
    iva_documento integer DEFAULT -1,
    doc_emesso integer,
    doc_fiscale integer,
    ins_pn integer DEFAULT 0,
    idpagamento bigint,
    idcausale bigint,
    spese_incasso double precision DEFAULT 0,
    spese_trasporto double precision DEFAULT 0,
    data_trasp date,
    ora_trasp time with time zone,
    colli integer,
    peso double precision DEFAULT 0,
    consegna character varying,
    porto character varying,
    diversa_dest character varying,
    idaspetto bigint,
    sconto integer DEFAULT 0,
    pagamento bigint,
    sconto_euro double precision,
    numero_fattura character varying(200),
    numero_ricevuta character varying(20),
    numero_non_fiscale character varying(20),
    riferimento_ordine bigint
);


ALTER TABLE public.scarico OWNER TO postgres;

--
-- TOC entry 1383 (class 1259 OID 34727)
-- Dependencies: 1500 6
-- Name: articoli_scaricati_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW articoli_scaricati_view AS
    SELECT d.idordine, d.idarticolo, a.codbarre, a.descrizione, d.prezzo_acquisto, a.prezzo_ingrosso, a.prezzo_dettaglio, a.iva, u.nome AS um, d.qta, d.sconto, d.prezzo_vendita FROM articolo a, dettaglio_scarico d, scarico o, cliente c, um u WHERE ((((a.idarticolo = d.idarticolo) AND (d.idordine = o.idordine)) AND (o.idcliente = c.idcliente)) AND (u.idum = a.um));


ALTER TABLE public.articoli_scaricati_view OWNER TO postgres;

--
-- TOC entry 1384 (class 1259 OID 34730)
-- Dependencies: 6
-- Name: aspetto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE aspetto (
    idaspetto bigint NOT NULL,
    nome character varying(40) NOT NULL
);


ALTER TABLE public.aspetto OWNER TO postgres;

--
-- TOC entry 1409 (class 1259 OID 35774)
-- Dependencies: 6
-- Name: banca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE banca (
    idbanca bigint NOT NULL,
    ragione_sociale character varying(255) NOT NULL,
    note character varying(255)
);


ALTER TABLE public.banca OWNER TO postgres;

--
-- TOC entry 1410 (class 1259 OID 35781)
-- Dependencies: 6
-- Name: carichi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE carichi (
    idcarico bigint NOT NULL,
    idfornitore bigint,
    iddocumento bigint,
    data_carico date,
    ora_carico time without time zone,
    note character varying(200),
    num_documento character varying(255),
    data_documento date,
    totale_documento double precision,
    sospeso integer,
    rif_doc integer,
    sconto integer,
    iva_documento integer,
    ins_pn integer,
    riferimento_ordine bigint
);


ALTER TABLE public.carichi OWNER TO postgres;

--
-- TOC entry 1385 (class 1259 OID 34732)
-- Dependencies: 6
-- Name: categoria; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE categoria (
    id bigint NOT NULL,
    data_creazione date,
    descrizione character varying NOT NULL,
    note character varying
);


ALTER TABLE public.categoria OWNER TO postgres;

--
-- TOC entry 1386 (class 1259 OID 34737)
-- Dependencies: 6
-- Name: causale; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE causale (
    idcausale bigint NOT NULL,
    nome character varying(40) NOT NULL
);


ALTER TABLE public.causale OWNER TO postgres;

--
-- TOC entry 1411 (class 1259 OID 35785)
-- Dependencies: 6
-- Name: clienti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE clienti (
    idcliente bigint NOT NULL,
    nazionalita bigint,
    documento bigint,
    provincia bigint,
    rilasciato_da bigint,
    data_inserimento date,
    nome character varying(40) NOT NULL,
    cognome character varying(40) NOT NULL,
    piva character varying(40),
    codfisc character varying(40),
    via character varying(40),
    cap character varying(40),
    citta character varying(40),
    tel character varying(40),
    cell character varying(40),
    fax character varying(40),
    email character varying(50),
    website character varying(40),
    note character varying(200),
    data_nascita date,
    num_doc character varying(255),
    rilasciato_il date,
    nato_a character varying(255),
    intestazione character varying(255),
    rilasciato_di character varying(255)
);


ALTER TABLE public.clienti OWNER TO postgres;

--
-- TOC entry 1407 (class 1259 OID 35514)
-- Dependencies: 6
-- Name: codici_iva; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE codici_iva (
    id bigint NOT NULL,
    codice character varying(3) NOT NULL,
    percentuale double precision NOT NULL,
    descrizione character varying(30),
    descrizione_breve character varying(15)
);


ALTER TABLE public.codici_iva OWNER TO postgres;

--
-- TOC entry 1412 (class 1259 OID 35792)
-- Dependencies: 6
-- Name: conto_bancario; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE conto_bancario (
    idconto bigint NOT NULL,
    idbanca bigint NOT NULL,
    abi integer,
    cab integer,
    cc integer,
    iban character varying(255)
);


ALTER TABLE public.conto_bancario OWNER TO postgres;

--
-- TOC entry 1387 (class 1259 OID 34739)
-- Dependencies: 6
-- Name: destinazione; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE destinazione (
    id bigint NOT NULL,
    ragione_sociale character varying,
    piva character(1),
    cofice_fiscale character(1),
    indirizzo character varying,
    cap character(5),
    localita character(1),
    provincia character(2),
    paese bigint,
    telefono character(1),
    fax character(1),
    email character(1),
    cellulare character(1),
    note character varying
);


ALTER TABLE public.destinazione OWNER TO postgres;

--
-- TOC entry 1413 (class 1259 OID 35796)
-- Dependencies: 6
-- Name: dettagli_documenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dettagli_documenti (
    id integer NOT NULL,
    id_documento integer NOT NULL,
    descrizione character varying(50) NOT NULL,
    aliquota integer,
    qta integer,
    prezzo double precision,
    prezzo_totale double precision,
    imponibile double precision,
    imposta double precision
);


ALTER TABLE public.dettagli_documenti OWNER TO postgres;

--
-- TOC entry 1414 (class 1259 OID 35800)
-- Dependencies: 6
-- Name: dettaglio_carichi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dettaglio_carichi (
    idarticolo bigint NOT NULL,
    idcarico bigint NOT NULL,
    qta double precision NOT NULL,
    prezzo_acquisto double precision,
    sconto integer
);


ALTER TABLE public.dettaglio_carichi OWNER TO postgres;

--
-- TOC entry 1415 (class 1259 OID 35804)
-- Dependencies: 6
-- Name: dettaglio_ordine_manuale; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dettaglio_ordine_manuale (
    id bigint NOT NULL,
    ordine bigint NOT NULL,
    descrizione character varying(255) NOT NULL,
    qta double precision NOT NULL,
    sconto bigint,
    prezzo_vendita double precision,
    iva integer
);


ALTER TABLE public.dettaglio_ordine_manuale OWNER TO postgres;

--
-- TOC entry 1416 (class 1259 OID 35808)
-- Dependencies: 6
-- Name: dettaglio_ordini; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dettaglio_ordini (
    idordine bigint NOT NULL,
    idarticolo bigint NOT NULL,
    qta double precision NOT NULL,
    sconto bigint,
    prezzo_acquisto double precision,
    prezzo_vendita double precision,
    iva integer
);


ALTER TABLE public.dettaglio_ordini OWNER TO postgres;

--
-- TOC entry 1388 (class 1259 OID 34744)
-- Dependencies: 1781 1782 6
-- Name: dettaglio_scarico_manuale; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE dettaglio_scarico_manuale (
    id bigint NOT NULL,
    descrizione character varying NOT NULL,
    qta double precision DEFAULT 0 NOT NULL,
    sconto bigint DEFAULT 0,
    prezzo_vendita double precision,
    iva integer,
    ordine bigint NOT NULL
);


ALTER TABLE public.dettaglio_scarico_manuale OWNER TO postgres;

--
-- TOC entry 1417 (class 1259 OID 35812)
-- Dependencies: 6
-- Name: documenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE documenti (
    id integer NOT NULL,
    num_documento integer NOT NULL,
    data_documento date,
    tipo character varying(10),
    stato character varying(10),
    imponibile_netto double precision,
    sconto double precision,
    imponibile_scontato double precision,
    imposta double precision,
    totale_documento double precision
);


ALTER TABLE public.documenti OWNER TO postgres;

--
-- TOC entry 1389 (class 1259 OID 34751)
-- Dependencies: 6
-- Name: documento_cliente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE documento_cliente (
    id bigint NOT NULL,
    descrizione character varying NOT NULL,
    abbreviazione character varying(10)
);


ALTER TABLE public.documento_cliente OWNER TO postgres;

--
-- TOC entry 1390 (class 1259 OID 34756)
-- Dependencies: 6
-- Name: ente; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ente (
    idente bigint NOT NULL,
    descrizione character varying NOT NULL
);


ALTER TABLE public.ente OWNER TO postgres;

--
-- TOC entry 1418 (class 1259 OID 35816)
-- Dependencies: 6
-- Name: fornitori; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE fornitori (
    idfornitore bigint NOT NULL,
    provincia bigint,
    data_inserimento date,
    nome character varying(100) NOT NULL,
    piva character varying(40),
    codfisc character varying(40),
    via character varying(40),
    cap character varying(40),
    citta character varying(40),
    tel character varying(40),
    cell character varying(40),
    fax character varying(40),
    email character varying(40),
    website character varying(40),
    note character varying(200),
    codbarre character varying(255)
);


ALTER TABLE public.fornitori OWNER TO postgres;

--
-- TOC entry 1391 (class 1259 OID 34761)
-- Dependencies: 1501 6
-- Name: qta_caricate_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW qta_caricate_view AS
    SELECT a.idarticolo, a.codbarre, sum(d.qta) AS sum FROM articolo a, carico c, dettaglio_carico d WHERE (((d.idcarico = c.idcarico) AND (a.idarticolo = d.idarticolo)) AND (c.iddocumento <> 0)) GROUP BY a.idarticolo, a.codbarre;


ALTER TABLE public.qta_caricate_view OWNER TO postgres;

--
-- TOC entry 1392 (class 1259 OID 34764)
-- Dependencies: 1502 6
-- Name: qta_scaricate_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW qta_scaricate_view AS
    SELECT a.idarticolo, a.codbarre, sum(d.qta) AS sum FROM articolo a, scarico c, dettaglio_scarico d WHERE ((d.idordine = c.idordine) AND (a.idarticolo = d.idarticolo)) GROUP BY a.idarticolo, a.codbarre;


ALTER TABLE public.qta_scaricate_view OWNER TO postgres;

--
-- TOC entry 1393 (class 1259 OID 34767)
-- Dependencies: 1503 6
-- Name: giacenza_articoli_all_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW giacenza_articoli_all_view AS
    SELECT c.idarticolo, a.codbarre AS codice, a.descrizione, um.nome AS um, c.sum AS carico, o.sum AS scarico, (c.sum - o.sum) AS deposito, a.prezzo_acquisto, (a.prezzo_acquisto * (c.sum - o.sum)) AS prezzo_tot FROM ((articolo a JOIN (qta_caricate_view c LEFT JOIN qta_scaricate_view o ON ((c.idarticolo = o.idarticolo))) ON ((a.idarticolo = c.idarticolo))) JOIN um ON ((a.um = um.idum)));


ALTER TABLE public.giacenza_articoli_all_view OWNER TO postgres;

--
-- TOC entry 1394 (class 1259 OID 34771)
-- Dependencies: 1504 6
-- Name: giacenza_articoli_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW giacenza_articoli_view AS
    SELECT c.idarticolo, a.codbarre AS codice, a.descrizione, um.nome AS um, c.sum AS carico, o.sum AS scarico, (c.sum - o.sum) AS deposito, a.prezzo_acquisto, (a.prezzo_acquisto * (c.sum - o.sum)) AS prezzo_tot FROM ((articolo a JOIN (qta_caricate_view c LEFT JOIN qta_scaricate_view o ON ((c.idarticolo = o.idarticolo))) ON ((a.idarticolo = c.idarticolo))) JOIN um ON ((a.um = um.idum))) WHERE ((c.sum - o.sum) > ((0)::numeric)::double precision);


ALTER TABLE public.giacenza_articoli_view OWNER TO postgres;

--
-- TOC entry 1395 (class 1259 OID 34775)
-- Dependencies: 6
-- Name: immagine_articolo; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE immagine_articolo (
    id bigint NOT NULL,
    nome character varying NOT NULL,
    estensione character(10),
    file bytea,
    articolo bigint
);


ALTER TABLE public.immagine_articolo OWNER TO postgres;

--
-- TOC entry 1419 (class 1259 OID 35823)
-- Dependencies: 6
-- Name: movimento_banca; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE movimento_banca (
    idmov bigint NOT NULL,
    idconto bigint NOT NULL,
    data_inserimento date,
    data_scadenza date,
    descrizione character varying(255),
    entrate double precision,
    uscite double precision,
    note character varying(255)
);


ALTER TABLE public.movimento_banca OWNER TO postgres;

--
-- TOC entry 1396 (class 1259 OID 34780)
-- Dependencies: 6
-- Name: nazionalita; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE nazionalita (
    idnazionalita bigint NOT NULL,
    descrizione character varying NOT NULL
);


ALTER TABLE public.nazionalita OWNER TO postgres;

--
-- TOC entry 1420 (class 1259 OID 35830)
-- Dependencies: 6
-- Name: ordini; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ordini (
    idordine bigint NOT NULL,
    tipo_documento bigint,
    idaspetto bigint,
    pagamento bigint,
    idcausale bigint,
    idpagamento bigint,
    idcliente bigint,
    data_ordine date,
    ora_ordine time without time zone,
    note character varying(200),
    num_documento character varying(255),
    data_documento date,
    totale_documento double precision,
    iva_documento integer,
    doc_emesso integer,
    doc_fiscale integer,
    ins_pn integer,
    spese_incasso double precision,
    spese_trasporto double precision,
    data_trasp date,
    ora_trasp time without time zone,
    colli integer,
    peso double precision,
    consegna character varying(255),
    porto character varying(255),
    diversa_dest character varying(255),
    sconto integer,
    sconto_euro double precision,
    numero_fattura character varying(200),
    numero_ricevuta character varying(20),
    numero_non_fiscale character varying(20),
    riferimento_ordine bigint
);


ALTER TABLE public.ordini OWNER TO postgres;

--
-- TOC entry 1397 (class 1259 OID 34785)
-- Dependencies: 6
-- Name: paese; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE paese (
    id bigint NOT NULL,
    descrizione character(1)
);


ALTER TABLE public.paese OWNER TO postgres;

--
-- TOC entry 1398 (class 1259 OID 34787)
-- Dependencies: 6
-- Name: pagamento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pagamento (
    idpagamento bigint NOT NULL,
    nome character varying(40) NOT NULL
);


ALTER TABLE public.pagamento OWNER TO postgres;

--
-- TOC entry 1399 (class 1259 OID 34789)
-- Dependencies: 6
-- Name: pannelli; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE pannelli (
    idpannelli bigint NOT NULL,
    nome character varying(40)
);


ALTER TABLE public.pannelli OWNER TO postgres;

--
-- TOC entry 1421 (class 1259 OID 35837)
-- Dependencies: 6
-- Name: prenotazione; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE prenotazione (
    id integer NOT NULL,
    id_cliente integer,
    n_pax integer,
    num_persone integer,
    dal date,
    al date,
    id_convenzione integer,
    acconto character varying(255),
    mod_arrivo character varying(255),
    note character varying(255),
    stato character varying(255),
    accontoric character varying(2),
    nbimbi integer,
    scontoperc integer,
    scontoeuro double precision,
    scontobimbi integer,
    chiuso character varying(2),
    solo_camera character varying(2),
    ordine bigint,
    maggiorazione integer,
    numero_ragazzi integer,
    sconto_ragazzi integer
);


ALTER TABLE public.prenotazione OWNER TO postgres;

--
-- TOC entry 1400 (class 1259 OID 34791)
-- Dependencies: 1783 1784 6
-- Name: progressivi; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE progressivi (
    prog_fattura integer NOT NULL,
    prog_ricevuta integer NOT NULL,
    prog_scontrino integer NOT NULL,
    prog_non_fiscale integer DEFAULT 0 NOT NULL,
    anno integer DEFAULT 2008 NOT NULL
);


ALTER TABLE public.progressivi OWNER TO postgres;

--
-- TOC entry 1401 (class 1259 OID 34795)
-- Dependencies: 6
-- Name: provincia; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE provincia (
    idprovincia bigint NOT NULL,
    provincia character varying NOT NULL,
    targa character(2)
);


ALTER TABLE public.provincia OWNER TO postgres;

--
-- TOC entry 1422 (class 1259 OID 35844)
-- Dependencies: 6
-- Name: reparti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE reparti (
    idreparto bigint NOT NULL,
    categoria bigint,
    data_creazione date,
    nome character varying(40),
    descrizione character varying(100)
);


ALTER TABLE public.reparti OWNER TO postgres;

--
-- TOC entry 1402 (class 1259 OID 34800)
-- Dependencies: 6
-- Name: reparto; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE reparto (
    idreparto bigint NOT NULL,
    data_creazione date,
    nome character varying(40),
    descrizione character varying(100),
    categoria bigint
);


ALTER TABLE public.reparto OWNER TO postgres;

--
-- TOC entry 1403 (class 1259 OID 34802)
-- Dependencies: 6
-- Name: tipo_documento; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tipo_documento (
    iddocumento bigint NOT NULL,
    tipo character varying(40) NOT NULL,
    descrizione character varying(200)
);


ALTER TABLE public.tipo_documento OWNER TO postgres;

--
-- TOC entry 1404 (class 1259 OID 34804)
-- Dependencies: 6
-- Name: tmp_etichette; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tmp_etichette (
    id bigint NOT NULL,
    codice character varying,
    descrizione character varying,
    prezzo double precision,
    note character varying
);


ALTER TABLE public.tmp_etichette OWNER TO postgres;

--
-- TOC entry 1405 (class 1259 OID 34809)
-- Dependencies: 6
-- Name: tmp_etichette_fornitori; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tmp_etichette_fornitori (
    idfornitore bigint NOT NULL,
    nome character varying,
    via character varying,
    cap character varying,
    citta character varying,
    provincia character varying
);


ALTER TABLE public.tmp_etichette_fornitori OWNER TO postgres;

--
-- TOC entry 1406 (class 1259 OID 34814)
-- Dependencies: 6
-- Name: tmp_scelti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE tmp_scelti (
    descrizione character varying,
    qta integer,
    prezzo double precision,
    totale double precision
);


ALTER TABLE public.tmp_scelti OWNER TO postgres;

--
-- TOC entry 1423 (class 1259 OID 35848)
-- Dependencies: 6
-- Name: u88fax; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE u88fax (
    id bigint NOT NULL,
    codice_aams character varying(1),
    kilogrammi character varying(255),
    grammi character varying(255)
);


ALTER TABLE public.u88fax OWNER TO postgres;

--
-- TOC entry 1424 (class 1259 OID 35855)
-- Dependencies: 6
-- Name: utenti; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE utenti (
    idutente bigint NOT NULL,
    nome character varying(20) NOT NULL,
    pwd character varying(20) NOT NULL,
    lettura integer NOT NULL,
    scrittura integer NOT NULL,
    esecuzione integer NOT NULL,
    note character varying(255) NOT NULL
);


ALTER TABLE public.utenti OWNER TO postgres;

SET search_path = doc, pg_catalog;

--
-- TOC entry 1984 (class 0 OID 34616)
-- Dependencies: 1363
-- Data for Name: acconto; Type: TABLE DATA; Schema: doc; Owner: postgres
--

COPY acconto (id, data, totale, note, fattura) FROM stdin;
\.


--
-- TOC entry 1985 (class 0 OID 34621)
-- Dependencies: 1364
-- Data for Name: bolla; Type: TABLE DATA; Schema: doc; Owner: postgres
--

COPY bolla (id) FROM stdin;
\.


--
-- TOC entry 1986 (class 0 OID 34623)
-- Dependencies: 1365
-- Data for Name: consegna; Type: TABLE DATA; Schema: doc; Owner: postgres
--

COPY consegna (id, descrizione) FROM stdin;
\.


--
-- TOC entry 1987 (class 0 OID 34628)
-- Dependencies: 1366
-- Data for Name: ddt; Type: TABLE DATA; Schema: doc; Owner: postgres
--

COPY ddt (id, serie, sconto, spese_trasporto, spese_incasso, causale, riferimento, consegna_a_mezzo, porto, pagamento, colli, destinazione) FROM stdin;
\.


--
-- TOC entry 1988 (class 0 OID 34633)
-- Dependencies: 1367
-- Data for Name: dettaglio_documento; Type: TABLE DATA; Schema: doc; Owner: postgres
--

COPY dettaglio_documento (id, descrizione, um, iva, quantita, imponibile, sconto, documento) FROM stdin;
\.


--
-- TOC entry 1989 (class 0 OID 34641)
-- Dependencies: 1368
-- Data for Name: documento; Type: TABLE DATA; Schema: doc; Owner: postgres
--

COPY documento (id, data_emissione, tipo_documento, cliente, note, numero_documento) FROM stdin;
\.


--
-- TOC entry 1990 (class 0 OID 34646)
-- Dependencies: 1369
-- Data for Name: fattura; Type: TABLE DATA; Schema: doc; Owner: postgres
--

COPY fattura (id, spese_trasporto, spese_incasso, pagamento, note_pagamento, serie, sconto, banca_abi, banca_cab, banca_iban) FROM stdin;
\.


--
-- TOC entry 1991 (class 0 OID 34656)
-- Dependencies: 1370
-- Data for Name: ordine; Type: TABLE DATA; Schema: doc; Owner: postgres
--

COPY ordine (id, sconto, spese_trasporto, spese_incasso, annotazioni, pagamento, note_pagamento, banca_abi, banca_cab, banca_iban, stato, convertito, tipo_documento) FROM stdin;
\.


--
-- TOC entry 1992 (class 0 OID 34664)
-- Dependencies: 1371
-- Data for Name: porto; Type: TABLE DATA; Schema: doc; Owner: postgres
--

COPY porto (id, descrizione) FROM stdin;
\.


--
-- TOC entry 1993 (class 0 OID 34669)
-- Dependencies: 1372
-- Data for Name: ricevuta; Type: TABLE DATA; Schema: doc; Owner: postgres
--

COPY ricevuta (id, spese_trasporto, spese_incasso, pagamento, note_pagamento, serie, sconto, banca_abi, banca_cab, banca_iban) FROM stdin;
\.


--
-- TOC entry 1994 (class 0 OID 34674)
-- Dependencies: 1373
-- Data for Name: stato; Type: TABLE DATA; Schema: doc; Owner: postgres
--

COPY stato (id, descrizione) FROM stdin;
\.


SET search_path = public, pg_catalog;

--
-- TOC entry 2023 (class 0 OID 35767)
-- Dependencies: 1408
-- Data for Name: articoli; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY articoli (idarticolo, um, idfornitore, idreparto, idpannello, codfornitore, codbarre, descrizione, prezzo_acquisto, iva, prezzo_dettaglio, prezzo_ingrosso, imballo, peso, sconto, colore, scorta_minima, note, data_inserimento, carico_iniziale, scorta_massima, numero_pacchetti, qta_infinita) FROM stdin;
\.


--
-- TOC entry 1995 (class 0 OID 34679)
-- Dependencies: 1374
-- Data for Name: articolo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY articolo (idarticolo, codfornitore, codbarre, descrizione, prezzo_acquisto, iva, um, prezzo_dettaglio, prezzo_ingrosso, imballo, peso, sconto, idreparto, colore, scorta_minima, note, data_inserimento, carico_iniziale, scorta_massima, numero_pacchetti, idpannello, qta_infinita) FROM stdin;
2781	276	\N	FORTE	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2810	17583	\N	MAC BAREN CUBE	0	1	2	32.799999999999997	32.799999999999997	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
1157	725	\N	CHE	0	1	2	2.9500000000000002	2.9500000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
3	2098	\N	AFRICAINE SENZA FILTRO	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
5	332	\N	AMADIS AZZURRA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
6	787	\N	AMADIS CLASSICA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
7	142	\N	AMADIS SILVER	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
8	364	\N	AROME VANILLE	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
12	99998	\N	BARCLAY CITY RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
13	NEW	\N	BASIC KS	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
15	1917	\N	BENSON & HEDGES AMERICAN BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
18	1916	\N	BENSON & HEDGES AMERICAN RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
21	1715	\N	BENSON & HEDGES AMERICAN RED 100 S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
23	872	\N	BENSON & HEDGES AMERICAN YELLOW	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
24	550	\N	BENSON & HEDGES GOLD	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
25	NEW	\N	BENSON & HEDGES PLATINUM	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
26	NEW	\N	BENSON & HEDGES RED	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
27	NEW	\N	BENSON & HEDGES RED STYLE	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
28	1270	\N	BENSON & HEDGES SILVER	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
29	1859	\N	BENSON & HEDGES SUPER SLIMS	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
30	686	\N	BIS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
33	NEW	\N	BOND STREET BLUE KS	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
34	NEW	\N	BOND STREET RED KS	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
35	NEW	\N	BOND STREET SILVER KS	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
36	61	\N	BRERA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
39	263	\N	CAMEL	0	1	2	4	4	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
40	632	\N	CAMEL BLUE	0	1	2	4	4	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
43	546	\N	CAMEL BLUE 100S	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
46	270	\N	CAMEL FILTERS	0	1	2	4	4	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
47	405	\N	CAMEL FILTERS 100S	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
48	1961	\N	CAMEL NATURAL FLAVOR	0	1	2	2.1499999999999999	2.1499999999999999	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
49	1879	\N	CAMEL NATURAL FLAVOR	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
0	\N	REPARTO 1	REPARTO 1	0	1	2	0	0	\N	0	0	3	\N	\N	\N	\N	\N	\N	\N	\N	f
50	1880	\N	CAMEL NATURAL FLAVOR BLUE	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
51	1962	\N	CAMEL NATURAL FLAVOR BLUE	0	1	2	2.1499999999999999	2.1499999999999999	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
52	2108	\N	CAMEL ONE	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
53	464	\N	CAMEL ORANGE	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
55	664	\N	CARTIER VENDOME	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
56	339	\N	CARTIER VENDOME BLEU	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
58	4006	\N	CHESTERFIELD BLU KS	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
60	2082	\N	CHESTERFIELD BLU KS	0	1	2	4	4	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
63	4005	\N	CHESTERFIELD KS	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
64	2081	\N	CHESTERFIELD KS	0	1	2	4	4	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
67	1694	\N	CIGARONNE EXCLUSIVE	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
68	1695	\N	CIGARONNE EXCLUSIVE WHITE	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
71	1698	\N	CIGARONNE ORIGINAL	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
72	1699	\N	CIGARONNE ORIGINAL BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
75	647	\N	COLOMBO K.S. FILTRO	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
76	NEW	\N	CORONAS MENTHOL	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
77	NEW	\N	CORONAS ORO	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
78	NEW	\N	CORONAS ROJO	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
79	525	\N	CORTINA SUPER KS	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
80	222	\N	CORTINA SUPER SLIM	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
82	758	\N	DAVIDOFF GOLD	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
83	583	\N	DAVIDOFF GOLD SLIMS	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
84	2112	\N	DAVIDOFF GOLD SUPER SLIMS	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
85	738	\N	DAVIDOFF MAGNUM	0	1	2	6	6	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
86	522	\N	DAVIDOFF MENTHOL	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
87	2009	\N	DAVIDOFF RICH BLUE	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
88	2111	\N	DAVIDOFF SILVER SUPER SLIMS	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
89	487	\N	DIANA AZZURRA KS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
91	2208	\N	DIANA BIANCA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
92	1983	\N	DIANA BLU 100s	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
94	4002	\N	DIANA BLU KS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
97	1714	\N	DIANA OCRA KS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
98	NEW	\N	DIANA ORIGINAL RS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
101	4001	\N	DIANA ROSSA KS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
105	NEW	\N	DRUM ORIGINAL	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
106	NEW	\N	DRUM SUBTLE	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
109	818	\N	DUNHILL - ROTHMANS L.L. BLU SLIM	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
110	291	\N	DUNHILL - ROTHMANS L.L. GOLD SLIM	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
111	798	\N	DUNHILL - ROTHMANS L.L. SLIM	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
112	1893	\N	DUNHILL BLUE	0	1	2	2.25	2.25	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
113	441	\N	DUNHILL BLUE	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
114	NEW	\N	DUNHILL ESSENCE RED	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
115	1897	\N	DUNHILL FINE CUT BLUE	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
116	1898	\N	DUNHILL FINE CUT SILVER	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
117	1610	\N	DUNHILL GOLD	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
118	1894	\N	DUNHILL GOLD	0	1	2	2.25	2.25	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
119	549	\N	DUNHILL INTERNATIONAL	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
120	1895	\N	DUNHILL KS	0	1	2	2.25	2.25	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
121	532	\N	DUNHILL KS	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
122	1899	\N	DUNHILL TOP LEAF	0	1	2	6.4000000000000004	6.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
129	215	\N	EMBASSY NUMBER 1 KS	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
130	627	\N	ESPORTAZIONE	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
133	498	\N	FINE 120 VIRGINIA BLEND	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
134	1217	\N	FORTUNA AZUL	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
135	1727	\N	FORTUNA AZUL	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
136	1905	\N	FORTUNA AZUL 100S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
137	1718	\N	FORTUNA BLUE 25S	0	1	2	4.6500000000000004	4.6500000000000004	\N	0	0	1	\N	0	Confezione astuccio da 25 pezzi	2009-07-10	0	0	\N	\N	f
138	1276	\N	FORTUNA CELESTE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
139	2100	\N	FORTUNA ONE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
140	1717	\N	FORTUNA RED 25S	0	1	2	4.6500000000000004	4.6500000000000004	\N	0	0	1	\N	0	Confezione astuccio da 25 pezzi	2009-07-10	0	0	\N	\N	f
141	1726	\N	FORTUNA ROJO	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
142	1213	\N	FORTUNA ROJO	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
143	1904	\N	FORTUNA ROJO 100S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
145	4013	\N	GAULOISES BLONDES BLU	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
146	1772	\N	GAULOISES BLONDES BLU	0	1	2	2	2	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
147	558	\N	GAULOISES BLONDES BLU	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
148	477	\N	GAULOISES BLONDES GIALLA	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
149	640	\N	GAULOISES BLONDES ROSSA	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
150	1773	\N	GAULOISES BLONDES ROSSA	0	1	2	2	2	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
151	4014	\N	GAULOISES BLONDES ROSSA	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
152	884	\N	GAULOISES BRUNES	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
154	888	\N	GITANES CAPORAL	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
155	391	\N	GITANES CAPORAL BOUT FILTRE	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
156	767	\N	HB KS	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
163	891	\N	KENT BLUE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
164	1965	\N	KENT NANOTEK BLACK	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
165	1966	\N	KENT NANOTEK BLUE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
166	1967	\N	KENT NANOTEK TITANIUM	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
167	499	\N	KENT ORIGINAL TASTE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
168	1220	\N	KENT SILVER	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
169	1901	\N	KENT WHITE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
170	974	\N	KIM SUPERSLIM	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
171	976	\N	KIM SUPERSLIM CELESTE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
174	1302	\N	L&M SILVER LABEL KS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
175	224	\N	LAMBERT & BUTLER KING SIZE	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
176	NEW	\N	LD BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
177	NEW	\N	LD RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
178	2006	\N	LIDO	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
179	629	\N	LIDO	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
180	87	\N	LIDO BLU	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
182	841	\N	LINDA BLU	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
183	1979	\N	LUCKY STRIKE FIRELEAF SILVER	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
184	1980	\N	LUCKY STRIKE MADURA SILVER	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
185	1981	\N	LUCKY STRIKE PIPERITA SILVER	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
187	536	\N	LUCKY STRIKE RED	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
189	1814	\N	LUCKY STRIKE RED SPECIAL EDITION	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
190	867	\N	LUCKY STRIKE SILVER	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
191	1836	\N	LUCKY STRIKE SILVER	0	1	2	2	2	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
192	1815	\N	LUCKY STRIKE SILVER SPECIAL EDITION	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
193	NEW	\N	MANITOU AMERICAN RED	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
199	551	\N	MARLBORO 100S	0	1	2	4.4500000000000002	4.4500000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
200	1896	\N	MARLBORO BLEND 29	0	1	2	2.2000000000000002	2.2000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
204	651	\N	MARLBORO GOLD 100S	0	1	2	4.4500000000000002	4.4500000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
205	4004	\N	MARLBORO GOLD KS	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
210	4003	\N	MARLBORO KS	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
214	NEW	\N	MARLBORO MENTHOL KS	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
216	197	\N	MARLBORO MX4 KS	0	1	2	2.1000000000000001	2.1000000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
222	1271	\N	MAYFAIR	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
223	1272	\N	MAYFAIR SKY BLUE	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
224	842	\N	MEINE SORTE 100 LUXURY LENGHT	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
225	518	\N	MEINE SORTE CLASSIC	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
226	466	\N	MEMPHIS ORIGINAL BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
227	351	\N	MEMPHIS ORIGINAL BLUE 100’S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
228	465	\N	MEMPHIS ORIGINAL RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
229	623	\N	MERCEDES SUPERIOR SELECTION 100S	0	1	2	4.0999999999999996	4.0999999999999996	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
230	617	\N	MERCEDES SUPERIOR SELECTION KS	0	1	2	4.0999999999999996	4.0999999999999996	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
232	256	\N	MERIT BLU 100S	0	1	2	4.3499999999999996	4.3499999999999996	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
233	4008	\N	MERIT BLU KS	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
234	874	\N	MERIT BLU KS	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
235	1722	\N	MERIT EVOLUTION KS	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
236	2034	\N	MERIT FRESH	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
237	949	\N	MERIT GIALLA 100S	0	1	2	4.3499999999999996	4.3499999999999996	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
238	4007	\N	MERIT GIALLA KS	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
241	376	\N	MERIT UNO KS	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
244	2045	\N	MONTECRISTO GOLD	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
245	2046	\N	MONTECRISTO RED	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
246	467	\N	MORE 120S FILTER	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
247	445	\N	MORE MENTHOL 120S	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
248	860	\N	MORE SPECIAL WHITES 120S	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
255	827	\N	MS 100"S DE LUXE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
256	1640	\N	MS AZZURRE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
257	1639	\N	MS AZZURRE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
258	1641	\N	MS AZZURRE	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
260	255	\N	MS BIANCHE	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
264	149	\N	MS BLU	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
265	851	\N	MS CHIARE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
266	253	\N	MS CHIARE	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
267	850	\N	MS CHIARE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
268	18	\N	MS CLASSIC SOFT	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
271	NEW	\N	MS D	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
272	NEW	\N	MS G	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
273	60	\N	MS INTERNATIONAL 100"S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
274	NEW	\N	MS P	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
275	62	\N	MS RED BOX	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
279	NEW	\N	MS SLIM	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
280	NEW	\N	MS T	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
282	951	\N	MULTIFILTER PHILIP MORRIS BLU 100S	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
283	952	\N	MULTIFILTER PHILIP MORRIS ROSSA 100S	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
284	948	\N	MULTIFILTER PHILIP MORRIS ROSSA 100S	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
285	369	\N	MULTIFILTER PHILIP MORRIS SLIMS	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio in colorazione blu da 20 pezzi	2009-07-10	0	0	\N	\N	f
287	995	\N	MUNDIAL	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
289	876	\N	MURATTI AMBASSADOR GOLD KS	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
290	561	\N	MURATTI AMBASSADOR KS	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
292	374	\N	MURATTI AMBASSADOR SUPER SLIM	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
293	NEW	\N	MURATTI&CO BLU 100s	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
294	1978	\N	MURATTI&CO BLUE	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
295	1920	\N	MURATTI&CO BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
296	4010	\N	MURATTI&CO BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
297	1977	\N	MURATTI&CO RED	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
298	4009	\N	MURATTI&CO RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
299	1919	\N	MURATTI&CO RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
300	NEW	\N	MURATTI&CO RED 100s	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
310	1942	\N	NATURAL AMERICAN SPIRIT BLUE	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
311	1943	\N	NATURAL AMERICAN SPIRIT YELLOW	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
312	251	\N	NAZIONALE BOX	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
315	658	\N	NAZIONALI FILTRO	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
316	1671	\N	NEWS BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
317	1672	\N	NEWS RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
318	1644	\N	NEXT BLUE KS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
319	1643	\N	NEXT KS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
322	NEW	\N	PALL MALL AMBER KS 10S	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
323	1547	\N	PALL MALL AMBER KS 20S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
324	1215	\N	PALL MALL AZURE 100s	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
325	1724	\N	PALL MALL AZURE KS 10S	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
326	427	\N	PALL MALL AZURE KS 20S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
327	1219	\N	PALL MALL BLUE 100s	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
329	1837	\N	PALL MALL BLUE KS 20S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
332	1749	\N	PALL MALL RED 100S KS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
334	1838	\N	PALL MALL RED KS 20S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
336	2110	\N	PALL MALL SAN FRANCISCO CHARCOAL 20S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
338	1214	\N	PALL MALL WHITE KS 20S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
339	NEW	\N	PARISIENNE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
340	NEW	\N	PARLIAMENT 100S	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
341	773	\N	PEER EXPORT	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
344	2084	\N	PETER STUYVESANT GOLD	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
345	1788	\N	PETER STUYVESANT GOLD 100S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
347	2083	\N	PETER STUYVESANT INTERNATIONAL	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
348	547	\N	PETER STUYVESANT INTERNATIONAL 100S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
349	864	\N	PHILIP MORRIS BLU 100S	0	1	2	4.3499999999999996	4.3499999999999996	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
353	247	\N	PHILIP MORRIS ONE KS	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
354	NEW	\N	PHILIP MORRIS SIGNATURE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
357	539	\N	PHILIP MORRIS UL KS	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
361	2099	\N	PUEBLO	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
365	608	\N	R1 SLIM LINE	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
366	585	\N	R6	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
369	272	\N	REGAL KING SIZE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
383	NEW	\N	ROTHMANS FINELY RICH	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
384	810	\N	ROTHMANS INTERNATIONAL	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
385	221	\N	ROTHMANS KS BLUE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
386	692	\N	ROTHMANS KS RED	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
387	NEW	\N	ROTHMANS SUBTLY RICH	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
388	360	\N	ROTHMANS SUPERSLIMS	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
389	1236	\N	ROUTE 66 BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
390	1234	\N	ROUTE 66 RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
391	1780	\N	ROUTE 66 SUPER BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
392	1918	\N	SAKURA	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
393	832	\N	SALEM	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
394	1251	\N	SAX AZURE SENSATION	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
395	1244	\N	SAX BLUE EMOTION	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
396	1250	\N	SAX BLUE EMOTION	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
397	1745	\N	SAX MUSICAL EMOTION (BLUE)	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
398	1744	\N	SAX MUSICAL PASSION (RED)	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
399	1746	\N	SAX MUSICAL SENSATION (AZURE)	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
400	1249	\N	SAX RED PASSION	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
401	1243	\N	SAX RED PASSION	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
402	897	\N	SILK CUT PURPLE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
403	NEW	\N	SILK CUT YELLOW	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
404	825	\N	SPECIAL R6	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
405	533	\N	ST. MORITZ MENTHOL	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
406	660	\N	STOP K.S. FILTRO	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
407	666	\N	SUPER FILTRO	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
408	322	\N	SUPERKINGS	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
409	1230	\N	SUPERKINGS BLUE	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
411	1779	\N	VANTAGE BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
412	1778	\N	VANTAGE ROSSA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
413	NEW	\N	VICEROY BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
414	NEW	\N	VICEROY FILTER	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
415	NEW	\N	VICEROY SILVER	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
420	2190	\N	VIRGINIA SLIMS	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio in colorazione nera da 20 pezzi	2009-07-10	0	0	\N	\N	f
421	2189	\N	VIRGINIA SLIMS	0	1	2	4	4	\N	0	0	1	\N	0	Confezione astuccio in colorazione bianca da 20 pezzi	2009-07-10	0	0	\N	\N	f
422	1900	\N	VOGUE AROME	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
423	600	\N	VOGUE BLEUE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
424	544	\N	VOGUE FINE BLEUE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
425	868	\N	VOGUE FINE LILAS	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
426	834	\N	VOGUE FINE MENTHE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
427	292	\N	VOGUE LILAS	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
428	821	\N	VOGUE MENTHE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
432	1860	\N	WEST BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
433	2010	\N	WEST ICE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
434	1320	\N	WEST RED	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
435	1634	\N	WEST RED 20	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
436	NEW	\N	WEST RICH BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
437	1321	\N	WEST SILVER	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
438	1635	\N	WEST SILVER 20	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
439	1809	\N	WINFIELD BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
440	1808	\N	WINFIELD RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
442	1733	\N	WINSTON BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
446	1775	\N	WINSTON CLASSIC	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione astuccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
447	245	\N	WINSTON CLASSIC	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
450	1248	\N	WINSTON ONE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
451	134	\N	WINSTON SILVER	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
452	2066	\N	WINSTON SUBTLE SILVER SUPERSLIMS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
454	2070	\N	YESMOKE RED	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
455	2071	\N	YESMOKE RED	0	1	2	1.8	1.8	\N	0	0	1	\N	0	Confezione cartoccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
457	2074	\N	YESMOKE WHITE	0	1	2	1.8	1.8	\N	0	0	1	\N	0	Confezione cartoccio da 10 pezzi	2009-07-10	0	0	\N	\N	f
458	2073	\N	YESMOKE WHITE	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
459	295	\N	ZENIT	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
460	1941	\N	ZUNI	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
465	826	\N	AGIO MEHARIS SWEET ORIENT	0	1	2	3.3999999999999999	3.3999999999999999	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
466	855	\N	AGIO MINI MEHARIS ANISETTE	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
468	615	\N	AGIO MINI MEHARIS ECUADOR	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
469	2167	\N	AGIO MINI MEHARIS FILTER VANILLA	0	1	2	1	1	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
470	2166	\N	AGIO MINI MEHARIS FILTER VANILLA	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
471	631	\N	AGIO MINI MEHARIS JAVA	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
472	161	\N	AGIO MINI MEHARIS SWEET ORIENT	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
473	1613	\N	AGIO MINI MEHARIS SWEET ORIENT FILTER	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
474	1614	\N	AGIO MINI MEHARIS SWEET ORIENT FILTER INTERNATIONAL 2	0	1	2	0.16	0.16	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
475	523	\N	AGIO TIP CLAIR	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
476	1874	\N	AL CAPONE POCKETS 10	0	1	2	2.2000000000000002	2.2000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
477	1873	\N	AL CAPONE POCKETS FILTER 10	0	1	2	2.2000000000000002	2.2000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
478	1913	\N	AL CAPONE POCKETS FILTER 2	0	1	2	0.44	0.44	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
479	2155	\N	AL CAPONE POCKETS FILTER 3	0	1	2	0.66000000000000003	0.66000000000000003	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
480	1872	\N	AL CAPONE SWEETS FILTER 10	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
481	27	\N	AMABILE AROMA COLA	0	1	2	2.2999999999999998	2.2999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
482	29	\N	AMABILE AROMA PESCA	0	1	2	2.3999999999999999	2.3999999999999999	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
483	25	\N	AMABILE AROMA VANIGLIA	0	1	2	2.3999999999999999	2.3999999999999999	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
484	768	\N	AMBER NATURAL FILTER	0	1	2	2.2999999999999998	2.2999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
485	1658	\N	AMIGOS	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
486	1970	\N	AMIGOS FILTER	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
487	1926	\N	AMIGOS MEDIUM	0	1	2	1.3999999999999999	1.3999999999999999	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
488	502	\N	AVANA	0	1	2	2.1000000000000001	2.1000000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
489	370	\N	AXX FILTER FLAVOUR	0	1	2	2.2999999999999998	2.2999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
490	365	\N	AXX FILTER REGULAR	0	1	2	2.2999999999999998	2.2999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
491	729	\N	BLUES LIGHTS	0	1	2	1.75	1.75	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
496	2064	\N	CAFÉ CRÉME AROME DUO	0	1	2	0.080000000000000002	0.080000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
498	1660	\N	CAFÉ CRÈME FILTER (5)	0	1	2	1.5	1.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
499	1735	\N	CAFÉ CRÉME FILTER AROMA DUO	0	1	2	0.040000000000000001	0.040000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
500	1233	\N	CAFE CREME FILTER AROME	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
501	2142	\N	CAFE CREME FILTER AROME	0	1	2	1.3999999999999999	1.3999999999999999	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
502	2063	\N	CAFÉ CRÉME FILTER AROME DUO	0	1	2	0.080000000000000002	0.080000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
503	2048	\N	CAFE CREME FINOS	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
504	2049	\N	CAFE CREME FINOS AROME	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
505	2152	\N	CAFE CREME FINOS AROME DUO	0	1	2	0.080000000000000002	0.080000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
506	2151	\N	CAFE CREME FINOS DUO	0	1	2	0.080000000000000002	0.080000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
509	1736	\N	CAFÉ CRÉME ORIENTAL AROMA DUO	0	1	2	0.040000000000000001	0.040000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
510	NEW	\N	CANDLELIGHT FILTER SUMATRA	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
511	NEW	\N	CANDLELIGHT FILTER VANILLA	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
512	1875	\N	CANDLELIGHT NEW AROMA CHERRY	0	1	2	0.90000000000000002	0.90000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
513	1876	\N	CANDLELIGHT NEW AROMA COFFEE	0	1	2	0.90000000000000002	0.90000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
514	1877	\N	CANDLELIGHT NEW AROMA VANILLA	0	1	2	0.90000000000000002	0.90000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
515	1868	\N	CANDLELIGHT NEW MINIS CHERRY	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
516	1870	\N	CANDLELIGHT NEW MINIS COFFEE	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
517	1869	\N	CANDLELIGHT NEW MINIS VANILLA	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
518	98	\N	CAPTAIN BLACK AROMATIC	0	1	2	0.26000000000000001	0.26000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
519	1764	\N	CAPTAIN BLACK CARIBBEAN RUM FILTER	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
520	1768	\N	CAPTAIN BLACK CARIBBEAN RUM TWIN FILTER	0	1	2	0.040000000000000001	0.040000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
521	1765	\N	CAPTAIN BLACK MADAGASCAR VANILLA FILTER	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
522	1769	\N	CAPTAIN BLACK MADAGASCAR VANILLA TWIN FILTER	0	1	2	0.040000000000000001	0.040000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
523	1762	\N	CAPTAIN BLACK ORIGINAL AROMA	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
524	1763	\N	CAPTAIN BLACK ORIGINAL AROMA FILTER	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
525	1766	\N	CAPTAIN BLACK ORIGINAL AROMA TWIN	0	1	2	0.040000000000000001	0.040000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
526	1767	\N	CAPTAIN BLACK ORIGINAL AROMA TWIN FILTER	0	1	2	0.040000000000000001	0.040000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
527	931	\N	CAPTAIN BLACK ORIGINALS	0	1	2	2.1000000000000001	2.1000000000000001	\N	0	0	1	\N	0	Confezione da 8 pezzi	2009-07-10	0	0	\N	\N	f
528	939	\N	CAPTAIN BLACK SWEETS	0	1	2	2.1000000000000001	2.1000000000000001	\N	0	0	1	\N	0	Confezione da 8 pezzi	2009-07-10	0	0	\N	\N	f
529	1991	\N	CHIWAWA MINI	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
530	1992	\N	CHIWAWA VANILLA MINI	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
531	1615	\N	CLUBMASTER AROMATIC GOLD FILTER	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
532	1636	\N	CLUBMASTER MINI FILTER AROMATIC	0	1	2	0.46000000000000002	0.46000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
533	1758	\N	CLUBMASTER MINI FILTER AROMATIC UNO	0	1	2	0.040000000000000001	0.040000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
534	1651	\N	CLUBMASTER MINI FILTER BLUE	0	1	2	0.46000000000000002	0.46000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
535	1618	\N	CLUBMASTER MINI FILTER FULL FLAVOUR	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
536	1650	\N	CLUBMASTER MINI FILTER SUPERIOR BLUE	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
537	1617	\N	CLUBMASTER MINI FILTER SUPERIOR VANILLA	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
538	1616	\N	CLUBMASTER MINI VANILLA	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
539	1688	\N	CONSTELLATION BLACK SLIMS	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
540	2165	\N	CONSTELLATION MINI FILTER	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
541	1231	\N	DANNEMANN SWEETS FILTER	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
542	2025	\N	DAYBREAK	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
543	17457	\N	EJECUTIVOS AMARETTO	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
544	17458	\N	EJECUTIVOS ANISETTE	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
545	17459	\N	EJECUTIVOS CHERRY	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
546	17460	\N	EJECUTIVOS CHOCOLATE	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
547	17461	\N	EJECUTIVOS KALHUA	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
548	17462	\N	EJECUTIVOS NATURAL	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
549	17463	\N	EJECUTIVOS RUM	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
550	17464	\N	EJECUTIVOS VANILLA	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
551	204	\N	FLEUR DE SAVANE PETITS BOITE BEIGE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
552	614	\N	FLEUR DE SAVANE TRADITION	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
553	1284	\N	HAMLET	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
554	1285	\N	HAMLET FINE AROMA	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
555	1286	\N	HAMLET FINE AROMA FILTER	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
556	1823	\N	HAMLET FINE AROMA MINI CIGARS	0	1	2	1	1	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
558	1287	\N	HAMLET MINIATURES	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
559	1647	\N	HANDELSGOLD CHERRY TIP-CIGARILLOS	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
560	1646	\N	HANDELSGOLD VANILLA TIP-CIGARILLOS	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
561	2148	\N	HOLLANDIA CLASSIC CIGARILLOS 5	0	1	2	1	1	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
562	2147	\N	HOLLANDIA MINI AROMA	0	1	2	1	1	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
563	2149	\N	HOLLANDIA PEQUENITO AROMA	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
564	2150	\N	HOLLANDIA PEQUENITO CLASSIC	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
565	1887	\N	ITALY 4U CLASSICO	0	1	2	1.5	1.5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
566	1886	\N	ITALY 4U SPORT	0	1	2	1.5	1.5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
567	1888	\N	ITALY MINI DISTILLATO	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
568	1889	\N	ITALY MINI ESPRESSO	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
569	18147	\N	KING EDWARD MINI CIGARILLOS	0	1	2	3.2999999999999998	3.2999999999999998	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
570	18149	\N	KING EDWARD MINI CIGARILLOS CHERRY	0	1	2	3.2999999999999998	3.2999999999999998	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
571	18148	\N	KING EDWARD MINI CIGARILLOS VANILLA	0	1	2	3.2999999999999998	3.2999999999999998	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
572	15054	\N	KING EDWARD SPECIALS	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
573	18146	\N	KING EDWARD SPECIALS SWEET CHERRY	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
574	18145	\N	KING EDWARD SPECIALS SWEET VANILLA	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
578	223	\N	MERCATOR SUNRISE TROPICAL TASTE	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
579	747	\N	MERCATOR SUNRISE TROPICAL TASTE FILTER	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
580	2177	\N	MINI MOODS 3 FILTER	0	1	2	0.59999999999999998	0.59999999999999998	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
581	881	\N	MOODS	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
582	675	\N	MOODS FILTER	0	1	2	5.7000000000000002	5.7000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
583	644	\N	MOODS FILTER	0	1	2	0.56999999999999995	0.56999999999999995	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
584	1731	\N	MOODS FILTER FINE AROMA 5	0	1	2	1.7	1.7	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
585	1730	\N	MOODS FINE AROMA 5	0	1	2	1.6000000000000001	1.6000000000000001	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
586	1232	\N	MOODS GOLDEN TASTE FILTER	0	1	2	5.7000000000000002	5.7000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
587	1642	\N	MOODS GOLDEN TASTE FILTER	0	1	2	0.56999999999999995	0.56999999999999995	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
588	1732	\N	MOODS GOLDEN TASTE FILTER FINE AROMA 5	0	1	2	1.7	1.7	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
589	2102	\N	MOODS MINI FILTER	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
590	1659	\N	NEOS CAPPUCCINO	0	1	2	2.3999999999999999	2.3999999999999999	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
591	2024	\N	NEOS CAPPUCCINO RICH TASTE	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
592	820	\N	NEOS EXOTIC FINE & FLAVOUR	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
593	182	\N	NEOS PACIFIC AROMATIC	0	1	2	0.56000000000000005	0.56000000000000005	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
594	789	\N	NEOS PACIFIC AROMATIC	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
595	1506	\N	NEOS PACIFIC AROMATIC DUO	0	1	2	0.040000000000000001	0.040000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
596	1914	\N	NEOS PACIFIC AROMATIC SINGOLO	0	1	2	0.02	0.02	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
597	1822	\N	NEOS SELECTION CAPPUCCINO 2	0	1	2	0.029999999999999999	0.029999999999999999	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
598	15156	\N	NEWMINSTER CIGARILLOS	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
599	15159	\N	NEWMINSTER SENORITAS	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
600	606	\N	ORO AROMA 20	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
601	605	\N	ORO ORIGINAL 20	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
602	202	\N	PANTER BLUE	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
603	968	\N	PANTER COLLECTION 50	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
604	1277	\N	PANTER DESSERT	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
605	2037	\N	PANTER DESSERT 5	0	1	2	1.5	1.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
606	1841	\N	PANTER FILTER DESSERT 20	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
607	2038	\N	PANTER FILTER DESSERT 5	0	1	2	1.5	1.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
608	730	\N	PANTER MIGNON DE LUXE	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
609	439	\N	PANTER VITESSE DE LUXE	0	1	2	3.2999999999999998	3.2999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
610	1761	\N	SALSA FILTER BLACK CHERRY	0	1	2	1.6000000000000001	1.6000000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
611	1759	\N	SALSA FILTER ORIGINAL	0	1	2	1.6000000000000001	1.6000000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
612	1760	\N	SALSA FILTER VANILLA	0	1	2	1.6000000000000001	1.6000000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
613	1843	\N	SILVERADO AMERICAN BLEND	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
614	1844	\N	SILVERADO CHERRY	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
615	1845	\N	SILVERADO VANILLA	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
616	601	\N	ST. LOUIS BLUES FILTER	0	1	2	3.3999999999999999	3.3999999999999999	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
617	597	\N	ST. LOUIS QUEEN	0	1	2	2.3999999999999999	2.3999999999999999	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
620	1619	\N	SUNRISE TROPICAL TASTE TWIN	0	1	2	0.040000000000000001	0.040000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
621	1620	\N	SUNRISE TROPICAL TASTE TWIN FILTRO	0	1	2	0.040000000000000001	0.040000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
622	839	\N	TOSCANELLI MINI CLASSICO	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
623	495	\N	TOSCANELLI MINI SPORT	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
624	1261	\N	VASCO DA GAMA CAPA DE CUBA CIGARILLOS	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
625	1687	\N	VILLIGER CULEBRAS SMALL	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
626	17685	\N	VILLIGER HONEY FILTER DUO	0	1	2	0.10000000000000001	0.10000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
627	844	\N	VILLIGER KIEL JUNIOR SUMATRA	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
628	17686	\N	VILLIGER MOCCA FILTER DUO	0	1	2	0.10000000000000001	0.10000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
629	15698	\N	VILLIGER PREMIUM FILTER TIP 5 MILD CIGARS	0	1	2	2.2000000000000002	2.2000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
630	15697	\N	VILLIGER PREMIUM FILTER TIP AROMATIC BLEND	0	1	2	2.2000000000000002	2.2000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
631	1535	\N	VILLIGER PREMIUM HONEY	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
632	17469	\N	VILLIGER PREMIUM HONEY	0	1	2	0.5	0.5	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
633	17567	\N	VILLIGER PREMIUM HONEY DUO	0	1	2	0.10000000000000001	0.10000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
634	1737	\N	VILLIGER PREMIUM HONEY FILTER	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
635	1883	\N	VILLIGER PREMIUM HONEY FILTER 5	0	1	2	1.3	1.3	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
636	17470	\N	VILLIGER PREMIUM MOCCA	0	1	2	0.5	0.5	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
637	1584	\N	VILLIGER PREMIUM MOCCA	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
638	17568	\N	VILLIGER PREMIUM MOCCA DUO	0	1	2	0.10000000000000001	0.10000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
639	1738	\N	VILLIGER PREMIUM MOCCA FILTER	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
640	1884	\N	VILLIGER PREMIUM MOCCA FILTER 5	0	1	2	1.3	1.3	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
641	1282	\N	VILLIGER PREMIUM VANILLA	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
642	17468	\N	VILLIGER PREMIUM VANILLA FILTER	0	1	2	0.52000000000000002	0.52000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
643	1283	\N	VILLIGER PREMIUM VANILLA FILTER	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
644	1885	\N	VILLIGER PREMIUM VANILLA FILTER 5	0	1	2	1.3	1.3	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
645	17569	\N	VILLIGER PREMIUM VANILLA FILTER DUO	0	1	2	0.10000000000000001	0.10000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
646	NEW	\N	WILLEM II PRIMINI ORIGINAL	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
647	NEW	\N	WILLEM II PRIMINI VANILLE	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
648	1206	\N	WINGS DARK VANILLA	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
649	1208	\N	WINGS DARK VANILLA FILTER	0	1	2	2.8999999999999999	2.8999999999999999	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
650	1488	\N	BACKWOODS 100% TOBACCO	0	1	2	2.8999999999999999	2.8999999999999999	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
651	1987	\N	BACKWOODS 100% TOBACCO 2	0	1	2	0.080000000000000002	0.080000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
652	1490	\N	BACKWOODS AROMATIC	0	1	2	2.8999999999999999	2.8999999999999999	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
653	1990	\N	BACKWOODS AROMATIC 2	0	1	2	0.080000000000000002	0.080000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
654	1489	\N	BACKWOODS BLACK & AROMATIC	0	1	2	2.8999999999999999	2.8999999999999999	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
655	1989	\N	BACKWOODS BLACK AROMATIC 2	0	1	2	0.080000000000000002	0.080000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
656	1487	\N	BACKWOODS WILD RUM	0	1	2	2.8999999999999999	2.8999999999999999	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
657	1988	\N	BACKWOODS WILD RUM 2	0	1	2	0.080000000000000002	0.080000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
658	1969	\N	BALMORAL DOMINICAN SELECTION 5 SHORT PANATELA	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
659	NEW	\N	BALMORAL DOMINICAN SELECTION MINI CIGARILLOS	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
660	557	\N	BALMORAL RICH E LIGHT N.3	0	1	2	7.4000000000000004	7.4000000000000004	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
664	1705	\N	CHE MINI AROMATIC	0	1	2	1.3	1.3	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
665	1820	\N	CLUBMASTER MINI VANILLA SINGLES	0	1	2	0.25	0.25	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
666	16540	\N	COHIBA CLUB	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
667	17933	\N	COHIBA CLUB	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
668	1275	\N	COHIBA MINI	0	1	2	6.2999999999999998	6.2999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
669	15509	\N	COHIBA PANETELAS	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
670	15508	\N	COHIBA PANETELAS	0	1	2	35	35	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
671	1840	\N	DAVIDOFF CLUB	0	1	2	8.1999999999999993	8.1999999999999993	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
672	17543	\N	DAVIDOFF DEMI TASSE	0	1	2	72	72	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
673	901	\N	DAVIDOFF DEMI TASSE	0	1	2	14.4	14.4	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
674	NEW	\N	DAVIDOFF EXQUISITOS	0	1	2	40	40	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
675	17407	\N	DAVIDOFF EXQUISITOS	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
676	898	\N	DAVIDOFF LONG PANATELLAS	0	1	2	18.399999999999999	18.399999999999999	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
677	17295	\N	DAVIDOFF MINI CIGARILLOS	0	1	2	62	62	\N	0	0	1	\N	0	Confezione da 100 pezzi	2009-07-10	0	0	\N	\N	f
678	17294	\N	DAVIDOFF MINI CIGARILLOS	0	1	2	31	31	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
679	17276	\N	DAVIDOFF MINI CIGARILLOS	0	1	2	1.24	1.24	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
680	769	\N	DAVIDOFF MINI CIGARILLOS	0	1	2	12.4	12.4	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
681	903	\N	DAVIDOFF MINI CIGARILLOS	0	1	2	6.2000000000000002	6.2000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
682	17885	\N	DAVIDOFF MINI CIGARILLOS 2	0	1	2	0.10000000000000001	0.10000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
683	956	\N	DAVIDOFF MINI CIGARILLOS SILVER	0	1	2	12.4	12.4	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
684	17544	\N	DAVIDOFF MINI CIGARILLOS SILVER	0	1	2	31	31	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
685	17085	\N	DOMAINE AVO PURITOS	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
686	15157	\N	DON ESTEBAN SENORITAS	0	1	2	8.0500000000000007	8.0500000000000007	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
687	1798	\N	DOUGALLS SPECIAL CHEROOTS	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
688	1799	\N	DOUGALLS SPECIAL COLLECTION	0	1	2	0.040000000000000001	0.040000000000000001	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
689	17976	\N	DUE MONDI NO TIME	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
690	973	\N	FLEUR DE SAVANE MINI CIGARS 10	0	1	2	2.2000000000000002	2.2000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
691	455	\N	FLEUR DE SAVANE PETITS CIGARES	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
692	17774	\N	FLOR DE SELVA PETIT CIGARE	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
693	15213	\N	GARCIA Y VEGA CHICO	0	1	2	4.0999999999999996	4.0999999999999996	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
694	15670	\N	GARCIA Y VEGA WHIFFS CAVENDISH	0	1	2	3.1000000000000001	3.1000000000000001	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
695	15669	\N	GARCIA Y VEGA WHIFFS NATURAL	0	1	2	3.1000000000000001	3.1000000000000001	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
697	1968	\N	GRIFFINOS	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
698	17566	\N	GUANTANAMERA DUO	0	1	2	0.29999999999999999	0.29999999999999999	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
699	17144	\N	GUANTANAMERA PURITOS	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
700	17143	\N	GUANTANAMERA PURITOS	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
701	17524	\N	HEAVEN CHERUBS HONEY NUT	0	1	2	13.4	13.4	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
703	17408	\N	HOLLANDIA CLASSIC	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
704	17884	\N	IL CAVALIERE	0	1	2	94	94	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
705	534	\N	J. CORTES MINI	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
706	642	\N	J. CORTES PUROS	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
707	16548	\N	JOSE L. PIEDRA MINI	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
708	1590	\N	LA CAPITANA DEMI-TASSE	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
709	1591	\N	LA CAPITANA MINI	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
710	1882	\N	LA PAZ 20 WILDE MINIATURAS	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
711	NEW	\N	LA PAZ 5 WILDE CONICOS	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
712	517	\N	LA PAZ MINI WILDE	0	1	2	5.5999999999999996	5.5999999999999996	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
713	1704	\N	LA PAZ MINI WILDE AROMA SPECIALE	0	1	2	0.040000000000000001	0.040000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
714	1221	\N	LA PAZ MINI WILDE CIGARILLOS 10	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
715	1702	\N	LA PAZ MINI WILDE CIGARILLOS AROMA	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
716	1205	\N	LA PAZ WILDE CIGARILLOS	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
717	646	\N	LA PAZ WILDE CIGARILLOS	0	1	2	6.4000000000000004	6.4000000000000004	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
718	1703	\N	LA PAZ WILDE CIGARILLOS AROMA	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
719	648	\N	LA PAZ WILDE CIGARILLOS BRAZIL TYPE	0	1	2	6.5999999999999996	6.5999999999999996	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
720	1223	\N	LA PAZ WILDE PANATELA	0	1	2	2.3999999999999999	2.3999999999999999	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
721	2146	\N	LEON JIMENES CIGARILLOS	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
722	2145	\N	MACANUDO CIGARILLOS	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
723	2144	\N	MACANUDO CLUB	0	1	2	6.5	6.5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
724	15603	\N	MACANUDO MINIATURES	0	1	2	7.5999999999999996	7.5999999999999996	\N	0	0	1	\N	0	Confezione da 8 pezzi	2009-07-10	0	0	\N	\N	f
725	90	\N	MINI CHE	0	1	2	1.3	1.3	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
726	799	\N	MINI COHIBA	0	1	2	12.6	12.6	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
727	165	\N	MINI LONGCHAMP	0	1	2	8.5999999999999996	8.5999999999999996	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
728	16525	\N	MONTECRISTO CLUB	0	1	2	16	16	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
730	16935	\N	MONTECRISTO JOYITAS	0	1	2	112.5	112.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
731	674	\N	MONTECRISTO MINI	0	1	2	10.6	10.6	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
732	1274	\N	MONTECRISTO MINI	0	1	2	5.2999999999999998	5.2999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
733	17338	\N	MONTECRISTO MINI BOX WOOD	0	1	2	26.5	26.5	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
734	17721	\N	MONTECRISTO PURITOS	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
735	17720	\N	MONTECRISTO PURITOS	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
736	159	\N	NEOS MINI	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
737	17257	\N	NICARAGUA BY DREW ESTATE TWIGS	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
738	696	\N	NOBEL PETIT	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
739	807	\N	PANTER TANGO MINI	0	1	2	2.2000000000000002	2.2000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
740	18174	\N	PARTAGAS 10 CLUB	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
741	18173	\N	PARTAGAS 10 MINI	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
742	15500	\N	PARTAGAS CHICOS	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
743	16715	\N	PARTAGAS CHICOS	0	1	2	27.5	27.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
744	16529	\N	PARTAGAS MINI	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
745	16538	\N	QUINTERO MINI	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
746	18018	\N	ROMEO Y JULIETA CLUB	0	1	2	13.5	13.5	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
747	680	\N	ROMEO Y JULIETA MEDIUM	0	1	2	26	26	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
748	17081	\N	ROMEO Y JULIETA MINI	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
749	17082	\N	ROMEO Y JULIETA MINI	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
750	18101	\N	ROMEO Y JULIETA PURITOS	0	1	2	5.7000000000000002	5.7000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
751	1800	\N	SALSA BLACK CHERRY SPECIAL	0	1	2	0.040000000000000001	0.040000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
752	1202	\N	WILLEM II PRIMO 10 PANATELLAS	0	1	2	3.1000000000000001	3.1000000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
753	1866	\N	WILLEM II PRIMO 20 MINI ESPRESSO	0	1	2	4.7999999999999998	4.7999999999999998	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
754	1867	\N	WILLEM II PRIMO 20 MINI VANILLA	0	1	2	4.7999999999999998	4.7999999999999998	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
755	737	\N	WILLEM II PRIMO GOLD CIGARILLOS	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
756	688	\N	WILLEM II PRIMO MINI	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
757	1279	\N	ZINO CIGARILLO SUMATRA	0	1	2	8.6999999999999993	8.6999999999999993	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
758	1720	\N	ZINO MINI CIGARILLOS	0	1	2	3.8500000000000001	3.8500000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
759	1278	\N	ZINO MINI CIGARILLOS	0	1	2	7.7000000000000002	7.7000000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
760	1864	\N	CANDLELIGHT CORONA BRASIL 100	0	1	2	0.5	0.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
761	1865	\N	CANDLELIGHT CORONA SUMATRA 100	0	1	2	0.5	0.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
762	401	\N	CAVOUR	0	1	2	5.1600000000000001	5.1600000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
763	1265	\N	IL GUELFO ROSSO	0	1	2	3.1000000000000001	3.1000000000000001	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
764	613	\N	IL GUELFO TRADIZIONALE	0	1	2	3.1000000000000001	3.1000000000000001	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
765	15055	\N	KING EDWARD IMPERIAL	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
766	15056	\N	KING EDWARD INVINCIBLE	0	1	2	7.5999999999999996	7.5999999999999996	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
767	16306	\N	KING EDWARD SWEET VANILLA WOOD TIP	0	1	2	5.2999999999999998	5.2999999999999998	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
768	16302	\N	KING EDWARD TIP CIGARILLO	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
771	685	\N	MOODS TUBOS	0	1	2	6.4000000000000004	6.4000000000000004	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
772	1700	\N	MOODS TUBOS	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
773	704	\N	MOODS TUBOS	0	1	2	32	32	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
774	1352	\N	MOODS TUBOS	0	1	2	1.6000000000000001	1.6000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
775	1269	\N	NEOS MYSTIC AROMATIC	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
776	15161	\N	NEWMINSTER HALF CORONAS	0	1	2	17.600000000000001	17.600000000000001	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
777	475	\N	RILLOS	0	1	2	1.45	1.45	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
778	1986	\N	VASCO DA GAMA CAPA DE CUBA N° 2 INDIVIDUALES	0	1	2	1.2	1.2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
779	1797	\N	VASCO DA GAMA CORONA N.2 VANILLA	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
780	1985	\N	VASCO DA GAMA N° 5 CLARO	0	1	2	2.8999999999999999	2.8999999999999999	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
781	1263	\N	VASCO DA GAMA N°2 CORONAS CAPA DE ORO	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
782	72	\N	VILLIGER KIEL SUMATRA	0	1	2	2.75	2.75	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
783	1686	\N	VILLIGER PREMIUM TUBO	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
784	1685	\N	VILLIGER PREMIUM VANILLA TUBOS	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
785	2015	\N	WILLEM II PRIMO INTERMEZZO	0	1	2	2.2999999999999998	2.2999999999999998	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
786	244	\N	AGIO WILDE CIGARROS	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
787	17812	\N	ALLEGRIA CERVANTES	0	1	2	50	50	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
788	17811	\N	ALLEGRIA CERVANTES	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
789	17813	\N	ALLEGRIA CERVANTES	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
790	17810	\N	ALLEGRIA CORONAS	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
791	17809	\N	ALLEGRIA CORONAS	0	1	2	40	40	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
792	17808	\N	ALLEGRIA CORONAS	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
793	17805	\N	ALLEGRIA JULIETAS	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
794	17806	\N	ALLEGRIA JULIETAS	0	1	2	60	60	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
795	17807	\N	ALLEGRIA JULIETAS	0	1	2	150	150	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
796	17803	\N	ALLEGRIA ROBUSTOS	0	1	2	50	50	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
797	17802	\N	ALLEGRIA ROBUSTOS	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
798	17804	\N	ALLEGRIA ROBUSTOS	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
799	17800	\N	ALLEGRIA SHORT PERFECTOS	0	1	2	50	50	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
800	17801	\N	ALLEGRIA SHORT PERFECTOS	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
801	17799	\N	ALLEGRIA SHORT PERFECTOS	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
807	425	\N	APOSTOLADO	0	1	2	6.5	6.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
808	17931	\N	ARABESQUE	0	1	2	120	120	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
809	17778	\N	ARABESQUE	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
810	15618	\N	ARISTOFF BLACK CHURCHILL BRAZILIAN MADURO WRAPPER	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
811	15620	\N	ARISTOFF BLACK CHURCHILL CONNECTICUT SHADE WRAPPER	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
812	15653	\N	ARISTOFF BLACK CORONA BRAZILIAN MADURO WRAPPER	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
813	15652	\N	ARISTOFF BLACK CORONA CONNECTICUT SHADE WRAPPER	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
814	15644	\N	ARISTOFF BLACK ROBUSTO BRAZILIAN MADURO WRAPPER	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
815	15616	\N	ARISTOFF BLACK ROBUSTO CONNECTICUT SHADE WRAPPER	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
802	684	\N	AMMEZZATI TOSCANO GARIBALDI	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
816	15537	\N	ARTURO FUENTE CHATEAU FUENTE	0	1	2	170	170	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
817	16237	\N	ARTURO FUENTE CHATEAU FUENTE	0	1	2	8.5	8.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
818	15423	\N	ARTURO FUENTE CHICOS	0	1	2	55	55	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
819	16181	\N	ARTURO FUENTE CHICOS	0	1	2	2.2000000000000002	2.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
820	16207	\N	ARTURO FUENTE CORONA GRANDE	0	1	2	7.4000000000000004	7.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
821	15394	\N	ARTURO FUENTE CORONA GRANDE	0	1	2	185	185	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
822	16348	\N	ARTURO FUENTE CUBAN CORONA	0	1	2	7.5999999999999996	7.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
823	16352	\N	ARTURO FUENTE CUBAN CORONA	0	1	2	190	190	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
824	15649	\N	ARTURO FUENTE CUBANITOS	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
825	15560	\N	ARTURO FUENTE DOUBLE CHATEAU FUENTE	0	1	2	225	225	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
826	16182	\N	ARTURO FUENTE DOUBLE CHATEAU FUENTE	0	1	2	11.25	11.25	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
827	15389	\N	ARTURO FUENTE DOUBLE CORONA	0	1	2	220	220	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
828	16183	\N	ARTURO FUENTE DOUBLE CORONA	0	1	2	8.8000000000000007	8.8000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
829	15422	\N	ARTURO FUENTE EPICURE	0	1	2	192.5	192.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
830	16184	\N	ARTURO FUENTE EPICURE	0	1	2	7.7000000000000002	7.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
831	15648	\N	ARTURO FUENTE EXQUISITOS MADURO	0	1	2	180	180	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
832	16185	\N	ARTURO FUENTE EXQUISITOS MADURO	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
833	15388	\N	ARTURO FUENTE FLOR FINA 8-5-8	0	1	2	200	200	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
834	16186	\N	ARTURO FUENTE FLOR FINA 8-5-8	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
835	16570	\N	ARTURO FUENTE HEMINGWAY CLASSIC	0	1	2	16	16	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
836	16569	\N	ARTURO FUENTE HEMINGWAY CLASSIC	0	1	2	400	400	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
837	16565	\N	ARTURO FUENTE HEMINGWAY SIGNATURE	0	1	2	14.800000000000001	14.800000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
838	16574	\N	ARTURO FUENTE HEMINGWAY SIGNATURE	0	1	2	370	370	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
839	16187	\N	ARTURO FUENTE NUMERO 4	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
840	15392	\N	ARTURO FUENTE NUMERO 4	0	1	2	167.5	167.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
841	16188	\N	ARTURO FUENTE PETIT CORONA	0	1	2	6.2000000000000002	6.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
842	15410	\N	ARTURO FUENTE PETIT CORONA	0	1	2	155	155	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
843	16189	\N	ARTURO FUENTE RESERVA DON CARLOS	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
844	15393	\N	ARTURO FUENTE RESERVA DON CARLOS	0	1	2	325	325	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
845	16190	\N	ARTURO FUENTE RESERVA N. 2	0	1	2	19	19	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
846	15752	\N	ARTURO FUENTE RESERVA N. 2	0	1	2	475	475	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
847	15387	\N	ARTURO FUENTE RESERVA N. 3	0	1	2	315	315	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
848	16191	\N	ARTURO FUENTE RESERVA N. 3	0	1	2	12.6	12.6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
849	16199	\N	ARTURO FUENTE RESERVA N. 4	0	1	2	11.800000000000001	11.800000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
850	15751	\N	ARTURO FUENTE RESERVA N. 4	0	1	2	295	295	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
851	16572	\N	ARTURO FUENTE SHORT STORY	0	1	2	10.5	10.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
852	16527	\N	ARTURO FUENTE SHORT STORY	0	1	2	262.5	262.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
853	16053	\N	ASHTON 898	0	1	2	8.1999999999999993	8.1999999999999993	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
854	15130	\N	ASHTON 898	0	1	2	41	41	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
855	15122	\N	ASHTON 898	0	1	2	205	205	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
856	16063	\N	ASHTON CABINET  n. 2	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
857	15581	\N	ASHTON CABINET  n. 2	0	1	2	350	350	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
858	16073	\N	ASHTON CABINET  n. 3	0	1	2	14.800000000000001	14.800000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
859	15578	\N	ASHTON CABINET  n. 3	0	1	2	296	296	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
860	16060	\N	ASHTON CABINET n. 6	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
861	15542	\N	ASHTON CABINET n. 6	0	1	2	300	300	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
862	16058	\N	ASHTON CABINET n. 7	0	1	2	12.800000000000001	12.800000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
863	15532	\N	ASHTON CABINET n. 7	0	1	2	320	320	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
864	16057	\N	ASHTON CABINET n. 8	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
865	15531	\N	ASHTON CABINET n. 8	0	1	2	325	325	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
866	16061	\N	ASHTON CABINET PYRAMIDS	0	1	2	12.199999999999999	12.199999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
867	15530	\N	ASHTON CABINET PYRAMIDS	0	1	2	305	305	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
868	15124	\N	ASHTON CHURCHILL	0	1	2	245	245	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
869	16056	\N	ASHTON CHURCHILL	0	1	2	9.8000000000000007	9.8000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
870	15123	\N	ASHTON CHURCHILL	0	1	2	39.200000000000003	39.200000000000003	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
871	16054	\N	ASHTON CORDIAL	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
872	15121	\N	ASHTON CORDIAL	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
873	15131	\N	ASHTON CORDIAL	0	1	2	150	150	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
874	16072	\N	ASHTON CORONA	0	1	2	7.7000000000000002	7.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
875	15120	\N	ASHTON CORONA	0	1	2	192.5	192.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
876	15111	\N	ASHTON CORONA	0	1	2	38.5	38.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
877	15781	\N	ASHTON CRYSTAL N. 1	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
878	16009	\N	ASHTON CRYSTAL N. 1	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
879	15783	\N	ASHTON DOUBLE MAGNUM	0	1	2	260	260	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
880	16010	\N	ASHTON DOUBLE MAGNUM	0	1	2	10.4	10.4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
881	15436	\N	ASHTON ESQUIRE	0	1	2	28	28	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
882	15112	\N	ASHTON MAGNUM	0	1	2	205	205	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
883	16014	\N	ASHTON MAGNUM	0	1	2	8.1999999999999993	8.1999999999999993	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
884	15128	\N	ASHTON MAGNUM	0	1	2	32.799999999999997	32.799999999999997	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
885	16008	\N	ASHTON PANETELA	0	1	2	6.9000000000000004	6.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
886	15119	\N	ASHTON PANETELA	0	1	2	34.5	34.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
887	15107	\N	ASHTON PRIME MINISTER	0	1	2	36.799999999999997	36.799999999999997	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
888	16024	\N	ASHTON PRIME MINISTER	0	1	2	9.1999999999999993	9.1999999999999993	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
889	15108	\N	ASHTON PRIME MINISTER	0	1	2	230	230	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
890	17224	\N	ASHTON VIRGIN SUN GROWN BELICOSO N0.1	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
891	17225	\N	ASHTON VIRGIN SUN GROWN ENCHANTMENT	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
892	17223	\N	ASHTON VIRGIN SUN GROWN ROBUSTO	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
893	17221	\N	ASHTON VIRGIN SUN GROWN SORCERER	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
894	17222	\N	ASHTON VIRGIN SUN GROWN TORPEDO	0	1	2	14	14	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
895	17226	\N	ASHTON VIRGIN SUN GROWN TRES MYSTIQUE	0	1	2	10.5	10.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
896	18162	\N	AURORA 1495 SERIES BELLICOSO	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
897	18160	\N	AURORA 1495 SERIES N.4	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
898	18161	\N	AURORA 1495 SERIES ROBUSTO	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
899	16508	\N	AURORA PREFERIDOS N.1	0	1	2	20.699999999999999	20.699999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
900	16501	\N	AURORA PREFERIDOS N.1	0	1	2	517.5	517.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
901	16483	\N	AURORA PREFERIDOS N.2	0	1	2	18.100000000000001	18.100000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
902	16513	\N	AURORA PREFERIDOS N.2	0	1	2	452.5	452.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
903	17710	\N	AURORA SUBLIMES	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
904	17709	\N	AURORA SUBLIMES	0	1	2	97.5	97.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
905	17278	\N	AVO 22	0	1	2	198	198	\N	0	0	1	\N	0	Confezione da 22 pezzi	2009-07-10	0	0	\N	\N	f
906	16400	\N	AVO 75th ANNIVERSARY	0	1	2	12.9	12.9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
907	16406	\N	AVO 75th ANNIVERSARY	0	1	2	129	129	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
908	17339	\N	AVO 77 LIMITED EDITINO	0	1	2	161	161	\N	0	0	1	\N	0	Confezione da 14 pezzi	2009-07-10	0	0	\N	\N	f
909	17877	\N	AVO 80TH	0	1	2	300	300	\N	0	0	1	\N	0	Confezione da 24 pezzi	2009-07-10	0	0	\N	\N	f
910	17049	\N	AVO CLASSIC PURITOS	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
911	15836	\N	AVO DOMAINE 10	0	1	2	36	36	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
912	15840	\N	AVO DOMAINE 10	0	1	2	225	225	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
913	15923	\N	AVO DOMAINE 10	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
914	15847	\N	AVO DOMAINE 20	0	1	2	210	210	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
915	15848	\N	AVO DOMAINE 20	0	1	2	33.600000000000001	33.600000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
916	15932	\N	AVO DOMAINE 20	0	1	2	8.4000000000000004	8.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
917	15934	\N	AVO DOMAINE 30	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
918	15850	\N	AVO DOMAINE 30	0	1	2	250	250	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
919	15849	\N	AVO DOMAINE 30	0	1	2	40	40	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
920	16676	\N	AVO DOMAINE 40	0	1	2	40	40	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
921	16671	\N	AVO DOMAINE 40	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
922	16677	\N	AVO DOMAINE 40	0	1	2	250	250	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
923	16678	\N	AVO DOMAINE 50	0	1	2	237.5	237.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
924	16675	\N	AVO DOMAINE 50	0	1	2	38	38	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
925	16672	\N	AVO DOMAINE 50	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
926	16679	\N	AVO DOMAINE 60	0	1	2	185	185	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
927	16674	\N	AVO DOMAINE 60	0	1	2	37	37	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
928	16673	\N	AVO DOMAINE 60	0	1	2	7.4000000000000004	7.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
929	15851	\N	AVO DOMAINE ASSORTMENT	0	1	2	27	27	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
930	16681	\N	AVO DOMAINE CLASICOS	0	1	2	25.5	25.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
931	16680	\N	AVO DOMAINE FIGURADOS	0	1	2	27	27	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
932	18016	\N	AVO L.E. 07	0	1	2	190	190	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
933	17736	\N	AVO LE 05	0	1	2	198	198	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
934	17570	\N	AVO LEGACY	0	1	2	120	120	\N	0	0	1	\N	0	Confezione da 12 pezzi	2009-07-10	0	0	\N	\N	f
935	15929	\N	AVO NOTTURNO TUBOS XO SERIE QUARTETTO	0	1	2	7.2999999999999998	7.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
936	15462	\N	AVO NOTTURNO TUBOS XO SERIE QUARTETTO	0	1	2	146	146	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
937	15464	\N	AVO NOTTURNO TUBOS XO SERIE QUARTETTO	0	1	2	29.199999999999999	29.199999999999999	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
938	15933	\N	AVO PRELUDIO TUBOS XO SERIE TRIO	0	1	2	7.7999999999999998	7.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
939	15467	\N	AVO PRELUDIO TUBOS XO SERIE TRIO	0	1	2	156	156	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
940	15457	\N	AVO PRELUDIO TUBOS XO SERIE TRIO	0	1	2	31.199999999999999	31.199999999999999	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
941	17211	\N	AVO SIGNATURE LONSDALE	0	1	2	8.5	8.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
942	17210	\N	AVO SIGNATURE LONSDALE	0	1	2	85	85	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
943	17212	\N	AVO SIGNATURE ROBUSTO	0	1	2	95	95	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
944	17213	\N	AVO SIGNATURE ROBUSTO	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
945	17209	\N	AVO SIGNATURE SMALL CORONA	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
946	17208	\N	AVO SIGNATURE SMALL CORONA	0	1	2	70	70	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
947	18128	\N	AVO TESORO LIMITED EDITION 2008	0	1	2	200	200	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
948	15374	\N	AVO XO ALLEGRO	0	1	2	145	145	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
949	15927	\N	AVO XO ALLEGRO	0	1	2	5.7999999999999998	5.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
950	15396	\N	AVO XO ALLEGRO	0	1	2	29	29	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
951	15930	\N	AVO XO INTERMEZZO	0	1	2	7.7999999999999998	7.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
952	15399	\N	AVO XO INTERMEZZO	0	1	2	31.199999999999999	31.199999999999999	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
953	15378	\N	AVO XO INTERMEZZO	0	1	2	195	195	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
954	15377	\N	AVO XO MAESTOSO	0	1	2	225	225	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
955	15928	\N	AVO XO MAESTOSO	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
956	15398	\N	AVO XO MAESTOSO	0	1	2	36	36	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
957	15424	\N	AVO XO NOTTURNO	0	1	2	34	34	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
958	15935	\N	AVO XO NOTTURNO	0	1	2	6.7999999999999998	6.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
959	15390	\N	AVO XO NOTTURNO	0	1	2	170	170	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
960	15381	\N	AVO XO PRELUDIO	0	1	2	182.5	182.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
961	15926	\N	AVO XO PRELUDIO	0	1	2	7.2999999999999998	7.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
962	15397	\N	AVO XO PRELUDIO	0	1	2	36.5	36.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
963	15925	\N	AVO XO PRESTO	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
964	15395	\N	AVO XO PRESTO	0	1	2	27.5	27.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
965	15375	\N	AVO XO PRESTO	0	1	2	137.5	137.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
966	15408	\N	AVO XO SERENATA	0	1	2	162.5	162.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
967	15420	\N	AVO XO SERENATA	0	1	2	32.5	32.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
968	15924	\N	AVO XO SERENATA	0	1	2	6.5	6.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
969	928	\N	BACKGAMMON CORONAS ESPECIALES CLEAR HAVANA BLEND	0	1	2	21	21	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
970	833	\N	BACKGAMMON MEDIAS CORONAS	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
971	17340	\N	BAHIBA CHURCHILLS	0	1	2	6.0999999999999996	6.0999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
972	17341	\N	BAHIBA CORONAS	0	1	2	4.0999999999999996	4.0999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
973	17342	\N	BAHIBA DBL.ROBUSTOS	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
974	17343	\N	BAHIBA PYRAMIDS	0	1	2	5.4000000000000004	5.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
975	17344	\N	BAHIBA RESERVA PARADISO DBL.ROBUSTOS	0	1	2	7.0999999999999996	7.0999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
976	17345	\N	BAHIBA RESERVA PARADISO PYRAMIDS	0	1	2	7.7999999999999998	7.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
977	988	\N	BALMORAL CORONA DE LUXE	0	1	2	9.25	9.25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
978	724	\N	BALMORAL CORONA DE LUXE	0	1	2	46.25	46.25	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
979	343	\N	BALMORAL CORONA DE LUXE	0	1	2	1.8500000000000001	1.8500000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
980	321	\N	BALMORAL CORONA IDEALES	0	1	2	0.98999999999999999	0.98999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
981	419	\N	BALMORAL CORONA IDEALES	0	1	2	9.9000000000000004	9.9000000000000004	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
982	448	\N	BALMORAL DOMINICAN SELECTION CORONA	0	1	2	1.3	1.3	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
983	412	\N	BALMORAL DOMINICAN SELECTION CORONA TUBOS	0	1	2	1.8	1.8	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
984	458	\N	BALMORAL DOMINICAN SELECTION PANATELA	0	1	2	1.1000000000000001	1.1000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
985	568	\N	BALMORAL DOMINICAN SELECTION SMALL PANATELA	0	1	2	1	1	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
986	962	\N	BALMORAL OVERLAND	0	1	2	21.25	21.25	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
987	357	\N	BALMORAL OVERLAND	0	1	2	0.84999999999999998	0.84999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
988	297	\N	BALMORAL ROYAL SELECTION CORONA	0	1	2	4.1500000000000004	4.1500000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
989	301	\N	BALMORAL ROYAL SELECTION ROBUSTO	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
990	16550	\N	BELINDA PETIT PRINCESS	0	1	2	6.75	6.75	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
991	18110	\N	BOGART GRAN CORONA	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
992	16371	\N	BOLIVAR BELICOSOS FINOS	0	1	2	280	280	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
993	16837	\N	BOLIVAR CORONAS GIGANTES	0	1	2	305	305	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
994	18017	\N	BOLIVAR GOLD MEDAL	0	1	2	104	104	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
995	NEW	\N	BOLIVAR INMENSAS	0	1	2	255	255	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
996	15902	\N	BOLIVAR PETIT CORONAS	0	1	2	320	320	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
997	16386	\N	BOLIVAR ROYAL CORONAS	0	1	2	225	225	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
998	18179	\N	BOLIVAR ROYAL CORONAS TUBOS	0	1	2	9.5999999999999996	9.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
999	16839	\N	BOLIVAR TUBOS No. 1	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1000	16838	\N	BOLIVAR TUBOS No. 1	0	1	2	237.5	237.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1001	NEW	\N	BOLIVAR TUBOS NO. 2	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1002	17107	\N	BOLIVAR TUBOS No. 3	0	1	2	5.2999999999999998	5.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1003	16840	\N	BOLIVAR TUBOS No. 3	0	1	2	132.5	132.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1004	17548	\N	BUNDLE SELECTION CHURCHILL	0	1	2	43.200000000000003	43.200000000000003	\N	0	0	1	\N	0	Confezione da 16 pezzi	2009-07-10	0	0	\N	\N	f
1005	17545	\N	BUNDLE SELECTION CORONA	0	1	2	33.600000000000001	33.600000000000001	\N	0	0	1	\N	0	Confezione da 16 pezzi	2009-07-10	0	0	\N	\N	f
1006	17549	\N	BUNDLE SELECTION FIGURADO	0	1	2	33.600000000000001	33.600000000000001	\N	0	0	1	\N	0	Confezione da 16 pezzi	2009-07-10	0	0	\N	\N	f
1007	17547	\N	BUNDLE SELECTION LONSDALE	0	1	2	36.799999999999997	36.799999999999997	\N	0	0	1	\N	0	Confezione da 16 pezzi	2009-07-10	0	0	\N	\N	f
1008	17550	\N	BUNDLE SELECTION PETIT CORONA	0	1	2	32	32	\N	0	0	1	\N	0	Confezione da 16 pezzi	2009-07-10	0	0	\N	\N	f
1009	17938	\N	BUNDLE SELECTION PETIT PANATELA	0	1	2	27.199999999999999	27.199999999999999	\N	0	0	1	\N	0	Confezione da 16 pezzi	2009-07-10	0	0	\N	\N	f
1010	17546	\N	BUNDLE SELECTION ROBUSTO	0	1	2	38.399999999999999	38.399999999999999	\N	0	0	1	\N	0	Confezione da 16 pezzi	2009-07-10	0	0	\N	\N	f
1011	16203	\N	C.A.O. ANIVERSARIO 20 N. IV MADURO	0	1	2	9.75	9.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1012	15218	\N	C.A.O. ANIVERSARIO 20 N. IV MADURO	0	1	2	195	195	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1013	16158	\N	C.A.O. ANIVERSARIO BELICOSOS	0	1	2	11.75	11.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1014	16202	\N	C.A.O. ANIVERSARIO CHURCHILL MADURO	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1015	15241	\N	C.A.O. ANIVERSARIO CHURCHILL MADURO	0	1	2	230	230	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1016	15216	\N	C.A.O. ANIVERSARIO ROBUSTOS MADURO	0	1	2	198	198	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1017	16193	\N	C.A.O. ANIVERSARIO ROBUSTOS MADURO	0	1	2	9.9000000000000004	9.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1018	17347	\N	C.A.O. BELLA VANILLA PETIT CORONA	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1019	17346	\N	C.A.O. BELLA VANILLA PETIT CORONA	0	1	2	87.5	87.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1020	17348	\N	C.A.O. BRAZILIA IPANEMA	0	1	2	138	138	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1021	17349	\N	C.A.O. BRAZILIA IPANEMA	0	1	2	6.9000000000000004	6.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1022	16200	\N	C.A.O. CHURCHILL	0	1	2	5.5999999999999996	5.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1023	15245	\N	C.A.O. CHURCHILL	0	1	2	140	140	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1024	15250	\N	C.A.O. CORONA GORDAS	0	1	2	130	130	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1025	16197	\N	C.A.O. CORONA GORDAS	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1026	16196	\N	C.A.O. CORONAS	0	1	2	4.7999999999999998	4.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1027	17351	\N	C.A.O. CRIOLLO CONQUISTADOR	0	1	2	7.7000000000000002	7.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1028	17350	\N	C.A.O. CRIOLLO CONQUISTADOR	0	1	2	154	154	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1029	17353	\N	C.A.O. CRIOLLO MANCHA	0	1	2	6.9000000000000004	6.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1030	17352	\N	C.A.O. CRIOLLO MANCHA	0	1	2	138	138	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1031	17355	\N	C.A.O. CRIOLLO PAMPA	0	1	2	5.4000000000000004	5.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1032	17354	\N	C.A.O. CRIOLLO PAMPA	0	1	2	162	162	\N	0	0	1	\N	0	Confezione da 30 pezzi	2009-07-10	0	0	\N	\N	f
1033	17356	\N	C.A.O. CRIOLLO PATO	0	1	2	128	128	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1034	17357	\N	C.A.O. CRIOLLO PATO	0	1	2	6.4000000000000004	6.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1035	17359	\N	C.A.O. GOLD HONEY PETIT CORONA	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1036	17358	\N	C.A.O. GOLD HONEY PETIT CORONA	0	1	2	87.5	87.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1037	16510	\N	C.A.O. GOLD ROBUSTO TUBOS	0	1	2	87.5	87.5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1038	16493	\N	C.A.O. GOLD ROBUSTO TUBOS	0	1	2	8.75	8.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1039	16487	\N	C.A.O. GOLD TORPEDO TUBOS	0	1	2	9.75	9.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1040	16509	\N	C.A.O. GOLD TORPEDO TUBOS	0	1	2	97.5	97.5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1041	16153	\N	C.A.O. LANNIVERSAIRE, BELICOSOS CAMEROON	0	1	2	9.1999999999999993	9.1999999999999993	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1042	15663	\N	C.A.O. LANNIVERSAIRE, BELICOSOS CAMEROON	0	1	2	184	184	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1043	15661	\N	C.A.O. LANNIVERSAIRE, CORONA CAMEROON	0	1	2	156	156	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1044	16154	\N	C.A.O. LANNIVERSAIRE, CORONA CAMEROON	0	1	2	7.7999999999999998	7.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1045	16155	\N	C.A.O. LANNIVERSAIRE, NAPOLEON CAMEROON	0	1	2	8.1999999999999993	8.1999999999999993	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1046	15664	\N	C.A.O. LANNIVERSAIRE, NAPOLEON CAMEROON	0	1	2	164	164	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1047	16156	\N	C.A.O. LANNIVERSAIRE, PETIT BELICOSOS CAMEROON	0	1	2	7.7999999999999998	7.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1048	15659	\N	C.A.O. LANNIVERSAIRE, PETIT BELICOSOS CAMEROON	0	1	2	156	156	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1049	16157	\N	C.A.O. LANNIVERSAIRE, ROBUSTO CAMEROON	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1050	15662	\N	C.A.O. LANNIVERSAIRE, ROBUSTO CAMEROON	0	1	2	160	160	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1051	17360	\N	C.A.O. MOONTRANCE PETIT CORONA	0	1	2	87.5	87.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1052	17361	\N	C.A.O. MOONTRANCE PETIT CORONA	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1053	16404	\N	C.A.O. PETIT CAMEROON	0	1	2	21	21	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1054	16403	\N	C.A.O. PETIT MADURO	0	1	2	21	21	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1055	15253	\N	C.A.O. PRESIDENTE	0	1	2	145	145	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1056	16194	\N	C.A.O. PRESIDENTE	0	1	2	5.7999999999999998	5.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1057	17973	\N	CAO BRAZILIA FIVE CARIOCAS	0	1	2	13.5	13.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1058	17188	\N	CAO BRAZILIA GOL	0	1	2	134	134	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1059	17189	\N	CAO BRAZILIA GOL	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1060	17186	\N	CAO BRAZILIA PIRANHA	0	1	2	122.5	122.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1061	17187	\N	CAO BRAZILIA PIRANHA	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1062	17191	\N	CAO BRAZILIA SAMBA	0	1	2	7.7999999999999998	7.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1063	17190	\N	CAO BRAZILIA SAMBA	0	1	2	156	156	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1064	17947	\N	CAO CONMEMORATIVO	0	1	2	68.25	68.25	\N	0	0	1	\N	0	Confezione da 7 pezzi	2009-07-10	0	0	\N	\N	f
1065	17916	\N	CAO CONMEMORATIVO	0	1	2	58.5	58.5	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
1066	17972	\N	CAO CRIOLLO FIVE PAMPAS	0	1	2	13.5	13.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1067	17578	\N	CAO EARTH NECTAR	0	1	2	87.5	87.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1068	17579	\N	CAO EARTH NECTAR	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1069	17577	\N	CAO EILEENS DREAM	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1070	17576	\N	CAO EILEENS DREAM	0	1	2	87.5	87.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1071	17192	\N	CAO EXTREME TUBO NO.1	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1072	17193	\N	CAO EXTREME TUBO NO.1	0	1	2	8.75	8.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1073	17195	\N	CAO EXTREME TUBO NO.2	0	1	2	9.9000000000000004	9.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1074	17194	\N	CAO EXTREME TUBO NO.2	0	1	2	198	198	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1075	17921	\N	CAO FLAVOURS BY CAO	0	1	2	20.399999999999999	20.399999999999999	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
1076	18155	\N	CAO GOLD CORONA	0	1	2	98	98	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1077	18201	\N	CAO GOLD CORONA	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1078	17975	\N	CAO GOLD FIVE KARATS	0	1	2	13.5	13.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1079	18157	\N	CAO GOLD ROBUSTO	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1080	18199	\N	CAO GOLD ROBUSTO	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1081	18200	\N	CAO GOLD TORPEDO	0	1	2	6.2000000000000002	6.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1082	18156	\N	CAO GOLD TORPEDO	0	1	2	124	124	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1083	17639	\N	CAO ITALIA CIAO	0	1	2	118	118	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1084	17640	\N	CAO ITALIA CIAO	0	1	2	5.9000000000000004	5.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1085	17974	\N	CAO ITALIA FIVE PICCOLOS	0	1	2	13.5	13.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1086	17641	\N	CAO ITALIA GONDOLA	0	1	2	144	144	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1087	17642	\N	CAO ITALIA GONDOLA	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1088	17644	\N	CAO ITALIA PIAZZA	0	1	2	8.1999999999999993	8.1999999999999993	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1089	17643	\N	CAO ITALIA PIAZZA	0	1	2	164	164	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1090	17769	\N	CAO KARMA SUTRA SPLASH PETIT CORONA	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1091	17768	\N	CAO KARMA SUTRA SPLASH PETIT CORONA	0	1	2	87.5	87.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1092	17767	\N	CAO KARMA SUTRA SPLASH ROBUSTO	0	1	2	4.7999999999999998	4.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1093	17966	\N	CAO MX2 20 BELI	0	1	2	168	168	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1094	17967	\N	CAO MX2 20 BELI	0	1	2	8.4000000000000004	8.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1095	17918	\N	CAO MX2 ROB	0	1	2	6.9000000000000004	6.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1096	17917	\N	CAO MX2 ROB	0	1	2	138	138	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1097	17920	\N	CAO MX2 TORO	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1098	17919	\N	CAO MX2 TORO	0	1	2	144	144	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1099	18141	\N	CAO SOPRANO ASSOCIATE	0	1	2	196	196	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1100	18142	\N	CAO SOPRANO ASSOCIATE	0	1	2	9.8000000000000007	9.8000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1101	18137	\N	CAO SOPRANO BOSS	0	1	2	280	280	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1102	18138	\N	CAO SOPRANO BOSS	0	1	2	14	14	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1103	18139	\N	CAO SOPRANO SOLDIER	0	1	2	250	250	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1104	18140	\N	CAO SOPRANO SOLDIER	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1105	18144	\N	CAO VISION PRANA	0	1	2	16	16	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1106	18143	\N	CAO VISION PRANA	0	1	2	320	320	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1107	16031	\N	CARLOS TORANO DOMINICAN SELECTION CARLOS II	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1108	16025	\N	CARLOS TORANO DOMINICAN SELECTION CARLOS VIII	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1109	16857	\N	CARLOS TORANO EXODUS 1959 DOUBLE CORONA	0	1	2	6.25	6.25	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1110	17603	\N	CARLOS TORANO EXODUS 1959 PERFECTO	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1111	16856	\N	CARLOS TORANO EXODUS 1959 ROBUSTO	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1112	17604	\N	CARLOS TORANO EXODUS 1959 TORO	0	1	2	5.75	5.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1113	16858	\N	CARLOS TORANO EXODUS 1959 TORPEDO	0	1	2	6.5	6.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1114	15544	\N	CARLOS TORANO NICARAGUA SELECTION CHURCHILL	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1115	16015	\N	CARLOS TORANO NICARAGUA SELECTION CHURCHILL	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1116	15522	\N	CARLOS TORANO NICARAGUA SELECTION DOBLE CORONA	0	1	2	122.5	122.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1117	16032	\N	CARLOS TORANO NICARAGUA SELECTION DOBLE CORONA	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1118	16018	\N	CARLOS TORANO NICARAGUA SELECTION PETIT CORONA	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1119	15525	\N	CARLOS TORANO NICARAGUA SELECTION PETIT CORONA	0	1	2	95	95	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1120	16017	\N	CARLOS TORANO NICARAGUA SELECTION ROBUSTO	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1121	15520	\N	CARLOS TORANO NICARAGUA SELECTION ROBUSTO	0	1	2	115	115	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1122	16016	\N	CARLOS TORANO NICARAGUA SELECTION TORPEDO	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1123	15536	\N	CARLOS TORANO NICARAGUA SELECTION TORPEDO	0	1	2	130	130	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1124	17741	\N	CARLOS TORANO PURITOS EXODUS 1959	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1125	17742	\N	CARLOS TORANO PURITOS RESERVA SELECTA	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1126	16066	\N	CARLOS TORANO RESERVA SELECTA CHURCHILL	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1127	15538	\N	CARLOS TORANO RESERVA SELECTA CHURCHILL	0	1	2	55	55	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1128	15541	\N	CARLOS TORANO RESERVA SELECTA CHURCHILL	0	1	2	220	220	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1129	16854	\N	CARLOS TORANO RESERVA SELECTA CHURCHILL MADURO	0	1	2	65	65	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1130	16129	\N	CARLOS TORANO RESERVA SELECTA PETIT CORONA	0	1	2	8.5	8.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1131	15535	\N	CARLOS TORANO RESERVA SELECTA PETIT CORONA	0	1	2	170	170	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1132	15540	\N	CARLOS TORANO RESERVA SELECTA ROBUSTO	0	1	2	200	200	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1133	16126	\N	CARLOS TORANO RESERVA SELECTA ROBUSTO	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1134	15527	\N	CARLOS TORANO RESERVA SELECTA ROBUSTO	0	1	2	50	50	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1135	16855	\N	CARLOS TORANO RESERVA SELECTA ROBUSTO MADURO	0	1	2	57.5	57.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1136	16125	\N	CARLOS TORANO RESERVA SELECTA TORPEDO	0	1	2	10.5	10.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1137	15539	\N	CARLOS TORANO RESERVA SELECTA TORPEDO	0	1	2	210	210	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1138	932	\N	CEZAR BRONNER 1956	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1139	16289	\N	CEZAR BRONNER 1956	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1140	18058	\N	CEZAR BRONNER 1956 ALFIERE	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1141	18059	\N	CEZAR BRONNER 1956 CACIQUE	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1142	17873	\N	CEZAR BRONNER 1956 CACIQUE	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1143	16283	\N	CEZAR BRONNER 1956 CORONA	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1144	573	\N	CEZAR BRONNER 1956 CORONA	0	1	2	62.5	62.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1145	869	\N	CEZAR BRONNER 1956 PETIT CORONA	0	1	2	60	60	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1146	16284	\N	CEZAR BRONNER 1956 PETIT CORONA	0	1	2	2.3999999999999999	2.3999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1147	569	\N	CEZAR BRONNER 1956 PHARAON	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1148	16285	\N	CEZAR BRONNER 1956 PHARAON	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1149	16287	\N	CEZAR BRONNER 1956 PHARAON ROBUSTO	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1150	184	\N	CEZAR BRONNER 1956 PHARAON ROBUSTO	0	1	2	67.5	67.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1151	16288	\N	CEZAR BRONNER 1956 ROBUSTO	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1152	188	\N	CEZAR BRONNER 1956 ROBUSTO	0	1	2	67.5	67.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1153	17563	\N	CHABA BAHIA CADETES	0	1	2	1.7	1.7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1154	17565	\N	CHABA BAHIA PURO BAHIANO SUPER	0	1	2	1.7	1.7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1155	17562	\N	CHABA BRASIL AUTÊNTICOS PETIT LONSDALE	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1156	17561	\N	CHABA BRASIL AUTÊNTICOS TORPEDO	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1158	180	\N	CHURCHILL HAVANA	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1159	17851	\N	CICERO CRIOLLO IMPERIUM CABINET	0	1	2	220.5	220.5	\N	0	0	1	\N	0	Confezione da 49 pezzi	2009-07-10	0	0	\N	\N	f
1160	17610	\N	CICERO CRIOLLO IMPERIUM CORONA	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1161	17613	\N	CICERO CRIOLLO IMPERIUM PERFECTO NO.1	0	1	2	27.5	27.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1162	17614	\N	CICERO CRIOLLO IMPERIUM PERFECTO NO.3	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1163	17608	\N	CICERO CRIOLLO IMPERIUM PERLA	0	1	2	70	70	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1164	17611	\N	CICERO CRIOLLO IMPERIUM PETIT LANCERO	0	1	2	23	23	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1165	17609	\N	CICERO CRIOLLO IMPERIUM ROBUSTO	0	1	2	29	29	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1166	17612	\N	CICERO CRIOLLO IMPERIUM SHORT TORPEDO	0	1	2	28	28	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1167	17740	\N	CICERO CRIOLLO IMPERIUM TORPEDITO	0	1	2	90	90	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1168	17739	\N	CICERO CRIOLLO IMPERIUM VICESIMOS	0	1	2	160	160	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1169	NEW	\N	COHIBA COLECCION 2008	0	1	2	1	1	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1170	837	\N	COHIBA CORONAS ESPECIALES	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1171	16376	\N	COHIBA CORONAS ESPECIALES	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1172	16360	\N	COHIBA CORONAS ESPECIALES	0	1	2	375	375	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1173	17436	\N	COHIBA DOUBLE CORONAS	0	1	2	650	650	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1174	17363	\N	COHIBA ESPLENDIDOS	0	1	2	81	81	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1175	17362	\N	COHIBA ESPLENDIDOS	0	1	2	675	675	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1176	16895	\N	COHIBA EXQUISITOS	0	1	2	225	225	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1177	17335	\N	COHIBA EXQUISITOS	0	1	2	45	45	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1178	18027	\N	COHIBA GENIOS	0	1	2	210	210	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1179	18026	\N	COHIBA GENIOS	0	1	2	525	525	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1180	16361	\N	COHIBA LANCEROS	0	1	2	450	450	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1181	17101	\N	COHIBA LANCEROS	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1182	15511	\N	COHIBA LANCEROS	0	1	2	90	90	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1183	18025	\N	COHIBA MAGICOS	0	1	2	437.5	437.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1184	18024	\N	COHIBA MAGICOS	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1185	17942	\N	COHIBA PIRAMIDES EDICIÒN LIMITADA 2006	0	1	2	240	240	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1186	15512	\N	COHIBA ROBUSTOS	0	1	2	412.5	412.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1187	17336	\N	COHIBA ROBUSTOS	0	1	2	49.5	49.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1188	18023	\N	COHIBA SECRETOS	0	1	2	93	93	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1189	18022	\N	COHIBA SECRETOS	0	1	2	232.5	232.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1190	17102	\N	COHIBA SIGLO I	0	1	2	8.3000000000000007	8.3000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1191	24	\N	COHIBA SIGLO I	0	1	2	207.5	207.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1192	16587	\N	COHIBA SIGLO I	0	1	2	41.5	41.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1193	17103	\N	COHIBA SIGLO II	0	1	2	11.199999999999999	11.199999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1194	15905	\N	COHIBA SIGLO II	0	1	2	56	56	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1195	16370	\N	COHIBA SIGLO II	0	1	2	280	280	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1196	17905	\N	COHIBA SIGLO II TUBOS	0	1	2	35.399999999999999	35.399999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1197	17903	\N	COHIBA SIGLO II TUBOS	0	1	2	11.800000000000001	11.800000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1198	17104	\N	COHIBA SIGLO III	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1199	16375	\N	COHIBA SIGLO III	0	1	2	65	65	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1200	16368	\N	COHIBA SIGLO IV	0	1	2	80	80	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1201	16381	\N	COHIBA SIGLO IV	0	1	2	16	16	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1202	18181	\N	COHIBA SIGLO IV TUBOS	0	1	2	17	17	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1203	16363	\N	COHIBA SIGLO V	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1204	16362	\N	COHIBA SIGLO V	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1205	18182	\N	COHIBA SIGLO V TUBOS	0	1	2	21	21	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1206	18183	\N	COHIBA SIGLO V TUBOS	0	1	2	63	63	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1207	17280	\N	COHIBA SIGLO VI	0	1	2	550	550	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1208	17532	\N	COHIBA SIGLO VI	0	1	2	66	66	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1209	17432	\N	COHIBA SIGLO VI	0	1	2	220	220	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1210	17872	\N	COHIBA SIGLO VI TUBOS	0	1	2	69	69	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1211	18113	\N	COHIBA SIGLO VI TUBOS	0	1	2	23	23	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1212	17683	\N	COHIBA SUBLIMES	0	1	2	650	650	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1213	420	\N	CORPS DIPLOMATIQUE	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1214	125	\N	CRUZEROS CORONA IN TUBO	0	1	2	8.8000000000000007	8.8000000000000007	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
1215	740	\N	CRUZEROS DEMI TASSE IN TUBO	0	1	2	6.7999999999999998	6.7999999999999998	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
1216	17575	\N	CUABA DIADEMA	0	1	2	22.5	22.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1217	17574	\N	CUABA DIADEMA	0	1	2	112.5	112.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1218	17555	\N	CUABA DISTINGUIDOS	0	1	2	118	118	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1219	15513	\N	CUABA DIVINOS	0	1	2	140	140	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1220	17481	\N	CUABA EXCLUSIVOS	0	1	2	39	39	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1221	15485	\N	CUABA EXCLUSIVOS	0	1	2	195	195	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1222	17482	\N	CUABA GENEROSOS	0	1	2	32.5	32.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1223	15486	\N	CUABA GENEROSOS	0	1	2	162.5	162.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1224	18122	\N	CUABA PIRAMIDES EDIZIONE LIMITATA 2008	0	1	2	155	155	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1225	17364	\N	CUABA SALOMONES	0	1	2	180	180	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1226	15477	\N	CUABA TRADICIONALES	0	1	2	152.5	152.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1227	16159	\N	CUESTA REY ARISTOCRAT	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1228	16175	\N	CUESTA REY BELICOSO n. 11	0	1	2	5.2999999999999998	5.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1229	15289	\N	CUESTA REY CAMEO	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1230	16147	\N	CUESTA REY CAPTIVA	0	1	2	5.4000000000000004	5.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1231	15276	\N	CUESTA REY CAPTIVA	0	1	2	108	108	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1232	17770	\N	CUESTA REY CENTRO FINO BELICOSO N.11	0	1	2	68	68	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1233	17771	\N	CUESTA REY CENTRO FINO BELICOSO N.11	0	1	2	6.7999999999999998	6.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1234	18044	\N	CUESTA REY CENTRO FINO N.60	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1235	18045	\N	CUESTA REY CENTRO FINO PYRAMID N.9	0	1	2	7.5999999999999996	7.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1236	17772	\N	CUESTA REY CENTRO FINO ROBUSTO N.7	0	1	2	68	68	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1237	17773	\N	CUESTA REY CENTRO FINO ROBUSTO N.7	0	1	2	6.7999999999999998	6.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1238	15280	\N	CUESTA REY DOMINICAN No. 5	0	1	2	14.1	14.1	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1239	16173	\N	CUESTA REY DOMINICAN No. 5	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1240	15287	\N	CUESTA REY DOMINICAN No. 5	0	1	2	117.5	117.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1241	16172	\N	CUESTA REY DOMINICAN No. 60	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1242	16781	\N	CUESTA REY PYRAMID N. 9	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1243	16169	\N	CUESTA REY PYRAMID N. 9 MADURO	0	1	2	11.75	11.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1244	15281	\N	CUESTA REY ROBUSTO No. 7	0	1	2	52	52	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1245	16171	\N	CUESTA REY ROBUSTO No. 7	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1246	16394	\N	CUESTA REY TUSCANY	0	1	2	12.25	12.25	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1247	15274	\N	DAVIDOFF 1000	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1248	15275	\N	DAVIDOFF 1000	0	1	2	35	35	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1249	15990	\N	DAVIDOFF 1000	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1250	748	\N	DAVIDOFF 2000	0	1	2	47.5	47.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1251	755	\N	DAVIDOFF 2000	0	1	2	237.5	237.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1252	16003	\N	DAVIDOFF 2000	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1253	148	\N	DAVIDOFF 2000 TUBOS	0	1	2	40	40	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1254	152	\N	DAVIDOFF 2000 TUBOS	0	1	2	200	200	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1255	16000	\N	DAVIDOFF 2000 TUBOS	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1256	15842	\N	DAVIDOFF 3000	0	1	2	55	55	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1257	15890	\N	DAVIDOFF 3000	0	1	2	275	275	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1258	16006	\N	DAVIDOFF 3000	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1259	15919	\N	DAVIDOFF 4000	0	1	2	65	65	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1260	15954	\N	DAVIDOFF 4000	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1261	15917	\N	DAVIDOFF 4000	0	1	2	325	325	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1262	160	\N	DAVIDOFF 5000	0	1	2	61	61	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1263	15966	\N	DAVIDOFF 5000	0	1	2	12.199999999999999	12.199999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1264	163	\N	DAVIDOFF 5000	0	1	2	305	305	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1265	18047	\N	DAVIDOFF 6000	0	1	2	330	330	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1266	18048	\N	DAVIDOFF 6000	0	1	2	52.799999999999997	52.799999999999997	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1267	15273	\N	DAVIDOFF AMBASSADRICE	0	1	2	157.5	157.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1268	15272	\N	DAVIDOFF AMBASSADRICE	0	1	2	31.5	31.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1269	16759	\N	DAVIDOFF AMBASSADRICE	0	1	2	63	63	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1270	15970	\N	DAVIDOFF AMBASSADRICE	0	1	2	6.2999999999999998	6.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1271	15915	\N	DAVIDOFF ANIVERSARIO N.1	0	1	2	315	315	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1272	15971	\N	DAVIDOFF ANIVERSARIO N.1	0	1	2	31.5	31.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1273	15887	\N	DAVIDOFF ANIVERSARIO N.1	0	1	2	157.5	157.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1274	16756	\N	DAVIDOFF ANIVERSARIO N.2	0	1	2	250	250	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1275	15911	\N	DAVIDOFF ANIVERSARIO N.2	0	1	2	625	625	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1276	15912	\N	DAVIDOFF ANIVERSARIO N.2	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1277	15978	\N	DAVIDOFF ANIVERSARIO N.2	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1278	18015	\N	DAVIDOFF ANIVERSARIO N.3	0	1	2	180	180	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1279	15974	\N	DAVIDOFF ANIVERSARIO N.3 TUBOS	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1280	15914	\N	DAVIDOFF ANIVERSARIO N.3 TUBOS	0	1	2	54	54	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1281	15913	\N	DAVIDOFF ANIVERSARIO N.3 TUBOS	0	1	2	360	360	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1282	16442	\N	DAVIDOFF ASSORTIMENT	0	1	2	312.5	312.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1283	16666	\N	DAVIDOFF CHURCHILL	0	1	2	94	94	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1284	16668	\N	DAVIDOFF CHURCHILL	0	1	2	23.5	23.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1285	16670	\N	DAVIDOFF CHURCHILL	0	1	2	235	235	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1286	16766	\N	DAVIDOFF CIGAR ASSORTMENT	0	1	2	64	64	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1287	17732	\N	DAVIDOFF CIGAR ASSORTMENT MILLENNIUM BLEND	0	1	2	56	56	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1288	17939	\N	DAVIDOFF CIGARS ASSORTMENT 9 PREMIUM CIGARS	0	1	2	112.5	112.5	\N	0	0	1	\N	0	Confezione da 9 pezzi	2009-07-10	0	0	\N	\N	f
1289	17876	\N	DAVIDOFF DIADEMAS FINAS	0	1	2	180	180	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1290	15871	\N	DAVIDOFF DOUBLE R	0	1	2	104	104	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1291	15870	\N	DAVIDOFF DOUBLE R	0	1	2	650	650	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1292	15961	\N	DAVIDOFF DOUBLE R	0	1	2	26	26	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1293	16760	\N	DAVIDOFF DOUBLE R	0	1	2	260	260	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1294	17728	\N	DAVIDOFF ENTREACTO	0	1	2	124	124	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1295	17727	\N	DAVIDOFF ENTREACTO	0	1	2	24.800000000000001	24.800000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1296	17726	\N	DAVIDOFF ENTREACTO	0	1	2	6.2000000000000002	6.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1297	15839	\N	DAVIDOFF GRAND CRU N.1	0	1	2	325	325	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1298	15964	\N	DAVIDOFF GRAND CRU N.1	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1299	15853	\N	DAVIDOFF GRAND CRU N.1	0	1	2	65	65	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1300	15838	\N	DAVIDOFF GRAND CRU N.2	0	1	2	287.5	287.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1301	15963	\N	DAVIDOFF GRAND CRU N.2	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1302	15837	\N	DAVIDOFF GRAND CRU N.2	0	1	2	57.5	57.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1303	15980	\N	DAVIDOFF GRAND CRU N.3	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1304	15863	\N	DAVIDOFF GRAND CRU N.3	0	1	2	50	50	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1305	15841	\N	DAVIDOFF GRAND CRU N.3	0	1	2	250	250	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1306	15995	\N	DAVIDOFF GRAND CRU N.4	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1307	128	\N	DAVIDOFF GRAND CRU N.4	0	1	2	225	225	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1308	132	\N	DAVIDOFF GRAND CRU N.4	0	1	2	45	45	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1309	15843	\N	DAVIDOFF GRAND CRU N.5	0	1	2	182.5	182.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1310	15968	\N	DAVIDOFF GRAND CRU N.5	0	1	2	7.2999999999999998	7.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1311	15874	\N	DAVIDOFF GRAND CRU N.5	0	1	2	36.5	36.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1312	18164	\N	DAVIDOFF LANCERO MILLENNIUM BLEND	0	1	2	160	160	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1313	16667	\N	DAVIDOFF LONSDALE MILLENNIUM BLEND	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1314	16663	\N	DAVIDOFF LONSDALE MILLENNIUM BLEND	0	1	2	325	325	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1315	16669	\N	DAVIDOFF LONSDALE MILLENNIUM BLEND	0	1	2	65	65	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1316	17985	\N	DAVIDOFF MB SHORT ROBUSTO	0	1	2	230	230	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1317	17984	\N	DAVIDOFF MB SHORT ROBUSTO	0	1	2	46	46	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1318	15846	\N	DAVIDOFF N.1	0	1	2	387.5	387.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1319	15910	\N	DAVIDOFF N.1	0	1	2	77.5	77.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1320	15976	\N	DAVIDOFF N.1	0	1	2	15.5	15.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1321	16757	\N	DAVIDOFF N.1	0	1	2	155	155	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1322	701	\N	DAVIDOFF N.2	0	1	2	330	330	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1323	689	\N	DAVIDOFF N.2	0	1	2	66	66	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1324	16758	\N	DAVIDOFF N.2	0	1	2	132	132	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1325	15977	\N	DAVIDOFF N.2	0	1	2	13.199999999999999	13.199999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1326	15845	\N	DAVIDOFF N.2 TUBOS	0	1	2	56.799999999999997	56.799999999999997	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1327	15844	\N	DAVIDOFF N.2 TUBOS	0	1	2	284	284	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1328	15979	\N	DAVIDOFF N.2 TUBOS	0	1	2	14.199999999999999	14.199999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1329	15832	\N	DAVIDOFF N.3	0	1	2	185	185	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1330	15956	\N	DAVIDOFF N.3	0	1	2	7.4000000000000004	7.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1331	15865	\N	DAVIDOFF N.3	0	1	2	37	37	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1332	17365	\N	DAVIDOFF PANETELA EXTRA VINTAGE 2000	0	1	2	160	160	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1333	16660	\N	DAVIDOFF PETIT CORONA MILLENNIUM BLEND	0	1	2	47.5	47.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1334	16661	\N	DAVIDOFF PETIT CORONA MILLENNIUM BLEND	0	1	2	237.5	237.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1335	16659	\N	DAVIDOFF PETIT CORONA MILLENNIUM BLEND	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1336	17734	\N	DAVIDOFF PIRAMIDES MILLENNIUM BLEND	0	1	2	68	68	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1337	17735	\N	DAVIDOFF PIRAMIDES MILLENNIUM BLEND	0	1	2	170	170	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1338	17733	\N	DAVIDOFF PIRAMIDES MILLENNIUM BLEND	0	1	2	17	17	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1339	17983	\N	DAVIDOFF PRIMEROS	0	1	2	22.199999999999999	22.199999999999999	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
1340	18055	\N	DAVIDOFF PURO ROBUSTO	0	1	2	150	150	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1341	17940	\N	DAVIDOFF ROBUSTO 100	0	1	2	108	108	\N	0	0	1	\N	0	Confezione da 8 pezzi	2009-07-10	0	0	\N	\N	f
1342	18102	\N	DAVIDOFF ROBUSTO COLLECTION	0	1	2	80	80	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1343	18163	\N	DAVIDOFF ROBUSTO EXTRA RESERVA 12	0	1	2	150	150	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1344	17852	\N	DAVIDOFF ROBUSTO INTENSO	0	1	2	150	150	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1345	16665	\N	DAVIDOFF ROBUSTO MILLENNIUM BLEND	0	1	2	56.799999999999997	56.799999999999997	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1346	16664	\N	DAVIDOFF ROBUSTO MILLENNIUM BLEND	0	1	2	14.199999999999999	14.199999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1347	16662	\N	DAVIDOFF ROBUSTO MILLENNIUM BLEND	0	1	2	355	355	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1348	17595	\N	DAVIDOFF ROBUSTO REAL ESPECIALES 7	0	1	2	140	140	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1349	17729	\N	DAVIDOFF ROBUSTO TUBOS MILLENNIUM BLEND	0	1	2	45	45	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1350	17731	\N	DAVIDOFF ROBUSTO TUBOS MILLENNIUM BLEND	0	1	2	300	300	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1351	17730	\N	DAVIDOFF ROBUSTO TUBOS MILLENNIUM BLEND	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1352	15811	\N	DAVIDOFF SHORT PERFECTO	0	1	2	275	275	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1353	15858	\N	DAVIDOFF SHORT PERFECTO	0	1	2	44	44	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1354	15972	\N	DAVIDOFF SHORT PERFECTO	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1355	15864	\N	DAVIDOFF SHORT T	0	1	2	46.399999999999999	46.399999999999999	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1356	15969	\N	DAVIDOFF SHORT T	0	1	2	11.6	11.6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1357	15859	\N	DAVIDOFF SHORT T	0	1	2	232	232	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1358	17206	\N	DAVIDOFF SPECIAL 48	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1359	17207	\N	DAVIDOFF SPECIAL 53	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1360	15867	\N	DAVIDOFF SPECIAL B	0	1	2	290	290	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1361	15854	\N	DAVIDOFF SPECIAL B	0	1	2	58	58	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1362	15953	\N	DAVIDOFF SPECIAL B	0	1	2	11.6	11.6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1363	15918	\N	DAVIDOFF SPECIAL C. CULEBRAS	0	1	2	126	126	\N	0	0	1	\N	0	Confezione da 12 pezzi	2009-07-10	0	0	\N	\N	f
1364	15921	\N	DAVIDOFF SPECIAL C. CULEBRAS	0	1	2	31.5	31.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1365	137	\N	DAVIDOFF SPECIAL R	0	1	2	330	330	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1366	15962	\N	DAVIDOFF SPECIAL R	0	1	2	13.199999999999999	13.199999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1367	143	\N	DAVIDOFF SPECIAL R	0	1	2	52.799999999999997	52.799999999999997	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1368	15960	\N	DAVIDOFF SPECIAL R TUBOS	0	1	2	14	14	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1369	15872	\N	DAVIDOFF SPECIAL R TUBOS	0	1	2	280	280	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1370	15873	\N	DAVIDOFF SPECIAL R TUBOS	0	1	2	42	42	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1371	15868	\N	DAVIDOFF SPECIAL T	0	1	2	300	300	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1372	15869	\N	DAVIDOFF SPECIAL T	0	1	2	60	60	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1373	15959	\N	DAVIDOFF SPECIAL T	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1374	15857	\N	DAVIDOFF TUBOS ASSORTMENT	0	1	2	37.5	37.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1375	15199	\N	DON SEBASTIAN CHURCHILL	0	1	2	120	120	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1376	16177	\N	DON SEBASTIAN CHURCHILL	0	1	2	4.7999999999999998	4.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1377	15232	\N	DON SEBASTIAN CORONA	0	1	2	23.399999999999999	23.399999999999999	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
1378	16167	\N	DON SEBASTIAN CORONA	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1379	16505	\N	DON SEBASTIAN GRAN CORONA MADURO	0	1	2	27	27	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
1380	16479	\N	DON SEBASTIAN GRAN CORONA MADURO	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1381	16503	\N	DON SEBASTIAN GRAN CORONA MADURO	0	1	2	112.5	112.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1382	16749	\N	DON SEBASTIAN LONSDALE	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1383	15234	\N	DON SEBASTIAN LONSDALE	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1384	17367	\N	DON SEBASTIAN NO°4	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1385	16166	\N	DON SEBASTIAN TORO	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1386	16165	\N	DON SEBASTIAN TUBOS	0	1	2	4.7999999999999998	4.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1387	15892	\N	DON SEBASTIAN TUBOS	0	1	2	14.4	14.4	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1388	16164	\N	DON SEVILLE BONITA	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1389	15675	\N	DON SEVILLE BONITA	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1390	15665	\N	DON SEVILLE ROBUSTO	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1391	16163	\N	DON SEVILLE ROBUSTO	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1392	16148	\N	DON SEVILLE VALENCIA	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1393	15673	\N	DON SEVILLE VALENCIA	0	1	2	14	14	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1394	18040	\N	DON TOMAS CLÀSICO CORONA GRANDE	0	1	2	102.5	102.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1395	18041	\N	DON TOMAS CLÀSICO CORONA GRANDE	0	1	2	4.0999999999999996	4.0999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1396	18034	\N	DON TOMAS CLÀSICO NUMBER 4	0	1	2	70	70	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1397	18035	\N	DON TOMAS CLÀSICO NUMBER 4	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1398	18042	\N	DON TOMAS CLÀSICO PRESIDENTE	0	1	2	92.5	92.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1399	18043	\N	DON TOMAS CLÀSICO PRESIDENTE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1400	18039	\N	DON TOMAS CLÀSICO ROBUSTO	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1401	18038	\N	DON TOMAS CLÀSICO ROBUSTO	0	1	2	80	80	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1402	18037	\N	DON TOMAS MADURO ROTHSCHILD	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1403	18036	\N	DON TOMAS MADURO ROTHSCHILD	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1404	1354	\N	DOUGALLS KING SIZE CHEROOTS	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1405	17930	\N	DUE MONDI OSBA	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1406	17437	\N	DUE MONDI T	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1407	17487	\N	DUNHILL SIGNED RANGE CIGAR - CHURCHILLS	0	1	2	44.700000000000003	44.700000000000003	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1408	18052	\N	DUNHILL SIGNED RANGE CIGAR - CHURCHILLS	0	1	2	372.5	372.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1409	18049	\N	DUNHILL SIGNED RANGE CIGAR - CORONAS	0	1	2	44.5	44.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1410	17489	\N	DUNHILL SIGNED RANGE CIGAR - CORONAS	0	1	2	26.699999999999999	26.699999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1411	17488	\N	DUNHILL SIGNED RANGE CIGAR - CORONAS	0	1	2	222.5	222.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1412	17490	\N	DUNHILL SIGNED RANGE CIGAR - PETIT CORONAS	0	1	2	172.5	172.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1413	18050	\N	DUNHILL SIGNED RANGE CIGAR - PETIT CORONAS	0	1	2	34.5	34.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1414	17491	\N	DUNHILL SIGNED RANGE CIGAR - PETIT CORONAS	0	1	2	20.699999999999999	20.699999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1415	18051	\N	DUNHILL SIGNED RANGE CIGAR - ROBUSTOS	0	1	2	39.600000000000001	39.600000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1416	17492	\N	DUNHILL SIGNED RANGE CIGAR - ROBUSTOS	0	1	2	247.5	247.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1417	17493	\N	DUNHILL SIGNED RANGE CIGAR - ROBUSTOS	0	1	2	29.699999999999999	29.699999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1418	17494	\N	DUNHILL SIGNED RANGE CIGAR - TORPEDOS	0	1	2	297.5	297.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1419	17495	\N	DUNHILL SIGNED RANGE CIGAR - TORPEDOS	0	1	2	35.700000000000003	35.700000000000003	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1420	17496	\N	DUNHILL SIGNED RANGE CIGAR - TUBED CORONAS	0	1	2	49.5	49.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1421	17743	\N	DUNHILL SIGNED RANGE CIGAR - TUBED CORONAS	0	1	2	198	198	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1422	18136	\N	DUNHILL SIGNED RANGE SELECTION BOX	0	1	2	60	60	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
1423	18132	\N	DUNHILL SIGNED RANGE TOROS	0	1	2	38.700000000000003	38.700000000000003	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1424	18131	\N	DUNHILL SIGNED RANGE TOROS	0	1	2	322.5	322.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1425	18135	\N	DUNHILL SIGNED RANGE TUBED CHURCHILLS	0	1	2	50.700000000000003	50.700000000000003	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1426	18133	\N	DUNHILL SIGNED RANGE TUBED PETIT CORONAS	0	1	2	39.5	39.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1427	18134	\N	DUNHILL SIGNED RANGE TUBED ROBUSTOS	0	1	2	43.600000000000001	43.600000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1428	17032	\N	EL CREDITO CHURCHILL	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1429	17368	\N	EL CREDITO CHURCHILL MADURO	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1430	17598	\N	EL CREDITO COLLECCION (NATURAL) 6 CIGARROS	0	1	2	60	60	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
1431	17599	\N	EL CREDITO COLLECCION MADURO 6 CIGARROS	0	1	2	60	60	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
1432	17034	\N	EL CREDITO CRISTAL DE LUXE	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1433	17369	\N	EL CREDITO CRISTAL DE LUXE MADURO	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1434	17037	\N	EL CREDITO EXQUISITOS	0	1	2	24.5	24.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1435	17370	\N	EL CREDITO EXQUISITOS MADURO	0	1	2	24.5	24.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1436	17036	\N	EL CREDITO N.4	0	1	2	5.5999999999999996	5.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1437	17371	\N	EL CREDITO NO . 4 MADURO	0	1	2	5.5999999999999996	5.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1438	17438	\N	EL CREDITO PERFECTO	0	1	2	8.5	8.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1439	17038	\N	EL CREDITO PURITOS	0	1	2	10.5	10.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1440	17372	\N	EL CREDITO PURITOS MADURO	0	1	2	10.5	10.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1441	17035	\N	EL CREDITO ROBUSTO	0	1	2	7.5999999999999996	7.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1442	17373	\N	EL CREDITO ROBUSTO MADURO	0	1	2	7.5999999999999996	7.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1443	17848	\N	EL CREDITO SERIE F MANANA	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1444	17849	\N	EL CREDITO SERIE F NOCHE	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1445	17850	\N	EL CREDITO SERIE F SEMANA	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 14 pezzi	2009-07-10	0	0	\N	\N	f
1446	17600	\N	EL CREDITO SERIE R NO.4	0	1	2	8.5	8.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1447	17601	\N	EL CREDITO SERIE R NO.5	0	1	2	9.25	9.25	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1448	17602	\N	EL CREDITO SERIE R NO.6	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1449	17033	\N	EL CREDITO TORPEDO N.2	0	1	2	8.75	8.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1450	17374	\N	EL CREDITO TORPEDO N°2 MADURO	0	1	2	8.75	8.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1451	15494	\N	EL REY DEL MUNDO CHOIX SUPREME	0	1	2	207.5	207.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1452	NEW	\N	EL REY DEL MUNDO DEMI TASSE	0	1	2	82.5	82.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1453	NEW	\N	EL REY DEL MUNDO GRANDES DE ESPAÑA	0	1	2	220	220	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1454	NEW	\N	EL REY DEL MUNDO LUNCH CLUB	0	1	2	127.5	127.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1455	NEW	\N	EL REY DEL MUNDO PETIT CORONAS	0	1	2	132.5	132.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1456	NEW	\N	ESMERALDA ROBUSTO	0	1	2	83.75	83.75	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1457	17196	\N	EXCALIBUR CHURCHILL DE LUXE NO.II	0	1	2	98	98	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1458	17197	\N	EXCALIBUR CHURCHILL DE LUXE NO.II	0	1	2	9.8000000000000007	9.8000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1459	17199	\N	EXCALIBUR CORONA GORDA NO.IV	0	1	2	6.5	6.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1460	17198	\N	EXCALIBUR CORONA GORDA NO.IV	0	1	2	65	65	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1461	17203	\N	EXCALIBUR DEMI-TASSE NO.VIII	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1462	17202	\N	EXCALIBUR DEMI-TASSE NO.VIII	0	1	2	70	70	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1463	16243	\N	EXCALIBUR EPICURE	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1464	15357	\N	EXCALIBUR EPICURE	0	1	2	70	70	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1465	17205	\N	EXCALIBUR PERFECTO UNICO	0	1	2	6.75	6.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1466	17201	\N	EXCALIBUR PETIT CORONA NO.VII	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1467	17922	\N	EXCALIBUR ROYAL STERLING LEGENDA	0	1	2	112	112	\N	0	0	1	\N	0	Confezione da 40 pezzi	2009-07-10	0	0	\N	\N	f
1468	17935	\N	EXCALIBUR ROYAL STERLING LEGENDA	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1469	17924	\N	EXCALIBUR ROYAL STERLING NOBILIS	0	1	2	156	156	\N	0	0	1	\N	0	Confezione da 40 pezzi	2009-07-10	0	0	\N	\N	f
1470	17937	\N	EXCALIBUR ROYAL STERLING NOBILIS	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1471	17923	\N	EXCALIBUR ROYAL STERLING VALERE	0	1	2	144	144	\N	0	0	1	\N	0	Confezione da 40 pezzi	2009-07-10	0	0	\N	\N	f
1472	17936	\N	EXCALIBUR ROYAL STERLING VALERE	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1473	17145	\N	FELIPE GREGORIO BELICOSO	0	1	2	158	158	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1474	17146	\N	FELIPE GREGORIO BELICOSO	0	1	2	7.9000000000000004	7.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1475	17148	\N	FELIPE GREGORIO MYSTIC KNIGHT	0	1	2	8.0999999999999996	8.0999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1476	17147	\N	FELIPE GREGORIO MYSTIC KNIGHT	0	1	2	202.5	202.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1477	17154	\N	FELIPE GREGORIO NIÑO	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1478	17153	\N	FELIPE GREGORIO NIÑO	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1479	17150	\N	FELIPE GREGORIO ROBUSTO	0	1	2	7.5999999999999996	7.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1480	17149	\N	FELIPE GREGORIO ROBUSTO	0	1	2	190	190	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1481	17152	\N	FELIPE GREGORIO SERENO	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1482	17151	\N	FELIPE GREGORIO SERENO	0	1	2	187.5	187.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1483	17161	\N	FELIPE II FUSION OF VINTAGE TOBACCOS F3	0	1	2	166	166	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1484	17162	\N	FELIPE II FUSION OF VINTAGE TOBACCOS F3	0	1	2	8.3000000000000007	8.3000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1485	17156	\N	FELIPE II RESERVA B	0	1	2	7.9000000000000004	7.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1486	17155	\N	FELIPE II RESERVA B	0	1	2	197.5	197.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1487	17160	\N	FELIPE II RESERVA D	0	1	2	7.7000000000000002	7.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1488	17159	\N	FELIPE II RESERVA D	0	1	2	192.5	192.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1489	17158	\N	FELIPE II RESERVA R	0	1	2	7.5999999999999996	7.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1490	17157	\N	FELIPE II RESERVA R	0	1	2	190	190	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1491	579	\N	FLEUR DE SAVANE CORONA	0	1	2	5.7000000000000002	5.7000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1492	17763	\N	FLOR DE SELVA CHURCHILL	0	1	2	212.5	212.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1493	17953	\N	FLOR DE SELVA CHURCHILL	0	1	2	425	425	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1494	17764	\N	FLOR DE SELVA CHURCHILL SEMANARIO	0	1	2	59.5	59.5	\N	0	0	1	\N	0	Confezione da 7 pezzi	2009-07-10	0	0	\N	\N	f
1495	17761	\N	FLOR DE SELVA CORONA	0	1	2	187.5	187.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1496	17952	\N	FLOR DE SELVA CORONA	0	1	2	375	375	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1497	17762	\N	FLOR DE SELVA CORONA SEMANARIO	0	1	2	52.5	52.5	\N	0	0	1	\N	0	Confezione da 7 pezzi	2009-07-10	0	0	\N	\N	f
1498	18167	\N	FLOR DE SELVA DECIMO	0	1	2	144	144	\N	0	0	1	\N	0	Confezione da 12 pezzi	2009-07-10	0	0	\N	\N	f
1499	17954	\N	FLOR DE SELVA DOBLE CORONA	0	1	2	450	450	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1500	17765	\N	FLOR DE SELVA DOBLE CORONA	0	1	2	225	225	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1501	18168	\N	FLOR DE SELVA EL GALAN	0	1	2	300	300	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1502	17759	\N	FLOR DE SELVA FINO	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1503	17951	\N	FLOR DE SELVA FINO	0	1	2	350	350	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1504	17760	\N	FLOR DE SELVA FINO SEMANARIO	0	1	2	49	49	\N	0	0	1	\N	0	Confezione da 7 pezzi	2009-07-10	0	0	\N	\N	f
1505	17753	\N	FLOR DE SELVA PANATELA	0	1	2	105	105	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1506	17754	\N	FLOR DE SELVA PETIT CORONA	0	1	2	137.5	137.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1507	17949	\N	FLOR DE SELVA PETIT CORONA	0	1	2	275	275	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1508	17755	\N	FLOR DE SELVA PETIT CORONA SEMANARIO	0	1	2	38.5	38.5	\N	0	0	1	\N	0	Confezione da 7 pezzi	2009-07-10	0	0	\N	\N	f
1509	17756	\N	FLOR DE SELVA ROBUSTO	0	1	2	162.5	162.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1510	17950	\N	FLOR DE SELVA ROBUSTO	0	1	2	325	325	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1511	17757	\N	FLOR DE SELVA ROBUSTO SEMANARIO	0	1	2	45.5	45.5	\N	0	0	1	\N	0	Confezione da 7 pezzi	2009-07-10	0	0	\N	\N	f
1512	17963	\N	FLOR DE SELVA SIESTA	0	1	2	104	104	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1513	18169	\N	FLOR DE SELVA TEMPO	0	1	2	200	200	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1514	17376	\N	FLOR DEL CARIBE CORONA	0	1	2	3.1000000000000001	3.1000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1515	17375	\N	FLOR DEL CARIBE CORONA	0	1	2	77.5	77.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1516	17377	\N	FLOR DEL CARIBE PEQUENO	0	1	2	70	70	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1517	17378	\N	FLOR DEL CARIBE PEQUENO	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1518	17380	\N	FLOR DEL CARIBE ROBUSTO	0	1	2	2.8999999999999999	2.8999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1519	17379	\N	FLOR DEL CARIBE ROBUSTO	0	1	2	72.5	72.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1520	16382	\N	FONSECA COSACOS	0	1	2	21.5	21.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1521	15476	\N	FONSECA DELICIAS	0	1	2	72.5	72.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1522	15475	\N	FONSECA KDT CADETES	0	1	2	67.5	67.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1523	15904	\N	FONSECA N.1	0	1	2	157.5	157.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1524	16249	\N	FUENTE-FUENTE OPUS-X BELICOSO X3	0	1	2	21	21	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1525	15906	\N	FUENTE-FUENTE OPUS-X BELICOSO X3	0	1	2	882	882	\N	0	0	1	\N	0	Confezione da 42 pezzi	2009-07-10	0	0	\N	\N	f
1526	16250	\N	FUENTE-FUENTE OPUS-X DOUBLE CORONA	0	1	2	32.5	32.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1527	15881	\N	FUENTE-FUENTE OPUS-X DOUBLE CORONA	0	1	2	1.04	1.04	\N	0	0	1	\N	0	Confezione da 32 pezzi	2009-07-10	0	0	\N	\N	f
1528	16251	\N	FUENTE-FUENTE OPUS-X FUENTE-FUENTE	0	1	2	21	21	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1529	15901	\N	FUENTE-FUENTE OPUS-X FUENTE-FUENTE	0	1	2	672	672	\N	0	0	1	\N	0	Confezione da 32 pezzi	2009-07-10	0	0	\N	\N	f
1530	15880	\N	FUENTE-FUENTE OPUS-X PERFECXION N.2	0	1	2	928	928	\N	0	0	1	\N	0	Confezione da 29 pezzi	2009-07-10	0	0	\N	\N	f
1531	16252	\N	FUENTE-FUENTE OPUS-X PERFECXION N.2	0	1	2	32	32	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1532	15907	\N	FUENTE-FUENTE OPUS-X PERFECXION N.4	0	1	2	819	819	\N	0	0	1	\N	0	Confezione da 42 pezzi	2009-07-10	0	0	\N	\N	f
1533	16257	\N	FUENTE-FUENTE OPUS-X PERFECXION N.4	0	1	2	19.5	19.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1534	16691	\N	FUENTE-FUENTE OPUS-X PERFECXION N° 5	0	1	2	18.5	18.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1535	16690	\N	FUENTE-FUENTE OPUS-X RESERVA DCHATEAU	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1536	16263	\N	FUENTE-FUENTE OPUS-X ROBUSTO	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1537	16708	\N	FUENTE-FUENTE OPUS-X ROBUSTO	0	1	2	725	725	\N	0	0	1	\N	0	Confezione da 29 pezzi	2009-07-10	0	0	\N	\N	f
1538	16692	\N	FUENTE-FUENTE OPUS-X SUPER BELICOSO	0	1	2	28	28	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1539	15613	\N	GARCIA Y VEGA BARONS	0	1	2	6.2999999999999998	6.2999999999999998	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1540	15207	\N	GARCIA Y VEGA BRAVURA	0	1	2	5.7999999999999998	5.7999999999999998	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1541	15208	\N	GARCIA Y VEGA PRESIDENTE	0	1	2	6.4000000000000004	6.4000000000000004	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
1542	NEW	\N	GRANDUCATO	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1543	17472	\N	GRAYCLIFF EMERALD PG	0	1	2	15.9	15.9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1544	17057	\N	GRAYCLIFF PROFESSIONALE CORONAS	0	1	2	9.6999999999999993	9.6999999999999993	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1545	17055	\N	GRAYCLIFF PROFESSIONALE PG	0	1	2	11.9	11.9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1546	17052	\N	GRAYCLIFF PROFESSIONALE PG X	0	1	2	13.5	13.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1547	17053	\N	GRAYCLIFF PROFESSIONALE PIRATE	0	1	2	14.9	14.9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1548	17050	\N	GRAYCLIFF PROFESSIONALE PRESIDENT	0	1	2	14.9	14.9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1549	17141	\N	GUANTANAMERA COMPAY	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1550	17142	\N	GUANTANAMERA COMPAY	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1551	17137	\N	GUANTANAMERA CRISTALES	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1552	17138	\N	GUANTANAMERA CRISTALES	0	1	2	1.8	1.8	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1553	17136	\N	GUANTANAMERA CRISTALES	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1554	17140	\N	GUANTANAMERA DECIMOS	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1555	17139	\N	GUANTANAMERA DECIMOS	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1556	17943	\N	GUANTANAMERA MINUTOS	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1557	NEW	\N	GUANTANAMERA MINUTOS	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1558	18104	\N	H. UPMANN COLECCION 2007	0	1	2	750	750	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1559	16365	\N	H. UPMANN CONNOISSEUR N. 1	0	1	2	220	220	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1560	16821	\N	H. UPMANN CORONAS JUNIOR	0	1	2	107.5	107.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1561	16822	\N	H. UPMANN CORONAS JUNIOR	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1562	NEW	\N	H. UPMANN CORONAS MAJOR T/A	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1563	NEW	\N	H. UPMANN CORONAS MINOR T/A	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1564	NEW	\N	H. UPMANN LINEA MAGNUM	0	1	2	46	46	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
1565	16823	\N	H. UPMANN MAGNUM 46	0	1	2	280	280	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1566	17723	\N	H. UPMANN MAGNUM 46	0	1	2	33.600000000000001	33.600000000000001	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1567	18116	\N	H. UPMANN MAGNUM 46 TUBOS	0	1	2	35.399999999999999	35.399999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1568	18117	\N	H. UPMANN MAGNUM 46 TUBOS	0	1	2	11.800000000000001	11.800000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1569	18129	\N	H. UPMANN MAGNUM 50	0	1	2	120	120	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1570	18130	\N	H. UPMANN MAGNUM 50	0	1	2	600	600	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1571	18120	\N	H. UPMANN MAGNUM 50	0	1	2	300	300	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1572	17796	\N	H. UPMANN MAGNUM 50 EDIZIONE LIMITATA	0	1	2	362.5	362.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1573	16820	\N	H. UPMANN MAJESTIC	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1574	NEW	\N	H. UPMANN MONARCAS TUBOS	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1575	NEW	\N	H. UPMANN PETIT CORONAS	0	1	2	140	140	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1576	16824	\N	H. UPMANN REGALIAS	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1577	15505	\N	H. UPMANN SIR WINSTON	0	1	2	475	475	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1578	16818	\N	H. UPMANN UPMANN No. 2	0	1	2	300	300	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1579	17497	\N	HABANOS SELECCION PIRAMIDES	0	1	2	92.5	92.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1580	17440	\N	HABANOS SELECCION ROBUSTOS	0	1	2	87.5	87.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1581	NEW	\N	HABANOS X FESTIVAL 2008	0	1	2	220	220	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1586	16325	\N	HOMMAGE 1492 CHURCHILL	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1587	16304	\N	HOMMAGE 1492 CORONA	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1588	17826	\N	HOYO DE MONTERREY CORONATIONS	0	1	2	5.7999999999999998	5.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1589	17498	\N	HOYO DE MONTERREY CORONATIONS	0	1	2	17.399999999999999	17.399999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1590	17429	\N	HOYO DE MONTERREY DOUBLE CORONAS	0	1	2	45	45	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1591	16364	\N	HOYO DE MONTERREY DOUBLE CORONAS	0	1	2	375	375	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1592	17684	\N	HOYO DE MONTERREY EPICURE ESPECIAL	0	1	2	325	325	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1593	18172	\N	HOYO DE MONTERREY EPICURE ESPECIAL HABANA	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1594	18175	\N	HOYO DE MONTERREY EPICURE ESPECIAL HABANA	0	1	2	250	250	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1595	18178	\N	HOYO DE MONTERREY EPICURE ESPECIAL TUBOS	0	1	2	10.800000000000001	10.800000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1596	17428	\N	HOYO DE MONTERREY EPICURE N. 1	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1597	16384	\N	HOYO DE MONTERREY EPICURE N. 1	0	1	2	250	250	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1598	17648	\N	HOYO DE MONTERREY EPICURE N. 2	0	1	2	480	480	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1599	17427	\N	HOYO DE MONTERREY EPICURE N. 2	0	1	2	28.800000000000001	28.800000000000001	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1600	15472	\N	HOYO DE MONTERREY EPICURE N. 2	0	1	2	240	240	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1601	16830	\N	HOYO DE MONTERREY LE HOYO DES DIEUX	0	1	2	45	45	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1602	16601	\N	HOYO DE MONTERREY LE HOYO DU DEPUTE	0	1	2	290	290	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1603	15496	\N	HOYO DE MONTERREY LE HOYO DU DEPUTE"	0	1	2	145	145	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1604	16831	\N	HOYO DE MONTERREY LE HOYO DU GOURMET	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1605	15489	\N	HOYO DE MONTERREY LE HOYO DU PRINCE	0	1	2	162.5	162.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1606	16385	\N	HOYO DE MONTERREY LE HOYO DU ROI	0	1	2	38	38	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1607	NEW	\N	HOYO DE MONTERREY LINEA EPICURE	0	1	2	54	54	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1608	16832	\N	HOYO DE MONTERREY PALMAS EXTRA	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1609	17650	\N	HOYO DE MONTERREY PETIT ROBUSTO	0	1	2	195	195	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1610	17703	\N	HOYO DE MONTERREY PETIT ROBUSTO	0	1	2	23.399999999999999	23.399999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1611	18030	\N	HOYO DE MONTERREY REGALOS 2007	0	1	2	275	275	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1612	17777	\N	IL BRIGANTE	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1613	74	\N	IL MORO	0	1	2	35	35	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1614	17929	\N	IL PROFESSORE	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1615	17622	\N	IL TRAIANO CORONA 4	0	1	2	161	161	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1616	17725	\N	IL TRAIANO CORONA 4	0	1	2	16.100000000000001	16.100000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1617	17747	\N	INDEPENDENCIA BELICOSOS	0	1	2	95	95	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1618	17748	\N	INDEPENDENCIA BELICOSOS	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1619	17749	\N	INDEPENDENCIA N.4	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1620	17750	\N	INDEPENDENCIA N.4	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1621	17751	\N	INDEPENDENCIA ROBUSTO	0	1	2	82.5	82.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1622	17752	\N	INDEPENDENCIA ROBUSTO	0	1	2	3.2999999999999998	3.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1623	16123	\N	INDIAN TABAC CIGARS CO. CLASSIC BOXER	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1624	15742	\N	INDIAN TABAC CIGARS CO. CLASSIC BOXER	0	1	2	137.5	137.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1625	15762	\N	INDIAN TABAC CIGARS CO. CLASSIC CHIEF	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1626	16122	\N	INDIAN TABAC CIGARS CO. CLASSIC CHIEF	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1627	15761	\N	INDIAN TABAC CIGARS CO. CLASSIC TEEPEE	0	1	2	170	170	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1628	16121	\N	INDIAN TABAC CIGARS CO. CLASSIC TEEPEE	0	1	2	6.7999999999999998	6.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1629	16120	\N	INDIAN TABAC CIGARS CO. CLASSIC TOMAHAWK	0	1	2	6.2000000000000002	6.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1630	15758	\N	INDIAN TABAC CIGARS CO. CLASSIC TOMAHAWK	0	1	2	155	155	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1631	15759	\N	INDIAN TABAC CIGARS CO. LIMITED RESERVE-SERIES A THE BEAR	0	1	2	187.5	187.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1632	16110	\N	INDIAN TABAC CIGARS CO. LIMITED RESERVE-SERIES A THE BEAR.	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1633	15757	\N	INDIAN TABAC CIGARS CO. LIMITED RESERVE-SERIES A THE BISON	0	1	2	220	220	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1634	16118	\N	INDIAN TABAC CIGARS CO. LIMITED RESERVE-SERIES A THE BISON.	0	1	2	8.8000000000000007	8.8000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1635	15754	\N	INDIAN TABAC CIGARS CO. LIMITED RESERVE-SERIES A THE BUFFALO	0	1	2	200	200	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1636	16127	\N	INDIAN TABAC CIGARS CO. LIMITED RESERVE-SERIES A THE BUFFALO.	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1637	705	\N	J. CORTES CLUB	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1638	592	\N	J. CORTES HIGH CLASS	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
1639	578	\N	J. CORTES HIGH CLASS	0	1	2	21	21	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1640	18031	\N	J.L.PIEDRA PETIT CAZADORES	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1641	18032	\N	J.L.PIEDRA PETIT CAZADORES	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1642	17948	\N	JOSE L. PIEDRA BREVAS	0	1	2	41.25	41.25	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1643	16577	\N	JOSE L. PIEDRA BREVAS	0	1	2	8.25	8.25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1644	16568	\N	JOSE L. PIEDRA CAZADORES	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1645	16579	\N	JOSE L. PIEDRA CONSERVAS	0	1	2	8.75	8.75	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1646	16575	\N	JOSE L. PIEDRA CREMAS	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1647	16578	\N	JOSE L. PIEDRA NACIONALES	0	1	2	8.25	8.25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1648	16576	\N	JOSE L. PIEDRA PETIT CETROS	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1649	17241	\N	JOSE MARTI LA TRINIDAD	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1650	17242	\N	JOSE MARTI MASAYA	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1651	17245	\N	JOSE MARTI PETIT LANCERO	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1652	17243	\N	JOSE MARTI REMEDIOS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1653	17244	\N	JOSE MARTI ROBUSTO	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1654	17229	\N	JOYA DE NICARAGUA ANTANO 1970 BELICOSO	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1655	17227	\N	JOYA DE NICARAGUA ANTANO 1970 GRAN CONSUL	0	1	2	6.75	6.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1656	17383	\N	JOYA DE NICARAGUA ANTANO 1970 MACHITO	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1657	17228	\N	JOYA DE NICARAGUA ANTANO 1970 ROBUSTO GRANDE	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1658	17706	\N	JOYA DE NICARAGUA CELEBRACION CONSUL	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1659	17705	\N	JOYA DE NICARAGUA CELEBRACION CORONA	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1660	17707	\N	JOYA DE NICARAGUA CELEBRACION TORO	0	1	2	5.2999999999999998	5.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1661	17708	\N	JOYA DE NICARAGUA CELEBRACION TORPEDO	0	1	2	6.25	6.25	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1662	16116	\N	JOYA DE NICARAGUA CHURCHILL	0	1	2	4.7999999999999998	4.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1663	15221	\N	JOYA DE NICARAGUA CHURCHILL	0	1	2	120	120	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1664	16115	\N	JOYA DE NICARAGUA CONSUL	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1665	15205	\N	JOYA DE NICARAGUA CONSUL	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1666	17042	\N	JOYA DE NICARAGUA CONSUL MADURO	0	1	2	4.75	4.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1667	15229	\N	JOYA DE NICARAGUA NUMERO 5	0	1	2	90	90	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1668	16114	\N	JOYA DE NICARAGUA NUMERO 5	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1669	16113	\N	JOYA DE NICARAGUA NUMERO 6	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1670	15217	\N	JOYA DE NICARAGUA NUMERO 6	0	1	2	97.5	97.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1671	17041	\N	JOYA DE NICARAGUA NUMERO 6 MADURO	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1672	16112	\N	JOYA DE NICARAGUA PETITS	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1673	15257	\N	JOYA DE NICARAGUA PETITS	0	1	2	80	80	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1674	17040	\N	JOYA DE NICARAGUA PETITS MADURO	0	1	2	3.75	3.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1675	16111	\N	JOYA DE NICARAGUA PICCOLINO	0	1	2	2.3999999999999999	2.3999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1676	15215	\N	JOYA DE NICARAGUA PICCOLINO	0	1	2	60	60	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1677	17039	\N	JOYA DE NICARAGUA PICCOLINO MADURO	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1678	16136	\N	JOYA DE NICARAGUA SENORITAS	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1679	15237	\N	JOYA DE NICARAGUA SENORITAS	0	1	2	70	70	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1680	16138	\N	JOYA DE NICARAGUA TORO	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1681	15219	\N	JOYA DE NICARAGUA TORO	0	1	2	110	110	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1682	16075	\N	JOYA DE NICARAGUA TORPEDO	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1683	15220	\N	JOYA DE NICARAGUA TORPEDO	0	1	2	117.5	117.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1684	17043	\N	JOYA DE NICARAGUA TORPEDO MADURO	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1685	17441	\N	JUAN LOPEZ PETIT CORONAS	0	1	2	140	140	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1686	15497	\N	JUAN LOPEZ SELECCION N. 1	0	1	2	237.5	237.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1687	15903	\N	JUAN LOPEZ SELECCION N.2	0	1	2	225	225	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1688	16305	\N	KING EDWARD CORONA	0	1	2	8.6999999999999993	8.6999999999999993	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1689	17745	\N	LA AURORA AURORA PREFERIDOS	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1690	17746	\N	LA AURORA AURORA PREFERIDOS	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1691	16261	\N	LA AURORA BELICOSOS	0	1	2	8.5	8.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1692	15805	\N	LA AURORA BELICOSOS	0	1	2	212.5	212.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1693	16260	\N	LA AURORA BRISTOL ESPECIALES	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1694	15808	\N	LA AURORA BRISTOL ESPECIALES	0	1	2	122.5	122.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1695	15899	\N	LA AURORA FINOS	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1696	15813	\N	LA AURORA N.4	0	1	2	97.5	97.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1697	16259	\N	LA AURORA N.4	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1698	15860	\N	LA AURORA PETIT CORONAS	0	1	2	95	95	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1699	16253	\N	LA AURORA PETIT CORONAS	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1700	17384	\N	LA AURORA PREFERIDOS NO.2 PLATINUM EDITION	0	1	2	540	540	\N	0	0	1	\N	0	Confezione da 24 pezzi	2009-07-10	0	0	\N	\N	f
1701	17385	\N	LA AURORA PREFERIDOS NO.2 PLATINUM EDITION	0	1	2	22.5	22.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1702	15802	\N	LA AURORA ROBUSTO	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1703	16256	\N	LA AURORA ROBUSTO	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1704	17744	\N	LA AURORA ROBUSTO SELECTION	0	1	2	26.5	26.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1705	17883	\N	LA AURORA ROTHSCHILD	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1706	17882	\N	LA AURORA ROTHSCHILD	0	1	2	107.5	107.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1707	17233	\N	LA FINCA CORONA	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1708	17230	\N	LA FINCA FIGURADO	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1709	17232	\N	LA FINCA JOYAS	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1710	17231	\N	LA FINCA PYRAMIDE	0	1	2	4.25	4.25	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1711	17234	\N	LA FINCA ROBUSTO	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1712	NEW	\N	LA FLOR DE CANO PETIT CORONAS	0	1	2	57.5	57.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1713	16556	\N	LA FLOR DE CANO PREFERIDOS	0	1	2	3.4199999999999999	3.4199999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1714	NEW	\N	LA FLOR DE CANO SELECTOS	0	1	2	60	60	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1715	1922	\N	LA FLOR DE LA ISABELA CORONAS TUBOS	0	1	2	1.5	1.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1716	1921	\N	LA FLOR DE LA ISABELA CORONAS TUBOS	0	1	2	37.5	37.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1717	1923	\N	LA FLOR DE LA ISABELA HALF CORONAS	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1718	1924	\N	LA FLOR DE LA ISABELA PANATELAS	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1719	808	\N	LA FLOR DE LOS REYES BELICOSO	0	1	2	17.039999999999999	17.039999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1720	484	\N	LA FLOR DE LOS REYES BELICOSO	0	1	2	28.399999999999999	28.399999999999999	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1721	519	\N	LA FLOR DE LOS REYES BELICOSO	0	1	2	142	142	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1722	486	\N	LA FLOR DE LOS REYES BELICOSO	0	1	2	56.799999999999997	56.799999999999997	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1723	739	\N	LA FLOR DE LOS REYES CORONA	0	1	2	25.800000000000001	25.800000000000001	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1724	759	\N	LA FLOR DE LOS REYES CORONA	0	1	2	51.600000000000001	51.600000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1725	720	\N	LA FLOR DE LOS REYES CORONA	0	1	2	15.48	15.48	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1726	782	\N	LA FLOR DE LOS REYES CORONA	0	1	2	129	129	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1727	682	\N	LA FLOR DE LOS REYES TORPEDO	0	1	2	155	155	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1728	588	\N	LA FLOR DE LOS REYES TORPEDO	0	1	2	62	62	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1729	580	\N	LA FLOR DE LOS REYES TORPEDO	0	1	2	31	31	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1730	17386	\N	LA GLORIA CUBANA MEDAILLE DOR NO. 1	0	1	2	212.5	212.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1731	NEW	\N	LA GLORIA CUBANA MEDAILLE DOR NO. 2	0	1	2	255	255	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1732	17387	\N	LA GLORIA CUBANA MEDAILLE DOR NO. 3	0	1	2	167.5	167.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1733	18091	\N	LA GLORIA CUBANA TAINOS	0	1	2	122	122	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1734	16603	\N	LA LIBERTAD DEMI CORONA	0	1	2	1	1	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1735	1881	\N	LA PAZ 5 WILDE CIGARROS AROMA	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1736	16787	\N	LA PAZ CORONA	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1737	16785	\N	LA PAZ CORONA ESPECIAL	0	1	2	2.8999999999999999	2.8999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1738	16788	\N	LA PAZ GRAN CORONA	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1739	17965	\N	LA PAZ GRAN PANATELA	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1740	17964	\N	LA PAZ GRAN PANATELA	0	1	2	50	50	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1741	17711	\N	LA PAZ GRAN RESERVA PLATINUM	0	1	2	80	80	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1742	17712	\N	LA PAZ GRAN RESERVA PLATINUM	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1743	719	\N	LA PAZ WILDE 5 CIGARROS	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1744	2012	\N	LA PAZ WILDE CIGARROS 20	0	1	2	10.800000000000001	10.800000000000001	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1745	17607	\N	LA RESERVA DEL PRESIDENTE AÑO 2004 SERIE 1	0	1	2	550	550	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1746	17442	\N	LA RESERVA DEL PRESIDENTE CHURCHILL VIGESIMOS	0	1	2	500	500	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1747	17388	\N	LA RESERVA DEL PRESIDENTE TORPEDO VIGESIMOS	0	1	2	550	550	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1748	17704	\N	LA RESERVA DEL PRESIDENTE VIGESIMOS PERFECTO 6 X 60	0	1	2	550	550	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1749	17389	\N	LA RICA CHURCHILL NATURAL	0	1	2	6.4000000000000004	6.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1750	17390	\N	LA RICA CORONA NATURAL	0	1	2	4.7999999999999998	4.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1751	17391	\N	LA RICA ROBUSTO NATURAL	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1752	17605	\N	LA RICA TUBITOS	0	1	2	16	16	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1753	17606	\N	LA RICA TUBITOS	0	1	2	128	128	\N	0	0	1	\N	0	Confezione da 40 pezzi	2009-07-10	0	0	\N	\N	f
1754	16143	\N	LA TRADICION PERDOMO RESERVE PERDOMO A	0	1	2	14.9	14.9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1755	15763	\N	LA TRADICION PERDOMO RESERVE PERDOMO A	0	1	2	372.5	372.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1756	15756	\N	LA TRADICION PERDOMO RESERVE PERDOMO N. 1	0	1	2	215	215	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1757	16141	\N	LA TRADICION PERDOMO RESERVE PERDOMO N. 1	0	1	2	8.5999999999999996	8.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1758	16139	\N	LA TRADICION PERDOMO RESERVE PERDOMO N. 2	0	1	2	9.1999999999999993	9.1999999999999993	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1759	15755	\N	LA TRADICION PERDOMO RESERVE PERDOMO N. 2	0	1	2	230	230	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1760	16128	\N	LA TRADICION PERDOMO RESERVE PERDOMO N. 3	0	1	2	9.5999999999999996	9.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1761	15745	\N	LA TRADICION PERDOMO RESERVE PERDOMO N. 3	0	1	2	240	240	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1762	16142	\N	LA TRADICION PERDOMO RESERVE PERDOMO X	0	1	2	11.4	11.4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1763	15753	\N	LA TRADICION PERDOMO RESERVE PERDOMO X	0	1	2	285	285	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1764	17559	\N	LECIGAR PREMIUM CIGARS SENIOR	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1765	17558	\N	LECIGAR PREMIUM JUNIOR	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1766	17557	\N	LECIGAR PREMIUM ROBUSTO	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1767	16210	\N	LEON JIMENES BELICOSOS	0	1	2	9.75	9.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1768	15801	\N	LEON JIMENES BELICOSOS	0	1	2	243.75	243.75	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1769	17499	\N	LEON JIMENES CAFFE CORETTO	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1770	15800	\N	LEON JIMENES CHURCHILL DE LUXE	0	1	2	230	230	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1771	16211	\N	LEON JIMENES CHURCHILL DE LUXE	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1772	16502	\N	LEON JIMENES CRISTAL	0	1	2	11.75	11.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1773	16511	\N	LEON JIMENES CRISTAL	0	1	2	117.5	117.5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1774	16767	\N	LEON JIMENES MADURO n. 4	0	1	2	122.5	122.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1775	16768	\N	LEON JIMENES MADURO n. 4	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1776	16770	\N	LEON JIMENES MADURO ROBUSTO	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1777	16769	\N	LEON JIMENES MADURO ROBUSTO	0	1	2	137.5	137.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1778	15809	\N	LEON JIMENES N.4	0	1	2	122.5	122.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1779	16212	\N	LEON JIMENES N.4	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1780	15804	\N	LEON JIMENES PETITES	0	1	2	19.5	19.5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1781	15803	\N	LEON JIMENES ROBUSTO	0	1	2	143.75	143.75	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1782	16213	\N	LEON JIMENES ROBUSTO	0	1	2	5.75	5.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1783	17443	\N	LEON JIMENES VANILLA	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1784	17926	\N	LITALIANO	0	1	2	21.899999999999999	21.899999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1785	635	\N	LONGCHAMP CORONA	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
1786	16551	\N	LOS STATOS DE LUXE DELIRIOS	0	1	2	14.5	14.5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1787	18033	\N	LUIS MARTINEZ SAMPLER	0	1	2	28	28	\N	0	0	1	\N	0	Confezione da 8 pezzi	2009-07-10	0	0	\N	\N	f
1788	17958	\N	LUIS MARTINEZ SILVER SELECTION ASHCROFT CORONA	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1789	17957	\N	LUIS MARTINEZ SILVER SELECTION ASHCROFT CORONA	0	1	2	65	65	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1790	17961	\N	LUIS MARTINEZ SILVER SELECTION CRYSTAL CHURCHILL	0	1	2	92	92	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1791	17962	\N	LUIS MARTINEZ SILVER SELECTION CRYSTAL CHURCHILL	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1792	17960	\N	LUIS MARTINEZ SILVER SELECTION HAMILTON ROBUSTO	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1793	17959	\N	LUIS MARTINEZ SILVER SELECTION HAMILTON ROBUSTO	0	1	2	70	70	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1794	17955	\N	LUIS MARTINEZ SILVER SELECTION TRES PETIT	0	1	2	66	66	\N	0	0	1	\N	0	Confezione da 30 pezzi	2009-07-10	0	0	\N	\N	f
1795	17956	\N	LUIS MARTINEZ SILVER SELECTION TRES PETIT	0	1	2	2.2000000000000002	2.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1796	15193	\N	MACANUDO ASCOTS	0	1	2	19.5	19.5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1797	15198	\N	MACANUDO BARON DE ROTHSCHILD	0	1	2	19.5	19.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1798	15200	\N	MACANUDO BARON DE ROTHSCHILD CAFE	0	1	2	65	65	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1799	16134	\N	MACANUDO BARON DE ROTHSCHILD CAFE	0	1	2	6.5	6.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1800	673	\N	MACANUDO BARON DE ROTHSCHILD CAFE	0	1	2	162.5	162.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1801	15194	\N	MACANUDO CAVIAR CAFE	0	1	2	160	160	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1802	15195	\N	MACANUDO CLAYBOURNE CAFE	0	1	2	120	120	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1803	16133	\N	MACANUDO CLAYBOURNE CAFE	0	1	2	4.7999999999999998	4.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1804	15163	\N	MACANUDO CRYSTAL CAFE	0	1	2	79.200000000000003	79.200000000000003	\N	0	0	1	\N	0	Confezione da 8 pezzi	2009-07-10	0	0	\N	\N	f
1805	16132	\N	MACANUDO CRYSTAL CAFE	0	1	2	9.9000000000000004	9.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1806	16131	\N	MACANUDO DIPLOMAT CAFE	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1807	15608	\N	MACANUDO DIPLOMAT CAFE	0	1	2	200	200	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1808	15196	\N	MACANUDO DUKE OF DEVON	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1809	15197	\N	MACANUDO DUKE OF DEVON CAFE	0	1	2	150	150	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1810	16130	\N	MACANUDO DUKE OF DEVON CAFE	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1811	15203	\N	MACANUDO DUKE OF WINDSOR CAFE	0	1	2	200	200	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1812	16101	\N	MACANUDO DUKE OF WINDSOR CAFE	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1813	17847	\N	MACANUDO GOLD LABEL DUKE OF YORK	0	1	2	10.5	10.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1814	17392	\N	MACANUDO GOLD LABEL SHAKESPEARE	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1815	17596	\N	MACANUDO GOLD LABEL SOMERSET	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1816	17444	\N	MACANUDO GOLD LABEL TUDOR	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1817	15191	\N	MACANUDO H.R.H. PRINCE PHILIP CAFE	0	1	2	85	85	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1818	16145	\N	MACANUDO H.R.H. PRINCE PHILIP CAFE	0	1	2	8.5	8.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1819	16117	\N	MACANUDO HAMPTON COURT CAFE	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1820	428	\N	MACANUDO HAMPTON COURT CAFE	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1821	16090	\N	MACANUDO HYDE PARK CAFE	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1822	15189	\N	MACANUDO HYDE PARK CAFE	0	1	2	180	180	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1823	16089	\N	MACANUDO LORDS CAFE	0	1	2	6.9000000000000004	6.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1824	15609	\N	MACANUDO LORDS CAFE	0	1	2	172.5	172.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1825	16432	\N	MACANUDO MADURO ASCOT	0	1	2	22	22	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1826	16430	\N	MACANUDO MADURO BARON DE ROTHSCHILD	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1827	16433	\N	MACANUDO MADURO DIPLOMAT	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1828	16435	\N	MACANUDO MADURO DUKE OF DEVON	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1829	16427	\N	MACANUDO MADURO H.R.H. PRINCE PHILIP	0	1	2	9.3000000000000007	9.3000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1830	16434	\N	MACANUDO MADURO HYDE PARK	0	1	2	8.1999999999999993	8.1999999999999993	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1831	15607	\N	MACANUDO MAJESTY CAFE	0	1	2	220	220	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1832	16088	\N	MACANUDO MAJESTY CAFE	0	1	2	8.8000000000000007	8.8000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1833	17738	\N	MACANUDO MILLE MIGLIA	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1834	17737	\N	MACANUDO MILLE MIGLIA	0	1	2	500	500	\N	0	0	1	\N	0	Confezione da 100 pezzi	2009-07-10	0	0	\N	\N	f
1835	16863	\N	MACANUDO No. 4 PETIT CORONA CAFE	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1836	15135	\N	MACANUDO PETIT CORONA CAFE	0	1	2	122.5	122.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1837	16087	\N	MACANUDO PETIT CORONA CAFE	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1838	324	\N	MACANUDO PETIT CORONA CAFE	0	1	2	24.5	24.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1839	15201	\N	MACANUDO PORTOFINO	0	1	2	22.5	22.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1840	16086	\N	MACANUDO PORTOFINO CAFE	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1841	15202	\N	MACANUDO PORTOFINO CAFE	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1842	15165	\N	MACANUDO PRINCE OF WALES CAFE	0	1	2	225	225	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1843	16085	\N	MACANUDO PRINCE OF WALES CAFE	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1844	17651	\N	MACANUDO RESERVA ANUAL 2004 DIVINO	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1845	17652	\N	MACANUDO RESERVA ANUAL 2004 ENCANTO	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1846	17653	\N	MACANUDO RESERVA ANUAL 2004 MAXIMO	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1847	17844	\N	MACANUDO RESERVA ANUAL 2005 FORTALEZA	0	1	2	4.7999999999999998	4.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1848	17846	\N	MACANUDO RESERVA ANUAL 2005 GENEROSO	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1849	17845	\N	MACANUDO RESERVA ANUAL 2005 VIGOROSO	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1850	18056	\N	MACANUDO RESERVA ANUAL 2007 BERKELEY	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1851	18057	\N	MACANUDO RESERVA ANUAL 2007 STRATTON	0	1	2	10.5	10.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1852	15605	\N	MACANUDO ROBUST ASCOTS	0	1	2	21	21	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1853	16084	\N	MACANUDO ROBUST BARON DE ROTHSCHILD	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1854	15167	\N	MACANUDO ROBUST BARON DE ROTHSCHILD	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1855	16074	\N	MACANUDO ROBUST DIPLOMAT	0	1	2	8.5	8.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1856	15606	\N	MACANUDO ROBUST DIPLOMAT	0	1	2	212.5	212.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1857	16082	\N	MACANUDO ROBUST DUKE OF DEVON	0	1	2	6.5	6.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1858	15162	\N	MACANUDO ROBUST DUKE OF DEVON	0	1	2	162.5	162.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1859	16091	\N	MACANUDO ROBUST H.R.H. PRINCE PHILIP	0	1	2	8.9000000000000004	8.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1860	15169	\N	MACANUDO ROBUST H.R.H. PRINCE PHILIP	0	1	2	89	89	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1861	15166	\N	MACANUDO ROBUST HAMPTON COURT	0	1	2	187.5	187.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1862	16080	\N	MACANUDO ROBUST HAMPTON COURT	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1863	15168	\N	MACANUDO ROBUST HYDE PARK	0	1	2	192.5	192.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1864	16079	\N	MACANUDO ROBUST HYDE PARK	0	1	2	7.7000000000000002	7.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1865	16078	\N	MACANUDO ROBUST LORDS	0	1	2	7.4000000000000004	7.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1866	15612	\N	MACANUDO ROBUST LORDS	0	1	2	185	185	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1867	16077	\N	MACANUDO ROBUST PETIT CORONA	0	1	2	5.4000000000000004	5.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1868	15164	\N	MACANUDO ROBUST PETIT CORONA	0	1	2	135	135	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1869	17597	\N	MACANUDO SELECCION PARA CONOCEDORES	0	1	2	90	90	\N	0	0	1	\N	0	Confezione da 9 pezzi	2009-07-10	0	0	\N	\N	f
1870	17393	\N	MACANUDO VINTAGE 1997 CRYSTAL NUMBER VIII	0	1	2	18.899999999999999	18.899999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1871	17394	\N	MACANUDO VINTAGE 1997 NUMBER I	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1872	17395	\N	MACANUDO VINTAGE 1997 NUMBER II	0	1	2	80	80	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1873	17396	\N	MACANUDO VINTAGE 1997 NUMBER III	0	1	2	13.9	13.9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1874	17397	\N	MACANUDO VINTAGE 1997 NUMBER V	0	1	2	16.899999999999999	16.899999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1875	16076	\N	MACANUDO VINTAGE CABINET SELECTION 1993 CRYSTAL NUMBER VIII	0	1	2	18.899999999999999	18.899999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1876	15579	\N	MACANUDO VINTAGE CABINET SELECTION 1993 CRYSTAL NUMBER VIII	0	1	2	151.19999999999999	151.19999999999999	\N	0	0	1	\N	0	Confezione da 8 pezzi	2009-07-10	0	0	\N	\N	f
1877	15580	\N	MACANUDO VINTAGE CABINET SELECTION 1993 FIGURADO NUMBER VI	0	1	2	382	382	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1878	16099	\N	MACANUDO VINTAGE CABINET SELECTION 1993 FIGURADO NUMBER VI	0	1	2	19.100000000000001	19.100000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1879	15592	\N	MACANUDO VINTAGE CABINET SELECTION 1993 NUMBER I	0	1	2	350	350	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1880	16081	\N	MACANUDO VINTAGE CABINET SELECTION 1993 NUMBER I	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1881	15587	\N	MACANUDO VINTAGE CABINET SELECTION 1993 NUMBER II	0	1	2	310	310	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1882	16108	\N	MACANUDO VINTAGE CABINET SELECTION 1993 NUMBER II	0	1	2	15.5	15.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1883	15596	\N	MACANUDO VINTAGE CABINET SELECTION 1993 NUMBER III	0	1	2	278	278	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1884	16107	\N	MACANUDO VINTAGE CABINET SELECTION 1993 NUMBER III	0	1	2	13.9	13.9	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1885	16106	\N	MACANUDO VINTAGE CABINET SELECTION 1993 NUMBER V	0	1	2	16.899999999999999	16.899999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1886	15595	\N	MACANUDO VINTAGE CABINET SELECTION 1993 NUMBER V	0	1	2	338	338	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1887	17776	\N	MANFREDI	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1888	17932	\N	MANFREDI	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1889	17927	\N	MASANIELLO	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1890	15222	\N	MICUBANO 450	0	1	2	92.5	92.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1891	16105	\N	MICUBANO 450	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1892	16864	\N	MICUBANO 450 NATURAL	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1893	15223	\N	MICUBANO 542	0	1	2	92.5	92.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1894	16104	\N	MICUBANO 542	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1895	16865	\N	MICUBANO 542 NATURAL	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1896	15224	\N	MICUBANO 644	0	1	2	105	105	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1897	16109	\N	MICUBANO 644	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1898	15225	\N	MICUBANO 650	0	1	2	107.5	107.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1899	16097	\N	MICUBANO 650	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1900	16866	\N	MICUBANO 650 NATURAL	0	1	2	5.0999999999999996	5.0999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1901	16095	\N	MICUBANO 748	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1902	15226	\N	MICUBANO 748	0	1	2	110	110	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1903	15227	\N	MICUBANO 852	0	1	2	130	130	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1904	16093	\N	MICUBANO 852	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1905	16867	\N	MICUBANO 852 NATURAL	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1906	16869	\N	MICUBANO CHICOS	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1907	16871	\N	MICUBANO DEMI-TASSE	0	1	2	21.5	21.5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1908	16870	\N	MICUBANO ENTREACTO	0	1	2	21	21	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1909	16868	\N	MICUBANO JOYITAS	0	1	2	19	19	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1910	16872	\N	MICUBANO PERLA	0	1	2	22	22	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1911	17501	\N	MONTECRISTO "A"	0	1	2	145	145	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1912	17500	\N	MONTECRISTO "A"	0	1	2	29	29	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1913	18109	\N	MONTECRISTO 100° ANIVERSARIO DEL NATALICIO DE COMPAY SEGUNDO 2007	0	1	2	1.7	1.7	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
1914	17795	\N	MONTECRISTO D EDIZIONE LIMITATA	0	1	2	130	130	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1915	17573	\N	MONTECRISTO EDMUNDO	0	1	2	36	36	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1916	17572	\N	MONTECRISTO EDMUNDO	0	1	2	300	300	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1917	18112	\N	MONTECRISTO EDMUNDO TUBOS	0	1	2	12.6	12.6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1918	18019	\N	MONTECRISTO EDMUNDO TUBOS	0	1	2	37.799999999999997	37.799999999999997	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1919	15514	\N	MONTECRISTO ESPECIAL	0	1	2	312.5	312.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1920	15498	\N	MONTECRISTO ESPECIALES N. 2	0	1	2	265	265	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1921	17827	\N	MONTECRISTO N. 1	0	1	2	106	106	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1922	15499	\N	MONTECRISTO N. 1	0	1	2	265	265	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1923	17424	\N	MONTECRISTO N. 2	0	1	2	37.799999999999997	37.799999999999997	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1924	17828	\N	MONTECRISTO N. 2	0	1	2	126	126	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1925	16374	\N	MONTECRISTO N. 2	0	1	2	315	315	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1926	16378	\N	MONTECRISTO N. 3	0	1	2	27.600000000000001	27.600000000000001	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1927	17484	\N	MONTECRISTO N. 3	0	1	2	92	92	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1928	15488	\N	MONTECRISTO N. 4	0	1	2	20.699999999999999	20.699999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1929	316	\N	MONTECRISTO N. 4	0	1	2	34.5	34.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1930	17631	\N	MONTECRISTO N. 4	0	1	2	69	69	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1931	15478	\N	MONTECRISTO N. 5	0	1	2	145	145	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1932	17426	\N	MONTECRISTO N. 5	0	1	2	29	29	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1933	17533	\N	MONTECRISTO N. 5	0	1	2	58	58	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1934	18100	\N	MONTECRISTO NO. 4 RESERVA COSECHA 2002	0	1	2	400	400	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1935	17968	\N	MONTECRISTO PETIT EDMUNDO	0	1	2	212.5	212.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1936	17969	\N	MONTECRISTO PETIT EDMUNDO	0	1	2	85	85	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1937	18118	\N	MONTECRISTO PETIT EDMUNDO TUBOS	0	1	2	28.5	28.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1938	18119	\N	MONTECRISTO PETIT EDMUNDO TUBOS	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1939	17105	\N	MONTECRISTO PETIT TUBOS	0	1	2	8.1999999999999993	8.1999999999999993	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1940	16379	\N	MONTECRISTO PETIT TUBOS	0	1	2	205	205	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1941	17425	\N	MONTECRISTO PETIT TUBOS	0	1	2	41	41	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1942	17911	\N	MONTECRISTO ROBUSTOS EDICION LIMITADA 2006	0	1	2	362.5	362.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1943	18123	\N	MONTECRISTO SUBLIMES EDIZIONE LIMITATA 2008	0	1	2	180	180	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1944	17633	\N	MONTECRISTO TUBOS	0	1	2	34.5	34.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1945	16380	\N	MONTECRISTO TUBOS	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1946	1472	\N	MONTE-SANTO AMADOR GUERRERO	0	1	2	50	50	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1947	1550	\N	MONTE-SANTO AMADOR GUERRERO	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1948	1471	\N	MONTE-SANTO AMADOR GUERRERO	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1949	1473	\N	MONTE-SANTO AMADOR GUERRERO	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1950	1557	\N	MONTE-SANTO CENTENARIO	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1951	1609	\N	MONTE-SANTO CENTENARIO	0	1	2	12.6	12.6	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1952	1466	\N	MONTE-SANTO CENTENARIO	0	1	2	42	42	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1953	1467	\N	MONTE-SANTO CENTENARIO	0	1	2	105	105	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1954	1372	\N	MONTE-SANTO CORONITA	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1955	1373	\N	MONTE-SANTO CORONITA	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1956	1375	\N	MONTE-SANTO CORONITA	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1957	1560	\N	MONTE-SANTO CORONITA	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1958	1374	\N	MONTE-SANTO CORONITA	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1959	1463	\N	MONTE-SANTO DON QUIJOTE	0	1	2	13.5	13.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1960	1464	\N	MONTE-SANTO DON QUIJOTE	0	1	2	45	45	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1961	1465	\N	MONTE-SANTO DON QUIJOTE	0	1	2	112.5	112.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1962	1562	\N	MONTE-SANTO DON QUIJOTE	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1963	1455	\N	MONTE-SANTO EL CACIQUE	0	1	2	55	55	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1964	1456	\N	MONTE-SANTO EL CACIQUE	0	1	2	137.5	137.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1965	1563	\N	MONTE-SANTO EL CACIQUE	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1966	1454	\N	MONTE-SANTO EL CACIQUE	0	1	2	16.5	16.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1967	1566	\N	MONTE-SANTO GAMBOA	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1968	1468	\N	MONTE-SANTO GAMBOA	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1969	1469	\N	MONTE-SANTO GAMBOA	0	1	2	40	40	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1970	1470	\N	MONTE-SANTO GAMBOA	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1971	1448	\N	MONTE-SANTO GRAN ALMIRANTE	0	1	2	36	36	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1972	1449	\N	MONTE-SANTO GRAN ALMIRANTE	0	1	2	120	120	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1973	1450	\N	MONTE-SANTO GRAN ALMIRANTE	0	1	2	300	300	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1974	1567	\N	MONTE-SANTO GRAN ALMIRANTE	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1975	1377	\N	MONTE-SANTO LANCEROS	0	1	2	42	42	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1976	1376	\N	MONTE-SANTO LANCEROS	0	1	2	105	105	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1977	1379	\N	MONTE-SANTO LANCEROS	0	1	2	12.6	12.6	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1978	1378	\N	MONTE-SANTO LANCEROS	0	1	2	21	21	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1979	1569	\N	MONTE-SANTO LANCEROS	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1980	1572	\N	MONTE-SANTO MORGAN	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1981	1417	\N	MONTE-SANTO MORGAN	0	1	2	70	70	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1982	1416	\N	MONTE-SANTO MORGAN	0	1	2	28	28	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1983	1415	\N	MONTE-SANTO MORGAN	0	1	2	8.4000000000000004	8.4000000000000004	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1984	1574	\N	MONTE-SANTO ÓPALO DE FUEGO	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1985	1388	\N	MONTE-SANTO ÓPALO DE FUEGO	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
1986	1389	\N	MONTE-SANTO ÓPALO DE FUEGO	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1987	1390	\N	MONTE-SANTO ÓPALO DE FUEGO	0	1	2	40	40	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
1988	1386	\N	MONTE-SANTO PRECIOSOS	0	1	2	21	21	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1989	1385	\N	MONTE-SANTO PRECIOSOS	0	1	2	42	42	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1990	1384	\N	MONTE-SANTO PRECIOSOS	0	1	2	105	105	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1991	1577	\N	MONTE-SANTO PRECIOSOS	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1992	1387	\N	MONTE-SANTO PRECIOSOS	0	1	2	12.6	12.6	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1993	1579	\N	MONTE-SANTO RODRIGO DE JEREZ	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1994	1431	\N	MONTE-SANTO RODRIGO DE JEREZ	0	1	2	32	32	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
1995	1430	\N	MONTE-SANTO RODRIGO DE JEREZ	0	1	2	9.5999999999999996	9.5999999999999996	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
1996	1432	\N	MONTE-SANTO RODRIGO DE JEREZ	0	1	2	80	80	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1997	1580	\N	MONTE-SANTO SENORITA	0	1	2	1	1	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1998	1367	\N	MONTE-SANTO SENORITA	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
1999	1420	\N	MONTE-SANTO SOLEA	0	1	2	62.5	62.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2000	1419	\N	MONTE-SANTO SOLEA	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2001	1418	\N	MONTE-SANTO SOLEA	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2002	1581	\N	MONTE-SANTO SOLEA	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2003	1583	\N	MONTE-SANTO TORRE	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2004	1460	\N	MONTE-SANTO TORRE	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2005	1461	\N	MONTE-SANTO TORRE	0	1	2	50	50	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2006	1462	\N	MONTE-SANTO TORRE	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2007	2047	\N	NEOS COUNTRY CORONA DUO	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
2008	17925	\N	NERONE	0	1	2	27.600000000000001	27.600000000000001	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2009	17215	\N	NICARAGUA BY DREW ESTATE CHINA 5	0	1	2	6.7999999999999998	6.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2010	17216	\N	NICARAGUA BY DREW ESTATE CLEAN ROBUSTO	0	1	2	7.2999999999999998	7.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2011	17218	\N	NICARAGUA BY DREW ESTATE DIRT	0	1	2	6.2000000000000002	6.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2012	17447	\N	NICARAGUA BY DREW ESTATE EGG	0	1	2	16.100000000000001	16.100000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2013	17448	\N	NICARAGUA BY DREW ESTATE ELIXIR 5-50	0	1	2	9.8000000000000007	9.8000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2014	17217	\N	NICARAGUA BY DREW ESTATE GREEN HERO	0	1	2	8.6999999999999993	8.6999999999999993	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2015	17214	\N	NICARAGUA BY DREW ESTATE JUCY LUCY	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2016	17450	\N	NICARAGUA BY DREW ESTATE MIXED ELEMENTS	0	1	2	7.7999999999999998	7.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2017	17219	\N	NICARAGUA BY DREW ESTATE ROOT	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2018	16632	\N	ONEOFF CAMPANAS	0	1	2	625	625	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2019	16611	\N	ONEOFF CAMPANAS	0	1	2	312.5	312.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2020	16630	\N	ONEOFF CERVANTES	0	1	2	525	525	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2021	16613	\N	ONEOFF CERVANTES	0	1	2	262.5	262.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2022	17423	\N	ONEOFF CERVANTES	0	1	2	10.5	10.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2023	16633	\N	ONEOFF CORONA GORDAS	0	1	2	525	525	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2024	16610	\N	ONEOFF CORONA GORDAS	0	1	2	262.5	262.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2025	16614	\N	ONEOFF CORONAS	0	1	2	237.5	237.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2026	16629	\N	ONEOFF CORONAS	0	1	2	475	475	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2027	16636	\N	ONEOFF JULIETAS	0	1	2	625	625	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2028	16607	\N	ONEOFF JULIETAS	0	1	2	312.5	312.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2029	16627	\N	ONEOFF LAGUITOS N° 1	0	1	2	525	525	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2030	16616	\N	ONEOFF LAGUITOS N° 1	0	1	2	262.5	262.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2031	16617	\N	ONEOFF LAGUITOS N° 2	0	1	2	237.5	237.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2032	16626	\N	ONEOFF LAGUITOS N° 2	0	1	2	475	475	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2033	16624	\N	ONEOFF MAREVAS	0	1	2	425	425	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2034	16619	\N	ONEOFF MAREVAS	0	1	2	212.5	212.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2035	16618	\N	ONEOFF NINFAS	0	1	2	237.5	237.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2036	16625	\N	ONEOFF NINFAS	0	1	2	475	475	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2037	16622	\N	ONEOFF PERFECTOS	0	1	2	725	725	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2038	16621	\N	ONEOFF PERFECTOS	0	1	2	362.5	362.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2039	16628	\N	ONEOFF PERLAS	0	1	2	350	350	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2040	16615	\N	ONEOFF PERLAS	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2041	16634	\N	ONEOFF PIRAMIDES	0	1	2	725	725	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2042	16609	\N	ONEOFF PIRAMIDES	0	1	2	362.5	362.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2043	16635	\N	ONEOFF PROMINENTES	0	1	2	725	725	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2044	16608	\N	ONEOFF PROMINENTES	0	1	2	362.5	362.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2045	16612	\N	ONEOFF ROBUSTOS	0	1	2	262.5	262.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2046	16631	\N	ONEOFF ROBUSTOS	0	1	2	525	525	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2047	16623	\N	ONEOFF SEOANES	0	1	2	400	400	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2048	16620	\N	ONEOFF SEOANES	0	1	2	200	200	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2049	16743	\N	PADRON 2000	0	1	2	8.1999999999999993	8.1999999999999993	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2050	16522	\N	PADRON 2000	0	1	2	205	205	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2051	16518	\N	PADRON 3000	0	1	2	10.199999999999999	10.199999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2052	16521	\N	PADRON 3000	0	1	2	255	255	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2053	16526	\N	PADRON CHICOS	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2054	16524	\N	PADRON CHICOS	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2055	16541	\N	PADRON CHURCHILL	0	1	2	10.5	10.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2056	16516	\N	PADRON CHURCHILL	0	1	2	262.5	262.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2057	17398	\N	PADRON DELICIAS MADURO	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2058	17399	\N	PADRON DELICIAS NATURAL	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2059	16539	\N	PADRON DIPLOMATICO	0	1	2	575	575	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2060	16545	\N	PADRON DIPLOMATICO	0	1	2	23	23	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2061	16544	\N	PADRON EXCLUSIVO	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2062	16520	\N	PADRON EXCLUSIVO	0	1	2	500	500	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2063	16517	\N	PADRON EXECUTIVE	0	1	2	375	375	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2064	16542	\N	PADRON EXECUTIVE	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2065	16528	\N	PADRON LONDRES	0	1	2	5.7000000000000002	5.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2066	16523	\N	PADRON LONDRES	0	1	2	142.5	142.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2067	16543	\N	PADRON PRINCIPE	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2068	16519	\N	PADRON PRINCIPE	0	1	2	375	375	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2069	16546	\N	PADRON TORPEDO	0	1	2	31.5	31.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2070	16547	\N	PADRON TORPEDO	0	1	2	630	630	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2071	1934	\N	PARODI AMMEZZATI	0	1	2	3.2999999999999998	3.2999999999999998	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2072	2101	\N	PARODI CHEROOT	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2073	17281	\N	PARTAGAS 8 - 9 - 8 CABINET SELECTION	0	1	2	237.5	237.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2074	17485	\N	PARTAGAS 8-9-8	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2075	15479	\N	PARTAGAS 8-9-8	0	1	2	312.5	312.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2076	20	\N	PARTAGAS ARISTOCRATS	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2077	17534	\N	PARTAGAS ARISTOCRATS	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2078	17100	\N	PARTAGAS ARISTOCRATS	0	1	2	40	40	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2079	15833	\N	PARTAGAS CHURCHILLS DE LUXE	0	1	2	312.5	312.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2080	17713	\N	PARTAGAS CORONAS JUNIOR TUBOS	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2081	15501	\N	PARTAGAS CORONAS SENIOR	0	1	2	122.5	122.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2082	16372	\N	PARTAGAS CORONAS SENIOR	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2083	18028	\N	PARTAGAS CULEBRAS	0	1	2	54	54	\N	0	0	1	\N	0	Confezione da 9 pezzi	2009-07-10	0	0	\N	\N	f
2084	NEW	\N	PARTAGAS HABANEROS	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2085	18158	\N	PARTAGAS LUSITANIAS	0	1	2	155	155	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2086	15503	\N	PARTAGAS LUSITANIAS	0	1	2	387.5	387.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2087	17853	\N	PARTAGAS MILLE FLEURS	0	1	2	42	42	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2088	17714	\N	PARTAGAS PARTAGAS DE LUXE TUBOS	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2089	16553	\N	PARTAGAS PETIT CORONAS ESPECIALES	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2090	16800	\N	PARTAGAS PRINCESS	0	1	2	80	80	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2091	18103	\N	PARTAGAS REPLICA ANTIGUA	0	1	2	2.0499999999999998	2.0499999999999998	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2092	NEW	\N	PARTAGAS SALOMONES	0	1	2	150	150	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2093	15502	\N	PARTAGAS SERIE D N. 4	0	1	2	250	250	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2094	17634	\N	PARTAGAS SERIE D N. 4	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2095	18159	\N	PARTAGAS SERIE D N. 4	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2096	NEW	\N	PARTAGAS SERIE D N. 4 TUBOS	0	1	2	10.4	10.4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2097	18176	\N	PARTAGAS SERIE D N. 4 TUBOS	0	1	2	10.6	10.6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2098	17912	\N	PARTAGAS SERIE D N.3 EDICION LIMITADA 2006	0	1	2	337.5	337.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2099	18121	\N	PARTAGAS SERIE D NO. 5 EDIZIONE LIMITATA 2008	0	1	2	250	250	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2100	17592	\N	PARTAGAS SERIE D NO1	0	1	2	387.5	387.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2101	17282	\N	PARTAGAS SÉRIE DU CONNAISSEUR NO1	0	1	2	275	275	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2102	17283	\N	PARTAGAS SÉRIE DU CONNAISSEUR NO2	0	1	2	212.5	212.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2103	17284	\N	PARTAGAS SÉRIE DU CONNAISSEUR NO3	0	1	2	187.5	187.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2104	17724	\N	PARTAGAS SERIE P NO 2	0	1	2	120	120	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2105	17717	\N	PARTAGAS SERIE P NO 2	0	1	2	300	300	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2106	18115	\N	PARTAGAS SERIE P NO. 2 TUBOS	0	1	2	12.6	12.6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2107	18114	\N	PARTAGAS SERIE P NO. 2 TUBOS	0	1	2	37.799999999999997	37.799999999999997	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2108	15507	\N	PARTAGAS SHORTS	0	1	2	295	295	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2109	NEW	\N	PARTAGAS SUPER PARTAGAS	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2110	403	\N	PEDRONI ANISETTE	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2111	1532	\N	PEDRONI ANISETTE LUNGO	0	1	2	6.9000000000000004	6.9000000000000004	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2112	512	\N	PEDRONI ANISETTE SINGOLO	0	1	2	1	1	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2113	633	\N	PEDRONI BIONDO	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2114	734	\N	PEDRONI BIONDO	0	1	2	0.69999999999999996	0.69999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2115	45	\N	PEDRONI CLASSICO	0	1	2	3.2999999999999998	3.2999999999999998	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2116	503	\N	PEDRONI CLASSICO	0	1	2	0.66000000000000003	0.66000000000000003	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2117	44	\N	PEDRONI CLASSICO LUNGO	0	1	2	5.25	5.25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2118	16098	\N	PERDOMO 2 DESCARTES	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2119	16100	\N	PERDOMO 2 EXPONENTE	0	1	2	9.9000000000000004	9.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2120	15445	\N	PERFECTO GARCIA 1905	0	1	2	115	115	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2121	16083	\N	PERFECTO GARCIA 1905	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2122	16140	\N	PERFECTO GARCIA BELICOSO	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2123	15439	\N	PERFECTO GARCIA BELICOSO	0	1	2	115	115	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2124	16019	\N	PERFECTO GARCIA CHURCHILL	0	1	2	4.0999999999999996	4.0999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2125	15440	\N	PERFECTO GARCIA CHURCHILL	0	1	2	102.5	102.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2126	15441	\N	PERFECTO GARCIA ENSIGNS	0	1	2	92.5	92.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2127	16020	\N	PERFECTO GARCIA ENSIGNS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2128	16023	\N	PERFECTO GARCIA MAGNUM	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2129	15428	\N	PERFECTO GARCIA MAGNUM	0	1	2	97.5	97.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2130	16027	\N	PERFECTO GARCIA MAYFAIRS	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2131	15442	\N	PERFECTO GARCIA MAYFAIRS	0	1	2	90	90	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2132	16028	\N	PERFECTO GARCIA WALDORFS	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2133	15443	\N	PERFECTO GARCIA WALDORFS	0	1	2	87.5	87.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2134	16029	\N	PETERSON CHURCHILL	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2135	16065	\N	PETERSON CHURCHILL TUBED	0	1	2	8.5999999999999996	8.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2136	16051	\N	PETERSON CORONA	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2137	15110	\N	PETERSON CORONAS	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2138	16049	\N	PETERSON MADURO-CHURCHILL	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2139	16042	\N	PETERSON MADURO-CORONA	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2140	15115	\N	PETERSON ROBUSTO	0	1	2	29	29	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2141	16034	\N	PETERSON ROBUSTO	0	1	2	5.7999999999999998	5.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2142	16071	\N	PETERSON TORO	0	1	2	6.7999999999999998	6.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2143	16062	\N	PETERSON TORO TUBED	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2144	17180	\N	PETRUS ANTONIUS	0	1	2	192.5	192.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2145	17181	\N	PETRUS ANTONIUS	0	1	2	7.7000000000000002	7.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2146	17182	\N	PETRUS CHURCHILL	0	1	2	23.699999999999999	23.699999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2147	17183	\N	PETRUS CHURCHILL	0	1	2	7.9000000000000004	7.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2148	17166	\N	PETRUS ETIQUETTE ROUGE BELICOSO	0	1	2	144	144	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2149	17167	\N	PETRUS ETIQUETTE ROUGE BELICOSO	0	1	2	28.800000000000001	28.800000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2150	17168	\N	PETRUS ETIQUETTE ROUGE BELICOSO	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2151	17164	\N	PETRUS ETIQUETTE ROUGE CHURCHILL	0	1	2	28.800000000000001	28.800000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2152	17165	\N	PETRUS ETIQUETTE ROUGE CHURCHILL	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2153	17163	\N	PETRUS ETIQUETTE ROUGE CHURCHILL	0	1	2	144	144	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2154	17169	\N	PETRUS ETIQUETTE ROUGE CORONA	0	1	2	128	128	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2155	17170	\N	PETRUS ETIQUETTE ROUGE CORONA	0	1	2	25.600000000000001	25.600000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2156	17171	\N	PETRUS ETIQUETTE ROUGE CORONA	0	1	2	6.4000000000000004	6.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2157	17503	\N	PETRUS ETIQUETTE ROUGE ROBUSTO	0	1	2	27.600000000000001	27.600000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2158	17502	\N	PETRUS ETIQUETTE ROUGE ROBUSTO	0	1	2	138	138	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2159	17504	\N	PETRUS ETIQUETTE ROUGE ROBUSTO	0	1	2	6.9000000000000004	6.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2160	17175	\N	PETRUS ETIQUETTE ROUGE ROYAL MADURO BELICOSO	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2161	17174	\N	PETRUS ETIQUETTE ROUGE ROYAL MADURO BELICOSO	0	1	2	144	144	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2162	17173	\N	PETRUS ETIQUETTE ROUGE ROYAL MADURO CHURCHILL	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2163	17172	\N	PETRUS ETIQUETTE ROUGE ROYAL MADURO CHURCHILL	0	1	2	144	144	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2164	17177	\N	PETRUS ETIQUETTE ROUGE ROYAL MADURO ROBUSTO	0	1	2	6.9000000000000004	6.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2165	17176	\N	PETRUS ETIQUETTE ROUGE ROYAL MADURO ROBUSTO	0	1	2	138	138	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2166	17185	\N	PETRUS FORTUS AÑEJO 1	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2167	17184	\N	PETRUS FORTUS AÑEJO 1	0	1	2	200	200	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2168	17505	\N	PETRUS FORTUS ANEJO 3	0	1	2	200	200	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2169	17506	\N	PETRUS FORTUS ANEJO 3	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2170	17178	\N	PETRUS SPECIAL SELECTION PALMA FINA	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2171	17179	\N	PETRUS SPECIAL SELECTION PALMA FINA	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2172	16835	\N	POR LARRAÑAGA MONTE-CARLO	0	1	2	92.5	92.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2173	17875	\N	POR LARRANAGA PETIT CORONAS	0	1	2	270	270	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2174	15594	\N	PRIVATE STOCK MEDIUM FILLER CIGAR ASSORTMENT	0	1	2	17	17	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2175	15582	\N	PRIVATE STOCK MEDIUM FILLER CORONA	0	1	2	62	62	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2176	15931	\N	PRIVATE STOCK MEDIUM FILLER CORONA	0	1	2	3.1000000000000001	3.1000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2177	15557	\N	PRIVATE STOCK MEDIUM FILLER CORONA	0	1	2	12.4	12.4	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2178	15945	\N	PRIVATE STOCK MEDIUM FILLER LONSDALE	0	1	2	3.3999999999999999	3.3999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2179	15583	\N	PRIVATE STOCK MEDIUM FILLER LONSDALE	0	1	2	68	68	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2180	15556	\N	PRIVATE STOCK MEDIUM FILLER LONSDALE	0	1	2	13.6	13.6	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2181	15585	\N	PRIVATE STOCK MEDIUM FILLER PANETELA	0	1	2	62	62	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2182	15555	\N	PRIVATE STOCK MEDIUM FILLER PANETELA	0	1	2	12.4	12.4	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2183	15951	\N	PRIVATE STOCK MEDIUM FILLER PANETELA	0	1	2	3.1000000000000001	3.1000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2184	15576	\N	PRIVATE STOCK MEDIUM FILLER ROBUSTO	0	1	2	68	68	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2185	15455	\N	PRIVATE STOCK MEDIUM FILLER ROBUSTO	0	1	2	13.6	13.6	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2186	15950	\N	PRIVATE STOCK MEDIUM FILLER ROBUSTO	0	1	2	3.3999999999999999	3.3999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2187	15586	\N	PRIVATE STOCK MEDIUM FILLER TORO	0	1	2	74	74	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2188	15949	\N	PRIVATE STOCK MEDIUM FILLER TORO	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2189	15453	\N	PRIVATE STOCK MEDIUM FILLER TORO	0	1	2	14.800000000000001	14.800000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2190	17133	\N	PRIVATE STOCK MEDIUM FILLER TUBOS N.1	0	1	2	13.199999999999999	13.199999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2191	17134	\N	PRIVATE STOCK MEDIUM FILLER TUBOS N.1	0	1	2	88	88	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2192	17132	\N	PRIVATE STOCK MEDIUM FILLER TUBOS N.1	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2193	16515	\N	PRIVATE STOCK MEDIUM FILLER TUBOS N.2	0	1	2	11.699999999999999	11.699999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2194	16514	\N	PRIVATE STOCK MEDIUM FILLER TUBOS N.2	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2195	17551	\N	PRIVATE STOCK MEDIUM FILLER TUBOS N.3	0	1	2	50	50	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2196	17552	\N	PRIVATE STOCK MEDIUM FILLER TUBOS N.3	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2197	17553	\N	PRIVATE STOCK MEDIUM FILLER TUBOS N.3	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2198	15566	\N	PRIVATE STOCK n. 1	0	1	2	135	135	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2199	15943	\N	PRIVATE STOCK n. 1	0	1	2	5.4000000000000004	5.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2200	15549	\N	PRIVATE STOCK n. 1	0	1	2	27	27	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2201	15947	\N	PRIVATE STOCK n. 10	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2202	15599	\N	PRIVATE STOCK n. 10	0	1	2	16	16	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2203	15543	\N	PRIVATE STOCK n. 10	0	1	2	80	80	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2204	15456	\N	PRIVATE STOCK n. 11	0	1	2	16	16	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2205	15552	\N	PRIVATE STOCK n. 11	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2206	15946	\N	PRIVATE STOCK n. 11	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2207	15936	\N	PRIVATE STOCK n. 12	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2208	15553	\N	PRIVATE STOCK n. 12	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2209	15600	\N	PRIVATE STOCK n. 12	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2210	15937	\N	PRIVATE STOCK n. 14	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2211	15454	\N	PRIVATE STOCK n. 14	0	1	2	20.800000000000001	20.800000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2212	15554	\N	PRIVATE STOCK n. 14	0	1	2	130	130	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2213	15584	\N	PRIVATE STOCK n. 2	0	1	2	112.5	112.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2214	15577	\N	PRIVATE STOCK n. 2	0	1	2	22.5	22.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2215	15948	\N	PRIVATE STOCK n. 2	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2216	15545	\N	PRIVATE STOCK n. 3	0	1	2	95	95	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2217	15589	\N	PRIVATE STOCK n. 3	0	1	2	19	19	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2218	15973	\N	PRIVATE STOCK n. 3	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2219	15590	\N	PRIVATE STOCK n. 4	0	1	2	19	19	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2220	15574	\N	PRIVATE STOCK n. 4	0	1	2	95	95	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2221	15952	\N	PRIVATE STOCK n. 4	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2222	15546	\N	PRIVATE STOCK n. 5	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2223	15942	\N	PRIVATE STOCK n. 5	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2224	15591	\N	PRIVATE STOCK n. 5	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2225	15547	\N	PRIVATE STOCK n. 6	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2226	15593	\N	PRIVATE STOCK n. 6	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2227	15941	\N	PRIVATE STOCK n. 6	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2228	15940	\N	PRIVATE STOCK n. 7	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2229	15548	\N	PRIVATE STOCK n. 7	0	1	2	87.5	87.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2230	15588	\N	PRIVATE STOCK n. 7	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2231	15597	\N	PRIVATE STOCK n. 8	0	1	2	16	16	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2232	15558	\N	PRIVATE STOCK n. 8	0	1	2	80	80	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2233	15939	\N	PRIVATE STOCK n. 8	0	1	2	3.2000000000000002	3.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2234	15938	\N	PRIVATE STOCK n. 9	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2235	15598	\N	PRIVATE STOCK n. 9	0	1	2	13.5	13.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2236	15550	\N	PRIVATE STOCK n. 9	0	1	2	67.5	67.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2237	17301	\N	PRIVATE STOCK N.5 TUBOS	0	1	2	90	90	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2238	17300	\N	PRIVATE STOCK N.5 TUBOS	0	1	2	45	45	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2239	17299	\N	PRIVATE STOCK N.5 TUBOS	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2240	17298	\N	PRIVATE STOCK N.5 TUBOS	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2241	17131	\N	PRIVATE STOCK N.7 TUBOS	0	1	2	80	80	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2242	17130	\N	PRIVATE STOCK N.7 TUBOS	0	1	2	16	16	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2243	17129	\N	PRIVATE STOCK N.7 TUBOS	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2244	16828	\N	PUNCH CHURCHILL	0	1	2	13.4	13.4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2245	NEW	\N	PUNCH CORONAS	0	1	2	182.5	182.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2246	NEW	\N	PUNCH CORONATIONS TUBOS	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2247	17402	\N	PUNCH DOUBLE CORONAS	0	1	2	825	825	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2248	NEW	\N	PUNCH MARGARITAS	0	1	2	105	105	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2249	NEW	\N	PUNCH PETIT CORONAS	0	1	2	142.5	142.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2250	16937	\N	PUNCH PETIT CORONATIONS	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2251	15480	\N	PUNCH PETIT CORONATIONS	0	1	2	110	110	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2252	17647	\N	PUNCH PUNCH PUNCH	0	1	2	465	465	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2253	15481	\N	PUNCH PUNCH PUNCH	0	1	2	232.5	232.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2254	18177	\N	PUNCH PUNCH PUNCH TUBOS	0	1	2	10.5	10.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2255	NEW	\N	PUNCH ROYAL CORONATIONS TUBOS	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2256	15490	\N	PUNCH ROYAL SELECTION n. 11	0	1	2	240	240	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2257	16826	\N	PUNCH ROYAL SELECTION No. 12	0	1	2	162.5	162.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2258	18075	\N	PUNCH SUPER SELECTION N.1	0	1	2	405	405	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2259	17797	\N	PUNCH SUPERFINOS	0	1	2	400	400	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2260	NEW	\N	QUAY DORSAY CORONAS CLARO	0	1	2	162.5	162.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2261	18084	\N	QUAY DORSAY IMPERIALES	0	1	2	285	285	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2262	NEW	\N	QUAY DORSAY PANETELAS	0	1	2	180	180	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2263	15473	\N	QUINTERO BREVAS	0	1	2	65	65	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2264	16373	\N	QUINTERO NACIONALES	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2265	17615	\N	QUORUM CHURCHILL	0	1	2	3.1000000000000001	3.1000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2266	17617	\N	QUORUM CORONA	0	1	2	2.2000000000000002	2.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2267	17618	\N	QUORUM ROBUSTO	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2268	17616	\N	QUORUM TORO	0	1	2	2.8500000000000001	2.8500000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2269	18111	\N	QUORUM TORPEDO	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2270	16847	\N	RAFAEL GONZALES PETIT CORONAS	0	1	2	142.5	142.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2271	NEW	\N	RAFAEL GONZALEZ CORONAS EXTRA	0	1	2	190	190	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2272	17879	\N	RAFAEL GONZALEZ PANETELAS EXTRA	0	1	2	57.5	57.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2273	17928	\N	RAFFAELLO	0	1	2	70	70	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2274	15506	\N	RAMON ALLONES ALLONES SPECIALLY SELECTED	0	1	2	225	225	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2275	17654	\N	RAMON ALLONES GIGANTES	0	1	2	350	350	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2276	15495	\N	RAMON ALLONES SMALL CLUB CORONAS	0	1	2	142.5	142.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2277	16877	\N	REMEDIOS 92 CLEMENCEAU NATURAL	0	1	2	6.25	6.25	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2278	16875	\N	REMEDIOS 92 CORONA GORDA NATURAL	0	1	2	5.75	5.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2279	16874	\N	REMEDIOS 92 CORONA NATURAL	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2280	16876	\N	REMEDIOS 92 DON VICTOR NATURAL	0	1	2	5.9500000000000002	5.9500000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2281	16873	\N	REMEDIOS 92 ROBUSTO NATURAL	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2282	15133	\N	ROBT. BURNS BLACK WATCH	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2283	16043	\N	ROBT. BURNS BLACK WATCH	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2284	16803	\N	ROMEO Y JULIETA BELICOSOS	0	1	2	275	275	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2285	NEW	\N	ROMEO Y JULIETA BELVEDERES	0	1	2	72.5	72.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2286	16806	\N	ROMEO Y JULIETA CAZADORES	0	1	2	200	200	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2287	NEW	\N	ROMEO Y JULIETA CEDROS DE LUXE N. 1	0	1	2	225	225	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2288	18066	\N	ROMEO Y JULIETA CEDROS DE LUXE N. 2	0	1	2	200	200	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2289	15493	\N	ROMEO Y JULIETA CEDROS DE LUXE N. 3	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2290	16588	\N	ROMEO Y JULIETA CHURCHILLS	0	1	2	17	17	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2291	16589	\N	ROMEO Y JULIETA CHURCHILLS.	0	1	2	51	51	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2292	NEW	\N	ROMEO Y JULIETA CORONITAS EN CEDRO	0	1	2	85	85	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2293	18029	\N	ROMEO Y JULIETA ESCUDOS 2007	0	1	2	300	300	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2294	16366	\N	ROMEO Y JULIETA EXHIBICION N. 3	0	1	2	237.5	237.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2295	16815	\N	ROMEO Y JULIETA EXHIBICION No. 4	0	1	2	450	450	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2296	17591	\N	ROMEO Y JULIETA LOS TRES ROMEO	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2297	NEW	\N	ROMEO Y JULIETA MILLE FLEURS	0	1	2	38	38	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2298	17430	\N	ROMEO Y JULIETA PETIT CORONAS	0	1	2	32	32	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2299	16807	\N	ROMEO Y JULIETA PETIT CORONAS	0	1	2	160	160	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2300	16808	\N	ROMEO Y JULIETA PETIT JULIETA	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2301	17638	\N	ROMEO Y JULIETA PETIT JULIETA	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2302	17798	\N	ROMEO Y JULIETA PETIT PIRAMIDES	0	1	2	300	300	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2303	18069	\N	ROMEO Y JULIETA PETIT PRINCESS	0	1	2	130	130	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2304	16809	\N	ROMEO Y JULIETA REGALIAS DE LONDRES	0	1	2	95	95	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2305	17106	\N	ROMEO Y JULIETA ROMEO N. 2	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2306	15491	\N	ROMEO Y JULIETA ROMEO N. 2	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2307	17636	\N	ROMEO Y JULIETA ROMEO N. 2	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2308	15492	\N	ROMEO Y JULIETA ROMEO N. 2 TUBOS	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2309	16811	\N	ROMEO Y JULIETA ROMEO No. 1	0	1	2	5.5999999999999996	5.5999999999999996	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2310	16810	\N	ROMEO Y JULIETA ROMEO No. 1	0	1	2	140	140	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2311	17635	\N	ROMEO Y JULIETA ROMEO No. 1	0	1	2	16.800000000000001	16.800000000000001	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2312	16813	\N	ROMEO Y JULIETA ROMEO No. 3	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2313	16812	\N	ROMEO Y JULIETA ROMEO No. 3	0	1	2	112.5	112.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2314	17637	\N	ROMEO Y JULIETA ROMEO No. 3	0	1	2	13.5	13.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2315	17880	\N	ROMEO Y JULIETA SHORT CHURCHILLS	0	1	2	245	245	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2316	17906	\N	ROMEO Y JULIETA SHORT CHURCHILLS	0	1	2	98	98	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2317	17907	\N	ROMEO Y JULIETA SHORT CHURCHILLS TUBOS	0	1	2	31.800000000000001	31.800000000000001	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2318	17881	\N	ROMEO Y JULIETA SHORT CHURCHILLS TUBOS	0	1	2	10.6	10.6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2319	16814	\N	ROMEO Y JULIETA SPORTS LARGO	0	1	2	80	80	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2320	399	\N	RUBIROSA CORONA	0	1	2	25.800000000000001	25.800000000000001	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2321	457	\N	RUBIROSA CORONA	0	1	2	129	129	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2322	438	\N	RUBIROSA CORONA	0	1	2	51.600000000000001	51.600000000000001	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2323	805	\N	RUBIROSA CORONA	0	1	2	15.48	15.48	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2324	179	\N	RUBIROSA TORPEDO	0	1	2	72.5	72.5	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2325	164	\N	RUBIROSA TORPEDO	0	1	2	36.25	36.25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2326	800	\N	RUBIROSA TORPEDO	0	1	2	181.25	181.25	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2327	131	\N	RUBIROSA TORPEDO	0	1	2	21.75	21.75	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2328	NEW	\N	SAINT LUIS REY CHURCHILLS	0	1	2	550	550	\N	0	0	1	\N	0	Confezione da 50 pezzi	2009-07-10	0	0	\N	\N	f
2329	NEW	\N	SAINT LUIS REY CORONAS	0	1	2	162.5	162.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2330	17453	\N	SAINT LUIS REY PETIT CORONAS	0	1	2	28	28	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2331	NEW	\N	SAINT LUIS REY REGIOS	0	1	2	177.5	177.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2332	16849	\N	SAINT LUIS REY SERIE A	0	1	2	217.5	217.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2333	15572	\N	SAN CRISTOBAL DE LA HABANA EL MORRO	0	1	2	347.5	347.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2334	15568	\N	SAN CRISTOBAL DE LA HABANA EL PRINCIPE	0	1	2	147.5	147.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2335	15573	\N	SAN CRISTOBAL DE LA HABANA LA FUERZA	0	1	2	275	275	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2336	15551	\N	SAN CRISTOBAL DE LA HABANA LA PUNTA	0	1	2	275	275	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2337	17909	\N	SAN CRISTOBAL DE LA HABANA MERCADERES	0	1	2	332.5	332.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2338	17910	\N	SAN CRISTOBAL DE LA HABANA MURALLA	0	1	2	425	425	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2339	17908	\N	SAN CRISTOBAL DE LA HABANA OFICIOS	0	1	2	220	220	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2340	16841	\N	SANCHO PANZA BELICOSOS	0	1	2	262.5	262.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2341	16842	\N	SANCHO PANZA MOLINOS	0	1	2	225	225	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2342	16843	\N	SANCHO PANZA NON-PLUS	0	1	2	147.5	147.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2343	17404	\N	SANCHO PANZA SANCHOS	0	1	2	203	203	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2344	17655	\N	SANCHO PANZA SANCHOS ESTUCHE	0	1	2	105	105	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2345	16504	\N	SANTA CLARA 1830 BELICOSO MADURO	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2346	16481	\N	SANTA CLARA 1830 BELICOSO NATURAL	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2347	16494	\N	SANTA CLARA 1830 BOLERO	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2348	16485	\N	SANTA CLARA 1830 MAGNUM	0	1	2	17.100000000000001	17.100000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2349	16477	\N	SANTA CLARA 1830 N.1 MADURO	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2350	16475	\N	SANTA CLARA 1830 N.1 NATURAL	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2351	16491	\N	SANTA CLARA 1830 N.4 MADURO	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2352	16486	\N	SANTA CLARA 1830 N.4 NATURAL	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2353	16488	\N	SANTA CLARA 1830 N.6 MADURO	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2354	16484	\N	SANTA CLARA 1830 N.6 NATURAL	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2355	16495	\N	SANTA CLARA 1830 N.9 NATURAL	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2356	16658	\N	SANTA CLARA 1830 QVINO	0	1	2	16	16	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2357	16497	\N	SANTA CLARA 1830 ROBUSTO MADURO	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2358	16496	\N	SANTA CLARA 1830 ROBUSTO NATURAL	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2359	17240	\N	SANTA CLARA 1830 SPECIAL EDITION CORONA MADURO	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2360	17237	\N	SANTA CLARA 1830 SPECIAL EDITION CORONA NATURAL	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2361	17238	\N	SANTA CLARA 1830 SPECIAL EDITION N0.4 MADURO	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2362	17235	\N	SANTA CLARA 1830 SPECIAL EDITION N0.4 NATURAL	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2363	17239	\N	SANTA CLARA 1830 SPECIAL EDITION ROBUSTO MADURO	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2364	17236	\N	SANTA CLARA 1830 SPECIAL EDITION ROBUSTO NATURAL	0	1	2	5.5	5.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2365	16286	\N	SELLO DE ORO	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2366	193	\N	SELLO DE ORO	0	1	2	50	50	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2367	830	\N	SENESI	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2368	NEW	\N	SOL DE ORO ROBUSTO	0	1	2	91.75	91.75	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2369	16069	\N	SOSA CIGARS BREVAS	0	1	2	6.2000000000000002	6.2000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2370	16059	\N	SOSA CIGARS CHURCHILLS	0	1	2	8.3000000000000007	8.3000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2371	16055	\N	SOSA CIGARS GOVERNOR	0	1	2	7.7999999999999998	7.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2372	16011	\N	SOSA CIGARS LONSDALES	0	1	2	7.2999999999999998	7.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2373	16013	\N	SOSA CIGARS MAGNUM	0	1	2	9.3000000000000007	9.3000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2374	16007	\N	SOSA CIGARS PIRAMIDES n. 2	0	1	2	11.6	11.6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2375	16022	\N	SOSA CIGARS SANTA FE	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2376	16046	\N	SOSA CIGARS WAVELLS	0	1	2	7.2999999999999998	7.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2377	16647	\N	TE AMO ANIVERSARIO CHURCHILL	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2378	16643	\N	TE AMO ANIVERSARIO N. 2	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2379	16644	\N	TE AMO ANIVERSARIO N. 4	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2380	16645	\N	TE AMO ANIVERSARIO N. 7	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2381	16649	\N	TE AMO ANIVERSARIO PIRAMIDE	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2382	16648	\N	TE AMO ANIVERSARIO ROBUSTO	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2383	16646	\N	TE AMO ANIVERSARIO TORO	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2384	16639	\N	TE AMO MEDITATION	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2385	17246	\N	TE AMO MINIFIGURADO	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2386	17247	\N	TE AMO MINITORBUSTO	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2387	16638	\N	TE AMO N.7	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2388	15987	\N	THE GRIFFIN"s 100	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2389	15087	\N	THE GRIFFIN"s 100	0	1	2	35	35	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2390	15088	\N	THE GRIFFIN"s 100	0	1	2	175	175	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2391	15086	\N	THE GRIFFIN"s 200	0	1	2	195	195	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2392	15103	\N	THE GRIFFIN"s 200	0	1	2	39	39	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2393	15988	\N	THE GRIFFIN"s 200	0	1	2	7.7999999999999998	7.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2394	15989	\N	THE GRIFFIN"s 300	0	1	2	7.4000000000000004	7.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2395	15078	\N	THE GRIFFIN"s 300	0	1	2	185	185	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2396	15077	\N	THE GRIFFIN"s 300	0	1	2	37	37	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2397	15984	\N	THE GRIFFIN"S 300 TUBOS	0	1	2	7.9000000000000004	7.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2398	15403	\N	THE GRIFFIN"S 300 TUBOS	0	1	2	31.600000000000001	31.600000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2399	15400	\N	THE GRIFFIN"S 300 TUBOS	0	1	2	158	158	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2400	15095	\N	THE GRIFFIN"s 400	0	1	2	170	170	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2401	15099	\N	THE GRIFFIN"s 400	0	1	2	34	34	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2402	15991	\N	THE GRIFFIN"s 400	0	1	2	6.7999999999999998	6.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2403	15089	\N	THE GRIFFIN"s 500	0	1	2	31.5	31.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2404	15092	\N	THE GRIFFIN"s 500	0	1	2	157.5	157.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2405	15993	\N	THE GRIFFIN"s 500	0	1	2	6.2999999999999998	6.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2406	16413	\N	THE GRIFFIN"S No.500 MADURO	0	1	2	157.5	157.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2407	16410	\N	THE GRIFFIN"S No.500 MADURO	0	1	2	6.2999999999999998	6.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2408	16414	\N	THE GRIFFIN"S No.500 MADURO	0	1	2	31.5	31.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2409	15983	\N	THE GRIFFIN"S PIRAMIDES	0	1	2	7.7999999999999998	7.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2410	15835	\N	THE GRIFFIN"S PIRAMIDES	0	1	2	31.199999999999999	31.199999999999999	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2411	15834	\N	THE GRIFFIN"S PIRAMIDES	0	1	2	195	195	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2412	16405	\N	THE GRIFFIN"S PIRAMIDES MADURO	0	1	2	7.7999999999999998	7.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2413	16401	\N	THE GRIFFIN"S PIRAMIDES MADURO	0	1	2	31.199999999999999	31.199999999999999	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2414	16407	\N	THE GRIFFIN"S PIRAMIDES MADURO	0	1	2	195	195	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2415	15090	\N	THE GRIFFIN"s PRESTIGE	0	1	2	262.5	262.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2416	15981	\N	THE GRIFFIN"s PRESTIGE	0	1	2	10.5	10.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2417	15091	\N	THE GRIFFIN"s PRESTIGE	0	1	2	42	42	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2418	15975	\N	THE GRIFFIN"s PRIVILEGE	0	1	2	5.2999999999999998	5.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2419	15094	\N	THE GRIFFIN"s PRIVILEGE	0	1	2	132.5	132.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2420	15097	\N	THE GRIFFIN"s PRIVILEGE	0	1	2	26.5	26.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2421	15076	\N	THE GRIFFIN"s ROBUSTO	0	1	2	185	185	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2422	15104	\N	THE GRIFFIN"s ROBUSTO	0	1	2	29.600000000000001	29.600000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2423	15944	\N	THE GRIFFIN"s ROBUSTO	0	1	2	7.4000000000000004	7.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2424	16412	\N	THE GRIFFIN"S ROBUSTO MADURO	0	1	2	7.4000000000000004	7.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2425	16411	\N	THE GRIFFIN"S ROBUSTO MADURO	0	1	2	185	185	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2426	16388	\N	THE GRIFFIN"S ROBUSTO MADURO	0	1	2	29.600000000000001	29.600000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2427	15402	\N	THE GRIFFIN"S ROBUSTO TUBOS	0	1	2	23.699999999999999	23.699999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2428	15992	\N	THE GRIFFIN"S ROBUSTO TUBOS	0	1	2	7.9000000000000004	7.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2429	15401	\N	THE GRIFFIN"S ROBUSTO TUBOS	0	1	2	158	158	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2430	17571	\N	THE GRIFFIN"S SPECIAL XX EDITION	0	1	2	150	150	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2431	17817	\N	THE GRIFFIN"S SPECIAL XXI EDITION 2005	0	1	2	90	90	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2432	17915	\N	THE GRIFFIN"S SPECIAL XXII EDITION 2006	0	1	2	90	90	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2433	18046	\N	THE GRIFFIN"S SPECIAL XXIII EDITION 2007	0	1	2	80	80	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2434	18165	\N	THE GRIFFIN"S SPECIAL XXIV EDITION 2008	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2435	15982	\N	THE GRIFFIN"S TORO	0	1	2	8.9000000000000004	8.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2436	16408	\N	THE GRIFFIN"S TORO MADURO	0	1	2	222.5	222.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2437	16393	\N	THE GRIFFIN"S TORO MADURO	0	1	2	8.9000000000000004	8.9000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2438	16409	\N	THE GRIFFIN"S TORO MADURO	0	1	2	35.600000000000001	35.600000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2439	15866	\N	THE GRIFFIN"S TOROS	0	1	2	222.5	222.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2440	15875	\N	THE GRIFFIN"S TOROS	0	1	2	35.600000000000001	35.600000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2441	17815	\N	THE GRIFFINS PERFECTO	0	1	2	29.199999999999999	29.199999999999999	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2442	17816	\N	THE GRIFFINS PERFECTO	0	1	2	182.5	182.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2443	17814	\N	THE GRIFFINS PERFECTO	0	1	2	7.2999999999999998	7.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2444	17304	\N	THE GRIFFINS ROBUSTO FUERTE	0	1	2	6.7999999999999998	6.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2445	17305	\N	THE GRIFFINS ROBUSTO FUERTE	0	1	2	68	68	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2446	17303	\N	THE GRIFFINS SHORT CORONA FUERTE	0	1	2	53	53	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2447	17302	\N	THE GRIFFINS SHORT CORONA FUERTE	0	1	2	5.2999999999999998	5.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2448	18053	\N	THE GRIFFINS SHORT ROBUSTO	0	1	2	25.199999999999999	25.199999999999999	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2449	18054	\N	THE GRIFFINS SHORT ROBUSTO	0	1	2	157.5	157.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2450	17306	\N	THE GRIFFINS TORO FUERTE	0	1	2	8.4000000000000004	8.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2451	17307	\N	THE GRIFFINS TORO FUERTE	0	1	2	84	84	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2453	1289	\N	TOSCANELLO ANICE	0	1	2	0.14999999999999999	0.14999999999999999	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2454	88	\N	TOSCANELLO AROMA ANICE	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2455	1267	\N	TOSCANELLO AROMA CAFFE	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2456	2022	\N	TOSCANELLO AROMA FONDENTE	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2457	1701	\N	TOSCANELLO AROMA GRAPPA	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2458	2014	\N	TOSCANELLO AROMA GRAPPA RISERVA 2007	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2459	1290	\N	TOSCANELLO CAFFE	0	1	2	1	1	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2460	2159	\N	TOSCANELLO FONDENTE	0	1	2	1	1	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2461	1728	\N	TOSCANELLO GRAPPA	0	1	2	0.10000000000000001	0.10000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2462	471	\N	TOSCANELLO SPECIALE	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2463	2021	\N	TOSCANO 1492 ANNO DOMINI	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
2466	416	\N	TOSCANO CLASSICO	0	1	2	5.2000000000000002	5.2000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2467	2035	\N	TOSCANO COLLEZIONE	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 6 pezzi	2009-07-10	0	0	\N	\N	f
2468	1839	\N	TOSCANO DEL PRESIDENTE	0	1	2	120	120	\N	0	0	1	\N	0	Confezione da 32 pezzi	2009-07-10	0	0	\N	\N	f
2469	404	\N	TOSCANO EXTRAVECCHIO	0	1	2	5.7000000000000002	5.7000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2470	2023	\N	TOSCANO EXTRAVECCHIO DA 20 SIGARI	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2471	400	\N	TOSCANO GARIBALDI	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2472	2013	\N	TOSCANO GARIBALDI EDIZIONE BICENTENARIO	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 15 pezzi	2009-07-10	0	0	\N	\N	f
2473	846	\N	TOSCANO ORIGINALE	0	1	2	5.2999999999999998	5.2999999999999998	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
2474	1984	\N	TOSCANO ORIGINALE DA 8 PEZZI	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 8 pezzi	2009-07-10	0	0	\N	\N	f
2475	210	\N	TOSCANO ORIGINALE MILLENNIUM	0	1	2	171	171	\N	0	0	1	\N	0	Confezione da 18 pezzi	2009-07-10	0	0	\N	\N	f
2476	67	\N	TOSCANO ORIGINALE SELECTED DA 10 SIGARI	0	1	2	54	54	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2477	671	\N	TOSCANO ORIGINALE SELECTED DA 30 SIGARI	0	1	2	180	180	\N	0	0	1	\N	0	Confezione da 30 pezzi	2009-07-10	0	0	\N	\N	f
2478	1925	\N	TOSCANO SOLDATI	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2479	68	\N	TOSCANO SOLDATI AMMEZZATO	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2480	17454	\N	TRESIGARI BREAKFAST	0	1	2	9.9000000000000004	9.9000000000000004	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2481	17455	\N	TRESIGARI DINNER	0	1	2	9.9000000000000004	9.9000000000000004	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2482	17456	\N	TRESIGARI LUNCH	0	1	2	9.9000000000000004	9.9000000000000004	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2483	17941	\N	TRINIDAD COLECIÒN TRINIDAD EDICIÒN 2006	0	1	2	850	850	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2484	17645	\N	TRINIDAD COLONIALES	0	1	2	50	50	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2485	17519	\N	TRINIDAD COLONIALES	0	1	2	240	240	\N	0	0	1	\N	0	Confezione da 24 pezzi	2009-07-10	0	0	\N	\N	f
2486	17285	\N	TRINIDAD FUNDADORES	0	1	2	95	95	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2487	17433	\N	TRINIDAD FUNDADORES	0	1	2	456	456	\N	0	0	1	\N	0	Confezione da 24 pezzi	2009-07-10	0	0	\N	\N	f
2488	17682	\N	TRINIDAD FUNDADORES	0	1	2	228	228	\N	0	0	1	\N	0	Confezione da 12 pezzi	2009-07-10	0	0	\N	\N	f
2489	18099	\N	TRINIDAD INGENIOS 2007	0	1	2	198	198	\N	0	0	1	\N	0	Confezione da 12 pezzi	2009-07-10	0	0	\N	\N	f
2490	17646	\N	TRINIDAD REYES	0	1	2	36	36	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2491	17520	\N	TRINIDAD REYES	0	1	2	172.80000000000001	172.80000000000001	\N	0	0	1	\N	0	Confezione da 24 pezzi	2009-07-10	0	0	\N	\N	f
2492	17522	\N	TRINIDAD ROBUSTO EXTRA	0	1	2	228	228	\N	0	0	1	\N	0	Confezione da 12 pezzi	2009-07-10	0	0	\N	\N	f
2493	17521	\N	TRINIDAD ROBUSTO EXTRA	0	1	2	57	57	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2494	16894	\N	TROYA UNIVERSALES	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2495	16351	\N	VARGAS RESERVA CREMA	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2496	16347	\N	VARGAS RESERVA PANETELA	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2497	16356	\N	VARGAS RESERVA PRESIDENTE	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2498	17431	\N	VEGAS ROBAINA CLASICO	0	1	2	49	49	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2499	15487	\N	VEGAS ROBAINA CLASICO	0	1	2	245	245	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2500	15482	\N	VEGAS ROBAINA DON ALEJANDRO	0	1	2	375	375	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2501	15470	\N	VEGAS ROBAINA FAMILIAR	0	1	2	212.5	212.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2502	15483	\N	VEGAS ROBAINA FAMOSOS	0	1	2	212.5	212.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2503	17483	\N	VEGAS ROBAINA FAMOSOS	0	1	2	42.5	42.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2504	15484	\N	VEGAS ROBAINA UNICOS	0	1	2	295	295	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2505	NEW	\N	VEGUEROS ESPECIALES N. 1	0	1	2	247.5	247.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2506	NEW	\N	VEGUEROS ESPECIALES N. 2	0	1	2	197.5	197.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2507	16897	\N	VEGUEROS MAREVAS	0	1	2	27.5	27.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2508	18170	\N	VILLA ZAMORANO CORONA	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2509	18171	\N	VILLA ZAMORANO ROBUSTO	0	1	2	14.5	14.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2510	16878	\N	VILLAR Y VILLAR HALF CORONA	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2511	16880	\N	VILLAR Y VILLAR LAGUITOS	0	1	2	3.9500000000000002	3.9500000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2512	16879	\N	VILLAR Y VILLAR ROBUSTO	0	1	2	3.75	3.75	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2513	16881	\N	VILLAR Y VILLAR TRUMPETS	0	1	2	3.9500000000000002	3.9500000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2514	1260	\N	WILLEM II CORONA OPTIMUM	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2515	912	\N	WILLEM II OPTIMUM	0	1	2	50.25	50.25	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2516	236	\N	WILLEM II WILDE CIGARROS	0	1	2	2.6499999999999999	2.6499999999999999	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2517	18127	\N	WINSTON CHURCHILL BLENHEIM	0	1	2	575	575	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2518	18124	\N	WINSTON CHURCHILL CHEQUERS	0	1	2	312.5	312.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2519	18126	\N	WINSTON CHURCHILL MARRAKESH	0	1	2	425	425	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2520	18125	\N	WINSTON CHURCHILL NO. 10	0	1	2	350	350	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2521	15073	\N	ZINO CLASSIC BRASIL	0	1	2	52	52	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2522	15074	\N	ZINO CLASSIC BRASIL	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2523	15958	\N	ZINO CLASSIC BRASIL	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2524	18105	\N	ZINO CLASSIC N° 1 TUBOS	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2525	17988	\N	ZINO CLASSIC N° 1 TUBOS	0	1	2	22.5	22.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2526	17989	\N	ZINO CLASSIC N° 1 TUBOS	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2527	17990	\N	ZINO CLASSIC N° 3	0	1	2	27	27	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2528	17991	\N	ZINO CLASSIC N° 3	0	1	2	54	54	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2529	17993	\N	ZINO CLASSIC N° 4	0	1	2	43	43	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2530	17992	\N	ZINO CLASSIC N° 4	0	1	2	21.5	21.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2531	17995	\N	ZINO CLASSIC N° 5	0	1	2	53	53	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2532	17994	\N	ZINO CLASSIC N° 5	0	1	2	26.5	26.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2533	17996	\N	ZINO CLASSIC N° 6 TUBOS	0	1	2	22.5	22.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2534	17997	\N	ZINO CLASSIC N° 6 TUBOS	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2535	18106	\N	ZINO CLASSIC N° 6 TUBOS	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2536	17998	\N	ZINO CLASSIC N° 7 TUBOS	0	1	2	21.600000000000001	21.600000000000001	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2537	18107	\N	ZINO CLASSIC N° 7 TUBOS	0	1	2	5.4000000000000004	5.4000000000000004	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2538	17999	\N	ZINO CLASSIC N° 7 TUBOS	0	1	2	54	54	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2539	18108	\N	ZINO CLASSIC N° 8 TUBOS	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2540	18001	\N	ZINO CLASSIC N° 8 TUBOS	0	1	2	95	95	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2541	18000	\N	ZINO CLASSIC N° 8 TUBOS	0	1	2	28.5	28.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2542	18002	\N	ZINO CLASSIC N° DOUBLE CORONA	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2543	15072	\N	ZINO CLASSIC SUMATRA	0	1	2	52	52	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2544	15071	\N	ZINO CLASSIC SUMATRA	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2545	15957	\N	ZINO CLASSIC SUMATRA	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2546	18166	\N	ZINO CLASSIC TORPEDO	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2547	17046	\N	ZINO MOUTON CADET DOUBLE CORONA	0	1	2	38	38	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2548	17048	\N	ZINO MOUTON CADET DOUBLE CORONA	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2549	17047	\N	ZINO MOUTON CADET DOUBLE CORONA	0	1	2	95	95	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2550	15070	\N	ZINO MOUTON CADET N. 1	0	1	2	150	150	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2551	15955	\N	ZINO MOUTON CADET N. 1	0	1	2	6	6	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2552	15069	\N	ZINO MOUTON CADET N. 1	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2553	15468	\N	ZINO MOUTON CADET N. 1 TUBOS	0	1	2	26	26	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2554	15461	\N	ZINO MOUTON CADET N. 1 TUBOS	0	1	2	130	130	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2555	15986	\N	ZINO MOUTON CADET N. 1 TUBOS	0	1	2	6.5	6.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2556	15081	\N	ZINO MOUTON CADET N. 2	0	1	2	24.5	24.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2557	15080	\N	ZINO MOUTON CADET N. 2	0	1	2	122.5	122.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2558	15967	\N	ZINO MOUTON CADET N. 3	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2559	15082	\N	ZINO MOUTON CADET N. 3	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2560	15083	\N	ZINO MOUTON CADET N. 3	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2561	15079	\N	ZINO MOUTON CADET N. 4	0	1	2	18.5	18.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2562	15965	\N	ZINO MOUTON CADET N. 4	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2563	15084	\N	ZINO MOUTON CADET N. 4	0	1	2	92.5	92.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2564	16005	\N	ZINO MOUTON CADET N. 5	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2565	15106	\N	ZINO MOUTON CADET N. 5	0	1	2	23.5	23.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2566	15100	\N	ZINO MOUTON CADET N. 5	0	1	2	117.5	117.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2567	15102	\N	ZINO MOUTON CADET N. 6	0	1	2	157.5	157.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2568	15105	\N	ZINO MOUTON CADET N. 6	0	1	2	25.199999999999999	25.199999999999999	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2569	16004	\N	ZINO MOUTON CADET N. 6	0	1	2	6.2999999999999998	6.2999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2570	15421	\N	ZINO MOUTON CADET N. 7	0	1	2	23.5	23.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2571	15404	\N	ZINO MOUTON CADET N. 7	0	1	2	117.5	117.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2572	15999	\N	ZINO MOUTON CADET N. 7	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2573	15985	\N	ZINO MOUTON CADET N. 7 TUBOS	0	1	2	5	5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2574	15458	\N	ZINO MOUTON CADET N. 7 TUBOS	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2575	15463	\N	ZINO MOUTON CADET N. 7 TUBOS	0	1	2	100	100	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2576	15405	\N	ZINO MOUTON CADET N. 8	0	1	2	207.5	207.5	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2577	15998	\N	ZINO MOUTON CADET N. 8	0	1	2	8.3000000000000007	8.3000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2578	15407	\N	ZINO MOUTON CADET N. 8	0	1	2	33.200000000000003	33.200000000000003	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2579	15997	\N	ZINO MOUTON CADET N. 8 TUBOS	0	1	2	8.8000000000000007	8.8000000000000007	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2580	15465	\N	ZINO MOUTON CADET N. 8 TUBOS	0	1	2	176	176	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2581	15466	\N	ZINO MOUTON CADET N. 8 TUBOS	0	1	2	26.399999999999999	26.399999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2582	15996	\N	ZINO MOUTON CADET N.6 TUBOS	0	1	2	6.7999999999999998	6.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2583	15862	\N	ZINO MOUTON CADET N.6 TUBOS	0	1	2	20.399999999999999	20.399999999999999	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2584	15856	\N	ZINO MOUTON CADET N.6 TUBOS	0	1	2	136	136	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2585	15855	\N	ZINO MOUTON CADET N.6 TUBOS	0	1	2	170	170	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2586	17128	\N	ZINO MOUTON CADET TUBOS ASSORTMENT	0	1	2	27	27	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2587	15861	\N	ZINO MOUTON TORPEDO	0	1	2	27.199999999999999	27.199999999999999	\N	0	0	1	\N	0	Confezione da 4 pezzi	2009-07-10	0	0	\N	\N	f
2588	15994	\N	ZINO MOUTON TORPEDO	0	1	2	6.7999999999999998	6.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2589	15916	\N	ZINO MOUTON TORPEDO	0	1	2	170	170	\N	0	0	1	\N	0	Confezione da 25 pezzi	2009-07-10	0	0	\N	\N	f
2590	17656	\N	ZINO PLATINUM CROWN SERIES BARREL	0	1	2	75	75	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2591	17914	\N	ZINO PLATINUM CROWN SERIES BARRELL TUBOS	0	1	2	250	250	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2592	17657	\N	ZINO PLATINUM CROWN SERIES CHUBBY ESPECIAL	0	1	2	87	87	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2593	17913	\N	ZINO PLATINUM CROWN SERIES CHUBBY ESPECIAL TUBOS	0	1	2	290	290	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2594	17658	\N	ZINO PLATINUM CROWN SERIES DOUBLE GRANDE	0	1	2	78	78	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2595	17659	\N	ZINO PLATINUM CROWN SERIES STRETCH	0	1	2	102	102	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2596	NEW	\N	ZINO PLATINUM SCEPTER SERIES BULLET	0	1	2	22.5	22.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2597	17660	\N	ZINO PLATINUM SCEPTER SERIES BULLET	0	1	2	105	105	\N	0	0	1	\N	0	Confezione da 14 pezzi	2009-07-10	0	0	\N	\N	f
2598	NEW	\N	ZINO PLATINUM SCEPTER SERIES CHUBBY	0	1	2	33	33	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2599	17661	\N	ZINO PLATINUM SCEPTER SERIES CHUBBY	0	1	2	132	132	\N	0	0	1	\N	0	Confezione da 12 pezzi	2009-07-10	0	0	\N	\N	f
2600	17832	\N	ZINO PLATINUM SCEPTER SERIES CHUBBY TUBOS	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2601	17833	\N	ZINO PLATINUM SCEPTER SERIES CHUBBY TUBOS	0	1	2	34.5	34.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2602	17834	\N	ZINO PLATINUM SCEPTER SERIES CHUBBY TUBOS	0	1	2	230	230	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2603	NEW	\N	ZINO PLATINUM SCEPTER SERIES GRAND MASTER	0	1	2	37.5	37.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2604	17662	\N	ZINO PLATINUM SCEPTER SERIES GRAND MASTER	0	1	2	150	150	\N	0	0	1	\N	0	Confezione da 12 pezzi	2009-07-10	0	0	\N	\N	f
2605	17831	\N	ZINO PLATINUM SCEPTER SERIES GRAND MASTER TUBOS	0	1	2	260	260	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2606	17830	\N	ZINO PLATINUM SCEPTER SERIES GRAND MASTER TUBOS	0	1	2	39	39	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2607	17829	\N	ZINO PLATINUM SCEPTER SERIES GRAND MASTER TUBOS	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2608	NEW	\N	ZINO PLATINUM SCEPTER SERIES LOW RIDER	0	1	2	34.5	34.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2609	17663	\N	ZINO PLATINUM SCEPTER SERIES LOW RIDER	0	1	2	184	184	\N	0	0	1	\N	0	Confezione da 16 pezzi	2009-07-10	0	0	\N	\N	f
2610	18060	\N	ZINO PLATINUM SCEPTER SERIES MASTER EDITION 2007	0	1	2	125	125	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2611	NEW	\N	ZINO PLATINUM SCEPTER SERIES PUDGE	0	1	2	22.5	22.5	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2612	17987	\N	ZINO PLATINUM SCEPTER SERIES PUDGE	0	1	2	90	90	\N	0	0	1	\N	0	Confezione da 12 pezzi	2009-07-10	0	0	\N	\N	f
2613	17664	\N	ZINO PLATINUM SCEPTER SERIES SHORTY	0	1	2	128	128	\N	0	0	1	\N	0	Confezione da 16 pezzi	2009-07-10	0	0	\N	\N	f
2614	NEW	\N	ZINO PLATINUM SCEPTER SERIES SHORTY	0	1	2	24	24	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2615	17665	\N	ZINO PLATINUM SCEPTER SERIES STOUT	0	1	2	168	168	\N	0	0	1	\N	0	Confezione da 12 pezzi	2009-07-10	0	0	\N	\N	f
2616	NEW	\N	ZINO PLATINUM SCEPTER SERIES STOUT	0	1	2	42	42	\N	0	0	1	\N	0	Confezione da 3 pezzi	2009-07-10	0	0	\N	\N	f
2617	17666	\N	ZINO PLATINUM SCEPTER SERIES XS PURITOS	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2618	15093	\N	ZINO RELAX BRASIL	0	1	2	56	56	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2619	15096	\N	ZINO RELAX BRASIL	0	1	2	14	14	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2620	16002	\N	ZINO RELAX BRASIL	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2621	16001	\N	ZINO RELAX SUMATRA	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
2622	15101	\N	ZINO RELAX SUMATRA	0	1	2	14	14	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2623	15098	\N	ZINO RELAX SUMATRA	0	1	2	56	56	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
2624	2172	\N	CHEMA 30G	0	1	2	1.8	1.8	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
2625	NEW	\N	EDEL PRISE EXTRA	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 10 grammi	2009-07-10	0	0	\N	\N	f
2626	889	\N	GAWITH APRICOT SNUFF	0	1	2	1.5	1.5	\N	0	0	1	\N	0	Confezione da 10 grammi	2009-07-10	0	0	\N	\N	f
2627	209	\N	GLETSCHER PRISE SNUFF	0	1	2	1.5	1.5	\N	0	0	1	\N	0	Confezione da 10 grammi	2009-07-10	0	0	\N	\N	f
2628	1734	\N	MAKLA IFRIKIA	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 200 grammi	2009-07-10	0	0	\N	\N	f
2629	NEW	\N	Mc CHRYSTALS SNUFF	0	1	2	0.57999999999999996	0.57999999999999996	\N	0	0	1	\N	0	Confezione da 4 grammi	2009-07-10	0	0	\N	\N	f
2630	NEW	\N	McCHRYSTALS ORIGINAL & GENUINE NEW MEDICATED SNUFF	0	1	2	1	1	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2631	2118	\N	OZONA ANIS	0	1	2	1.2	1.2	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2632	1544	\N	OZONA CHERRY SNUFF	0	1	2	1.2	1.2	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2633	576	\N	OZONA PRESIDENT SNUFF	0	1	2	1.2	1.2	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2634	1545	\N	OZONA RASPBERRY SNUFF	0	1	2	1.2	1.2	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2635	299	\N	OZONA SNUFF (MENTHOL)	0	1	2	1.1000000000000001	1.1000000000000001	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2636	NEW	\N	RUMNEYS EXPORT SNUFF	0	1	2	1.3999999999999999	1.3999999999999999	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2637	1608	\N	SANTA CATERINA BLU	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 200 grammi	2009-07-10	0	0	\N	\N	f
2638	723	\N	SANTA CATERINA ROSSO	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 200 grammi	2009-07-10	0	0	\N	\N	f
2639	NEW	\N	SINGLETONS SPEARMINT	0	1	2	1.25	1.25	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2640	2158	\N	ALLEGRO	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2641	213	\N	AMPHORA BLACK CAVENDISH SPECIAL RESERVE	0	1	2	8.5	8.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2642	373	\N	AMPHORA FULL AROMA	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2643	214	\N	AMPHORA GOLDEN BLEND SPECIAL RESERVE	0	1	2	8.5	8.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2644	1242	\N	AMPHORA MATURE BLEND	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2645	811	\N	AMPHORA ORIGINAL BLEND	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2646	349	\N	AMPHORA RICH AROMA	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2647	15614	\N	ASHTON BLACK PARROT	0	1	2	24	24	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2648	17900	\N	ASHTON CONSUMMATE GENTLEMAN	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2649	15631	\N	ASHTON OLD LONDON	0	1	2	24	24	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2650	17901	\N	ASHTON RAINY DAY	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2651	17902	\N	ASHTON SMOOTH SAILING	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2652	15329	\N	ASHTON SOVEREIGN	0	1	2	24	24	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2653	15321	\N	ASHTON THE FRAGRANT BLEND	0	1	2	24	24	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2654	15316	\N	ASHTON TYPE 1	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2655	15317	\N	ASHTON TYPE 2	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2656	15619	\N	ASHTON TYPE 3	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2657	15318	\N	ASHTON TYPE 4	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2658	15319	\N	ASHTON TYPE 5	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2659	15630	\N	ASHTON TYPE 6	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2660	NEW	\N	BENTLEY EXCELLENCE ORANGE ORIENTAL TYPE	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2661	NEW	\N	BENTLEY EXCELLENCE THE CLASSIC ONE	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2662	NEW	\N	BENTLEY EXCELLENCE VIRGINIA HONEYDEW	0	1	2	15.5	15.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2663	17979	\N	BENTLEY ORANGE ORIENTAL TYPE	0	1	2	27.5	27.5	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2664	17981	\N	BENTLEY THE CLASSIC ONE	0	1	2	27.5	27.5	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2665	17980	\N	BENTLEY VIRGINIA HONEYDEW	0	1	2	29.5	29.5	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2666	15689	\N	BILL BAILEY"S BALKAN BLEND	0	1	2	14.699999999999999	14.699999999999999	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2667	15690	\N	BILL BAILEY"S BEST BLEND	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2668	16317	\N	BILL BAILEY"S BOWLING BLEND	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2669	16912	\N	BILL BAILEYS BOURBON BLEND	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2670	97	\N	BLACK AND MILD	0	1	2	5.25	5.25	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2671	1890	\N	BORKUM RIFF ADMIRALS FLAKE CHERRY	0	1	2	10.800000000000001	10.800000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2672	1891	\N	BORKUM RIFF ADMIRALS FLAKE VANILLA	0	1	2	10.800000000000001	10.800000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2673	1280	\N	BORKUM RIFF BLACK CAVENDISH	0	1	2	7.2999999999999998	7.2999999999999998	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2674	1713	\N	BORKUM RIFF BLACK CAVENDISH SPECIALE	0	1	2	0.17999999999999999	0.17999999999999999	\N	0	0	1	\N	0	Confezione da 3 grammi	2009-07-10	0	0	\N	\N	f
2675	1858	\N	BORKUM RIFF CHERRY & VANILLA	0	1	2	10.800000000000001	10.800000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2676	624	\N	BORKUM RIFF CHERRY CAVENDISH	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2677	2050	\N	BORKUM RIFF GENUINE	0	1	2	7.2999999999999998	7.2999999999999998	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2678	1930	\N	BORKUM RIFF HONEY AND ORANGE	0	1	2	7.2999999999999998	7.2999999999999998	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2679	711	\N	BORKUM RIFF ORIGINAL	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2680	1203	\N	BORKUM RIFF VANILLA CAVENDISH	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2681	1712	\N	BORKUM RIFF VANILLA CAVENDISH SPECIALE	0	1	2	0.17999999999999999	0.17999999999999999	\N	0	0	1	\N	0	Confezione da 3 grammi	2009-07-10	0	0	\N	\N	f
2682	121	\N	BORKUM RIFF WHISKEY	0	1	2	7.2999999999999998	7.2999999999999998	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2683	16476	\N	BREBBIA ADAGIO MIX N.5	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2684	17091	\N	BREBBIA ADAGIO MIX N.5	0	1	2	0.80000000000000004	0.80000000000000004	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2685	16489	\N	BREBBIA ALLEGRO MIX N.4	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2686	17090	\N	BREBBIA ALLEGRO MIX N.4	0	1	2	0.80000000000000004	0.80000000000000004	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2687	17687	\N	BREBBIA BALKAN N.10	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2688	17946	\N	BREBBIA CALVADOS MIX N.11	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2689	17274	\N	BREBBIA CLASSIC ENGLISH MIX N°7	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2690	17275	\N	BREBBIA CLASSIC ENGLISH MIX N°8	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2691	17688	\N	BREBBIA LATAKIA FLAKE N.9	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2692	18188	\N	BREBBIA OPERA MIX N.12	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2693	16499	\N	BREBBIA PRELUDIO MIX N.6	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2694	17092	\N	BREBBIA PRELUDIO MIX N.6	0	1	2	0.80000000000000004	0.80000000000000004	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2695	17088	\N	BREBBIA QUARTETTO MIX N.2	0	1	2	0.80000000000000004	0.80000000000000004	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2696	16492	\N	BREBBIA QUARTETTO MIX N.2	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2697	17087	\N	BREBBIA ROMANZA MIX N.1	0	1	2	0.80000000000000004	0.80000000000000004	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2698	16498	\N	BREBBIA ROMANZA MIX N.1	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2699	16490	\N	BREBBIA SINFONIA MIX N.3	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2700	17089	\N	BREBBIA SINFONIA MIX N.3	0	1	2	0.90000000000000002	0.90000000000000002	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2701	16318	\N	BRODER PETERSEN"S SPECIAL	0	1	2	13.699999999999999	13.699999999999999	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2702	938	\N	BROOKFIELD AROMATIC BLEND	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2703	15680	\N	C.A.O. INDIPENDENCE	0	1	2	13.699999999999999	13.699999999999999	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2704	15681	\N	C.A.O. LIBERTY	0	1	2	14.699999999999999	14.699999999999999	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2705	15682	\N	C.A.O. MIDNIGHT RIDE	0	1	2	14.300000000000001	14.300000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2706	15683	\N	C.A.O. OLD IRONSIDES	0	1	2	14.699999999999999	14.699999999999999	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2707	16390	\N	C.A.O. PATRIOT FLAKE	0	1	2	13.6	13.6	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2708	99	\N	CALEDONIAN GRAND RESERVE	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2709	902	\N	CALEDONIAN HIGHLAND CREAM	0	1	2	12	12	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2710	207	\N	CAPSTAN ORIGINAL NAVY CUT	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2711	950	\N	CAPTAIN BLACK	0	1	2	8.5	8.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2712	78	\N	CELLINI CLASSICO RISERVA	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2713	84	\N	CELLINI FORTE	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2714	933	\N	CHEVALIER	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2715	16726	\N	CHRISTMAS BLEND -IL TABACCO DI NATALE- WEIHNACHTS TABAK	0	1	2	28	28	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2716	797	\N	CLAN AROMATIC	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2717	2105	\N	CLAN HIGHLAND GOLD	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2718	2106	\N	CLAN HIGHLAND GOLD	0	1	2	0.65000000000000002	0.65000000000000002	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2719	2132	\N	CLEOPATRA MOLASSES APPLE	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 150 grammi	2009-07-10	0	0	\N	\N	f
2720	2133	\N	CLEOPATRA MOLASSES APPLE	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 250 grammi	2009-07-10	0	0	\N	\N	f
2721	2091	\N	CLEOPATRA MOLASSES APPLE	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2722	2087	\N	CLEOPATRA MOLASSES CHERRY	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2723	2124	\N	CLEOPATRA MOLASSES CHERRY	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 150 grammi	2009-07-10	0	0	\N	\N	f
2724	2125	\N	CLEOPATRA MOLASSES CHERRY	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 250 grammi	2009-07-10	0	0	\N	\N	f
2725	2131	\N	CLEOPATRA MOLASSES COCONUT	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 250 grammi	2009-07-10	0	0	\N	\N	f
2726	2130	\N	CLEOPATRA MOLASSES COCONUT	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 150 grammi	2009-07-10	0	0	\N	\N	f
2727	2090	\N	CLEOPATRA MOLASSES COCONUT	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2728	2128	\N	CLEOPATRA MOLASSES GRAPES	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 150 grammi	2009-07-10	0	0	\N	\N	f
2729	2089	\N	CLEOPATRA MOLASSES GRAPES	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2730	2129	\N	CLEOPATRA MOLASSES GRAPES	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 250 grammi	2009-07-10	0	0	\N	\N	f
2731	2121	\N	CLEOPATRA MOLASSES MANGO	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 250 grammi	2009-07-10	0	0	\N	\N	f
2732	2085	\N	CLEOPATRA MOLASSES MANGO	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2733	2120	\N	CLEOPATRA MOLASSES MANGO	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 150 grammi	2009-07-10	0	0	\N	\N	f
2734	2093	\N	CLEOPATRA MOLASSES MELON	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2735	2137	\N	CLEOPATRA MOLASSES MELON	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 250 grammi	2009-07-10	0	0	\N	\N	f
2736	2136	\N	CLEOPATRA MOLASSES MELON	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 150 grammi	2009-07-10	0	0	\N	\N	f
2737	2139	\N	CLEOPATRA MOLASSES MINT	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 250 grammi	2009-07-10	0	0	\N	\N	f
2738	2094	\N	CLEOPATRA MOLASSES MINT	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2739	2138	\N	CLEOPATRA MOLASSES MINT	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 150 grammi	2009-07-10	0	0	\N	\N	f
2740	NEW	\N	CLEOPATRA MOLASSES NATURAL TOBACCO FLAVOUR	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2741	2116	\N	CLEOPATRA MOLASSES NATURAL TOBACCO FLAVOUR	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 150 grammi	2009-07-10	0	0	\N	\N	f
2742	2117	\N	CLEOPATRA MOLASSES NATURAL TOBACCO FLAVOUR	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 250 grammi	2009-07-10	0	0	\N	\N	f
2743	2134	\N	CLEOPATRA MOLASSES PEACH	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 150 grammi	2009-07-10	0	0	\N	\N	f
2744	2092	\N	CLEOPATRA MOLASSES PEACH	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2745	2135	\N	CLEOPATRA MOLASSES PEACH	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 250 grammi	2009-07-10	0	0	\N	\N	f
2746	2086	\N	CLEOPATRA MOLASSES STRAWBERRY	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2747	2123	\N	CLEOPATRA MOLASSES STRAWBERRY	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 250 grammi	2009-07-10	0	0	\N	\N	f
2748	2122	\N	CLEOPATRA MOLASSES STRAWBERRY	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 150 grammi	2009-07-10	0	0	\N	\N	f
2749	2126	\N	CLEOPATRA MOLASSES SWEET MELON	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 150 grammi	2009-07-10	0	0	\N	\N	f
2750	2127	\N	CLEOPATRA MOLASSES SWEET MELON	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 250 grammi	2009-07-10	0	0	\N	\N	f
2751	2088	\N	CLEOPATRA MOLASSES SWEET MELON	0	1	2	2.5	2.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2753	16389	\N	DA VINCI	0	1	2	14.5	14.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2754	57	\N	DANISH BLACK VANILLE	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2755	144	\N	DANSKE CLUB BLACK LUXURY	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2756	17580	\N	DAVIDOFF BLUE MIXTURE	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2757	17581	\N	DAVIDOFF GREEN MIXTURE	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2758	17582	\N	DAVIDOFF RED MIXTURE	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2759	778	\N	DAVIDOFF SCOTTISH MIXTURE	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2760	17860	\N	DEVILS HOLIDAY	0	1	2	24.199999999999999	24.199999999999999	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2761	18152	\N	DINGLERS NINETEEN OFOUR CHERRY	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
2762	18150	\N	DINGLERS NINETEEN OFOUR ORIGINAL	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
2763	18154	\N	DINGLERS NINETEEN OFOUR RUM & RAISIN	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
2764	18153	\N	DINGLERS NINETEEN OFOUR VANILLA	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
2765	18151	\N	DINGLERS NINETEEN OFOUR WHISKY	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
2766	760	\N	DUNHILL AROMATIC	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2767	761	\N	DUNHILL BLACK AROMATIC	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2768	944	\N	DUNHILL DE LUXE NAVY ROLLS	0	1	2	16	16	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2769	205	\N	DUNHILL EARLY MORNING PIPE	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2770	970	\N	DUNHILL ELIZABETHAN MIXTURE	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2771	582	\N	DUNHILL LONDON MIXTURE	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2772	206	\N	DUNHILL MY MIXTURE 965	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2773	208	\N	DUNHILL NIGHT CAP	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2774	350	\N	DUNHILL STANDARD MIXTURE	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2775	368	\N	DUNHILL STANDARD MIXTURE MELLOW	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2776	17324	\N	ELYSEE MARC DE CHAMPAGNE	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2777	2114	\N	ERINMORE BALKAN MIXTURE	0	1	2	11.5	11.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2778	2119	\N	ERINMORE BALKAN MIXTURE	0	1	2	1.1499999999999999	1.1499999999999999	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2779	337	\N	ERINMORE MIXTURE MURRAYS	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2780	472	\N	FLYING DUTCHMAN AROMATIC	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2782	17861	\N	GOLD OF MYSORE	0	1	2	24.699999999999999	24.699999999999999	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2783	1711	\N	GOLDEN BLENDS AMARETTO	0	1	2	6.2999999999999998	6.2999999999999998	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2784	1539	\N	GOLDEN BLENDS BLACK CHERRY	0	1	2	6.2999999999999998	6.2999999999999998	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2785	925	\N	GOLDEN BLENDS CHOCOLATE	0	1	2	6.2999999999999998	6.2999999999999998	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2786	917	\N	GOLDEN BLENDS VANILLA	0	1	2	6.2999999999999998	6.2999999999999998	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2787	848	\N	GOLF	0	1	2	3.3999999999999999	3.3999999999999999	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2788	302	\N	GOLF	0	1	2	4.25	4.25	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2789	15688	\N	GORDON PYM	0	1	2	13.9	13.9	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2790	2005	\N	HABIBI BANANA FLAVOUR	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2791	2004	\N	HABIBI MELON FLAVOUR	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2792	2003	\N	HABIBI ORANGE FLAVOUR	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2793	772	\N	HALF AND HALF	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2794	625	\N	HOLGER DANSKE BLACK AND BOURBON (LUXURY BLEND)	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2795	15693	\N	HOLLYS NON PLUS ULTRA	0	1	2	10.300000000000001	10.300000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2796	17627	\N	IL REGNO DEL SOLE LIMITED EDITION 2004	0	1	2	15	15	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2797	424	\N	INDIAN SUMMER	0	1	2	8.1999999999999993	8.1999999999999993	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2798	303	\N	ITALIA	0	1	2	5.75	5.75	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2799	980	\N	ITALIA	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2800	16723	\N	JACARANDA TROPIC FRAGRANCE	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2801	17417	\N	JOSE GENER LA ESCEPCIÓN PICADURA SELECTA	0	1	2	16.5	16.5	\N	0	0	1	\N	0	Confezione da 110 grammi	2009-07-10	0	0	\N	\N	f
2802	32	\N	KENTUCKY BIRD	0	1	2	7.5999999999999996	7.5999999999999996	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2803	211	\N	KING CHARLES SMOKING MIXTURE	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2804	17945	\N	LUBINSKY MAXIMA MIXTURE	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2805	17944	\N	LUBINSKY SUPERBA MIXTURE	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2806	17857	\N	M A DEN DANSKE DROM	0	1	2	24	24	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2807	678	\N	MAC BAREN AROMATIC CHOICE	0	1	2	8.4000000000000004	8.4000000000000004	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2808	752	\N	MAC BAREN BLACK AMBROSIA (AROMATIC)	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2809	1725	\N	MAC BAREN CHERRY CHOICE	0	1	2	7.0999999999999996	7.0999999999999996	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2811	2154	\N	MAC BAREN CUBE PREMIUM GOLD	0	1	2	8.5	8.5	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2812	2153	\N	MAC BAREN CUBE PREMIUM SILVER	0	1	2	8.5	8.5	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2813	17465	\N	MAC BAREN DARK TWIST	0	1	2	24	24	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2814	347	\N	MAC BAREN GOLDEN BLEND	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2815	639	\N	MAC BAREN GOLDEN DICE	0	1	2	6.9000000000000004	6.9000000000000004	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2816	NEW	\N	MAC BAREN GOLDEN DICE INTERNATIONAL	0	1	2	0.25	0.25	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2817	2095	\N	MAC BAREN HABIBI APPLE FLAVOUR	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2818	17667	\N	MAC BAREN HABIBI APPLE FLAVOUR	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2819	17668	\N	MAC BAREN HABIBI GRAPES FLAVOUR	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2820	2096	\N	MAC BAREN HABIBI GRAPES FLAVOUR	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2821	17669	\N	MAC BAREN HABIBI MIXED FRUIT FLAVOUR	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2822	2097	\N	MAC BAREN HABIBI MIXED FRUIT FLAVOUR	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2823	17888	\N	MAC BAREN LATAKIA BLEND	0	1	2	23.5	23.5	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2824	346	\N	MAC BAREN MIXTURE	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2825	1540	\N	MAC BAREN MIXTURE  SPECIALE	0	1	2	0.12	0.12	\N	0	0	1	\N	0	Confezione da 3 grammi	2009-07-10	0	0	\N	\N	f
2826	17856	\N	MAC BAREN MIXTURE FLAKE	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2827	NEW	\N	MAC BAREN MIXTURE MODERN SPECIALE	0	1	2	0.12	0.12	\N	0	0	1	\N	0	Confezione da 3 grammi	2009-07-10	0	0	\N	\N	f
2828	17466	\N	MAC BAREN NAVY FLAKE	0	1	2	22	22	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2829	1542	\N	MAC BAREN NAVY MIXTURE	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2830	17889	\N	MAC BAREN NORWOOD	0	1	2	22	22	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2831	822	\N	MAC BAREN ORIGINAL CHOICE	0	1	2	8.4000000000000004	8.4000000000000004	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2832	NEW	\N	MAC BAREN ORIGINAL CHOICE SPECIALE	0	1	2	0.12	0.12	\N	0	0	1	\N	0	Confezione da 3 grammi	2009-07-10	0	0	\N	\N	f
2833	17890	\N	MAC BAREN PLUMCAKE	0	1	2	22	22	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2834	17467	\N	MAC BAREN ROLL CAKE	0	1	2	25.199999999999999	25.199999999999999	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2835	17887	\N	MAC BAREN THE SOLENT MIXTURE	0	1	2	23.5	23.5	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2836	1599	\N	MAC BAREN UNCLE LOUIES RUM	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2837	1653	\N	MAC BAREN UNCLE LOUIES RUM SPECIALE	0	1	2	0.23999999999999999	0.23999999999999999	\N	0	0	1	\N	0	Confezione da 3 grammi	2009-07-10	0	0	\N	\N	f
2838	1600	\N	MAC BAREN UNCLE LOUIES WHISKY	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2839	1654	\N	MAC BAREN UNCLE LOUIES WHISKY SPECIALE	0	1	2	0.23999999999999999	0.23999999999999999	\N	0	0	1	\N	0	Confezione da 3 grammi	2009-07-10	0	0	\N	\N	f
2840	1857	\N	MAC BAREN VANILLA CHOICE	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
2841	1601	\N	MAC BAREN VANILLA CREAM	0	1	2	7	7	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2842	1652	\N	MAC BAREN VANILLA CREAM SPECIALE	0	1	2	0.23999999999999999	0.23999999999999999	\N	0	0	1	\N	0	Confezione da 3 grammi	2009-07-10	0	0	\N	\N	f
2843	NEW	\N	Mc CHRYSTALS PIPE TOBACCO	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 25 grammi	2009-07-10	0	0	\N	\N	f
2844	NEW	\N	Mc CHRYSTALS PIPE TOBACCO DARK BLEND	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 25 grammi	2009-07-10	0	0	\N	\N	f
2845	NEW	\N	Mc CHRYSTALS PIPE TOBACCO LIGHT BLEND	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 25 grammi	2009-07-10	0	0	\N	\N	f
2846	17318	\N	MC LINTOCK BLACK CHERRY	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2847	17319	\N	MC LINTOCK BLACK CHERRY	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2848	17322	\N	MC LINTOCK REDNUT	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2849	17323	\N	MC LINTOCK REDNUT	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2850	17320	\N	MC LINTOCK WILD CHERRY	0	1	2	9	9	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2851	17321	\N	MC LINTOCK WILD CHERRY	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2852	17858	\N	MILONGA	0	1	2	24.699999999999999	24.699999999999999	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2853	2002	\N	MIT BLEND 39 TWENTY	0	1	2	0.80000000000000004	0.80000000000000004	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
2854	2163	\N	NAKHLA ALBICOCCA	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2855	2052	\N	NAKHLA CILIEGIA	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2856	2051	\N	NAKHLA DOPPIA MELA	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2857	2053	\N	NAKHLA FRAGOLA	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2858	2062	\N	NAKHLA LIQUIRIZIA	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2859	2059	\N	NAKHLA MANDARINO	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2860	2056	\N	NAKHLA MANGO	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2861	2060	\N	NAKHLA MELONE	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2862	2162	\N	NAKHLA MENTA	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2863	2057	\N	NAKHLA PESCA	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2864	2055	\N	NAKHLA ROSA	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2865	2054	\N	NAKHLA TUTTI FRUTTI	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2866	2058	\N	NAKHLA VANIGLIA	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2867	2061	\N	NAKHLA ZAGHLOUL	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2868	216	\N	NEPTUNE	0	1	2	6.7999999999999998	6.7999999999999998	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2869	1246	\N	NINETEEN OFOUR CHERRY	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2870	1245	\N	NINETEEN OFOUR VANILLA	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2871	15766	\N	OCEAN LINER BLACK & BRIGHT	0	1	2	24	24	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2872	15767	\N	OCEAN LINER FLAKE & CAVENDISH	0	1	2	28.699999999999999	28.699999999999999	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2873	15768	\N	OCEAN LINER SWEET & EASY	0	1	2	28.399999999999999	28.399999999999999	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2874	340	\N	PARK LANE N.7	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2875	17422	\N	PARTAGAS PICADURA GRANULADA	0	1	2	16.5	16.5	\N	0	0	1	\N	0	Confezione da 110 grammi	2009-07-10	0	0	\N	\N	f
2876	16725	\N	PERGAMON CLASSICAL TOBACCO	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2877	17670	\N	PETERSON CONNOISSEURS CHOICE	0	1	2	18.5	18.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2878	17671	\N	PETERSON DE LUXE MIXTURE	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2879	17672	\N	PETERSON GOLD BLEND	0	1	2	18.5	18.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2880	18010	\N	PETERSON IRISH FLAKE	0	1	2	18.25	18.25	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2881	16906	\N	PETERSON IRISH OAK	0	1	2	17	17	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2882	16905	\N	PETERSON IRISH WHISKEY	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2883	17673	\N	PETERSON LUXURY BLEND	0	1	2	18.5	18.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2884	16908	\N	PETERSON OLD DUBLIN	0	1	2	18.75	18.75	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2885	16904	\N	PETERSON SHERLOCK HOLMES	0	1	2	16	16	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2886	16910	\N	PETERSON SUNSET BREEZE	0	1	2	18.25	18.25	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2887	16909	\N	PETERSON SWEET KILLARNEY	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2888	16907	\N	PETERSON UNIVERSITY FLAKE	0	1	2	18.25	18.25	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2889	15325	\N	RATTRAYS 3 NOGGINS FULL	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2890	15313	\N	RATTRAYS 7 RESERVE MEDIUM	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2891	15326	\N	RATTRAYS ACCOUNTANTS MIXTURE	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2892	18011	\N	RATTRAYS BAGPIPERS DREAM	0	1	2	26.5	26.5	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2893	15323	\N	RATTRAYS BLACK MALLORY	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2894	15632	\N	RATTRAYS BLACK VIRGINIA	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2895	15628	\N	RATTRAYS BROWN CLUNEE	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2896	15638	\N	RATTRAYS CHARLES MIXTURE	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2897	15650	\N	RATTRAYS DARK FRAGRANT	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2898	15637	\N	RATTRAYS HAL OTHE WYND	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2899	15639	\N	RATTRAYS HIGH SOCIETY	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2900	15327	\N	RATTRAYS HIGHLAND TARGE	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2901	15642	\N	RATTRAYS JOCKS MIXTURE	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2902	15635	\N	RATTRAYS MARLIN FLAKE	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2903	15629	\N	RATTRAYS OLD GOWRIE	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2904	15328	\N	RATTRAYS PROFESSIONAL MIXTURE	0	1	2	25	25	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2905	15324	\N	RATTRAYS RED RAPPAREE	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2906	15640	\N	RATTRAYS SWEET FRAGRANT	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2907	15633	\N	RATTRAYS TERRY RED	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2908	17626	\N	ROBERT MC CONNELL RED ROSES	0	1	2	26.5	26.5	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2909	15636	\N	ROBERT McCONNEL BLACK & GOLD	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2910	15617	\N	ROBERT McCONNEL GLEN PIPER MELLOW AROMATIC	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2911	15634	\N	ROBERT McCONNEL MADURO	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2912	15627	\N	ROBERT McCONNEL ORIENTAL	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2913	15615	\N	ROBERT McCONNEL PURE LATAKIA	0	1	2	13.5	13.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2914	15626	\N	ROBERT McCONNEL RED VIRGINIA	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2915	15625	\N	ROBERT McCONNEL SCOTTISH BLEND	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2916	15624	\N	ROBERT McCONNEL SCOTTISH CAKE	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2917	15623	\N	ROBERT McCONNEL SCOTTISH FLAKE	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2918	15621	\N	ROBERT McCONNEL SPECIAL LONDON MATURE	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2919	15702	\N	SAM MALLOYS N. 4 EXTRA  STOUT	0	1	2	10.5	10.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2920	18005	\N	SAMUEL GAWITH 1792 FLAKE	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2921	17674	\N	SAMUEL GAWITH BALKAN FLAKE	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2922	18003	\N	SAMUEL GAWITH BEST BROWN FLAKE	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2923	17675	\N	SAMUEL GAWITH BROWN NO.4	0	1	2	20	20	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2924	18004	\N	SAMUEL GAWITH CHOCOLATE FLAKE	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2925	17676	\N	SAMUEL GAWITH FIRE DANCE FLAKE	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2926	17677	\N	SAMUEL GAWITH FULL VIRGINIA FLAKE	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2927	17678	\N	SAMUEL GAWITH GROUSE-MOOR	0	1	2	17	17	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2928	17679	\N	SAMUEL GAWITH KENDAL CREAM	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2929	18006	\N	SAMUEL GAWITH NAVY FLAKE	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2930	17680	\N	SAMUEL GAWITH PERFECTION	0	1	2	17	17	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2931	18007	\N	SAMUEL GAWITH SAMS FLAKE	0	1	2	17.5	17.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2932	18008	\N	SAMUEL GAWITH SKIFF MIXTURE	0	1	2	17	17	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2933	17681	\N	SAMUEL GAWITH SQUADRON LEADER	0	1	2	17	17	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2934	18009	\N	SAMUEL GAWITH WESTMORLAND MIXTURE	0	1	2	17	17	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2935	16724	\N	SANS SOUCI MAJESTIC MIXTURE	0	1	2	30	30	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2936	64	\N	SAVINELLI ARMONIA	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2937	342	\N	SCHIPPERS TABAK SPECIAAL	0	1	2	6.5999999999999996	6.5999999999999996	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2938	2171	\N	SKANDINAVIK ARABICA	0	1	2	0.65000000000000002	0.65000000000000002	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2939	2170	\N	SKANDINAVIK ARABICA	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2940	612	\N	SKANDINAVIK AROMATIC	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2941	1855	\N	SKANDINAVIK EXOTIC	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2942	1856	\N	SKANDINAVIK EXOTIC 5	0	1	2	0.29999999999999999	0.29999999999999999	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2943	129	\N	SKANDINAVIK MIXTURE	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2944	1892	\N	SKANDINAVIK MIXTURE 5	0	1	2	0.29999999999999999	0.29999999999999999	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2945	713	\N	SKANDINAVIK REGULAR	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2946	1256	\N	SKANDINAVIK VANILLA	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2947	1257	\N	SKANDINAVIK VANILLA 5 gr.	0	1	2	0.29999999999999999	0.29999999999999999	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2948	920	\N	SKANDINAVIK WHITE	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2949	16319	\N	SKIPPER"S FLAKE	0	1	2	13.699999999999999	13.699999999999999	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2950	1664	\N	STANWELL CLASSIC	0	1	2	6.5	6.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2951	1667	\N	STANWELL CLASSIC 5	0	1	2	0.25	0.25	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2952	1828	\N	STANWELL FULL AROMA	0	1	2	6.5	6.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2953	1829	\N	STANWELL FULL AROMA 5	0	1	2	0.25	0.25	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2954	1665	\N	STANWELL MELANGE	0	1	2	6.5	6.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2955	1668	\N	STANWELL MELANGE 5	0	1	2	0.25	0.25	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2956	1663	\N	STANWELL VANILLA	0	1	2	6.5	6.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2957	1666	\N	STANWELL VANILLA 5	0	1	2	0.25	0.25	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2958	596	\N	SWEET DUBLIN IRISH WHISKEY	0	1	2	6.7000000000000002	6.7000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2959	15746	\N	SWEET VANILLA HONEYDEW	0	1	2	14.300000000000001	14.300000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2960	358	\N	THE BALKAN SOBRANIE SMOKING MIXTURE	0	1	2	11.300000000000001	11.300000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2961	15701	\N	THE MALTHOUSE FOUNDER"S RESERVE	0	1	2	12.800000000000001	12.800000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2962	17978	\N	THE MELLOW MALLARD	0	1	2	14.199999999999999	14.199999999999999	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2963	15769	\N	THE SEASONS HARVESTTIME	0	1	2	13.300000000000001	13.300000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2964	15773	\N	THE SEASONS SPRINGTIME	0	1	2	13.300000000000001	13.300000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2965	15772	\N	THE SEASONS SUMMERTIME	0	1	2	13.300000000000001	13.300000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2966	15770	\N	THE SEASONS WINTERTIME	0	1	2	13.300000000000001	13.300000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2967	893	\N	THOMAS RADFORD SUNDAYS FANTASY	0	1	2	7.2999999999999998	7.2999999999999998	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2968	15677	\N	TIMM LONDON BLEND 1000	0	1	2	23.199999999999999	23.199999999999999	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2969	15679	\N	TIMM LONDON BLEND 250	0	1	2	22	22	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2970	16913	\N	TIMM LONDON BLEND 750	0	1	2	21.5	21.5	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2971	17859	\N	TORBEN DANSK 999	0	1	2	24.600000000000001	24.600000000000001	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2972	15788	\N	TORBEN DANSK BLACK CAVENDISH	0	1	2	12.800000000000001	12.800000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2973	16311	\N	TORBEN DANSK BLACK VELVET	0	1	2	13.800000000000001	13.800000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2974	15699	\N	TORBEN DANSK BLUE NOTE	0	1	2	13.800000000000001	13.800000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2975	16322	\N	TORBEN DANSK BURLEY	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2976	16315	\N	TORBEN DANSK KENTUCKY U.S.A.	0	1	2	14.699999999999999	14.699999999999999	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2977	16313	\N	TORBEN DANSK LATAKIA CYPERN	0	1	2	14	14	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2978	15787	\N	TORBEN DANSK N. 11 MELLOW MIXTURE	0	1	2	21.5	21.5	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2979	16316	\N	TORBEN DANSK N. 15 SAILOR"S FLAKE	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2980	15774	\N	TORBEN DANSK N. 2 ORIENTAL MIXTURE	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2981	15700	\N	TORBEN DANSK N. 3	0	1	2	12.800000000000001	12.800000000000001	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2982	15786	\N	TORBEN DANSK N. 4 ENGLISH MIXTURE	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2983	16307	\N	TORBEN DANSK ORIENT SPEZIALITAT	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2984	16324	\N	TORBEN DANSK VIRGINIA MYSORE 1,6	0	1	2	13.5	13.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2985	15678	\N	TREASURE OF IRELAND CONNEMARA	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2986	15685	\N	TREASURE OF IRELAND DONEGAL	0	1	2	13.4	13.4	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2987	15686	\N	TREASURE OF IRELAND GALWAY	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2988	15684	\N	TREASURE OF IRELAND KILLARNEY	0	1	2	12.5	12.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2989	15687	\N	TREASURE OF IRELAND LIMERICK	0	1	2	13	13	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2990	15692	\N	TREASURE OF IRELAND SHANNON	0	1	2	13.4	13.4	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2991	16911	\N	TREASURES OF IRELAND SHAMROCK	0	1	2	13.199999999999999	13.199999999999999	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2992	220	\N	TROOST AROMATIC CAVENDISH	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2993	749	\N	TROOST BLACK CAVENDISH	0	1	2	7.2000000000000002	7.2000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2994	48	\N	VAN DYCK MIXTURE	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2995	1834	\N	W.O. LARSEN A TRUE DELIGHT 5 GR.	0	1	2	0.25	0.25	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2996	2169	\N	W.O. LARSEN EDITION 2009	0	1	2	35	35	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
2997	1830	\N	W.O. LARSEN FINE & ELEGANT	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
2998	1831	\N	W.O. LARSEN FRESH & ELEGANT 5 GR.	0	1	2	0.25	0.25	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
2999	1237	\N	W.O. LARSEN MELLOW & TASTY	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
3000	1832	\N	W.O. LARSEN MELLOW & TASTY 5 GR.	0	1	2	0.25	0.25	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
3001	1235	\N	W.O. LARSEN SIMPLY UNIQUE	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
3002	1833	\N	W.O. LARSEN SIMPLY UNIQUE 5 GR.	0	1	2	0.25	0.25	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
3003	991	\N	W.O. LARSEN SWEET AROMATIC	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
3004	1239	\N	W.O. LARSEN TRUE DELIGHT	0	1	2	7.5	7.5	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
3005	1951	\N	WAZIR APPLE FLAVOUR	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3006	1955	\N	WAZIR CHERRY FLAVOUR	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3007	1954	\N	WAZIR GRAPE FLAVOUR	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3008	1956	\N	WAZIR ORANGE FLAVOUR	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3009	1957	\N	WAZIR PEACH FLAVOUR	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3010	1958	\N	WAZIR PEAR FLAVOUR	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3011	1960	\N	WAZIR PINEAPPLE FLAVOUR	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3012	1959	\N	WAZIR ROSE FLAVOUR	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3013	1952	\N	WAZIR STRAWBERRY FLAVOUR	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3014	1953	\N	WAZIR TUTTI FRUTTI FLAVOUR	0	1	2	2.6000000000000001	2.6000000000000001	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3015	1998	\N	WAZIR TWENTY APPLE FLAVOUR	0	1	2	0.80000000000000004	0.80000000000000004	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
3016	2001	\N	WAZIR TWENTY GRAPES FLAVOUR	0	1	2	0.80000000000000004	0.80000000000000004	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
3017	1999	\N	WAZIR TWENTY STRAWBERRY FLAVOUR	0	1	2	0.80000000000000004	0.80000000000000004	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
3018	2000	\N	WAZIR TWENTY TUTTI FRUTTI FLAVOUR	0	1	2	0.80000000000000004	0.80000000000000004	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
3019	17327	\N	WELLAUERS ENGLISH BLEND	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
3020	17326	\N	WELLAUERS FIRST CHOICE	0	1	2	11	11	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
3021	17328	\N	WELLAUERS LATAKIA	0	1	2	26	26	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
3022	2016	\N	AMIRAL 40	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3023	2040	\N	ARIZONA BLOND	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
3024	2039	\N	ARIZONA FULL FLAVOUR	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
3025	2157	\N	ARIZONA VIRGINIA	0	1	2	2.8500000000000001	2.8500000000000001	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
3026	1827	\N	BALI GOLDEN SHAG	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3027	1537	\N	BALI SHAG MELLOW VIRGINIA	0	1	2	2.8999999999999999	2.8999999999999999	\N	0	0	1	\N	0	Confezione da 25 grammi	2009-07-10	0	0	\N	\N	f
3028	1536	\N	BALI SHAG RICH VIRGINIA	0	1	2	2.8999999999999999	2.8999999999999999	\N	0	0	1	\N	0	Confezione da 25 grammi	2009-07-10	0	0	\N	\N	f
3029	17977	\N	BREBBIA ROLLING TOBACCO AMERICAN BLEND	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3030	359	\N	BROOKFIELD AMERICAN BLEND	0	1	2	4.5	4.5	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3031	918	\N	BROOKFIELD AMERICAN BLEND 200	0	1	2	19.5	19.5	\N	0	0	1	\N	0	Confezione da 200 grammi	2009-07-10	0	0	\N	\N	f
3032	NEW	\N	CAMEL FULL FLAVOUR	0	1	2	3.4500000000000002	3.4500000000000002	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
3033	2168	\N	CAMEL NATURAL FLAVOR	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3034	NEW	\N	CHESTERFIELD ROLL YOUR OWN	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
3035	1708	\N	DOMINGO CELESTE	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3036	1709	\N	DOMINGO CELESTE 200 GR.	0	1	2	18.5	18.5	\N	0	0	1	\N	0	Confezione da 200 grammi	2009-07-10	0	0	\N	\N	f
3037	1706	\N	DOMINGO ORIGINALE	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3038	1707	\N	DOMINGO ORIGINALE 200 GR.	0	1	2	18.5	18.5	\N	0	0	1	\N	0	Confezione da 200 grammi	2009-07-10	0	0	\N	\N	f
3039	2041	\N	DOMINGO VIRGINIA BLEND	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3040	706	\N	DRUM BRIGHT BLUE	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3041	336	\N	DRUM ORIGINAL	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3042	NEW	\N	DRUM SILVER	0	1	2	3.1499999999999999	3.1499999999999999	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
3043	361	\N	DRUM WHITE	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3044	430	\N	DRUM YELLOW	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3045	1973	\N	ELIXYR AMERICAN BLEND 40	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3046	1996	\N	FORTUNA AZUL	0	1	2	2.1000000000000001	2.1000000000000001	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
3047	1997	\N	FORTUNA AZUL	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3048	1849	\N	FORTUNA ROJO	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3049	1848	\N	FORTUNA ROJO	0	1	2	2.1000000000000001	2.1000000000000001	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
3050	212	\N	GAULOISES CAPORAL	0	1	2	5.7000000000000002	5.7000000000000002	\N	0	0	1	\N	0	Confezione da 50 grammi 	2009-07-10	0	0	\N	\N	f
3051	1795	\N	GOLDEN BLENDS AROMATIC SHAG	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3052	1538	\N	GOLDEN BLENDS VIRGINIA	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3053	1825	\N	GOLDEN BLENDS VIRGINIA 25	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 25 grammi	2009-07-10	0	0	\N	\N	f
3054	1638	\N	GOLDEN BLENDS VIRGINIA 5	0	1	2	0.54000000000000004	0.54000000000000004	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
3055	1796	\N	GOLDEN MIDWAY	0	1	2	4	4	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3056	801	\N	GOLDEN VIRGINIA	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3057	2156	\N	GOLDEN VIRGINIA 12,5G	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 12,5 grammi	2009-07-10	0	0	\N	\N	f
3058	1739	\N	GOLDEN VIRGINIA GREEN	0	1	2	3.1000000000000001	3.1000000000000001	\N	0	0	1	\N	0	Confezione da 25 grammi	2009-07-10	0	0	\N	\N	f
3059	1740	\N	GOLDEN VIRGINIA YELLOW	0	1	2	3.1000000000000001	3.1000000000000001	\N	0	0	1	\N	0	Confezione da 25 grammi	2009-07-10	0	0	\N	\N	f
3060	1915	\N	GOLDEN VIRGINIA YELLOW 40	0	1	2	4.9000000000000004	4.9000000000000004	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3061	1801	\N	HARVEST CHERRY	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3062	1802	\N	HARVEST COFFEE	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3063	1803	\N	HARVEST VANILLA	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3064	2113	\N	JPS VIRGINIA 40G	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3065	1850	\N	MAC BAREN AMERICAN BLEND	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3066	1853	\N	MAC BAREN CHERRY CHOICE PREMIUM	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3067	1851	\N	MAC BAREN ORIGINAL CHOICE PREMIUM	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3068	1852	\N	MAC BAREN VANILLA CHOICE PREMIUM	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3069	126	\N	MANILA	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
194	NEW	\N	MANITOU VIRGINIA GOLD	0	1	2	3.8500000000000001	3.8500000000000001	\N	0	0	1	\N	0	Confezione da 35 grammi	2009-07-10	0	0	\N	\N	f
3070	1846	\N	MATRIX	0	1	2	18	18	\N	0	0	1	\N	0	Confezione da 200 grammi	2009-07-10	0	0	\N	\N	f
3071	1847	\N	MATRIX	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3072	NEW	\N	Mc CHRYSTALS HAND ROLLING TOBACCO	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 25 grammi	2009-07-10	0	0	\N	\N	f
3073	NEW	\N	Mc CHRYSTALS HAND ROLLING TOBACCO DARK BLEND	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 25 grammi	2009-07-10	0	0	\N	\N	f
3074	NEW	\N	Mc CHRYSTALS HAND ROLLING TOBACCO LIGHT BLEND	0	1	2	3.25	3.25	\N	0	0	1	\N	0	Confezione da 25 grammi	2009-07-10	0	0	\N	\N	f
3075	1948	\N	MEMPHIS	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3076	NEW	\N	MYSELF	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3077	1963	\N	NATURAL AMERICAN SPIRIT	0	1	2	4.6500000000000004	4.6500000000000004	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
3078	279	\N	NAZIONALE	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3079	305	\N	NAZIONALE	0	1	2	2.2000000000000002	2.2000000000000002	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
3080	907	\N	OLD HOLBORN	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3081	1661	\N	OLD HOLBORN MINI	0	1	2	1.8	1.8	\N	0	0	1	\N	0	Confezione da 12,5 grammi	2009-07-10	0	0	\N	\N	f
3082	1662	\N	OLD HOLBORN MINI YELLOW	0	1	2	1.8	1.8	\N	0	0	1	\N	0	Confezione da 12,5 grammi	2009-07-10	0	0	\N	\N	f
3083	16	\N	OLD HOLBORN YELLOW	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3084	1929	\N	PALL MALL BLUE 70 GR	0	1	2	9.4499999999999993	9.4499999999999993	\N	0	0	1	\N	0	Confezione da 70 grammi	2009-07-10	0	0	\N	\N	f
3085	NEW	\N	PALL MALL BRIGHT FLAVOUR	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
3086	NEW	\N	PALL MALL FULL FLAVOUR	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
3087	1928	\N	PALL MALL RED 70 GR	0	1	2	9.4499999999999993	9.4499999999999993	\N	0	0	1	\N	0	Confezione da 70 grammi	2009-07-10	0	0	\N	\N	f
3088	2161	\N	PETER STUYVESANT GOLD 100G	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
3089	1972	\N	PETER STUYVESANT GOLD 20 GR.	0	1	2	2.1000000000000001	2.1000000000000001	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
3090	2160	\N	PETER STUYVESANT INTERNATIONAL 100G	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
3091	1971	\N	PETER STUYVESANT INTERNATIONAL 20 GR.	0	1	2	2.1000000000000001	2.1000000000000001	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
3092	1927	\N	PUEBLO	0	1	2	3.6000000000000001	3.6000000000000001	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
3093	2017	\N	PUEBLO 100	0	1	2	10.800000000000001	10.800000000000001	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
3094	1949	\N	PUEBLO 5	0	1	2	0.41999999999999998	0.41999999999999998	\N	0	0	1	\N	0	Confezione da 5 grammi	2009-07-10	0	0	\N	\N	f
3095	2075	\N	ROCKIES AMERICAN BLEND	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
3096	2078	\N	ROCKIES BLUE	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
3097	2076	\N	ROCKIES BLUE 100	0	1	2	9.5	9.5	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
3098	2079	\N	ROCKIES MENTHOL	0	1	2	3	3	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
3099	1741	\N	ROCKIES RED	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3100	1950	\N	ROCKIES VIRGINIA	0	1	2	3.7999999999999998	3.7999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3101	2077	\N	ROCKIES VIRGINIA BLEND	0	1	2	10	10	\N	0	0	1	\N	0	Confezione da 100 grammi	2009-07-10	0	0	\N	\N	f
3102	1946	\N	ROLL YOUR OWN AMERICAN BLEND	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3103	1947	\N	ROLL YOUR OWN HALFZWARE SHAG	0	1	2	4.2999999999999998	4.2999999999999998	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3105	59	\N	SAMSON EXTRA BRIGHT BLEND	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3106	506	\N	SAMSON GOLD BLEND	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3107	345	\N	SAMSON HALFZWARE SHAG ORIGINAL BLEND	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3108	1805	\N	SAMSON VIRGINIA BLEND	0	1	2	4.7000000000000002	4.7000000000000002	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3109	1824	\N	SAMSON VIRGINIA BLEND 25	0	1	2	2.9500000000000002	2.9500000000000002	\N	0	0	1	\N	0	Confezione da 25 grammi	2009-07-10	0	0	\N	\N	f
3110	1804	\N	SAMSON VIRGINIA BLEND MINI	0	1	2	1.05	1.05	\N	0	0	1	\N	0	Confezione da 12,5 grammi	2009-07-10	0	0	\N	\N	f
3111	NEW	\N	SAX N ROLL	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3112	1995	\N	TILBURY	0	1	2	2	2	\N	0	0	1	\N	0	Confezione da 20 grammi	2009-07-10	0	0	\N	\N	f
3113	930	\N	TILBURY AMERICAN BLEND	0	1	2	3.8999999999999999	3.8999999999999999	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3114	566	\N	VAN NELLE HALF ZWARE SHAG	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3115	2026	\N	VIRGINIA SPRING	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 25 grammi	2009-07-10	0	0	\N	\N	f
3116	258	\N	WEST RED	0	1	2	4.4000000000000004	4.4000000000000004	\N	0	0	1	\N	0	Confezione da 40 grammi	2009-07-10	0	0	\N	\N	f
3117	NEW	\N	WINSTON CLASSIC RED	0	1	2	3.1499999999999999	3.1499999999999999	\N	0	0	1	\N	0	Confezione da 30 grammi	2009-07-10	0	0	\N	\N	f
198	819		MARLBORO 100S	5	1	2	4.4500000000000002	4.4500000000000002		0	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	0	\N	\N	f
263	183	8027463101831	MS BIONDE	0	1	2	1.8500000000000001	1.8500000000000001		0	0	1		10	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	20	\N	\N	f
3104	695	8723900103795	SAMSON BRIGHT BLEND	0	1	2	4.7000000000000002	4.7000000000000002		0	0	1		0	CONFEZIONE DA 40 GRAMMI	\N	0	0	\N	\N	f
467	479	8710622512257	AGIO MINI MEHARIS BRASIL	0	1	2	2.7000000000000002	2.7000000000000002		0	0	1		0	CONFEZIONE DA 10 PEZZI	\N	0	0	\N	\N	f
3119	2179	\N	AUSTIN BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
9	1585	\N	AUSTIN GOLD	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
10	1586	\N	AUSTIN RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
3120	2180	\N	AUSTIN RED 100S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
31	2164	\N	BLACK DEVIL FINEST FLAVOUR	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
37	1689	\N	BURTON ORIGINAL	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
38	1691	\N	BURTON SILVER	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
65	1692	\N	CIGARONNE CLASSIC GOLD	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
66	1693	\N	CIGARONNE CLASSIC SILVER	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
69	1696	\N	CIGARONNE MINI GOLD	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
70	1697	\N	CIGARONNE MINI SILVER	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
3121	NEW	\N	CLEOPATRA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
73	NEW	\N	CLEVELAND FULL FLAVOUR	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
74	NEW	\N	CLEVELAND LIGHTS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
107	1656	\N	DUCAL BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
108	1655	\N	DUCAL FILTER	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
3122	2232	\N	EGALITE BLANCHES	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
123	1480	\N	ELIXYR	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
124	1817	\N	ELIXYR EXTRA TASTE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
126	1811	\N	ELIXYR FINE TASTE 100	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
127	1810	\N	ELIXYR FULL FLAVOUR 100	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
128	1719	\N	ELIXYR MENTHOL	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
3123	2233	\N	FRATERNITE BLONDES	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
3124	2218	\N	FUTURA ORO	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
3125	NEW	\N	GARETT BLU	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
3126	NEW	\N	GARETT SILVER	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
153	NEW	\N	GEORGE KARELIAS AND SONS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
157	154	\N	JPS BLACK ORIGINAL	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
158	293	\N	JPS RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
159	300	\N	JPS SILVER	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
160	229	\N	JPS WHITE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
161	911	\N	KARELIA LIGHTS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
162	923	\N	KARELIA SLIMS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
3127	2234	\N	LIBERTE BRUNES	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
195	NEW	\N	MARANELLO EDIZIONE NERA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
196	NEW	\N	MARANELLO N.1	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
197	NEW	\N	MARANELLO N.2	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
217	1791	\N	MARYLAND BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
218	2011	\N	MARYLAND MENTHOL	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
219	1792	\N	MARYLAND RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
220	1776	\N	MATRIX BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
242	1816	\N	MOHAWK BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
243	1793	\N	MOHAWK RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
249	NEW	\N	MPV 100S BIANCA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
250	NEW	\N	MPV 100S BLU	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
251	NEW	\N	MPV 100S NERA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
252	NEW	\N	MPV BIANCA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
253	NEW	\N	MPV BLU	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
254	NEW	\N	MPV NERA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione cartoccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
301	1645	\N	MUSTANG GOLD	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
302	1907	\N	MUSTANG GOLD 100S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
303	1670	\N	MUSTANG RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
304	1906	\N	MUSTANG RED 100S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
305	1908	\N	MUSTANG SILVER	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
307	1931	\N	NA-TUR BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
308	1932	\N	NA-TUR ORANGE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
309	1933	\N	NA-TUR RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
320	NEW	\N	OMNI GOLD KING SIZE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
321	NEW	\N	OMNI SILVER 100S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
3128	2207	\N	PARISIENNE ORANGE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
358	NEW	\N	POLICE BLU	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
359	NEW	\N	POLICE EDIZIONE ROSSA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
360	NEW	\N	POLICE ROSSA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
362	1100	\N	QUEST 1	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
363	1501	\N	QUEST 2	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
364	NEW	\N	QUEST 3	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
367	806	\N	RANGER FILTER MILD	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
368	NEW	\N	RANGER MILD FILTER 100S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
370	1241	\N	REYNOLDS BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
371	1240	\N	REYNOLDS RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
372	1587	\N	REYNOLDS SILVER	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
373	1588	\N	ROCKIES	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
374	1807	\N	ROCKIES BLUE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
375	NEW	\N	ROMA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
376	NEW	\N	RONHILL LIGHTS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
377	NEW	\N	RONHILL LIGHTS 100S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
378	2030	\N	RONHILL RICH	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
379	2044	\N	RONHILL SLIMS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
380	2109	\N	RONHILL SLIMS MENTHOL	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
381	NEW	\N	RONHILL ULTRA	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
382	2029	\N	RONHILL WHITE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
3129	NEW	\N	SOPRANO BLACK	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
3130		\N	SOPRANO GREY	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
3131	NEW	\N	SOPRANO MENTHOL	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
3132	NEW	\N	SOPRANO RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
3133	NEW	\N	SOPRANO WHITE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
410	1818	\N	THOMAS RADFORD SUNDAYS FANTASY	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
3134	NEW	\N	VANITY	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-18	0	0	\N	\N	f
416	1912	\N	VICTORY DE LUXE SLIMS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
417	1909	\N	VICTORY EXCLUSIVE BLACK	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
418	1910	\N	VICTORY EXCLUSIVE WHITE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
419	1911	\N	VICTORY SLIMS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
429	NEW	\N	WALTER WOLF	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
430	NEW	\N	WALTER WOLF LIGHTS	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
431	NEW	\N	WALTER WOLF LIGHTS 100S	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
453	2069	\N	YESMOKE RED	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
456	2072	\N	YESMOKE WHITE	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	Confezione astuccio da 20 pezzi	2009-07-10	0	0	\N	\N	f
493	2140	\N	CAFE CREME	0	1	2	1.3999999999999999	1.3999999999999999	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
492	384	\N	CAFE CREME	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
495	936	\N	CAFE CREME AROME	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
494	2141	\N	CAFE CREME AROME	0	1	2	1.3999999999999999	1.3999999999999999	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
497	900	\N	CAFE CREME BLUE	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
507	2036	\N	CAFE CREME NOIR	0	1	2	2.7999999999999998	2.7999999999999998	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
508	2143	\N	CAFE CREME NOIR	0	1	2	1.3999999999999999	1.3999999999999999	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
576	33	\N	MERCATOR MINI	0	1	2	2.9500000000000002	2.9500000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
577	836	\N	MERCATOR MINI MELLOW	0	1	2	2.9500000000000002	2.9500000000000002	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
618	1592	\N	SUNRISE TROPICAL TASTE	0	1	2	2.75	2.75	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
619	1593	\N	SUNRISE TROPICAL TASTE FILTER	0	1	2	2.75	2.75	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
661	1533	\N	CHE AROMATIC	0	1	2	5.9500000000000002	5.9500000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
662	954	\N	CHE BLUE	0	1	2	5.9500000000000002	5.9500000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
663	273	\N	CHE CIGARILLOS	0	1	2	5.9500000000000002	5.9500000000000002	\N	0	0	1	\N	0	Confezione da 20 pezzi	2009-07-10	0	0	\N	\N	f
702	1821	\N	HENRI WINTERMANS ROYALES	0	1	2	2.2999999999999998	2.2999999999999998	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
769	239	\N	MERCATOR JUPITER	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
770	3	\N	MERCATOR JUPITER MELLOW	0	1	2	2.7000000000000002	2.7000000000000002	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
804	1102	\N	ANTICO TOSCANO	0	1	2	1.6000000000000001	1.6000000000000001	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
803	413	\N	ANTICO TOSCANO	0	1	2	8	8	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
805	1794	\N	ANTICO TOSCANO 24 SIGARI	0	1	2	38.399999999999999	38.399999999999999	\N	0	0	1	\N	0	Confezione da 24 pezzi	2009-07-10	0	0	\N	\N	f
806	415	\N	ANTICO TOSCANO 40 SIGARI	0	1	2	64	64	\N	0	0	1	\N	0	Confezione da 40 pezzi	2009-07-10	0	0	\N	\N	f
1583	217	\N	HENRI WINTERMANS CORONA DE LUXE	0	1	2	1.7	1.7	\N	0	0	1	\N	0	Confezione da 1 pezzo	2009-07-10	0	0	\N	\N	f
1582	894	\N	HENRI WINTERMANS CORONA DE LUXE	0	1	2	3.3999999999999999	3.3999999999999999	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
1584	230	\N	HENRI WINTERMANS EXCELLENTES	0	1	2	4.5999999999999996	4.5999999999999996	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
1585	1819	\N	HENRI WINTERMANS HALF CORONA	0	1	2	3.5	3.5	\N	0	0	1	\N	0	Confezione da 5 pezzi	2009-07-10	0	0	\N	\N	f
2465	542	\N	TOSCANO ANTICA RISERVA	0	1	2	21	21	\N	0	0	1	\N	0	Confezione da 10 pezzi	2009-07-10	0	0	\N	\N	f
2464	409	\N	TOSCANO ANTICA RISERVA	0	1	2	4.2000000000000002	4.2000000000000002	\N	0	0	1	\N	0	Confezione da 2 pezzi	2009-07-10	0	0	\N	\N	f
172	1303	40235042	L&M BLUE LABEL KS	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		5	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	10	10	\N	f
173	1313	87248784	L&M RED LABEL KS	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	5	\N	f
45	377	40329659	CAMEL FILTERS	0	1	2	2	2		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	20	20	\N	f
328	668	40318370	PALL MALL BLUE KS 10S	0	1	2	1.8500000000000001	1.8500000000000001		0.20000000000000001	0	1		20	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	40	20	\N	f
281	875	87248050	MULTIFILTER PHILIP MORRIS BLU 100S	0	1	2	4.2999999999999998	4.2999999999999998		0.20000000000000001	0	1		0	CONFEZIONE CARTOCCIO DA 20 PEZZI	\N	0	0	10	\N	f
203	2215	80751380	MARLBORO COMPACT	0	1	2	2	2		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	20	20	\N	f
17	1716	4033100012044	BENSON & HEDGES AMERICAN BLUE 100 S	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		5	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	10	10	\N	f
356	877	87248869	PHILIP MORRIS SLIM ROSSA	0	1	2	4.2999999999999998	4.2999999999999998		0.20000000000000001	0	1		5	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	10	20	\N	f
104	913	40235875	DIANA SLIM BLU	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	40	10	\N	f
351	37	87292398	PHILIP MORRIS BLU KS	0	1	2	2.1499999999999999	2.1499999999999999		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	20	20	\N	f
188	1835	40318455	LUCKY STRIKE RED	0	1	2	2	2		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	20	20	\N	f
4	853	8027463108533	ALFA FILTRO	0	1	2	3.8999999999999999	3.8999999999999999		0.20000000000000001	0	1		5	CONFEZIONE CARTOCCIO DA 20 PEZZI	\N	0	10	10	\N	f
342	1201	42067252	PETER STUYVESANT BLUE	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	10	\N	f
221	1777	59919131	MATRIX RED	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		0	Confezione astuccio da 20 pezzi	\N	0	0	10	\N	f
208	618	87248579	MARLBORO GOLD KS	0	1	2	4.4000000000000004	4.4000000000000004		0.20000000000000001	0	1		5	CONFEZIONE CARTOCCIO DA 20 PEZZI	\N	0	10	10	\N	f
355	367	87248975	PHILIP MORRIS SLIM BLU	0	1	2	4.2999999999999998	4.2999999999999998		0.20000000000000001	0	1		5	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	10	20	\N	f
557	1288	3258170208239	HAMLET FINE AROMA MINI CIGARS FILTER	0	1	2	1	1		0.20000000000000001	0	1		5	CONFEZIONE DA 5 PEZZI	\N	0	10	20	\N	f
2452	410	8027463104108	TOSCANELLO	0	1	2	3.3999999999999999	3.3999999999999999		0	0	1		0	CONFEZIONE DA 5 PEZZI	\N	0	0	\N	\N	f
3135	2212	4069400184310	ROLL'S RED	0	1	2	2.7000000000000002	2.7000000000000002		0.5	0	1		5	CONFEZIONE ASTUCCIO DA 20 PZ	2009-07-18	0	10	10	\N	f
81	728	40307381	DAVIDOFF CLASSIC	0	1	2	4.5	4.5		0	0	1		5	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	10	10	\N	f
445	1784	40331423	WINSTON BLUE 100S	0	1	2	3.7000000000000002	3.7000000000000002		0	0	1		5	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	10	10	\N	f
131	653	8027463106539	ESPORTAZIONE FILTRO	0	1	2	3.8999999999999999	3.8999999999999999		0	0	1		5	CONFEZIONE CARTOCCIO DA 20 PEZZI	\N	0	10	10	\N	f
291	560	87248098	MURATTI AMBASSADOR KS	0	1	2	4.2999999999999998	4.2999999999999998		0	0	1		5	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	10	10	\N	f
346	348	40307947	PETER STUYVESANT INTERNATIONAL	0	1	2	3.7000000000000002	3.7000000000000002		0	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	10	\N	f
213	396	87248586	MARLBORO KS	0	1	2	4.4000000000000004	4.4000000000000004		0	0	1		5	CONFEZIONE CARTOCCIO DA 20 PEZZI	\N	0	10	10	\N	f
100	234	40235172	DIANA ROSSA KS	0	1	2	3.7000000000000002	3.7000000000000002		0	0	1		10	CONFEZIONE CARTOCCIO DA 20 PEZZI	\N	0	20	10	\N	f
201	1785	A	MARLBORO BLEND 29	0	1	2	4.4000000000000004	4.4000000000000004		0	0	1		0	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	0	\N	\N	f
306	54	8027463100544	N80 FILTRO	0	1	2	3.8999999999999999	3.8999999999999999		0.20000000000000001	0	1		10	CONFEZIONE CARTOCCIO DA 20 PEZZI	\N	0	20	10	\N	f
343	352	40305028	PETER STUYVESANT GOLD	0	1	2	3.7000000000000002	3.7000000000000002		0	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	10	\N	f
186	451	87196429	LUCKY STRIKE RED	0	1	2	4	4		0	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	10	\N	f
262	177	8027463101770	MS BIONDE	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		80	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	90	10	\N	f
93	406	87248319	DIANA BLU KS	0	1	2	3.7000000000000002	3.7000000000000002		0	0	1		20	CONFEZIONE CARTOCCIO DA 20 PEZZI	\N	0	40	10	\N	f
259	857	8027463108571	MS BIANCHE	0	1	2	3.7000000000000002	3.7000000000000002		0	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	10	\N	f
19	1530	90228643	BENSON & HEDGES AMERICAN RED	0	1	2	1.8500000000000001	1.8500000000000001		0	0	1		10	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	20	20	\N	f
16	520	3258170088909	BENSON & HEDGES AMERICAN BLUE	0	1	2	3.7000000000000002	3.7000000000000002		0	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	10	\N	f
57	5	87248210	CHESTERFIELD BLU KS	0	1	2	2	2		0	0	1		10	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	20	20	\N	f
352	553	87248517	PHILIP MORRIS FILTER KINGS	0	1	2	4.2999999999999998	4.2999999999999998		0	0	1		5	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	10	10	\N	f
449	1783	40329222	WINSTON CLASSIC 100S	0	1	2	3.7000000000000002	3.7000000000000002		0	0	1		5	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	10	10	\N	f
3139	0054	0054	CACCIA AI TESORI	2.7000000000000002	1	2	3	3	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3141	0050	0050	GRATTA QUIZ	2.7000000000000002	1	2	3	3	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3142	0062	0062	IL TESORO DEL FARAONE	9	1	2	10	10	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3143	0043	0043	PRENDI TUTTO	4.5	1	2	5	5	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3144	0038	0038	COLPO VINCENTE	9	1	2	10	10	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3145	0028	0028	MEGAMILIARDARIO	9	1	2	10	10	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3147	0036	0036	INDIANA JONES	2.7000000000000002	1	2	3	3	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3150	0014	0014	STELLA STELLINA	2.7000000000000002	1	2	3	3	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3151	0039	0039	MERCANTE IN FIERA	1.8	1	2	2	2	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3152	0035	0035	OROSCOPO	1.8	1	2	2	2	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3153	0004	0004	DADO MATTO	1.8	1	2	2	2	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3154	0033	0033	LA FORTUNA GIRA	1.8	1	2	2	2	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3155	0001	0001	BATTI IL BANCO	1.8	1	2	2	2	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3156	0041	0041	UN MARE DI FORTUNA	0.90000000000000002	1	2	1	1	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3158	0008	0008	SETTE E MEZZO	0.90000000000000002	1	2	1	1	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3140	0051	0051	SPIAGGIA D'ORO	1.8	1	2	2	2	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3149	0025	0025	GALLINA DALLE UOVA D'ORO	2.7000000000000002	1	2	3	3	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3146	0057	0057	MILIARDARIO	4.5	1	2	5	5	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
3157	0316	0316	PORTAFORTUNA	0.90000000000000002	1	2	1	1	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
240	497	87248623	MERIT GIALLA KS	0	1	2	2.1499999999999999	2.1499999999999999		0.20000000000000001	0	1		20	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	40	20	\N	f
239	997	87248289	MERIT GIALLA KS	0	1	2	4.2999999999999998	4.2999999999999998		0.20000000000000001	0	1		70	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	90	10	\N	f
44	264	40329055	CAMEL FILTERS	0	1	2	4	4		0.20000000000000001	0	1		40	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	50	10	\N	f
61	96	87248678	CHESTERFIELD KS	0	1	2	4	4		0.20000000000000001	0	1		20	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	30	10	\N	f
288	574	87248043	MURATTI AMBASSADOR BLU KS	0	1	2	4.2999999999999998	4.2999999999999998		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	10	\N	f
59	201	87248074	CHESTERFIELD BLU KS	0	1	2	4	4		0.20000000000000001	0	1		30	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	50	10	\N	f
448	91	40329253	WINSTON CLASSIC	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		5	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	10	10	\N	f
215	259	87248982	MARLBORO MX4 KS	0	1	2	4.2000000000000002	4.2000000000000002		0.20000000000000001	0	1		0	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	0	10	\N	f
32	2020	8710151546587	BLACK DEVIL SPECIAL FLAVOUR	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		5	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	10	10	\N	f
181	488	8027463104887	LINDA	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		30	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	50	10	\N	f
41	478	40331591	CAMEL BLUE	0	1	2	4	4		0.20000000000000001	0	1		30	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	40	10	\N	f
54	552	40329178	CAMEL SILVER	0	1	2	4	4		0.20000000000000001	0	1		20	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	30	10	\N	f
441	2065	42138105	WINSTON BALANCED BLUE SUPERSLIMS	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		30	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	40	10	\N	f
231	81	87248234	MERIT BIANCA SLIM	0	1	2	4.2999999999999998	4.2999999999999998		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	10	\N	f
42	489	40329192	CAMEL BLUE	0	1	2	2	2		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	20	20	\N	f
202	2107	80738619	MARLBORO COMPACT	0	1	2	4	4		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	10	\N	f
95	654	87248159	DIANA BLU KS	0	1	2	1.8500000000000001	1.8500000000000001		0.20000000000000001	0	1		20	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	40	20	\N	f
96	630	87248715	DIANA BLU KS	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		60	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	80	10	\N	f
209	2214	80750130	MARLBORO GOLD TOUCH KS	0	1	2	4	4		0.20000000000000001	0	1		40	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	50	10	\N	f
270	231	8027463102319	MS CLUB SLIM	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		30	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	40	10	\N	f
103	233	40235028	DIANA ROSSA KS	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		60	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	70	10	\N	f
212	395	87248593	MARLBORO KS	0	1	2	4.4000000000000004	4.4000000000000004		0.20000000000000001	0	1		40	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	50	10	\N	f
102	621	87248227	DIANA ROSSA KS	0	1	2	1.8500000000000001	1.8500000000000001		0.20000000000000001	0	1		20	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	40	20	\N	f
330	526	40318233	PALL MALL BLUE KS 20S	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		20	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	30	10	\N	f
443	338	40329574	WINSTON BLUE	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		40	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	50	10	\N	f
269	649	8027463106492	MS CLUB BIANCA	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		20	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	30	10	\N	f
261	176	8027463101763	MS BIONDE	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		30	CONFEZIONE CARTOCCIO DA 20 PEZZI	\N	0	50	10	\N	f
331	1787	8027463117870	PALL MALL PACIFIC BAY (BLUE)	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		5	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	10	10	\N	f
333	716	40318363	PALL MALL RED KS 10S	0	1	2	1.8500000000000001	1.8500000000000001		0.20000000000000001	0	1		20	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	40	20	\N	f
350	530	87248296	PHILIP MORRIS BLU KS	0	1	2	4.2999999999999998	4.2999999999999998		0.20000000000000001	0	1		5	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	10	10	\N	f
211	397	87248500	MARLBORO KS	0	1	2	2.2000000000000002	2.2000000000000002		0.20000000000000001	0	1		20	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	20	20	\N	f
286	984	87248746	MULTIFILTER PHILIP MORRIS SLIMS	0	1	2	4.2999999999999998	4.2999999999999998		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO IN COLORAZIONE ROSSA DA 20 PEZZI	\N	0	10	10	\N	f
444	1774	40329918	WINSTON BLUE	0	1	2	1.8500000000000001	1.8500000000000001		0.20000000000000001	0	1		20	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	20	20	\N	f
99	1982	80729891	DIANA ROSSA 100S	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	2009-07-10	0	10	0	\N	f
14	1531	90228667	BENSON & HEDGES AMERICAN BLUE	0	1	2	1.8500000000000001	1.8500000000000001		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	20	20	\N	f
20	676	3258170085519	BENSON & HEDGES AMERICAN RED	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	10	\N	f
90	460	40235479	DIANA AZZURRA KS	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		40	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	50	10	\N	f
335	531	40313948	PALL MALL RED KS 20S	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	10	\N	f
337	1786	8027463117863	PALL MALL SUNSET BOULEVARD (AMBER)	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	10	\N	f
144	604	8027463106041	FUTURA	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		40	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	50	10	\N	f
575	1842	5998900507123	MATRIX	0	1	2	2	2		0.5	0	1		40	CONFEZIONE DA 20 PEZZI	\N	0	50	10	\N	f
314	634	8027463106348	NAZIONALI	0	1	2	3.8999999999999999	3.8999999999999999		0.20000000000000001	0	1		20	CONFEZIONE CARTOCCIO DA 20 PEZZI	\N	0	30	10	\N	f
132	887	8027463108878	EURA	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		15	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	20	10	\N	f
278	992	8027463109929	MS ROSSE	0	1	2	1.8500000000000001	1.8500000000000001		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	20	0	\N	f
276	852	8027463108526	MS ROSSE	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		20	CONFEZIONE CARTOCCIO DA 20 PEZZI	\N	0	30	10	\N	f
277	993	8027463109936	MS ROSSE	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		20	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	30	10	\N	f
62	981	87248838	CHESTERFIELD KS	0	1	2	2	2		0.20000000000000001	0	1		10	CONFEZIONE ASTUCCIO DA 10 PEZZI	\N	0	20	20	\N	f
125	1481	54503571	ELIXYR FINE TASTE	0	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		20	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	30	10	\N	f
3136	\N	REPARTO 2	REPARTO 2	0	1	2	0	0	\N	0	0	3	\N	\N	\N	2009-07-18	\N	\N	0	\N	f
3137	\N	REPARTO 3	REPARTO 3	0	1	2	0	0	\N	0	0	3	\N	\N	\N	2009-07-18	\N	\N	0	\N	f
3138	\N	REPARTO 4	REPARTO 4	0	1	2	0	0	\N	0	0	3	\N	\N	\N	2009-07-18	\N	\N	0	\N	f
3159		CAFFE	CAFFE	0	1	2	0.59999999999999998	0.59999999999999998	\N	0	0	2	\N	\N		\N	\N	\N	\N	1	f
696	NEW	80274631178633	GOLD PROVA	0	1	2	5.4000000000000004	5.4000000000000004	\N	0	0	1	\N	0	CONFEZIONE DA 20 PEZZI	2009-07-10	0	0	\N	\N	f
729	17934	000444	MONTECRISTO CLUB	0	1	2	8	8	\N	0	0	1	\N	0	CONFEZIONE DA 10 PEZZI	2009-07-10	0	0	\N	\N	f
3161	2098	DFXCGV	AFRICAINE SENZA FILTRO	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	CONFEZIONE CARTOCCIO DA 20 PEZZI	2009-07-10	0	0	\N	\N	f
207	9	87248265	MARLBORO GOLD KS	0	1	2	4.4000000000000004	4.4000000000000004		0.20000000000000001	0	1		80	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	90	10	2	f
22	914	5010175802250	BENSON & HEDGES AMERICAN WHITE	13	1	2	3.7000000000000002	3.7000000000000002		0.20000000000000001	0	1		30	CONFEZIONE ASTUCCIO DA 20 PEZZI	\N	0	50	10	\N	f
2752	265	1234567890	COMUNE	120	1	2	4	4	\N	0	0	1	\N	0	CONFEZIONE DA 40 GRAMMI	2009-07-10	0	0	\N	\N	f
3163	WWW	WWWQ	WWW	11	1	1	110	110	\N	\N	\N	2	\N	\N		\N	\N	\N	\N	\N	f
2	742342	3333333	821 WHITE	10	1	1	4	4	\N	0	0	2	\N	0	CONFEZIONE ASTUCCIO DA 20 PEZZIDDDDD	2009-07-10	0	0	\N	1	f
464	75	4058032580PBC	AGIO MEHARIS ECUADOR	0	1	2	3.3999999999999999	3.3999999999999999	\N	0	0	1	\N	0	CONFEZIONE DA 10 PEZZI	2009-07-10	0	0	\N	\N	f
463	775	8681357068PBC	AGIO MEHARI’S JAVA	0	1	2	3.3999999999999999	3.3999999999999999	\N	0	0	1	\N	0	CONFEZIONE DA 10 PEZZI	2009-07-10	0	0	\N	\N	f
462	527	1683691466PBC	AGIO JUNIOR TIP	0	1	2	2	2	\N	0	0	1	\N	0	CONFEZIONE DA 5 PEZZI	2009-07-10	0	0	\N	\N	f
3160	2098	4835836881PBC	AFRICAINE SENZA FILTRO	0	1	2	3.7000000000000002	3.7000000000000002	\N	0	0	1	\N	0	CONFEZIONE CARTOCCIO DA 20 PEZZI	2009-07-10	0	0	\N	\N	f
3148	0034	2724357068PBC	AFFARI TUOI FASFDSDFSD	3	1	2	3	3	\N	0	0	4	\N	0		2009-08-20	0	0	0	\N	f
\.


--
-- TOC entry 2003 (class 0 OID 34730)
-- Dependencies: 1384
-- Data for Name: aspetto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY aspetto (idaspetto, nome) FROM stdin;
0	VISTA
\.


--
-- TOC entry 2024 (class 0 OID 35774)
-- Dependencies: 1409
-- Data for Name: banca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY banca (idbanca, ragione_sociale, note) FROM stdin;
\.


--
-- TOC entry 2025 (class 0 OID 35781)
-- Dependencies: 1410
-- Data for Name: carichi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY carichi (idcarico, idfornitore, iddocumento, data_carico, ora_carico, note, num_documento, data_documento, totale_documento, sospeso, rif_doc, sconto, iva_documento, ins_pn, riferimento_ordine) FROM stdin;
\.


--
-- TOC entry 1996 (class 0 OID 34686)
-- Dependencies: 1375
-- Data for Name: carico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY carico (idcarico, idfornitore, data_carico, ora_carico, note, iddocumento, num_documento, data_documento, totale_documento, sospeso, rif_doc, sconto, iva_documento, ins_pn, riferimento_ordine) FROM stdin;
1	0	2010-02-17	03:15:11.406		2	12	2010-02-15	11.109999999999999	0	-1	0	1	0	0
2	0	2010-02-26	18:46:25.562		2	12W	2010-02-26	240	0	-1	0	1	0	0
3	0	2010-02-26	21:30:43		2	123	2010-02-26	132	0	-1	0	1	0	0
0	\N	\N	\N	\N	\N	\N	\N	\N	0	-1	0	1	0	\N
4	0	2010-05-04	02:24:01.718		3	1222	2010-05-04	300	0	-1	0	1	0	0
\.


--
-- TOC entry 2004 (class 0 OID 34732)
-- Dependencies: 1385
-- Data for Name: categoria; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categoria (id, data_creazione, descrizione, note) FROM stdin;
1	\N	TABACCHI	\N
2	\N	BAR	\N
3	\N	VARIE	\N
\.


--
-- TOC entry 2005 (class 0 OID 34737)
-- Dependencies: 1386
-- Data for Name: causale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY causale (idcausale, nome) FROM stdin;
0	VENDITA
\.


--
-- TOC entry 2000 (class 0 OID 34709)
-- Dependencies: 1380
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY cliente (idcliente, data_inserimento, nome, cognome, piva, codfisc, via, cap, citta, tel, cell, fax, email, website, note, data_nascita, num_doc, rilasciato_il, nato_a, intestazione, provincia, documento, rilasciato_da, nazionalita, rilasciato_di) FROM stdin;
0	\N	BANCO	BANCO	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
1	2009-11-20	AABBBBBBB	A9876	AAAAAAAAAAAAAA	AA	AAAAAAAAAAAAAA	AA	AAAAAAAAAAAAAAAAAAAA	AAAAAAAAAAAAAA	AAAAAAAAAAAAAAA	AAAAAAAAAAAAA	AAAAAAAAAAAAAAAAAAAAA	AAAAAAAAAA	AAKJHKHKJHKHJHKYYYYYYYY	\N	\N	\N	\N	\N	36	\N	\N	\N	\N
\.


--
-- TOC entry 2026 (class 0 OID 35785)
-- Dependencies: 1411
-- Data for Name: clienti; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY clienti (idcliente, nazionalita, documento, provincia, rilasciato_da, data_inserimento, nome, cognome, piva, codfisc, via, cap, citta, tel, cell, fax, email, website, note, data_nascita, num_doc, rilasciato_il, nato_a, intestazione, rilasciato_di) FROM stdin;
\.


--
-- TOC entry 2022 (class 0 OID 35514)
-- Dependencies: 1407
-- Data for Name: codici_iva; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY codici_iva (id, codice, percentuale, descrizione, descrizione_breve) FROM stdin;
1	20	20	Iva 20%	
2	10	10	Iva 10%	
3	4	4	Iva 4%	
4	8	0	Non imponibile art.8	Non Imp. art.8
5	2	0	Non imponibile art.2	Non Imp. art.2
6	15	0	Esente IVA art.15	Es.IVA art.15
7	50	0	Esente IVA Art. 1 Fin.2008	Es.IVA Fin2008
\.


--
-- TOC entry 2027 (class 0 OID 35792)
-- Dependencies: 1412
-- Data for Name: conto_bancario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY conto_bancario (idconto, idbanca, abi, cab, cc, iban) FROM stdin;
\.


--
-- TOC entry 2006 (class 0 OID 34739)
-- Dependencies: 1387
-- Data for Name: destinazione; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY destinazione (id, ragione_sociale, piva, cofice_fiscale, indirizzo, cap, localita, provincia, paese, telefono, fax, email, cellulare, note) FROM stdin;
\.


--
-- TOC entry 2028 (class 0 OID 35796)
-- Dependencies: 1413
-- Data for Name: dettagli_documenti; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dettagli_documenti (id, id_documento, descrizione, aliquota, qta, prezzo, prezzo_totale, imponibile, imposta) FROM stdin;
\.


--
-- TOC entry 2029 (class 0 OID 35800)
-- Dependencies: 1414
-- Data for Name: dettaglio_carichi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dettaglio_carichi (idarticolo, idcarico, qta, prezzo_acquisto, sconto) FROM stdin;
\.


--
-- TOC entry 1997 (class 0 OID 34696)
-- Dependencies: 1376
-- Data for Name: dettaglio_carico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dettaglio_carico (idarticolo, idcarico, qta, prezzo_acquisto, sconto) FROM stdin;
3163	1	1	11	0
2	2	20	12	0
2	3	11	10	0
3148	4	100	3	0
20	4	111	0	0
\.


--
-- TOC entry 2030 (class 0 OID 35804)
-- Dependencies: 1415
-- Data for Name: dettaglio_ordine_manuale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dettaglio_ordine_manuale (id, ordine, descrizione, qta, sconto, prezzo_vendita, iva) FROM stdin;
\.


--
-- TOC entry 2031 (class 0 OID 35808)
-- Dependencies: 1416
-- Data for Name: dettaglio_ordini; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dettaglio_ordini (idordine, idarticolo, qta, sconto, prezzo_acquisto, prezzo_vendita, iva) FROM stdin;
\.


--
-- TOC entry 2001 (class 0 OID 34714)
-- Dependencies: 1381
-- Data for Name: dettaglio_scarico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dettaglio_scarico (idordine, idarticolo, qta, sconto, prezzo_acquisto, prezzo_vendita, iva) FROM stdin;
0	3163	0	0	\N	\N	1
2	3163	1	0	0	0	1
0	2	0	0	\N	\N	1
7	2	4	0	0	0	1
8	2	16	0	0	0	1
\.


--
-- TOC entry 2007 (class 0 OID 34744)
-- Dependencies: 1388
-- Data for Name: dettaglio_scarico_manuale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dettaglio_scarico_manuale (id, descrizione, qta, sconto, prezzo_vendita, iva, ordine) FROM stdin;
\.


--
-- TOC entry 2032 (class 0 OID 35812)
-- Dependencies: 1417
-- Data for Name: documenti; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY documenti (id, num_documento, data_documento, tipo, stato, imponibile_netto, sconto, imponibile_scontato, imposta, totale_documento) FROM stdin;
\.


--
-- TOC entry 2008 (class 0 OID 34751)
-- Dependencies: 1389
-- Data for Name: documento_cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY documento_cliente (id, descrizione, abbreviazione) FROM stdin;
1	NESSUNO	NN
2	PATENTE DI GUIDA	PAT
3	PASSAPORTO	PAS
4	TESSERA CC	TCC
5	CARTA D'IDENTITÀ	CI
6	TESSERA	\N
\.


--
-- TOC entry 2009 (class 0 OID 34756)
-- Dependencies: 1390
-- Data for Name: ente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ente (idente, descrizione) FROM stdin;
2	M.C.T.C.
3	PREFETTURA
4	U.C.O.
5	GOVERNO
6	QUESTURA
7	CONSOLATO
8	AUTORITÀ
9	REGIONE CARABINIERI
10	COMUNE
1	NESSUNO
11	FUNZIONARIO
\.


--
-- TOC entry 1998 (class 0 OID 34699)
-- Dependencies: 1377
-- Data for Name: fornitore; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY fornitore (idfornitore, data_inserimento, nome, piva, codfisc, via, cap, citta, tel, cell, fax, email, website, note, codbarre, provincia) FROM stdin;
1	\N	VUIIIIIIIIIIIIIIIIIIIIII	12334	GGGGGG	NNNN	87040	ACRI	EYTRET	RTRT	TRWR	QTRWETRQ	WRTWE	QTEWTRE	\N	33
0	\N	TRYTR	EQEW	RWRE	RWERE	QREWRE	REWREWQ							\N	16
\.


--
-- TOC entry 2033 (class 0 OID 35816)
-- Dependencies: 1418
-- Data for Name: fornitori; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY fornitori (idfornitore, provincia, data_inserimento, nome, piva, codfisc, via, cap, citta, tel, cell, fax, email, website, note, codbarre) FROM stdin;
\.


--
-- TOC entry 2010 (class 0 OID 34775)
-- Dependencies: 1395
-- Data for Name: immagine_articolo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY immagine_articolo (id, nome, estensione, file, articolo) FROM stdin;
1	test	png       	\\211PNG\\015\\012\\032\\012\\000\\000\\000\\015IHDR\\000\\000\\000 \\000\\000\\000 \\010\\006\\000\\000\\000szz\\364\\000\\000\\007nIDATx\\332\\235W\\013L\\225e\\030>\\202q\\023\\020\\334\\301e\\206\\232F*\\244\\351\\234\\246\\202-\\234\\2314\\361\\222A\\023\\035Y\\313\\265\\351\\226\\245\\316`-u\\225\\233\\335\\\\\\263\\013(\\020\\003S#\\207\\014AA\\004\\004\\025\\024\\021\\274\\240\\010\\336\\270\\310\\035Q@AP\\317y{\\236o\\347?\\236#\\250\\320\\277=\\343\\234\\363\\377\\377\\367>\\337\\363>\\357\\373\\275\\350t\\377\\363\\022\\221\\0017o\\336t,//\\327744L\\000>\\274w\\357\\336\\326;w\\356d\\\\++(\\317\\212\\232\\260}\\323\\372\\271C7o\\336l\\323\\347E\\353\\353\\353}\\012\\013\\013\\307\\2369sf\\0040\\354\\364\\351\\323/\\026\\027\\027\\277t\\366\\354\\331Q\\370\\353][[\\353\\213@K\\021\\370\\253\\246\\246\\246\\330\\272\\272\\272\\274\\353\\327\\257\\327\\\\\\272t\\351!\\236\\021<#\\374{\\354\\3301)J\\015\\222\\364?\\364E\\257\\215\\320\\371\\255X1\\312\\341\\271\\301\\257^\\275j_UUu\\351\\370\\361\\343-\\010\\\\{\\356\\334\\271\\312\\222\\222\\222\\033\\347\\317\\237\\257\\302\\302u\\005\\005\\005w\\362\\362\\362\\272\\261\\270177WrrrT \\374&\\270\\247\\202_\\270pA.^\\274\\250\\356\\345\\246~'\\206\\372\\265r\\372\\237\\241\\025\\223\\275l\\227\\370\\372\\352]\\236I\\340\\362\\345\\313\\243N\\236<\\331\\022\\035\\035-qqq\\262{\\367nIHH\\220\\375\\373\\367\\313\\201\\003\\007$--M233U\\320S\\247N\\011\\024R\\273\\005I\\201\\002RVV&W\\256\\\\\\021lD\\262\\263\\263%7\\371K1t\\354\\022\\343\\255\\020\\343\\371\\244!\\215P\\342#\\337\\261\\272\\247\\223\\000s\\337\\214\\214\\214N\\006\\337\\273w\\257\\012|\\360\\340A\\301o\\302\\035\\203\\234\\024\\025\\025\\251\\200Z\\260k\\327\\256\\011R \\025\\025\\025RYY)PP}\\316\\314<"\\205I\\263\\304X\\023 r?H\\244\\351u\\311\\216\\266\\273\\351:H\\367\\356\\333\\243t\\275\\247\\243\\261\\261q9\\002\\032\\366\\354\\331\\243\\202\\037:tH\\355\\204\\022s\\267\\224\\026\\206S\\001jjj\\004~\\260\\002\\374 \\360\\220"\\222\\225\\221"eI\\236\\322\\220\\343"\\365%C\\244\\245\\332M:K\\035$4@\\227\\214PoL\\231\\242{\\241\\007\\001,\\372MJJ\\212111QRSS\\225\\334'N\\2340\\357\\232\\301\\2718\\003\\301\\200f\\200\\270\\202\\366])\\220\\221.\\261\\277\\205K\\330\\232\\020Y\\272\\330W\\336\\363\\367\\224e\\001\\366\\022\\266\\\\\\3275p\\240n\\235\\275\\275n\\014BZW\\007\\344\\213`\\256\\223\\223\\223%==]\\311Ns\\301\\204Jr.\\314\\235677KKKK\\257\\270}\\373\\266J\\011\\323\\026\\021\\021)\\353\\327\\257\\227E\\213\\026\\313\\244I\\223D\\257\\367\\020g'\\007\\243\\215\\215.\\006\\341\\002\\201AV5\\215|&\\221\\000\\363\\236\\225\\225%\\371\\371\\371\\312d0\\247Z\\224\\2623xkk\\253\\264\\265\\265=\\025\\364\\305\\341\\303\\207%22R6l\\330 \\301\\301\\3012s\\346L\\231:u\\252xzz>B\\270]\\300g\\300P3\\001\\270\\330\\016\\001\\362)=_\\346\\356\\321\\017T\\336\\271 \\352^\\311\\313\\000h6V\\350\\350\\3500\\177\\276{\\367\\2562'\\025\\210\\212\\212\\222\\360\\360p\\011\\015\\015U$V\\256\\\\)\\023'N\\354B\\270\\270\\036\\004 \\261\\013\\362[B\\343q\\3674\\036\\372\\200\\222\\236\\316F\\363\\021t8\\351\\354\\354\\224\\373\\367\\357\\233\\321\\325\\325\\245\\320\\335\\335\\255@2$p\\344\\310\\021\\211\\211\\211\\221-[\\266(\\022\\0337n\\224m\\333\\266\\211\\237\\237_\\007\\302\\305\\002\\237\\000C,\\233\\220\\007d\\276\\312Z?z\\364\\250\\252s\\032\\217\\322\\323t\\314-\\027\\177\\360\\340\\201<|\\370\\320\\214G\\217\\036)\\030\\014\\006\\005\\222\\240W\\320\\314d\\337\\276}\\022\\033\\033+;w\\356TeMU\\002\\002\\002\\356"\\034=\\020\\012\\270\\233\\011\\300\\341\\303\\021\\254\\212\\362\\263\\321P\\376\\322\\322R\\265\\373[\\267n)i\\031\\320h4*<\\355\\3423,E\\032\\227\\025\\3042\\346\\206\\370\\235\\353\\005\\006\\006\\266!\\\\\\024\\260\\024x\\334\\224ps$r]K\\226$\\300\\272\\247\\374\\314=\\335\\315\\335s\\207\\317\\273\\250\\006\\215J\\337\\260;\\022\\374\\314\\362ej\\026,X\\320\\212p;\\201`\\017\\017\\017g3\\001\\334\\034\\015\\025\\032\\230;\\215\\000\\353\\236e\\307\\334S\\332g\\355\\\\\\273H\\222\\317\\3233Z\\177`\\012\\271\\021\\266\\350\\205\\013\\027\\266\\365J\\0007\\307\\200D\\223e\\363!\\001\\276\\334\\336\\336\\256v\\326\\227\\213\\004hTV\\004\\313\\225\\351#\\011n\\344\\306\\215\\033\\262d\\311\\222vS\\012z\\022\\000\\032\\2313\\255\\376\\311\\230\\371d\\376\\373"?/\\252D\\243\\222\\004\\211\\323\\274,_*R]]-!!!\\254\\202\\350\\036\\004\\220\\357W\\300\\260\\201\\206\\341\\241\\303\\022$\\001\\276\\310\\335\\364E~\\215\\000\\215\\310\\022%q\\246CS\\201j\\242\\027<0\\225\\341r`\\260\\231\\000*`\\004\\034_\\243\\235z\\232\\002$@\\003\\366\\207\\000\\323\\305\\336\\300\\367\\330\\270\\250\\002I\\320\\234aaa\\006\\204\\213\\007V\\014\\036<\\330\\335\\262\\012\\206\\241\\023VX\\022\\320<@9\\373J@\\253\\004\\232\\226\\357Q\\005z\\201J\\220\\010\\032\\223\\021\\341\\022\\200O]\\\\\\\\\\364\\226\\255x\\010\\202\\225q\\222\\241\\0078\\335\\260\\014\\331\\377\\373\\223\\002\\315\\210\\364\\001\\323@\\025HB;'v\\354\\330!\\266\\266\\266\\007\\020r\\265\\223\\223\\32303\\001\\004w\\202Y\\212\\351\\001\\266aV\\001\\017!\\032\\207/\\366\\207\\200\\226\\006\\252\\240\\221\\320\\316\\012\\036\\365\\216\\216\\216\\231\\010\\271\\326\\335\\335}\\204\\345ih\\013\\243d\\222\\000\\333(\\373\\000\\233\\010\\033\\010\\345\\353k\\025X\\022\\240\\012\\032\\011\\246\\203\\340\\372nnn\\005\\010\\031\\356\\352\\352\\352e5\\017\\300p\\1773\\005\\004\\347\\000\\016\\230\\254]\\232\\207\\213\\365\\307\\210$lI\\202\\2401\\271\\346\\310\\221#/#\\334\\267\\234\\214\\200\\001f\\002H\\301V6!\\313Y@\\363\\001k\\272\\277*h$,\\017/\\226\\343\\264i\\323j\\020\\356'`\\246\\325T\\204RY\\215S\\320\\310vl\\231\\006\\236nT\\241\\257\\355\\330\\222\\300\\223\\240\\012AAAl\\307\\277\\003s\\201\\307\\263!\\216\\337\\271h@\\335\\034\\307\\2644h\\015\\211*\\260\\214\\270@_H\\360\\031\\022\\246\\177x\\244SQ\\014;\\306\\370\\370x\\303\\354\\331\\263;LSQ\\220\\325X\\206\\0360\\036\\347A\\2536\\2240\\035\\3324\\254\\315\\005<\\031i\\246\\336\\322A\\211\\331\\270\\030,""\\302\\260j\\325\\252v\\177\\177\\377J//\\257b\\275^\\237\\203\\262K\\263\\263\\263K\\262\\261\\261\\371\\327\\324\\216WX\\315\\004\\010\\354\\012\\323Us\\220\\340l\\310Th$8\\234\\3608eUP\\015\\002\\312\\030\\2212\\003\\376y\\351F\\203\\351\\304A\\3234~\\374\\370Rgg\\347lS\\220\\277\\200?\\201\\237\\201\\315\\300:`%\\260\\014\\370\\000x\\323J\\001^\\230\\343>\\0367n\\\\\\242\\217\\217O\\371\\214\\0313\\352\\346\\314\\231\\323\\214!\\242e\\376\\374\\371-\\363\\346\\315k\\306\\367\\372\\351\\323\\247Wz{{\\227b\\300,DIe\\331\\333\\333\\357G@J\\032\\011\\374\\002l\\002>\\007B\\200w\\200)x\\346U\\374\\035\\206\\347\\335LA\\035L\\371\\037\\360\\344\\277\\007\\374a2\\260\\006\\370\\036\\370\\021\\370\\025\\370\\315\\204\\355\\3006\\340\\007\\323\\375\\257\\201/L3\\336\\373\\300[\\200\\017\\232\\315p\\323ac\\327c\\376\\177\\336\\205|qT\\032m\\252\\323i\\200\\037\\340\\017\\3146a\\0260\\035\\230\\004\\214E\\260\\227\\321T8`:\\001\\266\\275\\355\\352Y\\327\\177\\255\\306A\\244\\317\\220t\\323\\000\\000\\000\\000IEND\\256B`\\202	0
2	Colline azzurre.jpg	jpg       	\\377\\330\\377\\333\\000C\\000\\010\\006\\006\\007\\006\\005\\010\\007\\007\\007\\011\\011\\010\\012\\014\\024\\015\\014\\013\\013\\014\\031\\022\\023\\017\\024\\035\\032\\037\\036\\035\\032\\034\\034 $.' ",#\\034\\034(7),01444\\037'9=82<.342\\377\\333\\000C\\001\\011\\011\\011\\014\\013\\014\\030\\015\\015\\0302!\\034!22222222222222222222222222222222222222222222222222\\377\\300\\000\\024\\010\\002X\\003 \\004\\001"\\000\\002\\021\\001\\003\\021\\001\\004"\\000\\377\\304\\000\\037\\000\\000\\001\\005\\001\\001\\001\\001\\001\\001\\000\\000\\000\\000\\000\\000\\000\\000\\001\\002\\003\\004\\005\\006\\007\\010\\011\\012\\013\\377\\304\\000\\265\\020\\000\\002\\001\\003\\003\\002\\004\\003\\005\\005\\004\\004\\000\\000\\001}\\001\\002\\003\\000\\004\\021\\005\\022!1A\\006\\023Qa\\007"q\\0242\\201\\221\\241\\010#B\\261\\301\\025R\\321\\360$3br\\202\\011\\012\\026\\027\\030\\031\\032%&'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz\\203\\204\\205\\206\\207\\210\\211\\212\\222\\223\\224\\225\\226\\227\\230\\231\\232\\242\\243\\244\\245\\246\\247\\250\\251\\252\\262\\263\\264\\265\\266\\267\\270\\271\\272\\302\\303\\304\\305\\306\\307\\310\\311\\312\\322\\323\\324\\325\\326\\327\\330\\331\\332\\341\\342\\343\\344\\345\\346\\347\\350\\351\\352\\361\\362\\363\\364\\365\\366\\367\\370\\371\\372\\377\\304\\000\\037\\001\\000\\003\\001\\001\\001\\001\\001\\001\\001\\001\\001\\000\\000\\000\\000\\000\\000\\001\\002\\003\\004\\005\\006\\007\\010\\011\\012\\013\\377\\304\\000\\265\\021\\000\\002\\001\\002\\004\\004\\003\\004\\007\\005\\004\\004\\000\\001\\002w\\000\\001\\002\\003\\021\\004\\005!1\\006\\022AQ\\007aq\\023"2\\201\\010\\024B\\221\\241\\261\\301\\011#3R\\360\\025br\\321\\012\\026$4\\341%\\361\\027\\030\\031\\032&'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz\\202\\203\\204\\205\\206\\207\\210\\211\\212\\222\\223\\224\\225\\226\\227\\230\\231\\232\\242\\243\\244\\245\\246\\247\\250\\251\\252\\262\\263\\264\\265\\266\\267\\270\\271\\272\\302\\303\\304\\305\\306\\307\\310\\311\\312\\322\\323\\324\\325\\326\\327\\330\\331\\332\\342\\343\\344\\345\\346\\347\\350\\351\\352\\362\\363\\364\\365\\366\\367\\370\\371\\372\\377\\332\\000\\016\\004\\001\\000\\002\\021\\003\\021\\004\\000\\000?\\000\\367L\\321\\232\\217p\\244\\335\\371\\326\\366<\\376c\\337\\350\\242\\212\\2274f\\242\\310\\245\\315\\026\\016`\\242\\212*L\\321\\232\\2174f\\213\\0070QE\\025&h\\31534f\\225\\203\\230(\\242\\212w4\\271\\250\\363Fi\\3309\\202\\212(\\2513Fi\\231\\2434\\254\\027\\012(\\242\\237\\2323L\\315\\031\\242\\301\\314\\024QE?4f\\233\\2323@\\356\\024QE?4f\\231\\2323E\\205\\314\\024QE?4S3Fh\\260\\\\(\\242\\212~h\\31534f\\213\\016\\341E\\024S\\363Fi\\231\\2434X.\\024QE?4f\\2234R*\\341E\\024R\\321\\232nh\\315\\026\\016`\\242\\212*L\\323sM\\315\\031\\242\\301\\316\\024QE;4Rf\\214\\320\\027\\012(\\242\\226\\214\\322Ss@\\\\(\\242\\212~h\\31534f\\235\\203\\230(\\242\\212}\\031\\246\\346\\214\\322\\260\\\\(\\242\\212vh\\31534\\271\\024X9\\202\\212(\\2513EG\\232\\\\\\321`\\270QE\\024\\374\\321\\232fh\\315!\\334(\\242\\212}\\031\\246f\\214\\320\\027\\012(\\242\\237Fi\\231\\2434\\005\\302\\212(\\247\\346\\214\\3233K@\\\\(\\242\\212vh\\31534f\\200\\270QE\\024\\374\\321\\232fh\\315\\001p\\242\\212)\\331\\244\\244\\315\\024\\307\\314\\024QE;4f\\233E\\026\\016`\\242\\212)\\331\\2434\\334\\321\\232,\\034\\301E\\024S\\363Fi\\271\\244\\315!\\\\(\\242\\212~h\\3156\\214\\320\\027\\012(\\242\\235Fi\\224f\\200\\270QE\\024\\374\\321\\232fh\\315\\001p\\242\\212)\\364S3K\\232\\002\\341E\\024S\\263Fi\\271\\2434\\005\\302\\212(\\247Q\\232fis@\\\\(\\242\\212u\\031\\246f\\2274\\025p\\242\\212)\\324f\\233\\2323@\\\\(\\242\\212u\\031\\246\\346\\214\\320\\027\\012(\\242\\235\\2323M\\315&h\\2617\\012(\\242\\2274f\\233\\232B\\335{\\323\\260\\271\\202\\212(\\247\\346\\2235\\003\\312\\341xNOAU\\274\\273\\207l\\227\\307\\265Z\\217s9V\\266\\310(\\242\\212\\320\\310\\245\\315g\\013y\\201\\377\\000[\\370\\324\\321\\006^\\256\\307\\336\\207\\005\\334J\\263{\\240\\242\\212*\\336h\\315D2?\\212\\227\\177564\\346\\012(\\242\\244\\315\\0314\\314\\321\\232,+\\205\\024QO\\337F\\372fi3E\\207\\314\\024QEI\\276\\214\\324y\\2434X9\\202\\212(\\2513Fj<\\321\\232,\\036\\320(\\242\\212\\2234f\\243\\315\\031\\242\\303\\366\\201E\\024T9\\244\\311\\246\\222h\\006\\264\\261\\315p\\242\\212)\\371\\371\\250\\3153?\\376\\272SE\\205p\\242\\212)\\331;\\277\\225\\031\\246\\346\\214\\376\\224X.\\024QE;4\\273\\373S3Fh\\260\\\\(\\242\\212~h\\3153\\255\\031\\374\\250\\260\\\\(\\242\\212~\\377\\000\\232\\215\\365\\035\\031\\371h\\260\\356\\024QEI\\276\\215\\377\\000-C\\232\\001\\371\\250\\260\\\\(\\242\\212\\233\\177\\345N\\337\\305C\\277\\345Z\\0014X.\\024QEM\\276\\215\\365\\026~\\\\Q\\232,\\027\\012(\\242\\245\\337F\\372\\213?\\215\\031\\242\\301p\\242\\212*\\\\\\321\\276\\242\\243'\\265\\026\\035\\302\\212(\\251w\\321\\276\\242\\315\\000\\232,+\\205\\024QSf\\215\\365\\016~j3J\\301\\316\\024QEM\\276\\215\\365\\037\\361PN\\352,W0QE\\025&h\\337Q\\3474\\237\\344\\346\\213\\005\\302\\212(\\251sF\\361Q\\322\\034\\321`\\346\\012(\\242\\245\\337F\\372\\217?\\205\\034\\321`\\346aE\\024T\\233\\350\\337\\372T$\\321E\\203\\230(\\242\\212\\233}\\033\\352\\036\\234|\\324Q`\\346aE\\024T\\333\\350\\337P\\347\\345\\372\\321E\\203\\231\\205\\024QSo\\243}C\\377\\000\\002\\240\\237\\306\\213\\0073\\012(\\242\\246\\017F\\372\\2074d\\321`\\346\\012(\\242\\246\\336(\\337P\\356\\364\\243}\\034\\241\\314\\024QEM\\276\\235\\276\\253\\027\\351\\353F\\363\\332\\216P\\346\\012(\\242\\254o\\024\\273\\352\\266\\3727\\321\\312\\036\\320(\\242\\212\\261\\276\\223\\314\\252\\373\\350\\337\\337\\265>R}\\240QE\\025cx\\243x\\2507\\232n\\374Q\\312W\\264\\012(\\242\\254\\371\\202\\2172\\253\\007\\243y\\243\\220=\\240QE\\025gx\\243\\314\\025[~\\017\\024\\320\\347\\363\\351G)>\\320(\\242\\212\\267\\346Q\\274t\\252\\336e\\001\\373\\321\\312W\\264\\012(\\242\\254\\371\\224y\\225[\\177\\373_\\215\\005\\373Q\\312\\036\\320(\\242\\212\\263\\346Q\\276\\253o\\243\\177\\336\\243\\224=\\240QE\\025gx\\243}V\\363\\011\\246\\371\\237\\344\\321\\312O\\264\\012(\\242\\255\\357\\243}V\\336h\\363\\015\\034\\205{@\\242\\212*\\316\\3727\\374\\325[\\314\\364\\343\\322\\2170\\321\\312\\036\\320(\\242\\212\\265\\274Q\\272\\252\\371\\206\\233\\346\\021\\305\\034\\201\\355\\002\\212(\\253\\233\\250\\337\\332\\252o\\245\\336h\\344\\017h\\024QEZ\\337Hd\\003\\370\\252\\256\\362\\324Q\\310O\\264\\012(\\242\\254\\033\\204\\037\\305I\\366\\224\\376\\365W\\300\\374(\\030\\247\\310\\205\\355$\\024QEY\\363\\321W\\357Q\\366\\205\\037\\305U\\316)\\177\\212\\227"\\017i \\242\\212*o\\264.i\\206\\340\\225;?3L\\343\\374i\\274~\\036\\224\\371PsK\\270QE\\025(\\234\\367\\245\\363\\324\\377\\000\\215B1\\266\\2341E\\220s0\\242\\212*O5zS\\274\\334\\377\\000\\015C\\232Z,\\207\\314\\302\\212(\\251|\\301G\\2303Q\\346\\214\\365\\245`\\273\\012(\\242\\244\\336h\\337Q\\346\\227\\374\\346\\213\\005\\302\\212(\\247\\346\\227&\\243\\316\\3523E\\212\\270QE\\024\\375\\342\\235\\232\\2134g\\374(\\260\\\\(\\242\\212\\2274\\334\\374\\334\\3233A4X.\\024QE<\\032vj,\\217\\302\\214\\232,\\027\\012(\\242\\245&\\214\\3233H)X.\\024QEA\\237\\233\\212\\001\\375*\\0375h\\363Ek\\312a\\355\\027p\\242\\212*\\301"\\223v?\\032\\207\\315Z]\\343\\363\\242\\302\\346]\\302\\212(\\251s\\353FzT~`\\240H\\277\\375j,>e\\334(\\242\\212\\223=\\373Q\\237\\233\\232\\214\\310\\003}\\352<\\301\\320\\321as \\242\\212*l\\323wb\\231\\274R\\007\\037\\336\\242\\301\\316\\024QEK\\2323Qo\\024o\\374h\\261\\\\\\341E\\024T\\200\\363\\365\\243\\255G\\276\\235\\232,\\027\\012(\\242\\237\\367\\251sQo\\024\\240\\376t\\254\\027\\012(\\242\\244\\030\\242\\231\\277\\375\\2527\\212,;\\205\\024QO\\375)zS7\\344Ro\\371\\276\\365\\026\\013\\205\\024QO\\315\\031\\374)\\233\\366\\361K\\274Q`\\270QE\\024\\354\\374\\324qL\\310\\243~(\\260\\\\(\\242\\212~\\177\\001N\\315D\\010\\372R\\344Q`\\270QE\\025'\\360\\321\\237\\232\\243\\337\\271y\\245\\006\\225\\202\\341E\\024S\\363\\363R\\357\\025\\036G\\377\\000Z\\214\\212,\\027\\012(\\242\\244\\244\\3150\\220?\\302\\224\\021\\320\\322\\260\\\\(\\242\\212~E\\031\\250\\363H\\034u4\\354\\027\\012(\\242\\244\\315\\034S3\\363Rd\\177{\\360\\242\\301p\\242\\212*N>^\\364f\\231\\221\\375\\352nv\\321`\\270QE\\025.h\\315E\\274R\\357\\347\\212v\\013\\205\\024QO&\\202\\365\\036h'<Q`\\270QE\\024\\362~Z\\011\\246\\003M\\310\\357\\315\\026\\013\\205\\024QR\\344q\\362\\376\\024dTY\\313R\\223\\334sE\\202\\341E\\024T\\231\\335Hi\\271\\244\\316h\\260\\\\(\\242\\212~h\\317jni3E\\202\\341E\\024S\\363M\\373\\313H~Z\\001\\377\\000\\365\\320 \\242\\212)h\\006\\231\\327\\201F~_Zap\\242\\212)\\371\\242\\231\\221Fh\\000\\242\\212)\\364tn=1L\\315\\031\\365\\353E\\200(\\242\\212y\\243\\2674\\231\\3056\\200\\012(\\242\\237\\353G\\353L/Fv\\321`\\012(\\242\\235\\306)?\\205E&~^(\\347\\351@\\005\\024QN\\243?\\354\\323}h4\\000QE\\024\\354\\372\\321M\\315\\031=\\250\\260\\005\\024QN\\315\\031\\30574\\231\\371\\250\\000\\242\\212)\\344\\323\\177\\207\\371Ss\\326\\217\\370\\025;\\010(\\242\\212~M&~jo\\035\\327\\212^\\002\\3200\\242\\212)}\\177\\2358\\032i\\243\\251\\377\\000\\032@\\024QE??\\225\\033\\373S(\\311\\376\\224X\\002\\212(\\251s@\\177\\312\\231\\232O\\322\\213\\000QE\\025&h\\317Zfv\\361\\332\\220\\037\\366iXaE\\024T\\203\\377\\000\\325G\\024\\314\\372P\\036\\213\\000QE\\025&\\177\\302\\202\\177\\317\\2653}\\033\\366\\3764X.\\024QE?#nh\\376t\\314\\376to\\355E\\212\\270QE\\024\\377\\000\\342\\2434\\314\\321\\277\\024X.\\024QEK\\357G\\360\\212fE7>\\274\\321`\\012(\\242\\237\\375iO\\312\\324\\314\\377\\000\\365\\350\\337\\326\\213\\000QE\\025&i\\275\\032\\232\\015\\033\\307Z,PQE\\024\\362N\\337z@i\\273\\372\\035\\324\\273\\350\\260\\005\\024QO\\315(!\\252<\\342\\214\\322\\260\\256\\024QEP R\\001\\362\\343\\245I\\355@\\256\\213\\2346\\012(\\242\\233\\201\\272\\214S\\361I\\364\\245p\\260QE\\024\\337\\356\\373Q\\237\\226\\227\\037-\\030\\374\\205\\001`\\242\\212)\\005\\024c\\346\\240\\320\\026\\012(\\242\\217\\341\\242\\235G\\031\\240,\\024QE4\\372\\212^\\337\\316\\222\\217\\353@\\302\\212(\\247\\346\\214\\322Q\\376M\\000\\024QE.\\363\\212R\\335\\251\\270\\245\\376T\\212\\012(\\242\\227'\\240\\244\\317QM\\377\\000\\201u\\245\\240\\002\\212(\\247d\\376]\\351\\011?\\341A?5\\034\\377\\000\\365\\250\\013\\260\\242\\212)C\\036\\364d\\322~\\242\\217\\341\\343\\275\\001v\\024QE?\\177\\335\\246\\344\\356\\306\\352J3\\367\\210\\244\\027\\012(\\242\\235\\277\\276\\3527\\323E\\030\\371\\251\\205\\302\\212(\\247\\357;~\\365\\033\\351\\231\\243\\371R\\260]\\205\\024QO\\016\\177\\0127\\3233\\336\\235E\\202\\354(\\242\\212]\\364\\007\\371\\262i\\235i\\335\\377\\000\\235\\026\\013\\260\\242\\212)w\\372Q\\222i\\231\\354:\\032w\\024X.\\302\\212(\\245\\363\\017^\\364\\006;i>\\3657\\370\\261\\333\\275\\001v\\024QE.r=\\250\\336v\\322\\321\\376sLz\\205\\024QG\\230h\\336i\\275\\350\\305-\\005\\250QE\\024\\355\\364\\233\\316\\356)\\264\\264Xz\\205\\024QK\\3466i<\\303\\351E'\\037\\215;\\005\\330QE\\024\\276cQ\\346RqK\\322\\213\\005\\337p\\242\\212)\\333\\375h\\3637S=sK\\374?\\326\\225\\202\\354(\\242\\212\\177\\230?\\012\\004\\2375G\\374\\250\\316h\\260s0\\242\\212*M\\364o\\365\\250\\371\\037Zo\\275\\026\\016`\\242\\212*m\\341\\250\\004~5\\037\\374\\012\\223'\\346\\242\\305s0\\242\\212*QF\\377\\000\\226\\241\\337\\371\\323\\267\\232,\\034\\301E\\024T\\231\\033\\275q\\336\\214\\324y;\\251\\271\\242\\301\\314\\024QEM\\326\\202\\343w\\275C\\223\\3764\\271\\371\\277\\302\\235\\203\\230(\\242\\212\\227\\371\\321\\232\\2174\\233\\375:u\\346\\225\\203\\230(\\242\\212\\227?/\\024\\354\\217\\312\\240\\016zn\\305;\\177\\2474X9\\202\\212(\\247\\347\\346\\346\\214\\366\\246n8\\243=\\205\\026\\013\\205\\024QO\\310\\376\\367=is\\237\\255E\\277\\245)=\\350\\260\\356\\024QE>\\216)\\201\\361FwQ`\\270QE\\024\\374\\216\\264g\\346\\373\\325\\036}V\\216>\\224X.\\024QEI\\237\\227\\326\\214\\374\\325\\037\\035:Q\\305\\026\\013\\205\\024QRg\\326\\214\\3230(\\342\\213\\005\\302\\212(\\247\\347\\275\\004\\374\\276\\364\\316:\\366\\245\\364\\002\\213\\005\\302\\212(\\2513\\376\\325!'o\\336\\246\\014\\003F9\\242\\301p\\242\\212)\\344\\376T\\271\\365\\246P\\005 \\270QE\\024\\374\\212\\011\\371i\\275)9\\240\\253\\205\\024QN\\316\\177\\213\\255.N\\352f}y\\244\\317\\315\\315\\026\\013\\205\\024QO\\311\\245\\317\\353Qd\\323\\263\\370S\\260\\\\(\\242\\212~i\\271\\371\\251\\231\\357Fh\\260\\\\(\\242\\212\\224\\2327\\363Qd\\320O\\313\\305\\026\\013\\205\\024QO\\311\\243\\177\\336\\373\\264\\314\\367\\243;h\\260\\\\(\\242\\212~\\177:7\\374\\324\\302i3E\\202\\341E\\024T\\233\\361G\\231\\353Q\\223\\376\\365\\031\\242\\301p\\242\\212*O3\\360\\245\\017Qg\\363\\243>\\224X\\\\\\301E\\024Q\\276\\233\\235\\324\\037j3\\377\\000\\353\\2520\\012(\\242\\235\\307\\367\\250$S\\177\\206\\217\\243P\\027\\012(\\242\\2279?\\312\\223#\\363\\242\\222\\230\\005\\024QK\\232_o\\312\\233\\323\\371Q\\317\\024\\005\\302\\212(\\247\\346\\223\\376\\005M\\024\\177\\234\\321`\\270QE\\024\\354\\377\\000\\263\\232_\\341\\342\\233\\237\\275\\355G4\\000QE\\024\\277w\\351K\\3056\\214\\367\\244\\001E\\024S\\263\\267\\361\\243\\212h\\377\\000\\365\\321@\\005\\024QN\\376\\355&~_\\245'\\323\\232p"\\200\\012(\\242\\203G\\360\\321\\307\\343E\\000\\024QE.h\\317\\353II\\307\\377\\000^\\220\\005\\024QK\\327\\360\\245\\311\\335\\351\\355II\\355\\353L\\002\\212(\\245\\3674\\177\\015&;R\\177\\025\\000\\024QE8Q\\357I\\367\\226\\214\\217\\302\\200\\012(\\242\\227?5\\031\\243"\\232\\017\\343@\\\\(\\242\\212\\\\\\232p9oJg\\377\\000\\252\\214\\345\\250\\260\\\\(\\242\\212~h\\377\\000\\201sL\\353\\326\\214\\376\\264X.\\024QE?8\\242\\223?6={\\320\\015\\005\\\\(\\242\\212_z3M\\317\\255-\\026\\025\\302\\212(\\245\\317\\313M=\\276o\\377\\000U'\\327\\2323\\322\\220\\356\\024QE;4g\\2657\\352\\324g\\321\\251\\205\\302\\212(\\247\\177\\221E74\\204\\321`\\270QE\\024\\340M/\\361S3Fi\\330\\233\\205\\024QO\\310\\242\\231KE\\202\\341E\\024S\\263G\\035\\372\\323h\\317\\346)\\025p\\242\\212)O\\3714\\271\\246\\321\\313S\\2617\\012(\\242\\216:\\216=\\350\\316(\\317jo\\335\\307\\362\\240\\253\\205\\024QN\\376\\032\\017\\362\\246\\347\\360\\366\\240}\\352\\002\\341E\\024S\\263@\\244\\376\\0323\\377\\000\\353\\240.\\024QE)\\243\\037\\354\\322\\022iM\\001p\\242\\212)\\324S2\\177\\032\\017\\345E\\202\\350(\\242\\212Z\\\\t\\315&\\357\\366h\\2404\\012(\\242\\212?\\235\\031\\024g\\024\\006\\201E\\024S\\261G\\024\\334\\2129\\240.\\202\\212(\\245\\377\\000\\200\\321\\307\\341I\\273\\362\\244\\315\\003\\272\\012(\\242\\226\\200?\\372\\324\\231\\244\\006\\200\\272\\012(\\242\\234?J>\\224\\322i\\335\\350\\015\\002\\212(\\242\\217\\245\\031\\243#\\247j\\003@\\242\\212(\\344R\\347o\\036\\264\\231\\2439\\376\\264\\005\\302\\212(\\247\\023I\\236\\375\\351\\271\\245\\335\\376\\315+\\005\\302\\212(\\247d~\\264g\\364\\246\\346\\214\\212,U\\302\\212(\\247\\347\\346\\240\\032fE\\031\\377\\000\\353Q`\\270QE\\024\\2714\\246\\233\\277\\360\\243w\\275\\026\\000\\242\\212)\\331\\315\\024\\337\\370\\0274\\023@\\005\\024QFh\\243<qGz`\\024QE\\024\\023\\3074\\322M-\\000\\024QE/j3\\336\\222\\216(\\000\\242\\212)M\\031\\311\\244\\2448\\037\\205\\000\\024QE;==\\015\\024\\234Q@\\005\\024QK\\375(\\3157\\364\\364\\243\\332\\200\\012(\\242\\234~\\365'\\371\\305\\006\\232\\015\\006AE\\024S\\263\\267\\361\\242\\233F}(\\020QE\\024\\354\\321\\223\\364\\246\\346\\212\\000(\\242\\212q\\242\\233\\237J\\011\\376T\\000QE\\024\\3523\\363S}\\350\\315\\000\\024QE;"\\214\\374\\264\\322h\\343\\362\\242\\300\\024QE;;}\\350\\3156\\214\\374\\264\\000QE\\024\\374\\356\\333\\2323\\334\\365\\246gu\\031=(\\260\\005\\024QN\\343\\275/\\035i\\234\\320(\\000\\242\\212)\\343\\346\\351G\\353\\212fh'\\375\\252,\\001E\\024S\\363E&J\\321\\232,\\001E\\024R\\347\\326\\212O\\247\\326\\216\\277\\326\\200\\012(\\242\\224\\375\\337\\275Fi\\015&M\\000\\024QE8\\2323\\266\\223\\333\\362\\246\\223@\\005\\024QO\\317\\341I\\221M\\315\\037\\344P\\001E\\024S\\262?\\372\\324q\\371\\323s\\363Q\\374\\350\\000\\242\\212)\\342\\214\\365\\246u\\247\\014\\320\\001E\\024R\\346\\214\\374\\264\\314\\355\\367\\243$Q`\\012(\\242\\236_\\024g\\374\\212L\\236\\236\\224\\323\\362\\320\\001E\\024S\\311\\244\\376,\\232nh'4\\354\\001E\\024S\\263\\377\\000\\352\\242\\233\\317j9\\355@\\005\\024QN\\373\\334\\321\\374\\251\\240\\374\\324\\236\\336\\264\\014(\\242\\212Z^\\276\\364\\200\\372\\321\\232\\000(\\242\\212w\\362\\240\\221\\322\\233\\2327\\217\\316\\220\\202\\212(\\247\\037\\367\\261I\\372\\232L\\232=\\350\\000\\242\\212(\\242\\217\\363\\2128\\246\\001E\\024S\\275\\315'N{\\322g\\275\\000\\217\\376\\275\\000\\024QE\\031\\335\\374_J\\\\\\366\\244\\317jL\\346\\200\\012(\\242\\235\\375)(\\317\\315I\\237\\366\\263@\\005\\024QN\\347\\373\\324\\264\\334\\377\\000\\365\\2513\\232\\000(\\242\\212\\\\\\367\\243\\337\\247znv\\265.\\177\\032\\000(\\242\\212\\1774\\332L\\321\\232\\000(\\242\\212~i\\271\\240}\\3523@\\005\\024QG4\\003\\351IA4\\000QE\\024g\\346\\242\\217\\342\\367\\246\\373\\376\\264\\000QE\\024\\340h\\246\\363E\\000\\024QE?#\\251\\240}\\352gN(\\315\\000\\024QE?&\\2239\\2434\\334\\232\\000(\\242\\212vh\\246\\321\\322\\200\\012(\\242\\227'\\377\\000\\255F\\177\\306\\223\\370h\\246\\001E\\024S\\263I\\236y\\2444f\\230\\\\(\\242\\212u\\031\\371}\\251\\224\\264\\254\\027\\012(\\242\\227&\\2274\\332?\\206\\220\\356\\024QE/\\326\\214\\374\\324\\206\\214\\366\\333L\\002\\212(\\247\\347\\345\\342\\2234\\334\\321H.\\024QE.M)\\377\\000z\\232\\015\\037\\255\\000\\024QE;\\237\\376\\265\\031\\246\\321\\221T\\001E\\024R\\344\\322gu\\037\\305GN\\224\\000QE\\024\\354\\342\\2274\\312L\\321`\\270QE\\024\\374\\235\\264\\200\\376T\\231\\2435!p\\242\\212)I\\371\\270\\244\\317\\313A\\353\\305%U\\210\\270QE\\024\\372ni>\\264\\231\\377\\000\\365Q`\\270QE\\025&Ozm&\\177Jn\\177\\375tX.\\024QEK\\2323\\371\\323?\\212\\220\\221\\370\\321`\\270QE\\024\\354\\321\\232g-N\\357\\374\\250\\260\\\\(\\242\\212\\\\\\321\\235\\264\\231\\357F~_\\275E\\202\\341E\\024R\\203Fi\\006(\\315\\026\\013\\205\\024QO\\315'\\364\\246\\321\\237\\232\\213\\005\\302\\212(\\247\\373\\321L\\316\\325\\245\\245`\\270QE\\024\\354\\322\\346\\231\\237\\376\\275\\031\\347\\002\\213\\005\\302\\212(\\247d\\376\\024\\244\\217\\360\\246dQ\\355H\\253\\205\\024QO\\244?\\2357\\2458\\232\\002\\341E\\024R\\212>\\353g\\362\\244\\343o\\024f\\202n\\024QE/\\024\\224\\334\\364\\247\\177*\\006\\024QE\\037v\\217zo\\351A>\\224\\000QE\\024\\376)\\243\\327\\275 ?-\\031\\364\\240W\\012(\\242\\2363\\365\\364\\243\\376\\003L\\315;\\373\\264\\024\\024QE/\\371\\305\\037\\305I\\232\\005\\002\\012(\\242\\227\\374\\212?\\245%7\\370\\250\\000\\242\\212)\\377\\000w\\337\\336\\223\\215\\271\\246\\344\\321\\232\\006\\024QE;\\370h\\376*o\\363\\244\\372U\\000QE\\024\\363I\\310\\346\\223'u\\034\\355\\372\\324\\200QE\\024\\352m\\024U\\000QE\\024\\357\\247\\345M\\366\\242\\217\\370\\015H\\005\\024QN\\243\\217\\302\\233\\232(\\000\\242\\212)\\177\\225%\\024\\017\\273T\\001E\\024Q\\375(\\315\\037\\303\\374\\251(\\000\\242\\212)\\331\\377\\000j\\220Q\\234\\375h\\372P\\001E\\024Q\\2323I\\367is@\\005\\024QGn)\\302\\233\\326\\216(\\000\\242\\212(8\\374)\\324\\334\\321\\355@\\005\\024QN\\242\\223\\215\\277JL\\374\\336\\225 \\024QE8b\\212nirh\\000\\242\\212)i\\255\\332\\217\\370\\015\\031\\025@\\024QE\\004\\322}\\352>\\275\\351M\\000\\024QE\\024\\037\\275M\\366\\364\\351N\\376*\\000(\\242\\2123\\336\\217\\245\\031\\243\\364\\240\\002\\212(\\243\\351I\\315\\031\\375ih\\000\\242\\212)(\\305'\\360\\256)\\324\\000QE\\024\\177\\300\\251?\\206\\227\\336\\223\\333m\\000\\024QE\\034~TR\\366\\377\\000\\201RP\\001E\\024QG\\335\\366\\240\\373\\320s@\\005\\024QG\\037\\215\\024g\\364\\243\\327\\336\\200\\012(\\242\\223?\\355Q\\333\\371R\\177\\013Q\\232`\\024QE;\\370\\250\\246\\321H\\002\\212(\\245'\\374\\232ZnwsE\\000\\024QE:\\214\\374\\324\\337\\351@\\246\\001E\\024PsN\\246\\212(\\000\\242\\212)\\337J\\015\\024qH\\002\\212(\\2434\\023\\371\\320)\\277\\305\\374\\351\\200QE\\024\\026\\374)\\240\\324e\\317QH\\037\\357\\003Uc\\036d\\024QEOI\\237\\232\\243\\363\\001\\366\\247g\\322\\213\\016\\341E\\024S\\277\\275I\\223I\\374\\350\\317\\353HaE\\024S\\263\\351F~jni\\331\\371\\250\\013\\205\\024QA?--&i3\\362\\217\\345@\\005\\024QN\\315%7\\332\\217\\257\\341@\\\\(\\242\\212\\177\\363\\357G\\275%\\031\\240\\002\\212(\\245\\024Rf\\2238\\240aE\\024S\\271\\024R{\\321\\221@\\\\(\\242\\212vx\\243\\351M\\316iz\\364\\244\\027\\012(\\242\\227\\351GZO\\342\\243\\232\\002\\341E\\024S\\205\\031\\377\\000\\365\\323sGZAp\\242\\212)\\324g\\356\\373\\323s\\372Q\\236\\364\\005\\302\\212(\\247\\321L\\315\\031\\374\\350\\260\\\\(\\242\\212v~Z3\\363S}\\017j(\\013\\205\\024QJ=\\377\\000\\012\\\\\\3239\\242\\230\\005\\024QN&\\217\\342\\244\\315\\031\\355@\\\\(\\242\\212vE\\031\\246\\321\\376E \\012(\\242\\2279Z^i\\271\\374h\\376\\032`\\024QE8b\\217\\347M\\240\\237\\232\\200\\012(\\242\\227\\251\\245\\246\\217\\312\\212\\002\\341E\\024S\\263\\214R\\347\\365\\244\\3157\\372R\\035\\302\\212(\\245\\352>\\264\\275:Sh\\376/\\353N\\303\\012(\\242\\237\\364\\243?\\355S(\\375iX\\233\\205\\024QN\\310\\2434\\321\\367h\\240\\240\\242\\212)\\377\\000\\312\\2239\\246\\377\\000\\027\\037\\215.pO\\315\\370\\320\\001E\\024QG\\265!\\374\\350\\3150\\012(\\242\\216\\374\\364\\243\\232?\\206\\212`\\024QE-&h\\242\\200\\012(\\242\\227\\265\\024\\237^\\324t\\351H\\002\\212(\\245\\315\\031\\351\\353I\\236\\377\\000\\235\\031\\240\\002\\212(\\245\\316M\\004\\237\\312\\220c\\024g\\362\\240\\002\\212(\\245\\373\\313K\\232nOJo\\367\\250\\260\\005\\024QN\\310\\374\\251}\\251\\277\\322\\227\\255\\000\\024QE/\\031\\372\\322f\\233\\237\\366\\270\\245\\246\\001E\\024S\\263\\355G=7Rt\\374h\\006\\220\\005\\024QKA4\\237J?\\235\\000\\024QE-\\031\\024\\235(\\240\\002\\212(\\247f\\223'\\345\\244\\036\\324\\037n\\264\\200(\\242\\212w\\277\\347G\\335\\243\\374\\232o\\326\\200\\012(\\242\\235\\237\\366\\250\\024\\332(\\000\\242\\212)h\\244\\2434\\300(\\242\\212?\\206\\217\\245&B\\322\\037\\326\\230\\005\\024QN\\376\\032AE\\037\\316\\200\\012(\\242\\227\\237\\306\\203I\\2323\\362\\320\\001E\\024Q\\3744\\271\\244\\2434\\000QE\\024\\264\\177\\025'\\275&\\017J\\000(\\242\\212w\\177J3I\\232h\\305\\000\\024QE<\\234\\321\\232L\\321@\\005\\024QK\\3744Rg\\346\\243\\351@\\256\\024QEU<\\320Nh4\\237\\305\\3765\\251\\316\\024QE;!z\\322\\202{S8\\355E \\270QE\\025'\\231\\353N\\336\\274\\375\\352\\206\\212,>v\\024QEL\\035O\\002\\237\\232\\257\\236\\376\\234\\2323\\334w\\251\\260s\\005\\024QS\\227\\001~\\365\\031\\034|\\325_\\232vh\\260s\\005\\024QR\\231\\024{\\323\\014\\215M\\246\\323\\260\\271\\230QE\\024\\375\\355@\\221\\277:g\\367\\277Ju;\\005\\330QE\\025 \\220\\364?\\245\\036`\\377\\000h\\3244\\177\\016(\\345\\0373\\012(\\242\\244\\363\\032\\223y\\374})\\202\\234\\015\\026\\025\\302\\212(\\251<\\303\\307\\245(\\220\\023\\307\\025\\026h\\315.Q\\363\\260\\242\\212*\\315!5_#\\265.\\343\\335\\251r\\225\\314\\024QEX\\315\\025\\027\\230h\\363\\005+\\017\\231\\005\\024QRw\\364\\2455\\036\\361\\327\\346\\244\\363\\007Z,\\027\\012(\\242\\245\\310\\371\\275(\\315G\\274\\032v\\361\\330\\363E\\202\\341E\\024S\\276\\365&\\177\\037zN\\264g\\277\\245 \\012(\\242\\214\\376Tu\\246\\357\\024\\031\\005;\\005\\302\\212(\\2513\\336\\233\\232n\\365\\3067Q\\221\\377\\000\\352\\242\\303\\270QE\\025'\\3714\\032m&h\\030QE\\024\\2714\\352`\\245\\315\\000\\024QE;\\370\\250?v\\233I@\\005\\024QO\\244\\343\\352)(\\357\\355H\\002\\212(\\245\\243\\212A\\201H\\\\S\\013\\205\\024QJs\\212w\\035\\272T[\\366\\255(q\\273\\336\\213\\012\\341E\\024T\\224\\247\\216\\224\\300h\\317jC\\270QE\\024\\374\\377\\000\\372\\251=\\351\\274\\321@\\256\\024QE;4f\\233\\220\\277\\305I\\221\\322\\230\\302\\212(\\247sF{\\322\\003\\362\\321\\374\\215\\001p\\242\\212)s\\372\\321\\357\\322\\233\\372Q@\\302\\212(\\245\\315(?\\2357\\371Q@\\202\\212(\\247dQ\\237\\366\\251\\264\\177\\015\\001p\\242\\212)\\371\\2434\\3123E\\206\\024QE?4\\023L\\310\\244\\376\\032,\\027\\012(\\242\\237I\\232=\\3519\\315\\000\\024QE;>\\237JA\\326\\222\\227\\365\\240\\002\\212(\\245\\366\\357\\351H?ZJA\\236\\224\\005\\302\\212(\\247\\347\\212)>\\275h\\317\\024\\000QE\\024\\357\\275E4\\032)\\000QE\\024\\341K\\3153?-\\031\\240\\002\\212(\\247\\346\\223\\332\\233\\376sF~j\\000(\\242\\212~E&i\\271\\355FwP\\027\\012(\\242\\227#\\275\\024\\231\\243<\\363L\\002\\212(\\245\\343\\374(\\353\\365\\244\\317\\245\\003\\232\\000(\\242\\212ZJ?\\032?\\206\\200\\012(\\242\\226\\222\\216\\277J=h\\000\\242\\212(\\311\\377\\000\\032)(\\377\\000"\\200\\012(\\242\\227?\\200\\243?\\375z2i\\271\\371z\\320\\001E\\024S\\275(\\006\\223\\374\\212(\\000\\242\\212)s\\232?\\206\\2234q\\212\\000(\\242\\212Q\\2323H)9\\374h\\013\\205\\024QN\\3104f\\2234\\231\\353E\\200(\\242\\212\\200\\2145 4\\323\\317\\370\\323{`\\326\\2669\\202\\212(\\247\\236\\237z\\217jCA?\\375jb\\270QE\\024\\361\\330Q\\357L\\311\\335Fjl0\\242\\212)\\333{\\355\\245\\367\\355I\\237\\2274\\334\\341\\250\\000\\242\\212)\\364\\237w\\212(\\373\\337\\303@\\005\\024QJ(\\376\\264\\231\\364\\375h\\357\\374\\350\\000\\242\\212)qG\\265'+K\\322\\200\\012(\\242\\217\\257\\345G?JN\\177\\0128\\357@\\005\\024QG\\335\\374(\\377\\000\\201Rs\\267\\326\\2274\\000QE\\024\\236\\264p):6\\177\\012u0\\012(\\242\\201\\367}\\2504Q\\372z\\322\\000\\242\\212)rE\\031!\\275\\251\\243\\375\\356i\\177\\212\\200\\012(\\242\\235\\221\\377\\000\\327\\2439\\246\\232Z\\012\\012(\\242\\2274f\\223"\\212\\000(\\242\\212vh'u7\\374\\346\\212\\002\\341E\\024S\\250\\244\\034\\0323\\332\\200\\012(\\242\\226\\212O\\362)=\\250\\000\\242\\212)\\373\\315\\036a\\246g\\375\\237\\316\\224\\322\\260]\\205\\024QO\\022\\032]\\364\\312oJ,;\\260\\242\\212*L\\223\\317Z\\\\\\374\\265\\037\\024g\\362\\242\\301p\\242\\212)\\343\\371Q\\232L\\363\\364\\243?/4\\014(\\242\\212^\\364\\264\\322sE\\000\\024QE:\\223\\212Nh\\240\\002\\212(\\243\\376\\005K\\223\\353IG^O\\345@\\256\\024QE.\\343I\\237\\306\\212A@\\302\\212(\\245\\310\\355\\370\\321\\237\\376\\265%\\024\\000QE\\024\\271\\243\\371\\322Q\\3744\\000QE\\024\\2714o4\\224f\\201\\\\(\\242\\212\\\\\\236\\224d\\355\\373\\324\\237Z(\\013\\205\\024QK\\223\\337\\245(\\177^)\\231\\033}\\251~\\355\\001v\\024QEI\\221A?\\356\\347\\275DO4}9\\242\\305s\\005\\024QS\\321P\\203\\217\\306\\227y\\351\\272\\246\\301p\\242\\212*Ri\\277\\344S7\\234\\321\\274\\323\\260\\356\\024QEK\\315\\034\\324[\\317\\367\\251?\\255+\\005\\302\\212(\\2518\\242\\243\\316i3\\362\\325X\\\\\\301E\\024T\\277\\314S\\277\\340U\\016O\\367\\2512jl;\\205\\024QS\\364jN\\230\\025\\016M;y\\351E\\203\\230(\\242\\212\\224\\032*!'\\3734\\273\\305\\026\\013\\205\\024QO\\316h\\317\\031\\246u\\\\\\323\\207\\345AAE\\024S\\250\\246\\347\\363\\243\\370x\\346\\200\\012(\\242\\212u6\\216zv\\240\\002\\212(\\245\\375h\\317\\247\\345I\\221G\\245\\000\\024QE.r(\\317\\024\\337\\273K\\232\\000(\\242\\212u74\\234\\364\\245\\240\\002\\212(\\240\\237Z26\\322Q\\232\\000(\\242\\212\\\\\\361\\357@\\375i3G\\364\\240\\002\\212(\\245'+\\2323\\266\\231\\232)\\330\\002\\212(\\247\\203\\376\\325\\024\\317z?\\212\\200\\012(\\242\\235\\236\\224\\231\\030\\343\\363\\244\\372P)\\200QE\\024\\357\\363\\232L\\205_\\353IE \\012(\\242\\253\\034S\\263M=}i>\\225\\251\\314\\024QE;\\351\\370R\\346\\231\\315-\\000\\024QE;\\267\\255\\031\\246\\347\\037\\305\\315\\031\\371\\250\\000\\242\\212)\\307\\356\\322\\323\\001\\243?\\376\\252\\000(\\242\\212x?.i3M\\317\\245:\\220\\005\\024QK\\221F~n:\\3238\\340S\\263\\351\\370\\320\\027\\012(\\242\\237\\232?\\340U\\020=\\351s\\216\\224X\\002\\212(\\247f\\214\\376t\\231\\374h$P\\001E\\024R\\321\\232o\\035\\372R\\375\\352\\006\\024QE.h\\244\\243\\373\\324\\000QE\\024\\274\\320}{\\321\\232?J\\000(\\242\\2129\\353\\273\\353K\\236\\375\\351)=\\250\\000\\242\\212)\\335(\\377\\000"\\222\\217\\342\\240\\002\\212(\\245\\317\\245\\003\\322\\223\\237\\312\\217\\342\\240\\002\\212(\\245\\344\\321\\306)2(\\376\\224\\000QE\\024\\352)\\277\\360\\032\\017\\353H\\002\\212(\\247g\\362\\245\\3153?\\225\\004\\356\\376*@\\024QE;4\\240\\374\\264\\317\\273G\\371\\024\\354\\001E\\024S\\301\\317_\\302\\212O\\342\\242\\221AE\\024R\\321I\\237\\306\\227\\326\\200\\012(\\242\\235M\\342\\217aE\\000\\024QE.h\\353\\300\\372Rg\\2414P\\001E\\024R\\223Fi8\\034\\321\\315\\000\\024QE:\\223\\255&\\177*h&\\213\\000QE\\024\\377\\000\\362):\\177Z3\\232;}h\\000\\242\\212)\\177\\225%\\031\\315\\031\\315\\000\\024QE.zw\\024f\\223\\336\\214\\320\\001E\\024S\\275\\251\\277\\336\\315!\\374\\351s\\363PPQE\\024\\354\\321\\374\\\\S)h\\000\\242\\212(\\377\\0008\\247r\\264\\301E\\000\\024QE.}h\\342\\2234P \\242\\212)sE\\037\\305I@\\302\\212(\\245\\377\\000\\365\\321\\374\\2512~\\264\\276\\264\\000QE\\024\\354\\323i>\\224q\\212\\000(\\242\\212Ph\\243=\\251?\\212\\200\\012(\\242\\227\\257N\\264\\032O\\342\\245\\240\\002\\212(\\242\\217\\341\\315\\037J:\\320\\001E\\024Q\\232=\\250\\343\\245 ?5\\000\\024QE.\\177\\332\\307\\265('\\353I\\357I@\\005\\024QRo9\\243x\\037\\215E\\365\\351G\\326\\213\\016\\354(\\242\\212\\237xj3P\\373R\\377\\000*V\\013\\205\\024QO\\351N\\373\\325\\026N\\357j7\\237\\302\\213\\005\\302\\212(\\251s\\362\\361I\\236>\\367J\\217~z\\321\\277\\345\\376tXw\\012(\\242\\237GJL\\322o\\371\\275(\\260\\\\(\\242\\212vh\\3157vi7|\\276\\364X\\002\\212(\\247\\347\\364\\244\\315\\034})\\271\\240\\002\\212(\\247\\346\\214\\322q\\336\\233\\307\\341@\\005\\024QO\\316)3M\\3158~\\264\\300(\\242\\2123\\353I\\237\\233\\212_\\275M\\317\\315\\307\\347@\\005\\024QO\\315\\031\\371i\\224\\271\\375)\\000QE\\025X\\343u'\\361-)\\353\\317_ZN\\374V\\2470QE\\024\\271\\374\\351i\\246\\203L\\002\\212(\\247Sy\\335G;x\\245=h\\000\\242\\212)\\177\\206\\223?- \\365\\242\\200\\012(\\242\\227\\030\\244\\317\\313E\\037\\344P\\001E\\024S\\271\\240~t\\332:\\322((\\242\\212vG\\347KL\\377\\0008\\247\\017\\225i\\022\\024QE.wQ\\365\\364\\244'\\322\\233\\232\\012\\012(\\242\\224cw\\336\\245\\037-7?\\255\\031\\365\\246\\001E\\024S\\301\\371h\\246\\344\\006\\245\\310\\244\\001E\\024S\\363\\326\\212f{\\322\\203E\\200(\\242\\212?\\207>\\264\\357\\341\\342\\233\\235\\334\\321\\223\\377\\000\\327\\240\\002\\212(\\247R\\324O"\\242\\222\\335*\\263\\336\\036\\212\\270\\347\\2555\\026\\366&\\351\\005\\024QWi2;\\262\\343\\326\\263\\036W~K})\\231=OZ\\277e\\346/h\\024QE_{\\270\\307\\035i\\246\\364vJ\\245\\236\\2777\\024o\\253\\366H\\\\\\314(\\242\\212\\273\\366\\324\\376\\353\\001A\\275U\\376\\014\\325"I\\246\\357\\364\\243\\331 \\366\\214(\\242\\212\\270o[\\373\\213\\217z\\032\\365\\273"\\217\\2575S\\370\\250\\315?g\\036\\304\\3630\\242\\212*\\307\\332\\345\\356\\330\\251c\\275=\\031W\\360\\252<\\376t\\017n\\264{4W3\\356\\024QEk\\307,o\\321\\271\\364\\245\\336\\271\\306\\345'\\275d\\347w\\370\\321\\223\\237^\\365\\036\\313\\314~\\323\\310(\\242\\212\\330\\376tw\\342\\262\\322\\342D^\\037\\363\\251\\205\\351\\003\\224\\311\\250t\\230\\375\\242\\012(\\242\\257g\\265(5Z;\\270\\334s\\301\\367\\251\\203\\206]\\312\\312G\\265CMn]\\327@\\242\\212)\\331\\242\\232X\\017\\342Z<\\305=\\031s\\376\\365\\026\\000\\242\\212)\\331\\245\\316?\\372\\364\\231\\347\\2328\\333@\\005\\024QN\\244\\317\\037\\312\\220r3G\\267\\343@\\005\\024QF\\177\\332\\245'o\\322\\222\\212\\012\\012(\\242\\227?7\\365\\244\\242\\202{\\372\\320\\001E\\024Q\\237\\2274g\\346\\367\\246\\347\\346\\342\\226\\200\\012(\\242\\227?\\341K\\234\\2653\\221\\364\\243\\353E\\200(\\242\\212x=}\\351\\011\\037A@\\315\\031\\240\\002\\212(\\243"\\214\\376T\\017\\367\\250\\240\\002\\212(\\247f\\212e-\\026\\000\\242\\212(\\317\\313\\223J\\015%\\037\\360\\032\\000(\\242\\212vh\\3150\\023\\323\\255'!\\250\\000\\242\\212)\\336\\324\\037j?\\207\\357RP\\001E\\024R\\365\\346\\217j=(\\353@\\005\\024QJ\\015/\\374\\006\\232~\\365\\035>\\224\\000QE\\024\\271\\364\\240\\036\\364\\224u\\240\\002\\212(\\245\\376t\\202\\214\\236\\324PPQE\\024\\017\\367i\\324\\332J\\000(\\242\\212_\\341\\365\\243\\376\\005E\\031\\240\\002\\212(\\245\\317\\315K\\232h4P\\001E\\024R\\361\\365\\244\\353G\\322\\214\\355\\346\\200\\012(\\242\\212?\\225\\037\\316\\217\\341\\240\\002\\212(\\243\\332\\214\\320h\\002\\201\\005\\024QG4RR\\237\\363\\212\\006\\024QE;\\376\\005M\\311\\374\\350\\242\\201\\\\(\\242\\212v\\372^\\264\\317\\347\\336\\222\\225\\202\\341E\\024T\\224\\337\\275\\364\\244\\335L{\\204\\215s#(\\372\\265\\026e\\\\(\\242\\212\\227\\372Q\\221Y\\322\\352\\361\\205\\304J\\314}O\\002\\252\\035Vw\\\\\\005U\\307^\\365\\242\\2417\\320\\207V+\\250QE\\025\\273\\232Bk\\000jWK\\234\\262\\237\\252\\325\\353}U$!f]\\204\\364#\\245\\016\\204\\242\\012\\254XQE\\025h\\361\\232L\\320Ojo\\364\\240\\310(\\242\\212w^(?*\\362\\324\\231\\371y\\244\\343\\277\\024\\010(\\242\\212p4\\337\\342\\316\\356j7\\270@\\331\\352}\\251\\237j\\033\\276\\353Ur\\260\\272\\012(\\242\\254\\363F}\\177\\012\\257\\366\\225\\357\\270S\\205\\304\\177\\336\\245\\312\\373\\005\\320QE\\0257\\322\\216*!*7;\\327\\024\\340\\352\\337\\305\\232,;\\205\\024QN\\367\\355K\\374Y\\246\\347\\037\\215/O\\361\\244\\001E\\024Q\\367is\\351\\333\\241\\246\\217\\275Fz\\367\\364\\240\\002\\212(\\245\\244\\317\\341\\232\\\\Rg\\365\\357L\\002\\212(\\247{t\\243\\336\\233\\357\\326\\227\\200\\264\\200(\\242\\212?\\212\\201\\307\\024\\303:\\017\\342\\250\\236\\354\\005\\030\\371\\251\\250\\267\\320WAE\\024U\\237\\2555\\334 \\345\\277\\012\\246\\367/\\267\\003\\203\\353P\\274\\214y-\\311\\356j\\3257\\324\\034\\202\\212(\\253or\\271\\371y\\036\\265\\021\\272v\\350\\312\\265\\006i\\277Z\\321SDs0\\242\\212*B\\345\\272\\362{\\323x\\244\\037\\225\\007\\037\\235U\\204\\024QE.h&\\223\\037\\376\\252Z@\\024QE\\031\\240c\\220i9j=\\350\\000\\242\\212(\\024\\264\\206\\217\\347T\\001E\\024Q\\367\\233\\236\\324\\237\\360\\037\\257\\245/\\007u\\037\\305A!E\\024R\\177\\017\\277j\\\\\\377\\000\\263\\365\\244\\317\\377\\000\\250R\\347\\346\\240\\240\\242\\212(\\364\\365\\245\\030\\333\\217\\322\\2234f\\200\\012(\\242\\214\\235\\336\\364g\\024\\032o\\360\\214P\\001E\\024S\\350\\317\\341\\351M\\376\\034u\\245\\376*\\220\\012(\\242\\237\\274\\177z\\200s\\365\\246\\177\\222(\\242\\300\\024QEJ\\227\\022'G\\377\\000\\365U\\205\\276?\\304\\277\\227\\025L~F\\217AI\\301>\\203Rh(\\242\\212\\325\\216\\356)z6=sRg5\\215\\3374\\241\\330.\\0030\\037\\326\\263t{\\026\\246\\024QEl\\012v\\341X\\351q \\301\\335\\371\\373\\324\\361\\337\\267\\361\\257\\002\\245\\322c\\366\\210(\\242\\212\\320\\317\\373X4\\237\\312\\241K\\230\\344\\307\\315\\214\\372\\324\\240\\203\\214t\\355Y\\331\\242\\356\\024QE:\\212ni\\331\\315\\000\\024QE&\\177\\372\\364\\207\\024\\177\\025\\031\\377\\000\\365\\320PQE\\024\\357\\273M\\367\\243'm\\003\\356\\342\\202B\\212(\\247\\177\\0154\\232?\\207\\353Fh((\\242\\212vi\\271\\024\\014b\\216\\213\\317A\\311\\240\\002\\212(\\243\\371\\032uU\\222\\356\\024\\352\\353\\351\\201P\\276\\243\\030\\341U\\215R\\204\\237By\\227p\\242\\212*\\376M\\033\\253<\\352co\\372\\246\\015\\217\\302\\242:\\214\\234|\\253\\212\\245F]\\205\\355#\\334(\\242\\212\\324\\317\\377\\000\\252\\235\\374U\\220u\\031\\213\\177\\010\\247\\377\\000i?e_|\\321\\354d\\036\\321\\005\\024QZ|Q\\300\\344\\364\\254\\237\\355\\011\\363\\306\\337\\2451\\357'\\221X\\027\\300\\366\\247\\354d/h\\202\\212(\\255g\\221\\021~fQQ\\311y\\004}_'\\260\\025\\212\\357\\274\\345\\331\\217\\326\\223#\\373\\275*\\325\\005\\325\\222\\352\\276\\201E\\024V\\251\\325\\021w|\\214j#\\252\\2340X\\277\\361\\352\\315\\337\\371v\\245\\337W\\354b/h\\302\\212(\\253\\317\\250\\316\\315\\221\\264c\\265\\003R\\230uX\\352\\226F\\352?\\207\\006\\253\\331G\\261<\\362\\356\\024QEj\\246\\243\\027\\031F\\031\\353S\\307wo'G^x\\254=\\331\\245\\376/\\245C\\241\\022\\225W\\324(\\242\\212\\350\\270\\351\\374\\351O5\\205\\025\\344\\261\\267\\336\\334\\243\\261\\253\\321\\352H\\377\\000}Y}\\307"\\261\\225\\031#EQ0\\242\\212*\\377\\000\\364\\240T1\\317\\024\\213\\362J\\247\\025'\\037\\347\\232\\316\\305\\205\\024QG\\364\\247f\\233\\315G$\\361\\306p\\314\\243\\270\\242\\327\\000\\242\\212*ZL\\372UQ\\250E\\234\\036\\236\\265\\024\\232\\234c>Z\\261\\367\\355T\\251\\313\\261<\\313\\270QE\\025\\241\\305'\\277\\351Y\\217\\252\\235\\270X\\271\\317\\007uD\\372\\234\\371\\343h\\377\\000\\200\\325*3\\354/i\\020\\242\\212+`\\036ik\\014jW\\001\\262Yq\\351G\\366\\244\\352\\307;q\\311\\305W\\260\\220\\275\\252\\012(\\242\\266\\377\\000\\212\\220\\270\\013\\223\\267\\361\\342\\260\\237T\\270n\\003*\\375*\\007\\235\\335~gf\\307L\\363Ma\\245\\324N\\252\\350\\024QEoI{\\004\\177\\307\\234\\361\\3075NMT\\347\\367i\\371\\326N\\363F\\363[,<V\\344\\272\\254(\\242\\212\\267-\\375\\304\\215\\215\\330\\007\\260\\252\\305\\213uni\\271\\246\\346\\265PKdC\\223aE\\024S\\363FGJg\\275\\025v$(\\242\\212~{\\320\\016\\336\\277Zfi\\331\\245`\\012(\\242\\255\\227p\\307\\014\\303\\025,wr'%\\267\\017z\\256\\377\\000{\\357Rt>\\265\\217*kP\\270QE\\025h\\3361R\\013m\\244/\\275\\262[9\\252\\335?\\255\\031\\371\\263G"\\350\\027\\012(\\242\\254\\344\\377\\000J\\011\\250D\\207\\353O\\336\\032\\225\\200(\\242\\212~\\177:2;sIE\\000\\024QE/\\364\\243?\\355b\\217\\326\\217\\370\\027J\\220\\012(\\242\\244\\0220o\\274\\331\\247}\\246O\\357g\\353U\\362h\\372sG**\\354(\\242\\212\\261\\366\\231\\177\\331\\346\\244[\\261\\321\\277\\036\\342\\252\\177:N?\\375T\\271\\027a\\335\\205\\024QZ/p\\233xl\\324&\\354\\356\\342\\252\\375\\356\\264\\237z\\222\\246\\203\\231\\205\\024QS\\031\\330\\257\\336\\3439\\246\\027-\\325\\233\\232a'\\241\\374\\351x\\252\\345B\\270QE\\024\\271\\242\\230\\\\v\\243y\\376\\225V\\000\\242\\212)\\337\\305\\357K\\232f\\377\\000\\233;x4\\335\\377\\00074X\\002\\212(\\251?\\213\\336\\212nE\\034m\\240\\220\\242\\212)\\334\\321\\375h\\347\\361\\243\\370\\250((\\242\\2123\\232\\015\\024\\003A!E\\024SqK\\367V\\220zQ\\365\\240\\002\\212(\\245\\347\\362\\245\\024d\\377\\000v\\212\\000(\\242\\212?\\212\\214S\\177\\340X\\245$\\376\\024\\024\\024QE%:\\233\\305\\035h$(\\242\\212^\\027\\333=\\251>\\357_\\245\\037\\316\\235\\374\\350((\\242\\212\\015&}y\\2444\\177\\015\\000\\024QE\\003\\345\\243\\373\\337\\235\\031\\317\\341Fh\\000\\242\\212)~\\235{P\\000\\333I\\237N\\264g\\357\\032\\000(\\242\\212p?/\\362\\243>\\224g\\363\\242\\200\\012(\\242\\233\\312\\255/\\015I\\307J3\\371\\320\\001E\\024R\\344\\377\\000\\365\\251i\\274u\\333FE\\000\\024QE\\004\\372\\325\\210.\\032.?\\203\\322\\240\\310c\\303qI\\275v\\343w\\322\\245\\253\\351a\\246\\024QEi\\307r\\222q\\323\\32357\\276\\334\\032\\304.\\273[\\034S\\376\\322\\310\\303\\016\\336\\325\\233\\243\\330\\265S\\270QE\\025\\263\\315'N\\265\\223\\366\\367\\376\\363\\037zc\\335\\310\\371\\371\\262\\017j=\\214\\207\\355\\020QE\\025\\261\\346/wQ\\334\\320%\\211\\217\\016\\265\\203\\346\\265&\\366\\371E?a\\346/i\\344\\024QEm\\275\\314(\\271g_\\303\\232\\256\\332\\202\\205\\371W\\351\\232\\313\\313\\025\\243$U\\306\\202\\352'Q\\205\\024QV\\336\\376c\\355\\364\\250\\236\\342W\\030\\336\\304u5\\001oJ>\\265\\242\\246\\227B9\\237p\\242\\212)\\347\\326\\216\\234Ty\\377\\000\\353\\321WbB\\212(\\251\\013\\342\\232d\\355\\371Sr>\\224\\332,PQE\\024\\375\\371\\347\\265\\005\\3152\\227\\352\\271\\247bB\\212(\\247\\222qHz\\375\\352?\\340])\\271\\377\\000\\353\\032\\000(\\242\\212u\\024\\037_J\\001\\004q\\317\\275\\000\\024QE\\031\\371\\261\\371Ps\\375\\352dS,\\312J\\266@8?\\205C\\366\\310\\226\\031$\\357\\036x\\365\\245f\\001E\\024U\\234\\321T\\016\\246\\206TE\\350P\\263\\037B\\005S\\217Ya\\020\\005w?\\\\\\3765j\\234\\212\\324(\\242\\212\\333\\377\\0008\\2438\\376\\265\\203&\\254\\356\\221\\354l6\\363\\237\\247jk\\352\\215\\376\\222;\\267\\3355^\\311\\205\\202\\212(\\255\\343&1\\236\\347\\003\\353L\\027p\\227 7 \\343\\361\\0035\\316\\215BL\\301\\237\\273\\036?\\034T&\\342]\\304\\2430$\\226\\374\\370\\247\\354B\\301E\\024WC>\\251\\00419M\\245\\273\\001U\\343\\327&\\0219\\017\\264e@_\\250\\346\\260\\262\\177\\275\\311\\246\\222v\\375\\356*\\275\\224{\\016\\301E\\024WPu\\221\\276\\030\\313\\267\\3142\\307w\\003\\212\\2055\\230^W\\363\\033\\000\\036\\017\\2575\\316\\363\\337\\360\\242\\217c\\036\\301`\\242\\212+\\245\\213S\\215\\354\\332i6\\202\\011R=\\352\\314w) \\336\\215\\301\\003\\365\\256<\\023\\267\\333\\265H\\222\\276\\314\\007\\300=htPX(\\242\\212\\352\\315\\312\\024f\\034\\355\\316\\177\\012"\\235f\\211]\\033\\206\\344W*%u\\017\\030o\\225\\276\\365>;\\271cd\\001\\233\\3459\\002\\217d+\\005\\024Q]G4\\265\\204\\232\\303\\3712n\\346L\\215\\237\\235D5Y\\302\\347vNzv\\002\\247\\331\\260\\263\\012(\\242\\272\\037jO\\342\\376\\225\\2165c\\344\\270?\\3533\\225\\364\\305\\\\\\212\\375\\036\\026}\\334\\216\\000>\\302\\227#D\\332\\301E\\024U\\314\\376\\224\\352\\203\\317M\\340n\\353\\376\\325\\021\\334G \\341\\271\\351\\217qJ\\314\\002\\212(\\251sE7#v=\\263Jq@\\005\\024QF}iM3=\\277\\0323\\333\\265\\000\\024QE>\\223\\332\\232X\\005\\004\\267^\\225\\023\\334*\\\\yn\\312>M\\331\\242\\300\\024QEh\\237\\376\\275&E5\\272\\221\\272\\212\\312\\300\\024QE;\\247\\364\\244\\317\\315\\375i>\\215F}h\\260\\005\\024QO\\341\\227\\353FM3?\\205\\031\\371i\\330\\220\\242\\212*@\\370\\351R\\007\\317Z\\204~\\224g\\345\\365\\251\\261AE\\024T\\340\\347\\374)\\331\\305W\\310\\035(\\337J\\300\\024QEM\\372\\372\\323\\252\\000\\376\\234\\320d\\355\\323\\326\\225\\200(\\242\\212\\224\\270\\035z\\323L\\201~\\225\\036{Q\\232v\\000\\242\\212)\\373\\313P\\011?\\305L\\346\\214\\3769\\247`\\012(\\242\\235\\232\\\\\\235\\334S3E\\026\\000\\242\\212)\\371\\035h\\3153\\372zQ\\237\\232\\213\\000QE\\024\\362\\177*S\\326\\233\\237\\226\\214\\374\\264X\\002\\212(\\245\\310\\245\\377\\000\\201S3\\332\\224}\\321E\\200(\\242\\212~KQ\\277\\361\\367\\246f\\201\\203J\\300\\024QE<>\\326\\365\\243x\\351L\\315\\006\\213\\000QE\\025&~j?\\245E\\235\\276\\324\\007\\365\\242\\300\\024QEJ\\177Z\\011\\355M\\0042\\347\\275.qH\\002\\212(\\245\\317\\245\\003\\377\\000\\326)\\231\\240\\223N\\300\\024QE?"\\220\\232fh\\377\\0009\\242\\300\\024QE;'\\263u\\244\\033\\203\\032\\006>o\\347G\\360\\320\\001E\\024PG\\373T}h\\316x\\243?5\\000\\024QE\\034\\355\\243=\\315&h\\310\\246PQE\\024\\277\\313\\245.~_\\353Q\\347\\275\\033\\377\\000\\012,HQE\\025!n\\364\\233\\302\\365\\250\\211=\\351sE\\200(\\242\\212~\\363I\\346\\037\\312\\233GF\\242\\300\\024QE;\\314\\364\\246\\223I\\377\\000\\353\\243\\376\\005N\\300\\024QE-\\031\\305'\\037\\205%0\\012(\\242\\235\\237\\226\\233\\326\\214w4\\357\\356\\320\\001E\\024RtZQ\\212o\\270\\374h'\\357R\\000\\242\\212)\\324\\337q\\371\\321\\303Pi\\200QE\\024R\\032\\017\\335\\243\\374\\363L\\002\\212(\\244\\367\\245\\343nh\\376t\\323\\212\\000(\\242\\2129\\242\\214\\321\\364\\355\\332\\230\\005\\024QGz=)\\206E\\217\\004\\262\\200\\177.*\\275\\315\\357\\222\\320le!\\317\\351E\\233\\000\\242\\212*\\335/\\361V|\\372\\217\\222\\223\\020\\312H8Q\\364\\306j\\244z\\263y\\337?\\372\\263\\316}\\252\\224\\033\\013\\005\\024QZ\\376|^W\\230[\\012;\\375\\0155\\356bF\\013\\273\\234\\023\\371W5%\\313K\\307`I\\374\\351\\262\\\\<\\233r\\335\\001\\003\\3615\\247\\262\\363*\\301E\\024V\\331\\325\\220\\304\\257\\267\\004\\222\\010\\364\\000VU\\265\\364\\226\\322\\3443\\020F0j\\251?-\\031\\357V\\240\\220\\354\\024QEO\\025\\323\\306\\217\\0327\\014sQ\\371\\205\\327\\033\\270\\346\\242\\373\\275(\\373\\270\\252((\\242\\212pr\\274\\356\\306(\\317ze;\\205Q\\355L\\002\\212(\\244\\031\\374\\251\\303\\327\\326\\214\\374\\274q\\353Fv\\322\\000\\242\\212)q\\367sJ0\\253\\237\\322\\232M\\037\\316\\200\\012(\\242\\223\\215\\315K\\223\\266\\232\\203w\\005\\272\\367\\247\\014*\\032\\000(\\242\\212\\034|\\240~4s\\267\\024\\323\\367\\224\\376\\224\\244\\355lP\\001E\\024R{Rg\\255.{\\322s\\363\\032\\000(\\242\\212?\\207\\365\\243\\235\\277CA?.\\177J>\\224\\300(\\242\\2123\\266\\224\\221\\371\\322s\\273\\326\\227\\356\\322\\000\\242\\212(\\316~\\270\\245\\016v\\343v\\007<Rc\\346\\366\\245\\030\\333\\367h\\000\\242\\212*A<\\233~\\367NA\\372S\\343\\270x\\333\\357pNH\\372\\212\\207;\\225\\261L'\\356\\320\\001E\\024U\\330\\265\\011S~['\\000/\\340j\\344Z\\270*|\\305\\301\\306T\\373\\3268!\\223=M'\\014\\242\\247\\2212l\\202\\212(\\255)5\\027\\027\\241\\303.\\305\\371}\\210\\247\\337_\\224\\2701\\247A\\214\\373\\361YY\\033\\263\\333\\276(}\\314\\354O^\\2474\\371PX(\\242\\212\\276u\\031\\012F?\\271\\217\\304\\212\\246\\3624\\255\\222\\3315\\026\\376\\324\\341\\235\\271\\353G)V\\012(\\242\\273G?7\\326\\223&\\232O'\\270\\245\\316+\\226\\306\\001E\\024R\\346\\214\\374\\324\\224f\\200\\012(\\242\\2274\\354\\377\\000\\372\\251\\231\\371\\2513\\376\\327\\275\\026\\000\\242\\212*\\\\\\321\\232\\217\\2322)X\\002\\212(\\2513\\336\\217\\342\\246Q\\237Z,\\001E\\024S\\363FE3==h\\242\\300\\024QE?\\247\\271\\355Fi\\231\\371x\\2434X\\002\\212(\\247\\203\\206\\243?\\2352\\235\\232,\\001E\\024S\\317\\265 ?\\375zf\\357\\366\\250\\351J\\300\\024QEI\\2322)\\224\\235{\\323\\260\\005\\024QRg\\326\\214\\342\\230q\\305\\024\\200(\\242\\212~~j\\001\\355L\\315\\024X\\002\\212(\\247d\\322\\214n\\366\\246\\363\\375\\3523\\363PPQE\\024\\354\\322\\346\\231E+\\022\\024QE<\\320H\\246gm.x\\024X\\240\\242\\212)\\303\\356\\373Q\\221\\326\\2234\\334\\361\\237Z,\\001E\\024S\\351~\\367J\\217;h\\317n\\324X\\002\\212(\\251sEC\\277\\232\\013\\366\\335E\\200(\\242\\212\\227=\\315&v\\324$\\320O\\2474\\354\\001E\\024T\\331\\024\\026\\305AK\\223\\323\\267z,\\001E\\024T\\206JBOC\\332\\230\\015\\031\\364\\351N\\300\\024QE>\\202{\\367\\246dQ\\232,\\001E\\024S\\371\\243\\241\\342\\231\\232vh\\000\\242\\212)sF~jfiG\\336\\240\\002\\212(\\247\\0123\\307\\2457w\\315\\364\\247\\016h\\000\\242\\212(\\376^\\264\\340)\\273\\276_z3\\272\\220\\005\\024QJO\\345JO\\347Q\\237\\327\\322\\2274X\\002\\212(\\245\\2434\\231\\371i\\271\\246\\001E\\024S\\351\\011\\377\\000f\\233\\377\\000\\002\\351L2*\\021\\226\\3018\\0304X\\002\\212(\\251=\\272\\346\\223\\257\\343T%\\324\\343U\\230\\016$@q\\236\\365^\\347P\\331p\\3407\\356\\366/\\347T\\240\\300(\\242\\212\\325\\222@\\210\\347\\256\\321\\317\\341P\\213\\245\\373 \\270<\\002\\231\\305cO~\\3224\\370o\\221\\210\\300\\252\\362^3\\252G\\273\\205M\\270\\253T\\212\\260QE\\025\\257q\\250\\345 163&\\010\\252\\363\\352\\016\\227\\263z\\001\\260VO\\230v\\375\\016E4\\27333\\036\\374\\326\\252\\232C\\260QE\\025nK\\306\\222\\334D\\315\\235\\244\\221\\371T2\\\\<\\212\\200\\267\\0100\\007\\265E\\374X\\243\\247\\363\\247`\\260QE\\024\\244\\226\\340\\362\\007o\\255\\031\\306\\343I\\374C=\\351\\011\\252((\\242\\212\\\\\\236N\\352O\\274\\255H>onqJ\\011-\\200\\270\\240\\002\\212(\\243\\357-8}\\332m\\031\\012\\270\\365\\240\\002\\212(\\245<\\376tqI\\237N\\017AG\\257|P\\001E\\024R\\347\\345\\243\\035\\351\\001\\012\\274w\\243#w\\267z@\\024QE.1\\326\\202\\006\\352L\\366\\245\\036\\364\\000QE\\024\\237uis\\237\\312\\216\\032\\223\\370\\277J\\000(\\242\\212_\\273J>eZi?+\\012\\007\\314\\252E\\000\\024QE\\034q\\371\\320\\340\\262\\344~t\\207\\356dR\\347\\267lP\\001E\\024Sr6S\\263\\3764cr\\217\\322\\233\\317\\345@\\005\\024QJ~U\\243\\225\\351\\365\\246\\277\\336\\024\\270\\355\\351L\\002\\212(\\247o\\371T\\320yoza\\373\\336\\302\\235\\237\\227\\216\\264\\000QE\\024\\240\\345\\250\\317\\257CG\\035}x\\246\\344m_j\\000(\\242\\212\\177;\\277\\225&1\\267\\333\\275\\003\\371\\323rv\\320\\001E\\024S\\261\\267?JD==E)?\\347\\353M\\343\\237S\\351@\\005\\024QO\\037/\\275!?.O~\\337ZnB\\364\\351\\212\\011\\371A\\372\\012\\000(\\242\\212O\\342Pi\\343*\\254)\\274n\\300\\240\\377\\000*\\000(\\242\\212\\354\\2163I\\236\\224\\247\\346ojJ\\3450\\012(\\242\\227?5\\024\\237\\312\\200\\177\\034\\320\\001E\\024R\\344\\321\\3744\\231\\242\\200\\012(\\242\\226\\214\\322f\\214\\320\\001E\\024R\\322\\344\\237\\2457\\336\\214\\322\\260\\005\\024QO\\243>\\224\\314\\322\\346\\213\\000QE\\024\\354\\321M\\376/\\245\\037\\360\\032@\\024QE;\\237\\357Q\\232o\\360\\321@\\005\\024QO\\243\\351L\\243\\255\\026\\000\\242\\212)\\177\\340_\\205/\\322\\217\\341\\3056\\200\\012(\\242\\237\\372\\223Fi\\231\\374)\\222\\313\\034(\\322H\\330\\002\\213\\014(\\242\\212\\233&\\214\\346\\262\\347\\326-\\341\\227f\\354\\214\\036j\\225\\307\\210J\\271\\362\\223\\201\\320\\232\\265M\\215E\\205\\024Q]\\010oZ\\257=\\355\\275\\263\\001+\\340\\234c\\361\\256`\\353\\027E\\031\\003\\365\\311'\\353Ue\\271{\\227\\337+t\\030\\037\\205R\\245\\334\\265O\\270QE\\025\\326\\313\\252\\332D\\204\\371\\252J\\234m\\356y\\252\\307^\\267\\336\\273U\\210 \\344\\372\\032\\3468?ZnF\\314~uJ\\234J\\344AE\\024V\\361\\361\\013\\031\\262\\0231\\236\\307\\351H\\376 \\224K\\220\\237\\273(8\\367\\254Lm\\343\\266i\\243\\345\\300\\335\\356*\\271#\\3309PQE\\025\\321\\305\\342\\024m\\336bc\\323\\025e5\\233f\\316[\\011\\234)\\365\\256T\\377\\000\\365\\350\\033\\266\\343\\322\\247\\331\\3049PQE\\025\\332%\\36423\\215\\330\\330B\\363\\352i\\3512K\\277kgi!\\275\\210\\256,H\\353\\273\\346a\\222\\011\\374*h\\257g\\201[\\313v\\033\\272\\322\\366]\\211t\\302\\212(\\256\\307\\351I\\\\\\304Z\\275\\310Q\\036\\356{\\023Z\\261\\353\\020;\\244g\\214\\216O\\241\\250t\\332!\\305\\240\\242\\212+HQY\\261\\3530K7\\226\\027\\003 \\006\\2532\\336\\305\\033F\\013g~\\177J9_aY\\205\\024QVh\\246y\\350\\254\\203w\\337\\351K\\274o\\331\\273\\234g\\036\\3256\\000\\242\\212)\\300\\321\\305\\007\\212\\017\\347@\\202\\212(\\243?\\235;\\351L\\315&~Zv\\000\\242\\212*L\\321\\232fi\\001\\242\\300\\024QEI\\232L\\232fG\\341KE\\200(\\242\\212~i\\003\\232nh\\317\\312\\324\\254\\001E\\024T\\204\\342\\233\\274S=\\215!\\242\\300\\024QEI\\274S\\267\\374\\265\\016\\360\\245G\\257\\002\\253K\\177\\014=y \\221\\201\\352)\\362\\224\\024QE]\\317\\247\\341Q\\3178\\206\\027\\223r\\234\\016\\365\\217\\375\\256\\342`v\\376\\3579\\305Q\\226\\341\\244\\334;d\\234}MR\\245\\334,\\302\\212(\\255[\\335E\\243X^\\335\\224\\356\\007 \\325+\\273\\366\\222\\351dN\\213\\214UGvt@z(\\300\\246\\037z\\325A"\\322\\012(\\242\\244w.\\354ORy\\374i\\244\\355o\\322\\207\\373\\337J@F\\354\\325\\200QE\\024\\332\\010\\365\\247\\361\\262\\232~Z\\012\\012(\\242\\223\\322\\227\\370}\\351\\206\\235\\374T\\000QE\\024\\2474\\231\\351\\374\\350\\177\\316\\220\\023\\273\\332\\200\\012(\\242\\227 \\363\\351I\\237\\227\\216\\274\\321\\374D\\212L\\365\\240\\002\\212(\\245\\245\\316\\336j,\\366\\335\\232\\011\\371\\275\\273\\3200\\242\\212)\\300\\356\\376\\224u\\347\\351HN\\025\\261J1\\212\\000(\\242\\212\\011?6;Sr\\177\\375]\\250\\031\\335\\365\\244\\011\\327=\\350\\000\\242\\212)w\\355\\244\\007\\346\\247q\\371Q\\220\\277\\322\\200\\012(\\242\\223'o\\035irW9\\351\\324SC\\366\\243~W\\351@\\005\\024QJ\\011\\351J\\035\\252<\\376\\264\\200\\035\\331\\354(\\000\\242\\212*p\\377\\000\\355-8:\\364\\252\\237\\303\\370\\322\\362\\317H,\\024QEX\\3727\\326\\223\\370\\363\\355P\\022Cb\\237\\222\\253\\235\\324\\300(\\242\\212\\230}\\336z\\322\\373\\212\\204I\\353J\\034\\177\\365\\251\\000QE\\024\\374z\\366\\245#\\031\\246\\357\\035}h'r\\217\\233\\332\\201\\005\\024QG]\\302\\200~\\350=\\250\\317N\\364\\216?\\2350\\012(\\242\\225\\376Nwf\\233\\216\\335;\\323\\234\\015\\234\\177\\234P\\017\\315\\236\\330\\305\\003\\012(\\242\\215\\371\\\\\\364\\357M'r\\346\\214|\\324\\237\\303@\\005\\024QK\\316\\356)\\335\\177\\012n\\006\\336=)\\020\\235\\271\\240\\002\\212(\\247\\354;\\263\\370Ss\\265\\177\\213=(\\316)\\016\\177:\\000(\\242\\212\\221\\000+\\232R1\\327\\275F\\017\\311\\351\\212p'\\275\\002\\012(\\242\\273\\002~jL\\374\\337\\322\\220\\375\\352\\007\\034\\3271\\200QE\\024\\354\\321\\232O\\363\\232nM\\000\\024QE?4f\\223\\357Sz7\\362\\240\\002\\212(\\247\\346\\212a\\245\\317\\315\\367\\271\\240\\002\\212(\\247\\032uFO\\346i7\\374\\264X\\002\\212(\\251\\177\\340T\\322~j\\214\\237\\232\\201E\\200(\\242\\212\\223x\\024\\3373\\037\\303\\232\\214\\237\\377\\000]4:\\267FS\\353O\\224aE\\024T\\376a\\246\\357&\\250\\276\\243\\012D\\216[\\202\\344~UK\\373py_s2c\\257l\\325r\\215E\\205\\024Q[\\202CLyB.]\\324\\016\\265\\314\\177j\\334\\267\\311\\277\\030\\351Ud\\270\\226Vb\\316\\304\\223\\315?f_\\263aE\\024WQ&\\253m\\033\\354g\\365\\347\\320\\212\\244\\376 \\375\\327\\013\\227\\307S\\353\\\\\\361rI\\241\\315W")SAE\\024V\\234\\232\\315\\303\\354'\\250B\\277\\237z\\202]B\\342\\342!\\034\\217\\220\\016\\177\\032\\247\\316\\325\\374\\351R\\235\\221\\\\\\250(\\242\\212Bw~4\\034~t\\376:t\\241\\376\\357\\351L\\240\\242\\212)\\273\\360\\264\\344\\365\\246\\036x\\245\\316\\027\\024\\022\\024QE9>\\363\\035\\330\\024l\\333\\270\\356\\307j`=\\251K\\235\\264\\000QE\\024\\354\\365\\317>\\364\\364\\371T9\\365 \\323\\017n\\337\\375zS\\363.7w\\240\\002\\212(\\245\\311\\033M7=0\\335z\\323F~o\\347@\\371\\250\\000\\242\\212)\\345\\350\\316W\\036\\224\\230\\035\\233\\245\\003;~\\224\\000QE\\024\\375\\377\\0002~\\024\\354\\216\\233\\272\\036\\265\\026~_sM\\316\\345\\365\\240v\\012(\\242\\245\\004\\206\\372\\037\\345Ny\\031\\271-\\232\\210\\021\\267\\236\\346\\227\\205\\334=(\\020QE\\0251\\270}\\337y\\206:|\\325b-Fxe\\363C\\263\\2200A\\364\\252>\\276\\264\\271\\024\\254+ \\242\\212+j=q\\366\\260u\\313\\177^+U/!\\221\\022@\\313\\2078\\037Z\\343\\362C}\\356\\324\\341#m\\030l\\014\\376\\264\\234\\020\\2350\\242\\212+\\264\\342\\235\\232\\344\\343\\324.Q\\016\\307\\340\\236s\\353Z/\\254\\354\\231\\310\\344y`/\\326\\243\\221\\220\\340\\302\\212(\\255\\222B\\365\\243#v;\\3438\\366\\254\\013\\235`\\315\\026\\300\\270 \\3474\\327\\324\\331\\0267F\\313\\004\\303\\023\\334\\346\\216F\\034\\214(\\242\\212\\350\\377\\000\\212\\216\\330\\025\\227&\\246\\242T\\331\\317\\004\\260\\335\\307Ju\\325\\356\\333\\253P\\217\\327\\226\\036\\306\\247\\225\\223f\\024QEh\\324oq\\032)%\\261\\267\\257\\265R\\273\\324\\002\\031#V\\371\\207\\177J\\312\\226v\\232W\\220\\267\\336\\353T\\243\\334\\245\\020\\242\\212+zK\\305\\012\\341>\\360M\\303=*\\265\\336\\243\\261\\000\\217n\\357Z\\311y\\331\\331I\\354\\233\\177\\012i|\\252\\373U\\250 \\260QE\\025r[\\327\\233v[\\356\\234\\2028\\355T\\363\\271\\262y\\3157\\372\\321\\302\\252\\237\\255P\\302\\212(\\247\\202:\\364\\246\\177\\020\\244\\310\\333\\351Gn(((\\242\\212\\016v\\201K'\\312\\377\\000\\316\\220\\3106\\217\\227\\245!}\\355\\357L\\002\\212(\\245'\\347j9\\333\\236\\371\\300\\244\\3367g\\374\\361H\\\\\\363\\332\\220\\005\\024QO\\337\\205\\307\\345HHf\\367\\250\\313\\374\\242\\232\\\\\\356\\246\\001E\\024T\\244\\216\\224\\204|\\265\\037\\371\\024\\027\\373\\324\\000QE\\024\\374\\377\\000\\372\\351\\271\\334\\377\\000^\\224\\237Z\\001\\371\\230\\355\\240aE\\024S\\270\\331\\237J\\003\\356\\374j>\\276\\324\\344\\037/\\275\\000\\024QE\\031\\373\\335\\261M\\007k\\002h?\\375j7\\363@\\005\\024QN\\373\\314M\\003\\035\\0150\\311\\225\\240\\037\\233\\024\\000QE\\024\\375\\343\\346\\364\\246o\\335\\221L\\317\\316\\324\\244\\202\\331\\240aE\\024S\\207\\336>\\230\\024\\007\\333\\371\\323x\\244\\317z\\000(\\242\\212\\177\\361Q\\221\\270S\\001\\371i\\243\\370\\177Z\\000(\\242\\212\\177\\336\\300\\024\\340~U\\035sQ\\273\\343\\000~t\\360{\\367\\353@\\005\\024QI\\374<\\3751A\\307\\343H\\347k\\012\\016z\\372\\320\\001E\\024S\\211*\\331=\\351s\\372S?\\273\\355G\\255\\000\\024QE/V\\024\\354\\375\\357Zb\\021\\372R\\217Z\\000(\\242\\212\\\\\\374\\234\\364\\353JH\\335M\\337\\363sG\\335\\333\\236\\247\\255\\000\\024QE;'u\\033\\310\\343w~i\\216~j?\\306\\200\\012(\\242\\237\\277\\375\\246\\240?\\317L\\007\\346\\031n)\\271\\240\\002\\212(\\247\\011\\017\\367\\251\\373\\375j/\\342\\243\\370h\\000\\242\\212*S.\\336:\\320$+\\305E\\317\\315\\357R\\037\\272=\\250\\000\\242\\212)\\333\\376^h\\310m\\276\\225\\030\\371W\\217\\302\\200~ZC\\260QE\\025.GM\\264\\273\\306\\337\\303\\245C\\236\\347\\2123\\267\\353@X(\\242\\212\\354\\316C\\021M\\311\\2458n\\0057\\336\\2629B\\212(\\245\\336v\\322\\344\\356\\373\\325\\031`\\203%\\260:}\\356\\364\\303:/\\361\\343\\031\\037\\225\\026\\030QE\\0256\\374\\375GJ_0\\324\\036|\\1778\\336\\277'\\336\\366\\250M\\364\\000)\\337\\367\\210\\305;\\005\\202\\212(\\253\\271-I\\223Y\\277\\332\\260|\\377\\000{\\3458\\030\\357U\\247\\326~f\\021'\\034u\\375i\\330j,(\\242\\212\\332\\353\\357H\\362"`\\026\\306k\\236\\227U\\235\\212\\021\\362\\355\\034\\373\\232\\255%\\334\\3220gv$t\\247\\312R\\246\\302\\212(\\256\\231\\356\\340D\\311u\\000\\214\\325\\0115\\270\\221\\344\\001r\\007\\012}k\\015\\334\\234\\345\\263\\3053\\215\\264r\\026\\251\\256\\241E\\024V\\234\\232\\304\\322E\\345\\364'\\270\\252Iy2n\\001\\361\\236\\015G\\030;\\271\\246\\365\\335TRI\\005\\024QJK\\237\\223wC\\237\\316\\220}\\354S\\207\\012\\324\\0167\\032e\\005\\024QM\\007s\\321\\375\\357z\\000\\013\\270\\226\\2439j\\000(\\242\\212@?ZS\\367~\\365\\031\\371\\250\\311\\344\\320\\001E\\024Q\\306\\325\\364\\240\\034n\\036\\264\\337\\341\\2413@\\005\\024QA4\\351\\017\\313M\\0377ZC\\232\\000(\\242\\212Q\\236\\264\\021\\362\\347\\363\\245\\307\\313\\317zo\\265 \\012(\\242\\201\\367\\263\\332\\224}\\323\\217\\312\\224|\\253N\\007j\\346\\200\\012(\\242\\2209\\352h\\315\\031\\037\\201\\240\\222\\333s@\\005\\024QJ\\017\\313\\203\\370Q\\223H(\\310\\240\\220\\242\\212(\\343w\\322\\224}\\334|\\302\\220`\\362(\\004\\360\\015\\005\\005\\024QN'\\356\\372R}\\325\\373\\274R\\365\\374\\363\\2120\\017\\024\\022\\024QE*c\\374(\\343vwc\\326\\223\\007w4\\203\\346\\305\\000\\024QE\\000|\\334u\\247\\003\\271\\262zSq\\370f\\234O\\315\\364\\240\\002\\212(\\245?+P>\\352\\373P\\203\\346\\367\\357M\\031\\335@\\005\\024QO\\316\\335\\342\\220>\\345\\301\\374))\\310~\\367\\255\\000\\024QE/Z3\\267\\351L\\376,\\366\\240\\035\\315\\317^\\271\\240\\002\\212(\\251\\013\\226\\376T\\246F8r\\336\\337\\2251\\360:7#\\245.w.?*\\000(\\242\\212<\\302rKgu8\\271\\010\\007jf\\317\\227\\003\\362\\2449\\033\\250\\000\\242\\212*s)\\013\\307jo\\232z\\367\\250\\363\\216\\264d2\\372\\032\\007`\\242\\212*\\1774u4\\33707\\2775\\011\\366\\244\\031\\015\\374\\350&\\301E\\024T\\371\\005s\\351N\\310n\\215U\\301\\332\\277\\316\\224\\037\\231F\\352\\002\\301E\\024T\\234\\253R\\214/\\361Ty\\375)\\244\\377\\000\\265@\\005\\024QSg\\024\\237V\\246}\\345\\243=\\273P\\001E\\024S\\310\\316\\3346=(\\306\\357\\353L\\376.\\177Zo;\\263\\372\\320\\001E\\024S\\310<\\237\\306\\203\\353I\\277\\344\\246\\347\\371\\323\\030QE\\025!#\\257\\177J7\\374\\330\\333\\300\\025\\036~jL\\374\\331\\355@\\005\\024QO/\\265\\226\\233\\307_zQ\\202\\324\\322s@\\005\\024QA'm\\005\\300\\243\\031Zi\\007\\361\\240\\002\\212(\\247c\\345\\240w4\\207?\\227JNh\\000\\242\\212)O\\335\\343\\255(\\357\\371Ru\\334:P\\017_\\310\\320\\001E\\024Rf\\203\\215\\270\\244?\\326\\227o\\037z\\200\\012(\\242\\216\\337\\312\\223\\370qN\\007\\364\\244\\037w4\\000QE\\024\\217\\306\\017j_\\341\\342\\224}\\334\\232N\\253\\217z\\000(\\242\\212\\017\\315\\370S\\211\\371~\\264\\316:R\\365lz\\320\\001E\\024R\\377\\000\\036=\\250\\246\\377\\000\\0214\\247\\326\\200\\012(\\242\\234\\207\\2454\\037\\275H8\\335\\355K\\236\\270\\364\\240\\002\\212(\\245\\307OQJq\\273=\\2053\\007niI\\373\\264\\000QE\\024\\021\\237jq\\307\\343L?\\375z_\\342\\372P\\001E\\024Q\\3748\\375iH\\033s\\351M\\311\\351N?t\\343\\275\\000\\024QE'\\367O\\2558\\177*\\011\\364\\355M'\\362\\240\\002\\212(\\247\\021\\362\\343\\277zk\\232\\011\\364\\247q\\323u\\000\\024QE!\\033x\\024\\2314\\354z\\375i\\203\\363\\240\\002\\212(\\243&\\202[\\277\\255;\\373\\335\\277\\372\\364\\314\\363\\355@\\005\\024Q],\\272\\242o!\\033\\220\\033\\257\\250\\351Y\\351\\253\\312wy\\2376O\\035\\2539\\337/\\237z`~\\3256B\\345AE\\024U\\311\\357\\344\\235G\\314\\300\\003\\273\\361\\250\\015\\303\\273\\022\\356\\307w5\\016sI\\316j\\212\\262\\012(\\242\\246\\363[sa\\233\\346\\373\\325\\037\\230zn\\351M'\\256:\\322P;\\005\\024QJ\\034\\356\\243=i\\000\\033\\226\\234\\211\\362\\266h\\000\\242\\212)3\\271\\250\\376*q\\035\\350\\343p\\244\\001E\\024Pz\\265\\000|\\313\\357F\\177\\372\\364\\334\\372\\320\\001E\\024S\\362;Rg\\345\\372\\323I\\333\\364\\243?\\227\\245\\000\\024QE\\037Z\\011\\373\\324\\204\\320}\\005\\000\\024QE8\\235\\333i?\\340T\\334e\\276\\224P\\001E\\024R\\366\\301\\357GN\\015&y\\305!\\240aE\\024S\\262vb\\216zSs\\322\\235\\236\\375\\350\\020QE\\024\\340v\\322\\037\\272\\246\\220\\214\\217\\255\\007\\356\\375(\\000\\242\\212)G\\241\\374(\\310\\332\\303\\277j=F\\332\\010\\373\\306\\200\\012(\\242\\203\\321h\\316[\\035\\251=\\375)\\247"\\200\\012(\\242\\236~\\357\\326\\223\\337\\326\\233\\375\\332u\\000\\024QE?\\215\\331\\240\\037\\233\\0352j#\\367\\261N\\373\\255\\237z\\000(\\242\\212v1\\220?\\012@N\\332\\001\\303\\267\\326\\220\\347\\245\\000\\024QE?\\336\\212h\\316\\334v\\357F\\007\\367\\250\\000\\242\\212)\\337\\3354g\\037\\2074\\334\\215\\264\\356(\\000\\242\\212($\\355\\317z3\\353Hq\\363\\021\\323\\265&h\\000\\242\\212)\\371\\033\\226\\203\\376\\3653?\\235(|-\\001`\\242\\212)\\317\\355G?\\245.\\376\\200\\322\\003\\363PHQE\\024\\341\\367q\\372\\323O\\315N\\377\\0008\\240\\017\\307\\024\\000QE\\024\\307\\345E*\\035\\254\\303\\275\\004\\355\\244\\376*\\000(\\242\\212~J\\256?\\316h'w\\370\\323\\177\\210\\320\\017\\345@\\005\\024QN'\\015\\217\\316\\214\\001\\305\\000\\002\\276\\364\\337\\3424\\000QE\\024\\341\\367~\\246\\234\\177\\210zS\\177\\273\\354h\\317\\315\\365\\351@\\005\\024QG\\265\\037\\306\\007jn~f\\315;?5\\000\\024QE\\004\\201\\307o\\361\\240\\237\\366~\\224\\200\\356b\\017\\257ZOj\\000(\\242\\212\\177\\033}\\3074\\231\\302\\344\\364\\365\\246\\216\\033\\332\\235@\\005\\024QG;s\\327\\245\\007?LR\\003\\362\\237^\\324\\021\\271\\250\\000\\242\\212)r>l\\321\\374?\\322\\223\\370\\206=y\\243\\351\\353\\232`\\024QE.v\\363\\353M\\376\\034zR\\347;\\260\\274zSI\\371h\\000\\242\\212)\\334\\005\\243\\216O\\265G\\3744\\354\\320\\001E\\024P3\\267\\033x\\240\\237\\376\\275\\034\\257\\036\\264\\003\\267\\336\\221AE\\024R\\377\\000\\026E&~Zi\\377\\000"\\217\\341\\246\\001E\\024S\\311\\371x\\357\\315&~j>\\362\\346\\233\\232\\000(\\242\\212S\\367s\\357N\\177\\273\\357\\212c\\217\\232\\202\\177\\225\\000\\024QE;\\033\\177J?\\207\\351F\\177:h\\376\\032\\000(\\242\\212\\223\\242~\\264\\237w\\351I\\316\\3323\\362\\212\\011\\012(\\242\\216\\374\\322\\377\\000\\221H\\177:3\\362\\342\\202\\202\\212(\\243\\326\\215\\337/\\275%7=(\\000\\242\\212)\\347\\271\\243?/\\351A\\341i\\231=\\350$(\\242\\212x\\364\\243\\357}\\005&}(\\240\\002\\212(\\245?{\\237J^)\\007\\335o\\256)\\271\\357AAE\\024S\\272Q\\323m&zR\\2026\\343\\322\\202B\\212(\\243=3\\332\\214\\375\\343F\\374\\265\\031\\302\\320\\001E\\024Q\\234\\267\\326\\212nM8\\221@\\005\\024QA\\376b\\216\\213\\237Z@r\\207\\333\\247\\341H\\017\\310>\\264\\212\\012(\\242\\235\\201\\370\\320@\\351\\371Sy-@\\375{P\\001E\\024S\\2167\\373Rc\\322\\230s\\273\\350sK\\235\\264\\302\\301E\\024S\\270\\034\\322\\037O\\306\\220\\221\\300\\244'\\377\\000\\327H\\002\\212(\\247\\002)\\010\\364\\365\\246\\363\\371\\322\\344n\\030\\240\\002\\212(\\245\\343i\\365\\035(&\\223"\\220P\\001E\\024S\\211\\365\\244\\246\\216i\\300\\374\\264\\014(\\242\\212Q\\214Q\\236\\224\\323\\362\\320h\\000\\242\\212(\\376*S\\215\\300QM\\315\\000\\024QE/\\024\\271\\340\\323s\\326\\223\\266(\\000\\242\\212)\\331\\371i=\\350\\351I@\\005\\024QK\\216s\\351\\326\\235\\3748\\364\\244\\376\\032Ps\\217L\\320\\001E\\024R\\037JN\\370\\245\\376/\\245'\\024\\000QE\\024\\246\\234O\\311\\365\\246d\\363N\\3664\\000QE\\024\\277\\305\\351M\\004\\365\\243?>i2y\\367\\342\\200\\260QE\\024\\361\\367i?\\207\\334\\321M#\\246=(\\000\\242\\212)\\343\\014\\324g\\034SA\\244\\317\\315@X(\\242\\212y\\373\\324\\037\\271\\357M\\315;\\257\\024\\000QE\\024\\0226\\323\\177\\210Q\\235\\315J3\\273\\323\\024\\000QE\\024\\277\\343GJA\\236h=\\310\\374\\250\\000\\242\\212)N(\\364\\244\\316\\027\\035\\351z\\177\\205\\000\\024QE\\031\\365\\243?0\\243\\351\\311\\351HI\\343\\362\\240\\002\\212(\\245\\376\\037\\257j^>QI\\327i\\243#u\\002\\012(\\242\\224b\\235\\3749\\355L\\0304\\376vc\\246(\\000\\242\\212)N\\013g\\326\\2341\\337\\212\\217?/4\\240\\375\\321@\\005\\024QO\\331\\271F9\\3157\\033\\177\\016\\264\\273\\376\\\\R\\222w\\217qA!E\\024R\\034t\\024\\036\\037\\330\\322\\360\\335\\027\\237ZL\\037\\353\\232\\000(\\242\\212C\\307\\036\\224s\\265\\251N6f\\232\\177\\375t\\000QE\\024\\274+Q\\214\\322g\\327\\351F~oJ\\000(\\242\\212\\\\~F\\227\\217\\227\\363\\240\\223\\331\\177\\012\\001\\371\\216[\\236\\324\\000QE\\024\\247\\033s\\371\\322u\\335\\236q@\\371\\223\\036\\364\\200\\355\\366\\240\\002\\212(\\243\\257N\\324z~td\\356\\372\\322\\037\\273\\357@\\005\\024QG\\255\\004\\376T`\\357\\372\\361H\\017\\312h((\\242\\212P}(\\346\\233\\222\\264\\177\\027\\336\\342\\230\\005\\024QN\\031\\3157\\370\\251\\337u\\232\\233\\312\\267\\326\\220\\005\\024QN\\366\\375i\\2474\\275T\\321\\307\\347@\\005\\024QE\\024\\207\\357\\017\\312\\220S\\000\\242\\212)\\177\\212\\203\\3749\\240\\217\\233\\024\\216~oJ\\000(\\242\\212Q\\221G\\364\\244\\240\\037\\232\\200\\012(\\242\\234\\016[\\237\\316\\220\\015\\312i3\\226\\247\\003\\362\\232\\000(\\242\\212Ozq!y\\246\\377\\000*C\\367\\250\\000\\242\\212)\\371\\246\\372f\\220\\374\\277\\305Jp\\313\\364\\240\\002\\212(\\247{\\366\\246\\212S\\350:\\232O\\273\\370P\\001E\\024P\\010\\244\\376\\037\\241\\240}\\352\\017s@\\005\\024QJM)$\\253z\\323A\\377\\000\\353\\321\\232\\000(\\242\\212=\\250\\246\\237\\275G\\360\\320\\001E\\024S\\263\\205\\2434\\322;S\\206?*\\006\\024QE\\002\\214\\341\\250\\240\\340\\375(\\020QE\\024\\244|\\330\\243\\214R\\023\\363\\177:nh\\000\\242\\212)\\3343R\\377\\000\\026=i\\204\\321\\235\\315H\\002\\212(\\247r\\324\\247\\033\\260:SA\\355\\351K\\223\\264P\\001E\\024Q\\232\\007\\037\\2057\\370\\261\\357N^\\364\\300(\\242\\212C\\324\\236\\364\\231\\371i\\011?7\\265\\037\\326\\221v\\012(\\242\\214\\223\\315\\031\\371\\251\\247\\326\\224s\\212\\000(\\242\\212S\\362\\321\\317Zk\\237\\232\\216\\243\\024\\000QE\\024\\343\\367i\\331\\306)\\237\\326\\224\\237\\322\\202B\\212(\\243\\2474\\016\\270?QM\\317j\\011\\373\\264\\025`\\242\\212)\\337\\322\\217\\274\\271\\246\\347\\346`h\\311\\334(\\013\\005\\024QA'\\360\\245?\\305M\\316x\\367\\247\\017\\323\\024\\000QE\\024\\244\\374\\337\\255!\\376*o\\361~\\224\\243\\370\\263@\\005\\024QFzS\\207\\3624\\003\\332\\214\\374\\264\\000QE\\024g\\277j\\\\\\355a\\364\\246\\2168\\243"\\200\\012(\\242\\227??\\352h\\340\\2674\\012A\\362\\255\\000\\024QE;\\212S\\306\\007\\257\\2557\\266)\\007AA!E\\024R\\217\\273\\212_\\341\\315 \\003\\275:\\200\\012(\\242\\232\\207\\037Z2[q\\243\\370\\207\\275\\007\\370\\207n\\264\\024\\024QE\\0353\\2121\\316\\177:\\033\\371\\322z\\376t\\022\\024QE8}\\354\\322\\366&\\233\\327\\361\\243<\\032\\000(\\242\\21227{S\\211\\371\\2054t'\\277j\\017\\0304\\000QE\\024\\352h\\317&\\214\\363\\365\\243\\374\\232\\000(\\242\\212>\\224\\247\\346\\244\\317n\\324\\017\\322\\200\\012(\\242\\224g\\362\\245L\\321\\236p>\\264\\207\\035\\250\\000\\242\\212(\\376.(\\315 <\\375\\005\\003\\247\\362\\240\\002\\212(\\245\\024d\\355\\245\\037v\\232;P\\001E\\024T\\231\\335\\317\\3234\\200\\375\\332@~^i3@\\005\\024QRcr\\261\\245\\315C\\346\\014S\\014\\352\\017\\341\\212WC\\345aE\\024U\\275\\347\\360\\240>*\\267\\332\\027v;\\036iM\\312\\017\\255+\\241r>\\301E\\024U\\223\\206^>\\246\\220\\362\\370\\355P\\211Wo\\336\\353\\322\\2269\\220\\216zg\\024\\\\\\\\\\254(\\242\\212\\223\\257\\370\\322\\037\\275\\274\\320\\010\\354\\337\\344R\\241\\3712{\\325\\\\\\002\\212(\\246g-\\355J~\\367\\343K\\263j\\237\\320\\323\\017\\014\\270\\240\\002\\212(\\247d\\257N\\324\\271\\312\\3239\\353\\357N\\343\\346\\371\\250\\000\\242\\212)\\007\\033\\2058\\3201M\\307\\\\\\376\\024\\000QE\\024\\037\\275\\357H}\\275i\\330\\313\\001\\374\\250\\031f\\307\\255\\000\\024QE&w+Q\\303\\177Z1\\363R{w\\240\\002\\212(\\245\\376!@\\376\\032C\\221\\317\\245\\037uA\\240\\002\\212(\\2458\\357\\376sI\\236=\\205\\007\\024\\2078\\372P\\001E\\024R\\342\\203\\367\\276\\264\\352\\217\\206\\246\\001E\\024S\\277\\212\\202\\016\\354\\323}EHq\\267\\326\\200\\012(\\242\\220z\\322\\017\\275M\\317\\315N4\\014(\\242\\212\\000\\376\\264\\003M\\316('\\345\\240\\002\\212(\\247\\377\\000\\015'\\336o\\255\\000\\374\\270\\240z\\320 \\242\\212(\\177\\273\\364\\243\\370i\\246\\234E\\003\\012(\\242\\201\\367\\224\\212\\017\\336\\240c\\2657\\234\\320 \\242\\212)\\335h\\376*JA\\367\\250\\030QE\\024\\012Q\\367s\\353\\336\\223\\370M\\030\\371}\\250\\000\\242\\212)2v\\342\\227\\370i\\177\\205\\2157&\\200\\012(\\242\\227\\370}\\351s\\333\\2514\\0168\\353I\\305 \\012(\\242\\217\\341\\367\\243?-)\\374\\263HO\\363\\246\\001E\\024Q\\367\\226\\217\\342\\024\\2751\\357M\\311\\335\\232@\\024QE(>\\264\\177\\025\\006\\216:P\\001E\\024Rw4\\277\\336\\244\\007\\2514z\\373\\320\\001E\\024R\\377\\000\\017\\353G\\326\\227\\223\\322\\2166\\363\\305\\000\\024QE5\\361\\226\\246\\217\\275J{\\374\\335\\351\\274ph((\\242\\212_zF\\371q\\212^6\\375)G+\\232\\000(\\242\\212C\\367\\305&~j\\011\\310\\364\\244\\310<\\320\\001E\\024R\\347\\250\\240\\360\\271\\246\\377\\000Zv{PPQE\\024q\\267\\336\\203\\303b\\220}\\332S\\367\\260h\\000\\242\\212(\\376&"\\214\\364\\246\\217\\272\\306\\234\\007\\312\\017j\\000(\\242\\212\\011\\305\\004\\367\\024\\001\\275\\177\\225\\037x}(\\000\\242\\212(\\317\\315J3Hh\\307\\336\\307AA!E\\024P?ZS\\201\\370\\323?\\235;\\003o\\275\\005\\005\\024QFh\\307\\313\\232o\\265:\\200\\012(\\242\\227\\035)G\\335\\244\\376\\032@>_\\306\\202B\\212(\\243\\242\\323\\275=;\\322\\177JZ\\000(\\242\\212\\\\\\374\\264q\\223G9\\376T\\204\\203A!E\\024P0\\313\\315!\\371\\267\\032C\\234S\\201\\371\\177J\\012\\012(\\242\\227\\370y\\355M\\347\\245.v\\356\\024\\023\\206\\301\\240\\002\\212(\\245?v\\203\\312\\265#\\217\\225q\\336\\2167\\014~4\\000QE\\024\\203\\370h\\376,P0XPs\\276\\200\\012(\\242\\217\\342\\372S\\277\\205\\251\\243\\243R\\340\\225\\240\\002\\212(\\240|\\313I\\374\\024\\252\\330LS\\006rGz\\000(\\242\\212|d\\3434\\271\\244\\340.\\005\\031\\03714\\000QE\\024\\247\\216{\\236\\264\\200\\235\\224\\320\\340\\217\\316\\243k\\201\\306=8\\251\\272\\032\\213aE\\024T\\331\\302\\217Ja\\225~\\265]\\245%pzTE\\263\\323\\216\\015'.\\305\\252}\\302\\212(\\253Oq\\367\\200_\\306\\241\\363O'?\\344Ty\\306\\007\\347M'c{w\\251\\273-A\\005\\024QR\\007$sHrq\\363SI\\331M\\024\\213\\260QE\\025!\\004\\2120x\\347\\332\\233\\2228\\315*\\360\\007~y\\240AE\\024R\\202s\\355K\\033\\260oz`o\\361\\244\\311,@\\353@X(\\242\\212\\230;\\017\\306\\244K\\307\\013\\345\\236\\203\\245A\\311o\\255/\\177oZw%\\245\\325\\005\\024QV\\322\\363\\347\\031\\351\\223\\237\\245N]\\033\\010\\033\\323\\025\\231\\2161O\\215\\3327V<\\364\\241H\\207Mt\\012(\\242\\264JmQ\\236\\264\\230*\\271\\250\\015\\321g\\004\\372\\364\\366\\247\\255\\300\\331\\353\\223\\375j\\356g\\310\\302\\212(\\251\\020\\374\\270\\245\\037{\\007\\322\\233\\346/\\036\\244f\\2340[>\\335j\\210\\012(\\242\\216\\230\\367\\245\\003\\345'\\336\\243?/J_3\\344>\\243\\232\\000(\\242\\212\\220r\\337\\251\\246\\360\\274\\036j&\\270\\034\\037^\\264\\307\\234\\261\\035\\205M\\312PaE\\024U\\234|\\337^\\224\\301\\300\\372Uo=\\271?\\225\\036i>\\371\\243\\230~\\315\\205\\024QS\\231\\027w\\336\\2442\\2563U\\013\\347\\371\\320\\016\\345\\317\\347E\\313\\366aE\\024U\\301(jO1w}\\352\\250>\\366\\007j3\\301\\242\\341\\354\\320QE\\025l\\3128==\\251I\\033\\201\\335\\301\\344U0~nirw\\001E\\303\\331\\205\\024QV\\301\\375i\\334\\354cU\\021\\360\\312i\\321\\312z\\036\\224\\\\\\227\\006\\024QEX\\006\\224\\343uC\\346\\343i\\374\\352R\\341\\331\\210\\252\\270\\232\\260QE\\024\\037\\226\\214\\374\\264\\322\\331L\\372\\364\\247s\\265h$(\\242\\2123N&\\220\\217\\227"\\212\\000(\\242\\212CFzQ\\374T\\337\\342\\3050\\012(\\242\\237M\\317\\315N\\246\\217Z\\000(\\242\\212\\177ni\\277\\303\\217\\312\\224\\037\\226\\233H\\002\\212(\\245?\\305I\\367(\\243\\370h\\000\\242\\212)\\017\\010i\\177\\206\\223\\215\\274\\321AAE\\024R\\347\\363\\246\\347\\345\\243\\235\\271\\243\\370>\\264\\000QE\\024\\354\\3203\\267\\237Zh?-8\\375\\322\\002\\364\\240\\002\\212(\\240\\375\\3328\\334)\\277\\303\\317ZZ\\000(\\242\\212R>o\\257\\024\\017\\275\\237\\345A?\\235\\031;s@\\005\\024QFs\\212\\017\\335\\240p\\203\\326\\224\\021\\336\\202B\\212(\\250\\363\\363='\\363\\245?.\\352h\\357A\\240QE\\024\\243\\225\\245\\034(\\024\\224\\240\\374\\311\\355@\\005\\024QH\\377\\000\\316\\200\\010b)q\\337\\336\\203\\3637\\363\\240\\002\\212(\\246\\373\\322\\223\\362\\323M\\007\\356\\320\\001E\\024R\\346\\224\\237\\273M\\317\\313\\370\\323\\211\\033h\\000\\242\\212)?\\275J9\\030\\246\\347\\245.{P\\001E\\024R\\347\\237\\240\\245\\316i\\200q\\217\\302\\2348o\\245\\002\\260QE\\024\\200\\321\\374?SK\\237\\326\\202\\016\\332\\006\\024QE\\034\\356jQ\\374\\2517\\343\\203\\371R\\177\\016(\\000\\242\\212)\\334|\\276\\264gv\\352L\\374\\274\\322{P\\001E\\024S\\205\\011\\307\\341M'\\265(\\300n{\\320\\001E\\024R\\223\\362\\361\\336\\227\\370E0\\346\\201\\3744\\000QE\\025!8\\346\\214\\341\\261L\\007+JrN}\\272\\320M\\202\\212(\\2434\\274\\356\\\\\\364\\246\\344\\340R\\276w{\\320\\001E\\024S\\270\\334M0\\234\\2604\\237Jq\\305\\005\\005\\024QA?.(\\307\\312\\257\\272\\232~\\365;\\3701@\\005\\024Q@\\355\\351O8\\330OzL\\015\\23454\\344\\214PHQE\\024\\361\\235\\204\\323\\001\\240J\\021X\\036\\265\\010\\227\\031'\\245M\\306\\223aE\\024T\\304\\216I\\243z\\361\\353\\232\\246e\\311\\307cM\\014\\331\\346\\247\\234\\323\\331\\205\\024QV>\\320zTO9j\\214\\360G\\324\\322d\\343\\236\\330\\374\\351]\\232( \\242\\212)\\341\\210\\030-L$\\200~\\274Sw\\341@\\365\\244'(\\240\\366\\353H\\264\\202\\212(\\251?\\217\\024 \\014\\324\\316\\234\\3674\\231!3\\365\\240V\\012(\\242\\227\\370\\276\\2247-\\371\\032C\\362\\217\\250\\346\\202\\244\\214\\373\\177*\\006\\024QE+\\344\\201\\353\\3058\\017\\233\\007\\240\\351L~\\001\\241[-\\317J\\003\\240QE\\024\\334\\377\\000\\027\\275<\\036\\276\\375)1\\362\\017s\\237\\322\\224\\236G\\256(\\033\\012(\\242\\235\\367_\\332\\220\\035\\254)\\274\\343>\\324\\270\\005A\\240AE\\024S\\363\\327\\351A8o\\246)\\200\\343\\217j\\010%\\010\\364\\240\\233\\005\\024QNf\\303q\\353K\\237\\320\\323G8'\\251\\355K\\3764\\200(\\242\\212r\\271\\005\\375)\\310\\375*\\034\\344/\\345@\\354GJa`\\242\\212*\\3029\\334\\017\\247\\362\\251\\022f\\030\\036\\225Wv\\001\\371\\251A=}h\\271\\016\\001E\\024U\\223! \\375\\356i\\244\\237\\357T\\036e<\\037\\306\\235\\303\\226\\301E\\024T\\236\\335)\\244|\\330\\355\\336\\215\\303w\\024\\244\\372\\361@\\202\\212(\\241\\270"\\214\\372t\\240r\\337\\255\\037\\306=\\251\\200QE\\024\\336\\257\\212U\\0041\\036\\224t\\347\\261\\376\\224\\274\\005\\317\\257Z\\006\\024QE7\\223\\3158c\\245  p(\\007?\\205\\000\\024QE7\\216r\\264\\362>N;\\363I\\324\\021\\3234\\247\\356\\234t\\355@\\005\\024QL\\000\\347\\332\\235\\234b\\220\\014b\\223\\033\\207\\343\\322\\200\\012(\\242\\2361\\214\\237\\312\\224gk|\\324\\320\\010\\372Q\\324\\003\\216\\235\\250\\020QE\\024\\360\\304q\\273\\351O\\363N\\312\\204\\037\\227\\205\\357K\\306\\301\\357@4\\202\\212(\\253\\013/\\310)\\301\\303qU\\303\\364\\024\\274\\007\\373\\337Jw#\\224(\\242\\212\\234R\\361\\276\\240\\363\\010lT\\276`jw%\\246\\024QE;\\357R\\377\\000:L\\216\\273\\261A\\367\\353N\\342\\012(\\242\\216\\206\\224\\212NsJ\\307\\212d\\205\\024QF)\\246\\224\\237\\273I\\374T\\024\\024QE)\\373\\264\\200\\322\\236x4\\301\\320\\320\\001E\\024S\\306\\030\\201\\322\\223\\373\\324\\177\\010\\245\\240\\002\\212(\\246\\363\\300\\247\\344\\363\\3374\\337\\342\\346\\203\\357@\\005\\024QF~V\\240\\232S\\367i\\276\\377\\000\\205\\000\\024QE.M;\\370y\\364\\244\\316sH\\0008\\240\\002\\212(\\243>\\264\\347\\365\\354M\\004v\\244\\345P\\003\\301\\357@\\005\\024QQ\\036[\\353@\\342\\220\\260\\337\\215\\334\\346\\227\\003\\237~jK\\012(\\242\\201\\376M\\003\\2123\\362\\322\\217\\341\\240AE\\024R\\022U\\251\\300\\355\\242A\\235\\307\\276j1\\367\\252\\206\\024QE8\\3208\\241\\376\\366i\\017@j@(\\242\\212q\\366\\246\\3474\\246\\200?*\\004\\024QE\\024Ps\\3069\\240\\214U\\000QE\\024\\355\\247n\\352n\\005;<~4\\334\\363R\\001E\\024R\\221\\336\\224\\375\\334R\\032L\\376\\225@\\024QE\\004z-/\\361qH\\016i\\177\\275R\\001E\\024R\\203\\225\\246\\212r\\014\\251\\372f\\232\\243,G\\353@\\202\\212(\\247\\036G\\024R\\234P\\202\\250\\002\\212(\\246\\340\\322\\201\\320n\\246\\362\\306\\234\\237{\\232\\221\\205\\024QMQ\\363`\\323\\3623\\217O\\353@\\302\\344\\036\\364\\204\\015\\314}*\\200(\\242\\212R;\\216\\224\\234\\022=\\370\\247\\221\\214\\036\\237\\341Qo\\013\\232\\221-B\\212(\\247\\0049>\\202\\233\\232w\\230\\241\\017\\250\\252\\246a\\203\\352(rE(\\266\\024QEZ*1\\367\\252&\\225q\\237\\303\\362\\250$\\230\\261\\310\\351L\\311\\355\\365\\250\\346-S\\356\\024QEZ\\023\\215\\214:\\0368\\250\\314\\347vG\\345U\\363\\223\\365\\376\\224o\\373\\264\\256\\313T\\320QE\\025+JI\\317\\345\\364\\246o\\340~9\\246\\347\\250\\364\\342\\233\\375(- \\242\\212)\\304c\\221\\330S\\277\\210c\\236)\\244\\235\\204~T\\316q\\221\\326\\200\\260QE\\024\\362I_\\326\\214\\345\\207\\241\\031\\246\\003\\300\\371\\270\\247g\\347\\366\\355@\\354\\024QE\\014\\016\\341\\354E \\371\\237\\353H[\\203\\232\\010,\\310\\007\\245H\\005\\024QN\\317()\\255\\3671\\350i\\344\\012o\\335Z\\000(\\242\\212T9\\3104d\\340\\237\\326\\224}\\366#\\322\\223\\370\\261\\330u\\240\\002\\212(\\246Hs\\212\\\\\\036\\336\\3248\\317#\\265;!\\006;\\367\\240}\\002\\212(\\240\\037\\275K\\237N\\324d\\0254\\301\\311'\\360\\240AE\\024S\\311\\312\\034}(\\034\\201\\357L`@\\372\\323\\277\\345\\240\\364?\\322\\250AE\\024Q\\222\\304z\\364\\247\\237N\\306\\242\\350\\347\\036\\264\\374\\202~\\224\\003AE\\024Q\\301@h\\340\\255!8\\340Q\\321\\200\\024\\000QE\\024\\002\\002\\201\\357G;\\0053\\370\\215)?.h\\035\\202\\212(\\245?{\\024\\271!F)\\271\\311\\317\\2458\\036\\231\\240\\002\\212(\\241\\010\\\\\\373R\\344\\355>\\324\\3020\\204w\\243?'\\024\\005\\202\\212(\\247\\357\\310>\\264\\363-G\\306~\\202\\232\\337x\\320+ \\242\\212*a \\315?=\\010\\252\\304\\021'\\343\\326\\237\\274\\214\\012.K\\210QE\\025`\\037\\233\\352i\\277\\307\\201\\370\\322\\011\\006\\321M\\022w\\247qY\\205\\024QR\\2007\\034\\366\\246\\361\\202zQ\\234\\266i\\007\\2452B\\212(\\247\\201\\362\\321\\216\\335\\251\\254p1F{\\016\\324\\000QE\\024\\362q\\307Zh<\\034\\372\\322d\\226\\307\\255 =(\\013\\005\\024QO\\316\\023\\353@\\317\\006\\232\\3753\\336\\214\\376\\354z\\361@X(\\242\\212\\177\\003>\\224\\340A$zr*'\\306\\3522B\\346\\200\\260QE\\024s\\264\\037z{\\201\\270\\020\\330\\347\\232@Cpi\\240\\366\\364\\240\\002\\212(\\251\\210\\312\\014}M3\\356\\340\\372\\321\\223\\201\\352G"\\2023\\214\\366\\351@\\202\\212(\\247\\002\\335;u\\240HW\\257N\\324\\330\\334\\234\\373R8\\371\\316\\177\\316h\\013taE\\024T\\342P\\370\\024\\375\\343\\030\\366\\252\\312\\273\\000\\317Zp\\312\\216y\\247r9W@\\242\\212*\\310\\354h\\030\\311\\366\\252\\373\\212~"\\200\\370'\\015\\327\\372S\\270\\271\\002\\212(\\253<t\\364\\244^\\277\\205G\\346~\\264\\252\\370\\317\\313E\\311\\263\\012(\\242\\236>\\3674\\321\\371\\343\\265!\\223'=\\250\\022\\014\\375h\\270Y\\205\\024QJ\\335\\250\\346\\223\\314\\033\\216[\\245)\\223\\344_\\233\\360\\242\\343\\260QE\\024\\0363@\\240\\020p\\017\\031\\247\\201\\214\\367\\247q\\005\\024QM\\300\\331\\365\\245\\003\\037\\215!%v\\212]\\371\\340S\\000\\242\\212)1\\337u)\\313`\\355\\244\\366\\247\\0226\\255\\000\\024QEc\\371\\205f\\311\\365\\251\\276\\327\\363\\340t\\337\\237\\302\\252\\263\\002\\334\\367\\240\\021\\370\\3272l\\356qOt\\024QE_I\\325\\335>lpr*O3\\016\\213\\355\\232\\314\\015\\265\\262*U\\231\\221\\206[$\\014\\012\\26537K\\260QE\\025\\246O\\313\\374\\305G\\367j\\010\\245\\033r\\355\\3118\\374)\\342\\341z\\373\\361W\\316\\214\\371\\032\\012(\\242\\246\\306[\\024\\237Z`\\231z\\226\\365\\243\\314\\037\\336\\367\\247tM\\230QE\\024\\376\\207\\024\\243\\356\\346\\230[4\\355\\303h\\024\\010(\\242\\212\\\\\\364\\036\\235)\\011\\342\\2234\\271\\355@\\005\\024QK\\333\\232o'\\037Z\\\\\\363\\374\\350\\373\\264\\000QE\\024\\340>j\\010\\003\\247J@~jBI\\240AE\\024R\\200?\\275C\\200\\033\\024\\3406c?\\344\\320\\374\\2704\\007P\\242\\212(N\\027\\371P\\207o>\\264c\\257jny\\024\\000QE\\024\\343\\316;R\\343\\015\\353\\351Hq\\263\\364\\024\\334\\340\\203\\362\\340\\320\\001E\\024S\\320cw\\345L\\031\\034\\365\\246\\274\\270V\\250<\\334\\347\\267<R\\271J-\\205\\024QV7\\203\\3155%\\005I>\\265T\\261\\311\\375i\\270\\367\\372\\012\\236b\\375\\232\\012(\\242\\255\\375\\243\\217\\177J\\256\\362\\027\\177\\275\\300\\246r1\\351\\3150\\036=\\261J\\345\\250$\\024QE<\\023\\335\\262I\\244\\306q\\237\\306\\232\\017\\315\\355H\\\\\\346\\244\\273\\005\\024QO'\\267\\347J\\017_J\\214\\375\\337~\\264\\003\\362\\342\\200\\260QE\\024\\376r>\\224\\336\\343=\\350\\017I\\273\\224\\366\\240,\\024QE/\\034{\\363M'\\346oz^\\343\\361\\246\\277\\336j\\012AE\\024S\\363Fzf\\233\\237\\226\\235\\365\\240AE\\024Q\\217\\227\\036\\206\\234\\370\\332\\010\\246\\016\\264\\016\\277J\\004\\024QE)S\\317\\341\\372\\320>_\\255&y\\002\\224\\375\\356;\\032\\006\\024QE\\003\\357f\\235\\306\\361\\216\\225\\020\\373\\264\\247\\365\\240,\\024QEHI-\\364\\240\\260\\337M\\007\\346j\\015\\002\\260QE\\024\\356\\254GNh<g=\\377\\000\\24574\\023\\363\\217z\\000(\\242\\212wE\\301\\246\\223\\217\\322\\235\\234\\277=\\0055\\272c\\351@\\005\\024QN\\352Ny\\342\\233\\237\\270@\\377\\000&\\235\\202\\017=\\0057\\246\\007\\371\\351@\\005\\024QFp\\314E\\034sI\\334\\017j\\016ph\\030QE\\024\\002s\\370R\\347\\250\\244^\\243\\351G\\361\\267\\322\\200\\012(\\242\\217\\352h\\376\\034P>\\340\\372\\323GQ\\357@\\005\\024QN\\0351J@\\374i\\017Q\\216\\224\\0361@\\005\\024QK\\236?\\012\\027\\247\\2760)1\\201\\201Jh\\020QE\\024\\020y>\\334S\\270\\331\\317P(\\306\\027\\024\\247\\005\\212\\366=*\\200(\\242\\212q\\301\\376.\\224\\334\\003\\226\\246\\016\\011S\\315?8\\340zP+\\005\\024QI\\367\\261\\212j\\022\\020\\212r\\034'\\322\\207=\\007\\\\P? \\242\\212)K\\2361\\336\\244\\337Pg*\\242\\234r\\032\\2014\\024QELy\\306iJ\\015\\276\\347\\232\\204\\276T{S\\262r~\\234Qrl\\302\\212(\\247\\034\\374\\246\\2321\\264\\021\\3274\\374\\203\\370SXqN\\340\\024QE;9\\315\\000\\374\\330\\246\\234v^\\224dn\\006\\230X(\\242\\212{\\021\\317\\255!\\344c\\2763M\\317Z2s\\237j\\005`\\242\\212)\\331\\343\\336\\227\\214\\251\\246\\245(\\310\\310\\240\\002\\212(\\247\\203\\323\\365\\243;\\266\\212\\213\\370\\270\\351N\\031\\015\\365\\346\\201X(\\242\\212T\\312\\002=i\\300\\345\\261\\333\\2457\\266h'\\004P \\242\\212)\\314OJR{S\\011\\351\\357@\\316\\322h\\013\\005\\024QN\\316Ui@\\371\\361L\\311\\010=\\371\\247,\\237>h\\006\\024QE\\005\\317\\322\\2278\\037{\\353C\\341\\272\\367\\244\\220\\365\\307z\\000(\\242\\212x<cu4\\234~4\\341\\317\\036\\335i\\203!\\271j\\004\\220QE\\024\\277\\300Os\\315;$/\\335\\246\\367\\\\\\376T\\023\\363~\\264\\000QE\\024\\245\\2118\\247y\\207g\\336\\357\\3051\\316\\034\\212a<b\\200\\260QE\\0250\\224\\3559\\365\\342\\224KQpG?\\235(\\373\\2704\\003H(\\242\\212\\230\\310\\275q\\311<\\321\\346\\001\\236\\343\\245C\\200\\033#\\247\\245\\004\\347\\217Zw'\\225\\005\\024QY\\207\\357g\\320\\342\\216\\33147\\336?\\\\\\323I\\344\\001\\\\\\307xQE\\024\\341\\333\\336\\227?(\\307Z\\214\\036\\200\\366\\247\\347\\346\\375i\\203AE\\024S\\304\\204\\365\\245\\004m\\250\\377\\000\\213\\330s\\212\\017*\\264\\023`\\242\\212*o\\342\\366\\243\\177?\\312\\242\\315?\\371P&\\202\\212(\\251|\\343\\203K\\347\\266\\341\\355P\\006\\311\\306)s\\333\\322\\252\\344\\362\\256\\301E\\024U\\225\\224\\343\\232\\005\\311\\374\\352\\015\\377\\000.(\\3162;S\\273\\027"\\012(\\242\\255\\013\\201\\217\\240\\247\\013\\201\\214\\236\\202\\251\\215\\244}\\352\\017\\334\\307\\241\\252\\346d{4\\024QE]IT\\321\\347\\015\\340z\\325PN\\030\\367\\246\\356\\371\\263\\351G3\\017f\\202\\212(\\253\\306\\341w\\020{Pn\\001\\306;\\036\\225A\\301\\3114\\277\\303\\236\\347\\371Q\\314\\303\\331 \\242\\212*\\313\\\\\\036\\203\\2474\\317<\\3607t\\346\\241\\035\\006:\\3232G_\\255M\\331J\\232\\012(\\242\\254y\\244\\214n\\350x\\246\\371\\207\\037N\\225\\011\\004\\012\\001'\\212\\007\\312\\202\\212(\\247\\231\\016\\357\\275\\222i\\333\\375z\\324^\\237\\255+\\374\\255@\\354\\024QE)8\\006\\215\\376\\224\\323\\322\\2340\\032\\200\\012(\\242\\215\\330\\3154\\036\\027\\351A\\376|P\\016G\\323\\245\\003\\012(\\242\\224|\\255H~\\377\\000\\326\\217\\342\\240}\\334w\\240aE\\024S\\270+M\\037z\\201\\367\\261\\351I\\320\\203@\\005\\024QJ)\\177\\206\\232x\\305/c\\364\\240\\002\\212(\\240\\034\\206\\244\\376\\034\\372\\321\\216=\\215\\0148\\024\\000QE\\024\\255\\332\\223"\\201\\374\\2511\\363b\\200\\012(\\242\\234Gz\\007\\3374\\021\\307\\024\\023\\204\\240\\220\\242\\212(?{4\\277\\305I\\374T\\204\\374\\364\\024\\024QE)\\373\\270\\243\\255.7/\\322\\2328\\031\\240\\002\\212(\\240\\036\\364\\264%!\\340~4\\000QE\\024\\244\\374\\264\\034\\344z\\320\\335\\250ln\\317\\240\\240\\002\\212(\\247!\\3434\\204\\322zR\\037\\347A!E\\024S\\335\\362\\264\\322~qG\\360})\\011\\371\\205\\005X(\\242\\212yl\\276h\\310\\3057<\\0323A6\\012(\\242\\216\\342\\200y\\245=\\251\\006s@\\005\\024QG\\360\\320>\\367\\322\\200\\177\\235\\037\\304\\324\\024\\024QE\\000\\345\\350's\\014\\322\\014\\347?\\205/\\361\\342\\200\\012(\\242\\227?5/<S\\017\\336\\372S\\271\\335\\232\\011\\012(\\242\\244\\3168\\357\\232;\\347\\323\\212oV\\347\\3274\\230'?Z\\005`\\242\\212)H\\000\\361\\316i\\305\\271\\007\\333\\024\\334\\364\\375i\\331\\311\\305\\000\\024QE\\007\\204\\374s\\371\\322\\360\\031O\\250\\346\\2329l\\323\\263\\225S\\351\\301\\240\\002\\212(\\244\\217\\034\\221A9\\372\\3474\\321\\224sN\\352\\371\\037\\205\\000\\024QE\\037{>\\346\\202O\\037JN3K\\367\\270\\035\\250\\000\\242\\212(\\344\\201\\216\\375i\\331\\371\\275E4\\021\\263\\035\\250\\0347\\265P\\202\\212(\\251\\003d\\377\\000:p\\000\\012\\204~\\2719\\245\\363\\010?\\316\\213\\223`\\242\\212)\\343\\031\\372\\365\\244#\\0161\\323\\24578sR\\177\\016)\\3346\\012(\\242\\223\\241\\247g\\223\\372Pq\\217\\245'\\2751\\005\\024QHr\\273\\205!<\\375)O*=O\\024\\342\\243\\030\\374h\\030QE\\024\\300\\324\\273\\375h\\333\\201\\270P\\007\\255\\001\\240QE\\024\\340\\177\\302\\220\\232M\\275\\373PzP \\242\\212*\\\\\\374\\313\\350)\\230\\347\\353M\\311\\034w\\243\\322\\200\\260QE\\024\\357n\\375iN\\177.\\337Zfq\\326\\236\\016\\177:\\000(\\242\\212v\\3548\\240\\221\\310\\250\\334\\374\\337\\215;9\\372\\212D\\330(\\242\\212y\\306\\334\\323\\016M\\004\\374\\204\\356\\247.8\\335\\326\\230-\\002\\212(\\243v_\\334PG\\004\\365&\\214\\015\\371\\356('\\033M\\000\\024QE\\000|\\203\\345\\346\\216\\200|\\331\\305.~l\\036\\224\\337\\341\\367\\317\\024\\000QE\\024\\021\\362\\347\\363\\243\\007\\265;\\357p;\\320\\340 \\373\\274P\\001E\\024Vc\\365?Zf~b}(\\223\\3577\\326\\231\\310\\374k\\236\\347jAE\\024R\\203\\373\\303\\364\\243<\\201\\355Hs\\223\\364\\353K\\311\\\\\\355\\350:\\3200\\242\\212)\\371\\371\\377\\000\\235\\003\\336\\243\\347~O~\\224\\243\\234P+\\005\\024QO\\034\\000?Z3\\3074\\303\\221\\200}\\351A\\033\\250\\013\\005\\024QRd\\361\\357K\\352j0\\374}(\\004\\355$\\364\\240V\\012(\\242\\244\\037\\240\\031\\247\\0029\\366\\246g\\234z\\012L\\377\\000\\2052l\\024QEK\\323\\360\\247d\\001P\\234\\207\\305H\\230\\347\\351N\\342h(\\242\\212vGC\\322\\233\\306s\\372P\\244\\021F\\003~\\024\\356HQE\\024\\343\\311\\024\\322y\\3664t\\247`\\236h\\000\\242\\212(\\017\\332\\202~l\\372\\361M\\356=\\250\\030&\\230\\005\\024QA\\311L\\323\\272\\034\\323A\\343\\036\\224\\340G\\364\\244\\001E\\024SI\\374\\251\\033\\246iO\\024\\207\\224\\366\\246PQE\\024g"\\227\\2121I\\316\\372\\000(\\242\\212\\017N;P\\275>\\264\\177\\011\\243\\030\\024\\000QE\\024\\271\\344PO\\315Hz}h\\347 \\320\\001E\\024P\\017$\\321B\\367\\3154P\\001E\\024S\\233\\265(?-'\\033\\263B\\361\\305\\000\\024QE/\\0333\\336\\200s\\370R\\034\\221\\201\\364\\246\\347\\265\\001`\\242\\212)\\307\\206\\342\\216\\347\\351Jy\\351I\\236M\\000\\024QE&i\\307\\221\\212a\\030\\342\\235\\306(\\000\\242\\212(\\365\\366\\246\\271\\371\\351\\303\\2750\\203\\273\\351@\\320QE\\025 ?-\\006\\223\\372\\321\\367\\232\\201\\005\\024QJ\\237z\\201\\316\\352H\\376\\371\\240c\\265\\000\\024QE.y\\024\\323\\367\\251i\\247\\255\\000\\024QE?\\322\\206\\034c\\255%.h\\000\\242\\212)\\251\\367\\032\\235\\264\\355\\007\\361\\244\\217\\356\\342\\234\\015\\000\\302\\212(\\246\\377\\000\\017\\326\\226\\220\\364\\245\\024\\000QE\\024\\036\\306\\201\\232\\017\\335\\244=>\\264\\000QE\\024\\240u=\\250\\373\\315I\\320P=\\350\\000\\242\\212)E ?=\\024\\301\\327=\\215\\000\\024QEI\\216y\\247\\217\\275Lo^\\364)\\351\\212\\005\\320(\\242\\212vF\\372PEFO\\315\\307z\\177\\360\\375(\\023AE\\024Sr)\\351\\362\\2775\\035?$8\\240\\002\\212(\\243#v>\\264\\243\\267\\353L\\347y4\\365\\034\\234\\375h\\006\\024QE;p\\374M\\000|\\237\\215\\000\\215\\203\\326\\224\\347\\277A@\\202\\212(\\246c/\\201N\\310\\015\\355@\\307OL\\323@\\031\\240\\002\\212(\\2470\\371\\001\\355\\232i\\343\\237sN\\3348\\033zQ\\200W\\365\\240\\002\\212(\\2439\\000\\322\\203\\206\\372\\364\\244\\300\\012G\\322\\227\\216\\277\\200\\240AE\\024S\\302\\366\\035H\\241\\275\\272\\216\\264\\212x\\310\\353\\212U\\345O\\277Z\\011\\012(\\242\\204'i\\315\\031\\343\\203L\\003$\\236\\335\\251\\340\\000\\270\\357\\336\\252\\340\\302\\212(\\247!\\355\\364\\240\\222\\0334\\3202\\307\\037\\205\\004\\343\\004\\376T\\300(\\242\\212wT\\343\\2450\\266q\\372\\320\\017\\377\\000\\252\\233\\332\\230X(\\242\\212\\227?)\\250\\310=)C\\374\\330\\245'\\245\\001\\260QE\\0240\\371\\307\\352h\\3069=)\\316@\\246\\347#>\\224\\000QE\\024\\346\\3478\\357L\\\\\\367\\247\\377\\000\\361U\\026rG\\362\\240\\020QE\\025/\\336\\317\\257\\2550g'\\333\\255+\\360\\324\\006\\007\\361\\240\\002\\212(\\244$\\354\\310\\245\\223<\\032C\\300\\243?'<P\\001E\\024S\\363\\200M.Ie\\3150\\001\\310=\\351\\331\\371F\\033\\275\\002\\012(\\242\\244\\317\\257\\347\\355Q\\340\\365\\364\\351JI\\003\\030\\305\\003\\212\\011\\012(\\242\\2342:\\366\\353K\\346\\034z\\324[\\216EI\\222\\177>\\324\\005\\202\\212(\\254\\211\\0109\\3664\\314\\036\\010\\247\\036Y\\305\\037\\302k\\230\\357\\012(\\242\\225\\307\\313\\305"\\037\\220\\212\\\\c\\353H\\275M\\002\\350\\024QE\\014~T\\036\\224\\240\\200\\313\\355Mo\\272>\\264\\3421@\\302\\212(\\244\\223\\250\\243\\247\\351F3\\203A\\341\\370\\240\\002\\212(\\245\\347n=\\351\\006vc\\322\\224\\236F?\\032E\\343=\\250\\020QE\\024\\342p\\337{\\255 4\\001\\220=\\351\\370\\004\\217n\\264\\304\\024QE8\\021\\236\\177\\0327c\\212a\\306\\303\\365\\245\\3523\\267\\265\\002\\260QE\\024#sN\\337\\324g\\336\\231\\037\\000g\\275*\\362\\010\\357@4\\024QEJ\\033\\034\\365\\024\\240\\214f\\243\\007\\344\\307\\353B\\236)\\334\\226\\202\\212(\\251\\000\\303\\347\\267Zw+\\317j\\2139\\243w\\031\\367\\305;\\212\\301E\\024S\\372\\265&:\\343\\326\\200~|\\372R\\344m\\317z`\\024QE\\000e\\260{\\321\\216\\336\\224\\354c\\2457\\267\\324PHQE\\024\\3402\\331\\246\\2320@\\243\\370qL\\240\\242\\212(\\376\\360\\243\\370q\\351G\\335l\\212C\\236\\007\\255\\000\\024QE(\\005\\206=:Q\\367\\226\\214\\340\\373\\322\\036\\005 \\012(\\242\\200:\\323z\\237\\302\\235\\236)\\027\\2750\\012(\\242\\220\\323\\251\\214x\\245\\353H\\240\\242\\212)I\\371\\205'\\257\\265\\037\\304\\264\\037Z`\\024QE;\\370sG\\277z)\\270\\375h$(\\242\\212\\011\\313R\\236\\324\\2160\\370\\242\\201\\366\\012(\\242\\235\\236i\\275O4\\036\\264\\354rh\\020QE\\024\\036\\202\\201\\215\\324\\036\\224\\337z\\000(\\242\\212p"\\220}\\352N\\364\\016\\271\\240\\002\\212(\\247\\237\\273\\212g\\2758\\372\\323GN(\\004\\024QE(\\245\\3174\\321\\322\\234\\005\\000\\024QE"\\032q??4\\324\\315)\\373\\364\\007P\\242\\212)?\\212\\226\\233\\374B\\237\\374\\003\\036\\246\\200\\012(\\242\\223\\240\\244<\\000){~\\024\\263\\177\\255\\343\\326\\200\\012(\\242\\232~\\361\\244\\034u\\240\\374\\314\\324\\2474\\024\\024QE:\\223\\201J>\\355!=($(\\242\\212S\\337\\351I\\351M'\\203Fy\\024\\000QE\\024\\342~q\\212~z\\324G\\357\\255?\\370\\2104\\003AE\\024R\\177\\300\\251O\\336\\246f\\237\\325\\210\\240\\002\\212(\\247\\000[\\361\\246\\257\\337\\024\\003\\362\\346\\223\\356\\320\\001E\\024S\\301\\355F\\177\\306\\232)=}\\250$(\\242\\212x9\\317\\322\\214\\035\\347\\035:\\320\\017\\315F\\010\\347\\332\\200\\012(\\242\\203\\236\\224\\374\\227\\030\\035\\363M,6~8\\247 \\347;\\272\\017\\347@\\202\\212(\\2409\\333\\267\\327\\212\\017\\312\\304\\012n\\006\\361\\217\\255<\\343i~\\376\\224\\000QE\\024\\216>A\\216\\303\\037\\215\\000\\235\\304\\321\\316\\314\\236\\231\\246\\214\\364?Rh\\000\\242\\212)\\375=\\307Jq|=0\\014\\241\\356\\001\\247\\225\\371\\013\\016\\324\\010(\\242\\212Q\\214\\375?Z\\224\\225~\\0179\\346\\253\\347\\344\\004\\257\\343N'\\246=z\\325\\023`\\242\\212)\\376X\\013\\357Q`\\214{S\\306{\\323\\211'\\232\\002\\354(\\242\\212\\210\\340\\034\\343\\232\\017-\\317zq\\035I_\\2553\\232\\241\\205\\024QOb;\\322\\257@*3\\3104d\\214{P;\\005\\024QOC\\362\\322\\240\\303dS#\\353I\\222[\\006\\201X(\\242\\212s\\375\\325\\372\\322\\225\\306\\323\\3274\\336\\254i\\316I\\210zP\\035\\202\\212(\\242NS\\212o<\\017Z\\017 b\\214\\361\\364\\240aE\\024Q\\273\\221\\355A8l\\212A\\316q\\322\\224\\362G\\275\\000\\024QE=\\330\\201\\371Ry\\235\\275\\370\\246\\234\\036:P\\007c@YX(\\242\\212\\233\\205\\346\\231\\270\\016GJBIB=)\\230,>\\224\\022\\220QE\\025\\2348&\\2341\\307\\313C\\377\\000\\255osM\\316\\005r\\035\\241E\\024S\\311\\376T\\213\\316?ZnF(_Z\\241\\005\\024QF\\001\\343\\323\\2459\\317)L\\3763N\\376/\\245\\003\\012(\\242\\224}\\332c\\366\\367\\251\\020\\360E#\\214\\221\\332\\216\\202\\276\\241E\\024R\\364\\372\\012D\\3478\\353Ct\\242#\\337\\275\\002\\350\\024QE.~Z9\\335\\201\\337\\2753\\251\\367\\315<q\\264\\372P\\001E\\024S\\237\\356\\177:\\007L{Q\\374\\\\t\\034\\321\\234-1\\005\\024QK\\221\\326\\201\\307\\343\\223M\\317\\313\\212q?5\\000\\024QE"\\267\\311\\232S\\306>\\224\\231\\001\\016(\\317A\\352(\\013\\005\\024QO\\3543\\351M$\\001\\374\\351:\\222)G?-\\002\\012(\\242\\200N\\357\\2558\\277\\315\\364\\250\\201\\371\\271\\355A?=1\\330(\\242\\212\\230\\271\\347\\035\\350\\022t_^*\\034\\235\\243\\353@\\373\\340\\373\\322\\270\\271PQE\\025o\\314\\334\\2714\\314\\363\\355P\\347\\034~\\225"\\020>\\225W%\\306\\301E\\024S\\370\\351GC\\317c\\3050r\\007\\251\\247\\003\\320\\323\\020QE\\024\\2543\\317\\345G\\374\\263\\317\\343A \\247\\322\\200~N(\\020QE\\024\\204\\216}q@\\376t\\021\\232\\001\\340~T\\014(\\242\\212N)1\\377\\000\\327\\240q\\220i\\304\\355b(((\\242\\212oqHOZ\\177\\364\\250\\277\\214\\346\\201 \\242\\212*V\\376\\224\\334\\340\\212\\0174\\231\\371\\207\\265\\001`\\242\\212)\\347\\031\\373\\264\\336\\376\\324\\023\\315:\\201\\005\\024QM?x}i}~\\264\\037\\231\\251_\\246h((\\242\\212i?\\312\\200>L\\322\\234Rg\\344\\240\\002\\212(\\242\\225:Ss\\305==7P&\\024QE\\035\\377\\000Z\\020|\\264\\326\\3159N\\0051t\\012(\\242\\232\\224\\243\\357Q\\374Y\\365\\244\\240aE\\024P\\224\\277\\307H>Z9\\336\\324\\014(\\242\\212y\\373\\331\\243\\376Y\\322\\023\\305/\\360\\217z\\011\\012(\\242\\223\\370E:N]\\217l\\323\\177\\306\\224\\234\\202h\\000\\242\\212)\\203\\226\\247\\036\\224\\320\\017\\343OL\\036\\275\\350\\033\\012(\\242\\231\\3744\\356\\270\\366\\246\\343m\\002\\201\\205\\024QGf\\243\\356\\262\\322\\373R\\177\\0204\\000QE\\024\\177\\026i\\377\\000\\326\\230)\\331\\347\\024\\022\\024QE\\004w\\024to\\312\\2234\\275y\\315\\000\\024QE(\\373\\224\\207\\220=)OG\\375(\\307\\310\\007\\255\\000\\024QE \\351H\\247\\251\\247\\023\\330v\\246)\\342\\200\\012(\\242\\245 \\014\\021HX\\2557=3Jy}\\264\\012\\301E\\024S\\210\\373\\200z\\346\\224\\373S:s\\351K\\377\\000\\305P \\242\\212)A\\307J2H>\\246\\232\\0163\\350\\015;=\\372P\\001E\\024S\\337\\002\\034{~\\264\\261\\215\\333\\263\\351\\305BNq\\232r?\\336\\367\\240v\\320(\\242\\212\\2321\\345\\357\\3179\\246\\234l?7\\007\\372\\323\\\\\\374\\240\\322uG\\375(&\\335B\\212(\\251dR\\313\\362\\364\\003\\371Q\\030\\312\\214\\364\\024\\3259\\311\\015\\201H\\011L\\217Q\\221@\\272X(\\242\\212r\\266%\\301\\355\\336\\234\\034n\\372\\365\\250\\311%\\011\\357\\236\\264c\\000\\237\\310\\320\\026AE\\024T\\341\\376\\\\\\036i0\\017=\\252!!\\300\\247\\177\\010?\\245U\\311\\260QE\\024y|S\\010\\342\\246\\004\\276;SJn\\351@'\\334(\\242\\212\\216*kg>\\335\\251\\337q\\217\\246h\\177\\377\\000U2\\372\\205\\024QK\\374T\\231\\312b\\233\\374dS\\237\\033A\\246\\001E\\024Sq\\362\\361@ \\365\\245\\007\\346\\244#\\007\\035\\261@\\005\\024QN\\376\\003\\351@9\\376.\\224\\200\\322\\036\\034\\373\\320\\001E\\024S\\301\\033\\2334gkz\\323\\011\\305=\\016q\\232\\000(\\242\\212w\\256\\017ZoB;\\012N\\207\\374\\364\\240\\034\\3435"\\260QE\\025\\235'\\372\\321I\\352)\\317\\215\\324\\317\\\\W1\\326\\024QE\\003\\346\\251\\000\\033s\\372S\\020\\374\\224\\250h\\006\\024QE\\034o\\024\\277\\326\\233\\374\\\\t\\245\\350(\\000\\242\\212(\\034;\\323\\210;A\\246\\177\\0314\\363\\367\\011\\333T\\014(\\242\\212k\\375\\332\\020\\374\\264\\215\\310\\002\\225>\\356*C\\240QE\\024g\\346\\374i\\331\\376t\\177\\021>\\346\\217\\371fsT \\242\\212)I\\371\\037\\024\\235\\207\\275\\035\\316z\\021M=\\275h\\000\\242\\212('\\346\\245\\316\\346\\315/\\360\\261=\\351\\243\\232\\006\\024QE?\\203\\327\\275\\014Gn\\303\\212a\\316G\\275\\007\\356\\320+\\005\\024QR\\203\\306}i\\241\\371\\244\\037s\\360\\246\\236\\271\\366\\240,\\024QE)\\373\\325!\\306\\341Ll\\034S\\3079\\240L(\\242\\212nF1K\\237\\227\\357SG?\\215\\031\\344P\\026\\012(\\242\\237\\367\\034\\236\\364\\274~\\234S\\011=Gzx\\352=\\251\\211\\205\\024QH\\207\\221\\370\\322\\202G\\024\\233~\\361\\356:R\\367\\374)\\203\\012(\\242\\237\\237\\220R\\007\\343\\024\\301\\235\\277C\\232ol\\375(\\270\\254\\024QEX\\317\\2454\\372\\212`<~\\024\\006\\310#\\270\\247rl\\024QE<\\365\\244\\177\\2741J\\016I4\\236\\230\\244\\010(\\242\\212z\\375\\323\\357M\\300\\352z\\232\\017\\336\\366\\244\\310\\252\\030QE\\0246H\\310\\243\\257>\\224\\370\\375?\\032k\\360\\306\\201y\\005\\024QI\\374t\\016sG\\335j\\023\\370\\275\\250\\030QE\\024\\276\\206\\203\\376\\355'j3\\315\\000\\024QE/\\364\\240\\012=i\\001\\344P\\001E\\024SO\\335\\374i\\343\\357R\\001\\272\\205\\316M\\003aE\\024R\\267\\335\\244'\\000R\\3664\\303A((\\242\\212~~Z\\017\\335\\241\\270\\305!\\340\\032\\006\\024QE?\\037\\225G\\374F\\244\\037v\\230>\\3674\\011\\005\\024QO~\\231\\243<\\012oPhO\\274\\005\\003\\012(\\242\\235\\337\\365\\240\\364"\\233\\320\\323\\263\\332\\231!E\\024SA\\371M*\\037\\275H\\237v\\204\\373\\324\\206\\024QE!<\\320M\\007\\357\\340z\\321\\214\\271\\024\\014(\\242\\212Q\\367sE\\007 }(\\240\\002\\212(\\240P\\006\\\\\\375)\\310>_z\\023\\375i\\367\\024\\304\\024QE\\003?\\341G\\360g\\271\\240\\014t\\2439LzP \\242\\212(\\317\\360\\3664\\243\\357\\017jB0G\\353C\\036(\\000\\242\\212(\\177Z#\\347\\232\\017+Dg\\255\\001\\320(\\242\\212oqN=s\\371\\322\\221\\351\\326\\234\\006A\\312\\346\\200\\012(\\242\\231\\260\\225\\317l\\321\\236MH1\\332\\243\\307z\\002\\341E\\024Q\\330\\212_\\341\\244^\\177::\\212\\000(\\242\\212\\017P)@\\303R\\023\\374\\250\\317\\037Z\\000(\\242\\212y9\\317\\276hQ\\220@\\373\\307\\201M\\036\\236\\364\\367?84\\022\\024QE \\\\\\014\\037N\\336\\265 >g\\007\\351Mb0\\010\\352)9\\037?\\251\\240[\\205\\024QA\\312e\\177\\0329l/\\251\\240\\200d\\366\\357N#\\003\\216\\271\\342\\200\\012(\\242\\20268\\372R\\362\\212\\243\\2450\\340\\224&\\203\\222x\\350:\\320\\001E\\024T\\244\\220\\235is\\362\\361P\\215\\333\\017\\265?\\005\\276\\342\\347\\326\\201X(\\242\\212pen\\335z\\323H\\343\\035OZdg\\346\\372\\323\\271\\034\\216@\\353@Z\\301E\\024S_;\\263\\353C\\344\\247\\341\\322\\246\\340\\247+\\311\\353L#-\\370b\\250.\\024QEF8\\307z^\\303\\336\\235\\323\\037O\\326\\232{c\\221@\\302\\212(\\241\\0074\\363\\200\\337w4\\304\\034\\322\\271\\303P\\035B\\212(\\244a\\306h\\035V\\235\\325\\0154\\345\\206}(\\000\\242\\212(\\350\\015\\003\\201\\372\\323\\225:\\347\\251\\351M#\\015\\212\\000(\\242\\212\\240z\\223Hr)GS\\352h>\\236\\265\\314u\\005\\024QL\\037s\\357S\\220e\\263\\371\\322\\221\\215\\303\\332\\231\\036w\\014PW@\\242\\212)\\356\\007P\\276\\330\\244\\315=\\275\\275i\\2738\\301\\353A((\\242\\21207\\375E9\\217\\310E7\\270\\247q\\263\\360\\240\\002\\212(\\246\\216\\253H8\\220\\320\\001\\340\\372\\322\\023\\363\\346\\200\\012(\\242\\236z\\361H\\007\\030\\372\\322\\241\\244\\025@\\024QE\\007\\357PO\\316(>\\276\\324\\2319\\372T\\200QE\\024\\360y\\305\\000psM\\004\\323\\230\\377\\000*\\241\\005\\024QA\\354}\\350o\\271\\2323\\362b\\216\\243h\\240\\002\\212(\\246\\247(i\\375\\363L\\214`S\\232\\200{\\205\\024QA\\316\\342=9\\245\\007\\277\\245"cq\\367\\245\\343e\\000\\302\\212(\\244\\030\\375is\\310\\372S\\001\\247\\3434\\011\\205\\024QH;R\\234\\357\\030\\357H\\007J8\\335\\232\\000(\\242\\212~z})\\247\\206\\240|\\371\\240\\375\\354\\032b\\012(\\242\\227\\332\\227<f\\202\\3434\\322r\\224\\000QE\\024\\271\\371\\232\\224}\\362i\\2351\\356)S\\357\\232\\006\\024QE=O\\024\\233\\261MS\\363zR\\034\\236(\\270\\254\\024QE?<\\347\\326\\214\\363\\365\\246\\236\\237Jq\\037?\\336\\364\\240,\\024QE9[\\017J\\377\\0006M1\\373\\232\\020\\376\\264\\\\V\\352\\024QEH~Zo\\360\\322\\347\\346\\364\\244O\\233 \\323\\020QE\\024\\017\\271I\\375i\\303\\030\\307z\\006?\\255P\\302\\212(\\245\\034\\203M\\306\\017\\341O\\035\\351\\264\\010(\\242\\212h=h\\217\\206\\316h\\3063\\216\\224\\341\\327\\332\\201\\205\\024QK\\236MG\\316\\345\\247\\367\\246\\214\\364\\240\\020QE\\024\\346=(n\\237Z:\\212\\010\\343\\232\\000(\\242\\212\\\\\\320\\377\\000\\303HO<R\\214\\363@\\202\\212(\\241~\\355"\\377\\000J|`\\2054\\273\\000\\210\\037\\342\\357@\\256\\024QE0\\237\\232\\214\\362(<7\\245!\\355@\\302\\212(\\245\\037r\\210\\310\\3114\\037\\272\\000\\246\\016\\224\\000QE\\024\\362\\006sB\\365'\\326\\216\\264\\342~^8\\024\\000QE\\024\\323\\310\\372\\320F\\006}z\\322s\\333\\232{\\375\\317\\275@\\005\\024QM\\007=(^[>\\202\\221:g\\261\\251#\\307\\370\\320'\\240QE\\024\\003\\306}i\\203\\214\\367\\247z\\212fy4\\011\\005\\024QJ\\015\\003\\220\\177J\\037\\030\\343\\322\\210\\206\\006h\\037K\\205\\024Q@?-\\011\\306i\\310y\\3051~\\361\\240\\002\\212(\\247\\377\\000Z\\001\\377\\000\\012m;\\241\\375i\\210(\\242\\212\\001\\347\\006\\203\\307\\035h\\340\\234\\212k\\032\\000(\\242\\212p\\004\\016}iqI\\234\\322f\\200\\012(\\242\\227\\036\\264\\212(\\3158\\021\\264\\320\\001E\\024Rg\\232^\\012\\347\\270\\244 \\027\\372\\212A\\323\\361\\346\\200\\012(\\242\\223w\\313O\\337\\367\\0050FJ\\226\\035\\273P9a@\\364\\012(\\242\\235\\223\\212y|\\250\\365\\250\\372\\014R\\217\\270}\\215\\002\\012(\\242\\236\\314\\010\\375i\\353\\215\\230\\035OZ\\210r\\376\\324\\340F\\362GJ\\004\\320QE\\024\\365\\310b\\017~\\364\\210\\345\\011\\000\\367\\244\\337\\363}M!\\352=\\3114\\012\\301E\\024R\\227\\354jd\\333\\310\\354}j\\264\\207sf\\234\\215\\216:\\320&\\264\\012(\\242\\246\\300F\\307\\255\\034\\023\\317j`=O\\245\\033\\301\\036\\236\\324\\012\\301E\\024S\\376S\\301\\374\\0155\\320\\356\\310\\351L\\036\\203\\237Z\\225H)\\364\\2406\\012(\\242\\232z\\347\\360\\250\\337\\357}i\\371\\312\\343\\2757\\003\\177\\265P\\320QE\\024\\204\\343\\212T?.?:$\\024\\203\\217\\351@\\372\\005\\024QO\\007\\346\\366\\2469\\031\\374)\\034\\374\\324\\247\\033h\\013\\005\\024QT\\011\\245=\\215!\\376\\274\\323\\330e\\007\\245s\\035,(\\242\\212O\\275M@G^\\264g\\367\\230\\036\\264\\274\\361\\232\\000(\\242\\212F\\357K\\311\\374(\\333\\277 q\\2123\\363P\\001E\\024P\\307\\345\\036\\335\\350\\311\\333H\\307#4\\271<P\\001E\\024P\\207\\201\\232a\\347\\031\\364\\247/jh\\240\\240\\242\\212)\\340\\361\\357I\\322\\205<\\034PF\\030}($(\\242\\212^\\270\\246\\377\\000\\031\\024\\354\\344R\\017\\277\\212\\000(\\242\\2123\\363}i[\\356\\322?\\336\\342\\206?%\\001\\330(\\242\\212?\\3404\\243\\251\\246\\322\\214\\363@\\005\\024QJ\\237{\\232\\011\\351A\\373\\324\\234\\034\\012\\000(\\242\\212T\\373\\324\\377\\000\\340\\374i\\203\\207\\305;=q\\322\\232\\023\\012(\\242\\2301\\346T\\204\\177*fGZ\\1778\\036\\364\\301\\205\\024Q@8\\372Q\\300\\317\\277J3\\362S\\011\\371\\305\\002\\012(\\242\\236\\016\\301\\364\\247pN}\\261M\\333\\270\\022;\\014\\322\\017\\326\\200\\012(\\242\\233\\316\\354\\032\\220\\235\\264\\257\\367\\301+\\370\\323\\037\\266:\\012\\007\\275\\202\\212(\\246\\261\\344S\\207\\007>\\264\\303\\313\\217\\255HNh\\006\\024QE5>\\373S\\20512\\036\\244\\376\\012\\004\\302\\212(\\246\\177\\015I\\236\\177\\012\\217\\372\\324\\204\\003\\202;u\\240\\030QE\\024\\326\\373\\207\\353H\\247\\000b\\207\\341\\017\\326\\201\\232\\003\\240QE\\024\\375\\302\\225\\017\\316j7\\371[\\336\\244\\343\\013\\372\\323\\023AE\\024R1\\313\\234R\\277\\011L\\007\\015\\365\\247\\2671{\\323\\016\\301E\\024P\\017Z\\011\\377\\000\\032b\\037\\237\\006\\234\\177\\372\\324\\005\\202\\212(\\245\\334:\\03207\\342\\243?{\\357T\\203\\256}\\251&\\015X(\\242\\212y\\306p;sL\\003\\234\\323\\263\\317\\326\\214|\\265W$(\\242\\212\\007\\0034\\235\\001\\247\\003\\217\\246\\015'\\035)\\200QE\\024\\037\\271\\232P~J\\024|\\331\\355\\351A\\356(\\000\\242\\212)\\301\\377\\000\\332\\247\\2226\\000*\\036\\200R\\362\\274P+\\005\\024QH\\337t\\023\\315\\015\\333\\363\\241\\272\\032h\\035}\\250)\\005\\024QR\\201\\362\\347\\322\\242<S\\306\\177\\012C\\313~4\\022\\202\\212(\\240R\\203I\\323\\212Q\\302s@\\302\\212(\\247&\\003\\032l\\234\\016?*\\000\\031\\315\\007\\236}(\\027P\\242\\212(\\037s\\006\\2054\\032A\\324\\346\\201\\205\\024QK\\374\\177^\\264\\207=\\275ix\\333H(\\000\\242\\212)_\\356~\\264Fx\\373\\275i\\033\\322\\236\\033\\200=:P.\\201E\\024SG\\024\\204\\020G\\275<\\216}\\373S{\\320\\027\\012(\\242\\234\\343\\241\\035\\270\\246\\234\\216}:\\323\\201\\354:P~\\351\\240aE\\024S{g\\265!\\037(>\\364\\247 \\017z\\010\\005h\\000\\242\\212(\\350i\\31084?Q\\307\\265\\003\\356\\320O@\\242\\212)\\261\\375\\352p?6h\\034g\\351@\\376t\\015\\205\\024QM\\357\\370S\\277\\2034\\334\\036\\264\\277\\303@\\302\\212(\\245\\210\\341)\\240\\376\\362\\225>\\347\\246)F9\\365\\240\\236\\254(\\242\\212\\011\\346\\203\\221\\307\\2574\\316\\2479\\374)\\355\\323\\351@\\005\\024QB\\017\\2274!\\371\\271\\245\\355\\212f~c@\\005\\024QN\\350s\\357A\\317\\036\\271\\342\\214\\344b\\203\\324\\012\\000(\\242\\212:\\020}:\\322\\234db\\214\\217\\237\\320\\3220\\034\\021\\351@\\005\\024QJ\\033\\255\\033\\307Z\\020\\355\\374h\\343\\346\\246\\001E\\024S\\325~Rs\\370S\\201<\\343\\217aMC\\234\\373S\\010*\\271\\035\\350&\\301E\\024T\\244\\014\\361O9\\333\\307|TA\\373t\\317zR@\\310\\034\\320+\\005\\024QJ\\370\\3163\\317zk\\0147+\\364\\247\\021\\277\\030^EH@\\335\\223@\\257`\\242\\212*\\007\\373\\371\\240r}\\205=\\324\\034\\020~\\264\\305\\004g5CO@\\242\\212+???\\2659\\017ozFO\\230\\220\\275;P\\274\\214\\372W1\\330\\302\\212(\\246\\361\\346\\346\\234N\\027\\353C\\214\\220\\336\\235i\\010\\240\\002\\212(\\245C\\323\\265\\037\\307\\364\\353M\\006\\2340\\030\\320\\001E\\024Ss\\362\\217Bi\\313\\311\\305\\000\\014})@\\345\\350\\023\\012(\\242\\223\\247\\266(o\\273J@\\335\\355C\\014\\257\\035\\273P.\\301E\\024STq\\223\\322\\2448,\\0153'\\247JS\\374\\250\\000\\242\\212)\\242\\234~\\3657\\030\\3058w\\375(\\006\\024QE\\014\\275\\015\\015\\203\\221\\370\\320M\\037\\305@\\005\\024QF\\0004\\021\\202=)?\\216\\206\\355@\\005\\024QR\\014m\\372S\\005!4\\271\\310\\037Z\\000(\\242\\212B~z\\007JV_\\316\\221\\270\\307\\322\\200\\012(\\242\\233\\232\\220g\\257\\245G\\216\\225*\\177\\252&\\204\\014(\\242\\212O\\245!\\000m>\\324\\036\\255GT\\006\\250\\002\\212(\\247\\241\\371I\\034\\232gCB\\375\\303\\2323\\352h\\020QE\\024\\347<Pzb\\207\\037\\273\\316;\\321\\037\\316G\\245\\035C\\240QE\\024c\\003=\\373\\322\\220B\\216\\364\\207\\357\\372S\\263\\362\\320 \\242\\212*>\\374w\\251O\\334\\246\\236\\030{P\\001 \\001\\334\\342\\201\\260\\242\\212)\\033\\245(>\\2648\\371\\200\\374(^\\001\\357@\\272\\005\\024QI/\\010;\\321\\030\\034\\003\\365\\244\\223\\220\\007^i\\377\\000\\307K\\250\\372\\005\\024QQ\\220K\\347\\322\\245\\343v)\\207\\276:\\012\\017\\337\\036\\342\\230\\005\\024QO\\003\\034\\372\\366\\245\\373\\313\\3051\\217\\257\\326\\224\\035\\324\\311\\012(\\242\\220}\\363\\355N\\317\\031\\246\\311\\235\\371\\365\\240s@\\302\\212(\\240\\201\\221\\216\\364\\362A\\376T\\303\\367\\200\\355\\232~\\016\\320~\\264\\000QE\\024\\3044\\342x\\317\\265D\\007\\310O\\277Jv{{R\\033AE\\024T\\237\\301\\237QB\\020["\\214\\374\\210=\\251\\221\\212d\\367\\012(\\242\\245\\317\\317Fr1\\353L`\\335{\\320\\274\\3434\\\\V\\012(\\242\\234OjRr\\300\\372\\323G\\317\\237\\347N\\217\\234{U\\\\\\002\\212(\\241\\263\\212\\007\\177\\316\\227\\031\\245\\307\\317\\203\\310=\\351\\223p\\242\\212)\\011\\342\\201\\216\\236\\224\\177\\006?*\\0118\\347\\257z\\006\\024QE7\\271\\357R\\001\\212h\\347\\236\\364\\2034\\000QE\\024\\240\\361\\370R\\016i\\247\\002\\234\\017\\002\\201\\205\\024QCt\\300\\357M?z\\234F~\\202\\230\\375\\206)0AE\\024S\\3161F\\006\\006(\\350\\005)\\344S\\020QE\\024\\235H\\245\\376:@\\016\\374z\\321\\321\\377\\000\\212\\200\\012(\\242\\227$\\034Pz\\346\\220\\375\\377\\000\\302\\2250s@\\254\\024QE\\007-\\322\\202;\\037\\245\\012q\\337\\232;\\212\\006\\024QE9\\300\\300\\036\\224\\211\\336\\224\\223\\273&\\233\\216r:P.\\201E\\024R\\344\\323T\\346\\221O\\316iG\\337\\317l\\3200\\242\\212)NE'\\361\\012\\220\\363\\217J\\214\\375\\377\\000\\316\\201 \\242\\212)\\344c\\212nv\\323\\216Yx\\250\\233;\\215\\000\\202\\212(\\247\\366\\024Ps\\262\\201\\367\\250\\030QE\\024/C\\352i3\\232^\\231\\244\\031\\301\\365\\353@\\005\\024QJ~\\365 \\031B{\\322\\375\\343\\201B\\375\\312\\000(\\242\\212\\0008\\000v\\353O\\376\\000})\\203\\345\\037z\\237\\374\\034PK\\012(\\242\\243\\004\\343\\353O\\347h\\246\\304\\010\\015\\232\\023\\356P6\\024QE;?>iH?(\\366\\244\\352O\\265)=\\015\\002\\012(\\242\\201\\201\\307^\\364\\363\\203\\310\\357\\315E\\334~U"\\001\\222\\017<q@\\230QE\\024\\326\\004\\362;u\\247\\020C\\340w\\240\\002I\\307N\\202\\206\\376\\361\\240\\002\\212(\\240\\222H\\251\\267\\374\\334\\363\\3765\\004\\231\\310\\347\\250\\246\\363\\365\\305\\002\\265\\302\\212(\\251\\301\\015\\300\\241\\363\\214w\\250P\\236\\377\\000\\\\T\\331\\035\\373\\364\\246&\\254\\024QEP`7\\002\\027\\275F;\\347\\220;R\\223\\202q\\353A9b=k\\003\\250(\\242\\212F\\306\\314\\212h'8\\247\\002:P\\0179\\357\\322\\221AE\\024R\\220\\012\\344~\\024\\305?1\\247/?\\303\\300\\353Bcy\\372\\320 \\242\\212)3N\\007\\347\\307Zg\\335b(\\376:\\002\\301E\\024T\\307n\\303\\267\\2550d\\034\\236(\\034\\036=(\\357\\232b\\012(\\242\\230\\377\\000\\353~\\264\\362\\016O\\363\\250\\217\\337\\02504\\015\\205\\024QH\\177*\\017cC\\343"\\220\\023\\203@\\202\\212(\\245\\000\\217\\341\\244=h\\317\\002\\207\\306\\357\\255\\000\\024QE \\365\\247pH\\367\\244\\034\\012zb\\200aE\\024S\\034`\\375h\\037r\\224\\235\\343\\035\\363H\\330\\003\\3234\\000QE\\024\\376\\243\\336\\233&\\003\\017J\\027\\220h\\223\\266{t\\240:\\205\\024QGT\\315>0\\014&\\231\\377\\000,\\351\\361q\\021\\246\\204\\366\\012(\\242\\243=\\001\\364\\251\\0212\\231\\351\\355Q\\377\\000\\017\\275LH\\331\\307\\002\\222\\033\\012(\\242\\233\\353Q\\216Xg\\275<\\375\\314\\372\\320\\017\\003\\024\\002\\012(\\242\\211>\\346=)\\261\\347o=\\351\\362r\\207\\371\\323"\\371z\\325u\\016\\201E\\024S\\310\\334s\\320w\\243?'\\343C\\223\\371t\\244\\317\\311\\376\\024\\022\\024QE5\\273\\021OF\\342\\243\\356\\005I\\300Z\\006\\302\\212(\\240\\277\\317\\232\\017\\336\\372\\365\\244#\\346\\366\\315\\036\\243\\337\\024\\000QE\\024\\370\\306?\\213\\2753\\370\\317\\265\\031\\374\\350\\316\\034\\373P\\001E\\024R\\307\\3119\\374\\251$\\352\\007z\\220\\017\\233\\215\\334\\363Q\\312>`{zQ\\320\\026\\341E\\024Q&w\\2123I/Q\\364\\247&B\\375\\3259\\3474\\007@\\242\\212(\\221\\272~\\224'N?:IO8\\354i\\340\\374\\240t\\243\\250\\272\\005\\024QMnXzS\\301\\353Q\\220wc\\326\\244\\372u\\246\\204\\302\\212(\\244~T\\324c\\357\\012v7\\002?\\032g;\\305"\\220QE\\0253\\003\\230\\361\\336\\203\\221\\374\\\\\\321\\234\\340\\372\\034\\3229\\357\\3234\\311\\012(\\242\\224\\034\\322\\014\\206\\372\\364\\246\\307\\307'n;S\\262?\\302\\200\\012(\\242\\224}\\323\\365\\244\\310\\333\\350M<r\\276\\365\\021\\004\\201\\216I\\024\\000QE\\025$g\\345\\311\\246\\227\\371\\250A\\201A\\371X\\021\\320\\323\\015.\\024QEH?Q\\315/\\336\\250\\367g\\372\\323\\211\\034\\323\\271\\026\\012(\\242\\227\\332\\223\\0079\\333MS\\300\\247n*q\\355\\232.U\\202\\212(\\243n\\376\\374\\320\\300\\201\\364\\353K\\0318\\315\\03084\\304\\024QE\\006\\243q\\363\\012}\\030\\344\\037J\\221\\255\\002\\212(\\241\\360\\007\\024\\270\\356\\026\\220\\340\\221\\351J\\017QT \\242\\212(\\214\\341\\263\\326\\211\\010\\316}i\\234\\347\\031\\306)\\304\\177\\275\\364\\240-\\250QE\\024\\034\\000\\015\\013\\307\\370R\\377\\000\\015 \\307>\\264\\000QE\\024\\270\\031\\317z\\017\\336\\243\\034b\\223=?\\225\\000\\024QE\\004\\364\\364\\247!\\244\\333\\221\\216\\375hBE\\002{\\005\\024Q@\\0379\\305\\000|\\244\\2123\\226\\247d\\377\\000\\205\\003\\012(\\242\\231\\236\\224\\271\\371\\376\\2240\\037!\\024c\\245\\000\\024QE\\031\\347\\024\\214>~=(?\\353(<s@\\005\\024QO\\217\\271\\353L\\376*Phc@\\272\\205\\024Q@\\243\\250\\246\\003\\221F\\357\\223&\\200\\260QE\\0254\\177\\317\\2750\\017\\235\\200\\351\\357NC\\205\\367\\250\\363\\227=\\250\\004\\024QE/\\360\\221\\370\\322\\206\\340\\021H\\0174r\\016;-\\003\\012(\\242\\236\\207\\2227p\\006M4}\\317\\345B\\236\\264\\200\\2209\\355@\\005\\024QO\\217\\324\\320r>\\224\\314\\340R\\223\\225>\\324\\012\\332\\205\\024QF3\\371\\322\\344\\322\\216E\\034o\\311\\364\\240AE\\024P\\204\\253\\212W==\\015!\\030\\3407\\270\\240r9\\355@y\\205\\024QJ\\307\\356{\\034S\\207\\004\\032bg?\\312\\233\\374X\\240-\\320(\\242\\212y\\034\\347\\337\\030\\247\\221\\236wS\\027'\\255\\003\\256:\\021@\\202\\212(\\252\\022s\\237\\255 >\\364\\363\\215\\344\\036\\231\\246\\310\\000r}E`uy\\005\\024QH\\337\\1774\\240\\234\\320>\\367\\336\\315"\\203\\277\\024\\000QE\\024\\344=\\251\\007\\014}i\\300mo\\273\\217Jk\\372\\372\\320\\035B\\212(\\247\\001\\363r\\337\\376\\272i\\317\\231N\\007\\034u\\242L~\\224\\007P\\242\\212(J@73R'\\336\\247\\246B\\234\\367\\240O@\\242\\212*20\\302\\236~\\357\\2754\\375\\352q#o4\\007`\\242\\212)z\\260\\307\\024\\221\\375\\323B\\267\\313G\\334\\374i\\213\\310(\\242\\2121\\306(\\037y}\\251\\276\\277Jvq\\374T\\024\\024QE<\\000X\\347\\201L_\\276E*\\032\\017\\004\\372u\\240\\220\\242\\212(<>h\\220|\\243\\337\\371\\321\\301l\\355\\317\\245\\016>Ny\\240;\\005\\024QMC\\336\\234p\\177\\212\\231\\237\\226\\236\\243\\177;\\276\\224\\015\\205\\024QN##\\002\\227\\345\\003\\371\\322\\026\\033@\\355\\353\\272\\216\\200\\215\\271\\376T\\022\\024QE7\\220\\017\\277J~r\\230\\244?pP3\\266\\250\\002\\212(\\246\\234\\220@\\240\\344l\\375iq\\363R\\014\\2221\\3335#\\012(\\242\\236}i\\200\\036\\233ri\\307\\220I\\353\\351K\\321sT \\242\\212)$?\\235\\033q\\264z\\365\\245\\003{d\\361\\351Fr\\303\\271\\035h\\000\\242\\212)\\207\\357f\\235\\260\\365\\241\\200+\\201\\324R\\202\\246\\200\\270QE\\024\\314\\215\\324\\346\\007\\2550}\\372w8\\251\\033\\012(\\242\\224r\\271\\243\\253}iP\\321\\267\\347\\317\\\\\\377\\000:\\241\\005\\024QFp\\300~\\224\\215\\202G\\347K\\200O\\256)\\017\\337\\024\\000QE\\024\\254\\001\\031\\351\\357B\\375\\341\\206\\346\\221\\307c\\332\\2261\\362\\347\\323\\265\\035E\\320(\\242\\212I\\033\\214\\237\\302\\200z\\003\\267\\232Yr?\\032j};R\\352>\\201E\\024T\\215\\310\\372t\\246\\257\\246h\\007\\346\\247\\2221\\364\\246N\\301E\\024R\\034\\203\\3151\\201\\030>\\224\\360w\\002=h\\221};\\377\\000:cAE\\024P\\247\\214\\236\\364\\021\\362\\322\\344\\014~\\224\\216y\\307\\255\\035\\004\\024QE\\003\\217\\341\\374\\2522Nj_\\224r\\026\\200>N{\\365\\240.\\024QE\\003\\033E/N\\007\\\\\\361I\\203\\217\\2453\\314\\351@Z\\341E\\024S\\3118\\007m\\004\\015\\274\\3674d\\214g\\365\\244'\\356\\320\\001E\\024SH\\371\\216)\\331\\311\\3057\\250&\\205\\034gw>\\364\\014(\\242\\212\\007\\362\\2478,\\343\\365\\246r=\\315)'\\363\\244\\001E\\024S\\343$'=\\250\\223\\333\\2753}\\004\\374\\240zsLV\\326\\341E\\024S\\327\\257\\326\\234\\330\\351L\\214rM\\016y\\374\\250\\270\\255\\250QE\\024\\343\\355K\\201\\367\\251\\231\\034\\323\\320\\366\\246\\230\\005\\024Q@\\306\\363\\357A8\\376\\224\\305\\341\\217\\245=\\373|\\275\\250\\016\\241E\\024R\\340\\355\\372\\322\\034\\014\\037\\303\\024\\275F{S:\\361T\\010(\\242\\212z\\367\\366\\246\\340\\203\\317\\341N\\307\\315\\307zC@\\202\\212(\\247\\2141\\0375E\\234JsJ\\017\\311I\\367\\260}(\\032\\352\\024QE?o\\356\\372\\362)\\016x\\245\\340\\245!\\350\\015\\004\\240\\242\\212)_\\356\\247\\265/\\360\\212h\\344S\\341'\\232\\003\\240QE\\024\\307\\347\\232\\007\\337\\243\\216\\224tc@\\302\\212(\\240gv\\005\\007'\\200\\324s\\274\\232S\\200\\324\\014(\\242\\212a\\0050=i\\373Bq\\327\\275',E)\\300\\037\\326\\200l(\\242\\212\\013\\372\\323\\020rOcD\\211\\300\\303f\\237\\273\\267\\245\\001\\323@\\242\\212)\\221\\363On\\247\\336\\2220~\\2034\\256x\\376x\\240Op\\242\\212)\\271\\371\\251X\\214\\032\\007"\\201\\367\\271\\351\\351@\\302\\212(\\240t\\003\\245\\000|\\207\\232V\\034q\\332\\200s\\232\\004\\024QE"\\221\\212\\011\\301\\024`g\\330\\363J\\200\\036J\\344P\\001E\\024S\\263\\214{\\3208\\300\\035\\251\\244r\\005\\000\\363\\212\\011\\012(\\242\\235\\317S\\365\\024\\222}\\355\\335\\215+\\034\\001\\371Py\\000\\036\\202\\200\\012(\\242\\225A\\317\\260\\243\\276}G\\362\\243\\235\\344~T\\212\\337\\324P\\001E\\024U3\\334\\367\\245\\316\\370\\276\\356qHs\\270\\342\\233X\\035!E\\024P\\277s4\\014\\003\\365\\241\\0061\\351F>p?\\032\\000(\\242\\212v\\377\\000\\224\\212\\001\\033pi\\2149>\\324\\252;\\320\\001E\\024R\\367\\300\\0359\\244\\223\\356\\212x\\340\\214\\372S\\010\\374\\263@-\\302\\212(\\24109+\\317\\0253\\201\\260c\\203Q\\270\\010\\340\\373R\\347\\345>\\342\\231/[0\\242\\212(\\030\\374\\251\\207\\371u\\247\\001\\214\\032a?\\215"\\220QE\\024\\240`f\\234\\371\\330=\\251\\243\\375Y\\372\\323\\211\\371}\\250\\016\\241E\\024PG\\356\\363I\\327\\345\\356iA\\342\\225F9=\\351\\222\\024QE8\\002\\011\\367\\246\\266C\\034t\\024d\\221\\374\\250\\007\\327\\241\\240\\002\\212(\\241NI4\\354\\235\\277z\\230\\243\\347"\\2160x\\240\\002\\212(\\246\\204\\310\\311\\247\\361\\271GjB1\\032\\375(NN\\005\\005\\005\\024QJ\\340c\\327\\024\\350\\360\\006=j"~SR\\241\\0356\\363\\332\\202Z\\320(\\242\\212R\\007ON\\324\\316\\2758\\317AN\\035H+M^EP\\202\\212(\\247o;\\375\\351\\261\\222\\271\\367\\244\\003\\255*\\347\\003\\336\\244aE\\024S\\216s\\203\\30578\\036\\276\\264\\355\\271'\\346\\355L\\351\\237^\\364\\002\\012(\\242\\236\\011\\316\\177*7|\\371\\333M\\347\\214~\\024\\231\\371\\206h\\013\\005\\024QR\\003\\203\\351\\232N7\\03474\\370\\321YI<S1\\261\\276\\367&\\250AE\\024SLx<~4\\343\\223\\322\\217\\342\\037\\312\\232{{\\3200\\242\\212)\\341\\017C\\305\\007!G\\267Z\\001=\\377\\000\\012\\034\\356 |\\274\\320HQE\\024\\203\\007v;\\323F\\016=\\251O\\312\\324\\200\\021\\317n\\306\\202\\202\\212(\\247I\\333\\326\\224\\037\\236\\234\\311\\362\\003\\336\\242\\376<P%\\252\\012(\\242\\245\\220g\\035\\375\\352.\\231\\035\\311\\247\\347\\247\\2451\\306[4\\002\\354\\024QE?\\333o\\343F6\\2667g=h#\\216\\032\\220\\177\\254\\347u\\002\\012(\\242\\237\\356($\\343\\371\\323s\\267\\374h\\007*h\\025\\202\\212(\\247\\000v\\346\\232\\331\\336\\017jvO\\367\\277:\\007<\\037\\312\\200\\012(\\242\\233\\234\\205\\347\\216sO|\\244t\\314\\005\\330\\007\\000\\323\\245\\345\\177\\032a\\324(\\242\\212\\001\\355\\371\\324#\\375f*T4\\327\\373\\343\\362\\251e.\\241E\\024S\\311\\371s\\351\\332\\231\\333\\324v\\245\\373\\334t\\3058\\341\\207=\\007Za\\260QE\\025\\037\\361R\\243\\365\\376T\\337\\342\\240\\023\\320t\\240aE\\024S\\377\\000\\213%z\\322H03Js\\273\\372PyAL]\\202\\212(\\246g4\\343\\302\\217zS\\036\\024\\021\\310\\3050\\375\\312@\\024QEK\\267lji\\255\\235\\204\\355\\247c\\204\\035ie\\034\\026\\374\\351\\213\\250QE\\024\\317\\340\\317jt\\177p\\232n?w\\365\\247&E\\002{\\005\\024QS\\034pB\\257\\2750\\220\\033\\003\\362\\246\\357\\310\\372\\323\\035\\217\\007\\265\\027\\022AE\\024T\\337y*4\\0047\\266y\\245\\215\\306\\357\\351N|\\226=\\263L6\\320(\\242\\212DsN<\\344|\\302\\231\\236@\\365\\247l;\\216\\027\\363\\240\\002\\212(\\240\\340'\\363\\242<l\\240\\214~4\\330\\276\\353Uu\\016\\201E\\024Q\\237\\223\\216h\\0350h \\021\\317\\034\\320=\\350\\000\\242\\212)A\\371\\251\\310i\\247\\242\\322\\2169\\351@0\\242\\212)\\240\\362i\\307\\357\\017\\272i\\244s\\225\\374E\\031\\346\\200\\012(\\242\\236\\344g\\353H\\240\\225\\315\\017\\314`\\216\\306\\224t\\307\\265\\002\\350\\024QE4}\\352q\\365\\364\\244_\\272\\324\\337\\340\\367\\240aE\\024T\\213\\215\\231\\244\\353\\305"\\237\\223\\232D?5\\004\\330(\\242\\212s\\237\\232\\223<\\037zl\\235h\\347e\\005[@\\242\\212)\\301p\\203\\024\\270;\\177\\225!\\373\\234\\232\\024\\320 \\242\\212)\\340\\344\\023L\\003\\364\\245\\034\\202v\\320=(\\000\\242\\212(=A\\365\\247\\017JgS\\364\\346\\214\\363\\221\\307\\024\\012\\301E\\024Q\\311'\\332\\201\\327\\024\\243\\357b\\217\\342\\240aE\\024Q \\336\\277Jp\\347\\2455\\217oz\\023\\202h\\027@\\242\\212)\\371\\371\\200?JA\\300\\366\\006\\233\\334{\\034\\323\\224\\347\\257J\\004\\024QEQ#\\347\\374i\\231\\347\\024QX\\035AE\\024T\\275\\177\\003FXc\\363\\315\\024P \\242\\212)\\2547\\203\\205\\346\\201\\306(\\242\\200\\350\\024QE#\\036>\\224\\374\\015\\236\\376\\264Q@0\\242\\212(c\\362\\017cM'\\344\\364\\242\\212\\000(\\242\\212x9\\0314\\302\\200\\253\\036\\343\\232(\\246\\010(\\242\\212v\\010Lw\\317\\363\\246\\343x\\305\\024P+\\205\\024QO\\331\\265y\\244O\\275E\\024\\010(\\242\\212\\\\\\345qA\\306\\001\\355E\\024\\000QE\\024\\304\\371\\\\\\323\\207oj(\\240l(\\242\\212y?'\\335\\250\\240\\317\\231\\323\\216h\\242\\207\\272\\022\\331\\205\\024QO\\332\\007\\036\\371\\247\\036\\001\\242\\212\\241\\005\\024QB6_\\327\\036\\264D\\207\\007?AE\\024\\004\\264\\012(\\242\\232>\\351\\035\\351\\000\\001\\006M\\024P0\\242\\212)\\350q\\237\\232\\206#$v<\\232(\\244.\\241E\\024P\\230\\352h\\021\\374\\340\\216\\202\\212)\\331\\012\\341E\\024R\\223\\206\\307l\\367\\247\\000\\016}M\\024S\\000\\242\\212*/\\342\\244~\\000\\242\\212\\206R\\012(\\242\\244@M:@\\016\\017\\313\\305\\024Ut#\\250QE\\024\\327\\000=9O\\313\\364\\242\\212c{\\005\\024QK'\\177j\\207\\376Z\\346\\212*X\\343\\260QE\\024\\377\\000\\341\\316\\336\\364\\231\\016p\\335\\250\\242\\230\\005\\024QJJ\\361\\216\\237\\255\\003\\344j(\\246 \\242\\212)\\033\\276hN\\203\\336\\212)\\017\\240QE\\024\\177\\313>i\\303\\206\\306\\332(\\240AE\\024R6F\\317\\245\\016s\\0274QL}\\202\\212(\\241G\\356\\370\\372\\322:\\364#\\223E\\024\\205\\324(\\242\\212^\\203\\223N\\343g\\256h\\242\\230\\005\\024QMD\\003p=O\\245G\\217\\233\\370\\276\\224QR\\306\\236\\241E\\024R\\365\\346\\236q\\216x\\305\\024S\\006\\024QE=\\376\\352b\\241s\\207\\242\\212l"\\024QEM\\031\\374\\250~\\230\\034\\372\\321E\\035\\010\\352\\024QE2G\\350\\012\\323\\366e8\\353E\\024\\015\\350\\220QE\\024\\204|\\236\\365\\021\\242\\212CAE\\024S\\342\\377\\000\\365\\323\\345\\371\\272QE>\\202\\177\\020QE\\024\\221\\257B\\177\\310\\251\\262;\\365\\242\\212\\244)n\\024QEB\\347\\346\\037\\312\\201\\203\\375h\\242\\227Q\\364\\012(\\242\\2349\\342\\220\\2022(\\242\\250AE\\024Q\\316sGl\\321E\\000\\024QE;\\237\\2453\\235\\370\\375(\\242\\200AE\\024T\\270\\316\\321H\\343k\\220?J(\\240AE\\024Rc\\002\\230:q\\322\\212(\\032\\012(\\242\\236\\277s\\352i\\250p\\307\\024Q@\\005\\024QK'\\255,c\\344\\306\\336h\\242\\200\\350\\024QE\\004~\\353;i\\023\\346_z(\\240:\\005\\024QNNW\\007\\214\\324y\\307\\345E\\024\\002\\012(\\242\\244\\217\\260\\374\\351\\211\\303c\\360\\242\\212\\000(\\242\\212wG#\\323\\275/R\\015\\024P \\242\\212)\\204a\\370\\356jS\\305\\024P'\\320(\\242\\212\\211\\3161\\357OCE\\024\\025\\320(\\242\\212\\377\\331	207
\.


--
-- TOC entry 2034 (class 0 OID 35823)
-- Dependencies: 1419
-- Data for Name: movimento_banca; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY movimento_banca (idmov, idconto, data_inserimento, data_scadenza, descrizione, entrate, uscite, note) FROM stdin;
\.


--
-- TOC entry 2011 (class 0 OID 34780)
-- Dependencies: 1396
-- Data for Name: nazionalita; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY nazionalita (idnazionalita, descrizione) FROM stdin;
0	NESSUNA
2	RUMENA
3	IRLANDESE
4	TEDESCA
5	AUSTRIACA
6	PERU'
7	SVEDESE
8	GRECA
9	BELGA
10	INGLESE
11	SVIZZERA
12	CANADESE
13	AMERICANA
14	NORVEGESE
15	OLANDESE
16	MOLDOVA
17	SLOVENIA
18	ITALIANA
1	NESSUNA
19	FRANCESE
\.


--
-- TOC entry 2035 (class 0 OID 35830)
-- Dependencies: 1420
-- Data for Name: ordini; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ordini (idordine, tipo_documento, idaspetto, pagamento, idcausale, idpagamento, idcliente, data_ordine, ora_ordine, note, num_documento, data_documento, totale_documento, iva_documento, doc_emesso, doc_fiscale, ins_pn, spese_incasso, spese_trasporto, data_trasp, ora_trasp, colli, peso, consegna, porto, diversa_dest, sconto, sconto_euro, numero_fattura, numero_ricevuta, numero_non_fiscale, riferimento_ordine) FROM stdin;
\.


--
-- TOC entry 2012 (class 0 OID 34785)
-- Dependencies: 1397
-- Data for Name: paese; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY paese (id, descrizione) FROM stdin;
\.


--
-- TOC entry 2013 (class 0 OID 34787)
-- Dependencies: 1398
-- Data for Name: pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pagamento (idpagamento, nome) FROM stdin;
0	CONTANTI
1	CARTA DI CREDITO
3	ASSEGNO
2	BANCOMAT
\.


--
-- TOC entry 2014 (class 0 OID 34789)
-- Dependencies: 1399
-- Data for Name: pannelli; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pannelli (idpannelli, nome) FROM stdin;
1	Bar
2	BIRRA
3	prova pannello
\.


--
-- TOC entry 2036 (class 0 OID 35837)
-- Dependencies: 1421
-- Data for Name: prenotazione; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY prenotazione (id, id_cliente, n_pax, num_persone, dal, al, id_convenzione, acconto, mod_arrivo, note, stato, accontoric, nbimbi, scontoperc, scontoeuro, scontobimbi, chiuso, solo_camera, ordine, maggiorazione, numero_ragazzi, sconto_ragazzi) FROM stdin;
\.


--
-- TOC entry 2015 (class 0 OID 34791)
-- Dependencies: 1400
-- Data for Name: progressivi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY progressivi (prog_fattura, prog_ricevuta, prog_scontrino, prog_non_fiscale, anno) FROM stdin;
\.


--
-- TOC entry 2016 (class 0 OID 34795)
-- Dependencies: 1401
-- Data for Name: provincia; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY provincia (idprovincia, provincia, targa) FROM stdin;
4	TREVISO	TV
2	NAPOLI	NA
3	MESSINA	ME
6	PADOVA	PD
7	MILANO	MI
8	TORINO	TO
9	CROTONE	KR
10	COSENZA	CS
11	CATANZARO	CZ
12	SALERNO	SA
13	CASERTA	CE
15	VIBO VALENTIA	VV
16	AVELLINO	AV
17	BENEVENTO	BN
19	PORDENONE	PN
20	BARI	BA
21	PALERMO	PA
22	CATANIA	CT
23	MODENA	MO
24	BOLOGNA	BO
25	FOGGIA	FG
26	ENNA	EN
27	RIMINI	RN
28	BERGAMO	BG
29	PARMA	PR
30	RIETI	RI
31	MATERA	MT
32	BRINDISI	BR
33	CREMONA	CR
34	SIRACUSA	SR
35	CALTANISSETTA	CL
36	AGRIGENTO	AG
37	TARANTO	TA
38	FIRENZE	FI
39	VERONA	VR
40	FROSINONE	FR
41	FERRARA	FE
42	TERNI	TR
43	PISA	PI
44	VICENZA	VI
45	LIVORNO	LI
47	TRAPANI	TP
48	PERUGIA	PG
49	VITERBO	VT
50	ASTI	AT
51	RAGUSA	RG
52	LECCE	LE
53	ISERNIA	IS
54	ORISTANO	OR
55	FORLÌ - CESENA	FC
56	LUCCA	LU
57	BRESCIA	BS
58	LATINA	LT
59	COMO	CO
60	PIACENZA	PC
61	PISTOIA	PT
62	ANCONA	AN
63	ALESSANDRIA	AL
64	POTENZA	PZ
65	GENOVA	GE
66	BIELLA	BI
67	MANTOVA	MN
68	L'AQUILA	AQ
69	PESCARA	PE
70	GORIZIA	GO
71	CUNEO	CN
72	UDINE	UD
73	BELLUNO	BL
74	TERAMO	TE
75	PAVIA	PV
76	BOLZANO	BZ
77	CAMPOBASSO	CB
78	MACERATA	MC
79	VARESE	VA
80	SAVONA	SV
81	LECCO	LC
82	CHIETI	CH
83	TRENTO	TN
84	LODI	LO
85	VERCELLI	VC
14	REGGIO DI CALABRIA	RC
46	REGGIO NELL' EMILIA	RE
86	PRATO	  
87	NOVARA	  
88	ROMA	RM
1	NESSUNA	\N
89	NUORO	NU
90	SASSARI	SS
91	AOSTA	AT
\.


--
-- TOC entry 2037 (class 0 OID 35844)
-- Dependencies: 1422
-- Data for Name: reparti; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY reparti (idreparto, categoria, data_creazione, nome, descrizione) FROM stdin;
\.


--
-- TOC entry 2017 (class 0 OID 34800)
-- Dependencies: 1402
-- Data for Name: reparto; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY reparto (idreparto, data_creazione, nome, descrizione, categoria) FROM stdin;
2	2008-01-11	BAR	BAR	\N
6	2008-01-17	BEVANDE	BEVANDE	\N
7	2008-01-17	ALIMENTARI	ALIMENTARI	\N
9	2008-02-01	PASTICCERIA	PASTICCERIA	\N
13	2008-04-11	GELATI	GELATI	\N
3	2008-01-11	VARIE	VARIE	\N
4	2009-08-29	GRATTAEVINCI	GRATTA E VINCI	\N
15	2010-02-22	PROVA	PROVA	\N
1	2010-02-26	UTENSILI		1
\.


--
-- TOC entry 2002 (class 0 OID 34716)
-- Dependencies: 1382
-- Data for Name: scarico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY scarico (idordine, idcliente, data_ordine, ora_ordine, note, tipo_documento, num_documento, data_documento, totale_documento, iva_documento, doc_emesso, doc_fiscale, ins_pn, idpagamento, idcausale, spese_incasso, spese_trasporto, data_trasp, ora_trasp, colli, peso, consegna, porto, diversa_dest, idaspetto, sconto, pagamento, sconto_euro, numero_fattura, numero_ricevuta, numero_non_fiscale, riferimento_ordine) FROM stdin;
1	0	2010-02-17	02:55:00.187		0		2010-02-17	0	1	0	0	0	0	0	0	0	\N	\N	0	0	\N	\N	\N	0	0	\N	\N	\N	\N	\N	\N
0	0	2010-02-17	03:13:50.25		\N	\N	\N	\N	1	\N	\N	0	\N	\N	0	0	\N	\N	\N	0	\N	\N	\N	\N	0	\N	\N	\N	\N	\N	\N
2	0	2010-02-17	03:15:33.234		0	2	2010-02-17	0	1	0	0	0	0	0	0	0	\N	\N	0	0	\N	\N	\N	0	0	\N	\N	\N	\N	\N	\N
3	0	2010-02-26	21:36:37.421	Vendita al banco	0	1234	2010-02-26	4.7999999999999998	1	0	2	0	0	0	0	0	\N	\N	0	0	\N	\N	\N	0	0	\N	\N	\N	\N	\N	\N
4	0	2010-05-04	02:19:46.484		0	456	2010-05-04	0	1	0	0	0	0	0	0	0	\N	\N	0	0	\N	\N	\N	0	0	\N	\N	\N	\N	\N	\N
5	0	2010-05-04	02:20:39.875		0	12344	2010-05-04	0	1	0	0	0	0	0	0	0	\N	\N	0	0	\N	\N	\N	0	0	\N	\N	\N	\N	\N	\N
6	0	2010-05-04	02:24:10.671		0	2222	2010-05-04	0	1	0	0	0	0	0	0	0	\N	\N	0	0	\N	\N	\N	0	0	\N	\N	\N	\N	\N	\N
7	0	2010-05-04	02:26:04.984		0	231	2010-05-04	19.199999999999999	1	0	0	0	0	0	0	0	\N	\N	0	0	\N	\N	\N	0	0	\N	\N	\N	\N	\N	\N
8	0	2010-05-04	00:00:00		0	333	2010-05-04	52.799999999999997	1	0	0	0	0	0	0	0	\N	\N	0	0	\N	\N	\N	0	0	\N	\N	\N	\N	\N	\N
\.


--
-- TOC entry 2018 (class 0 OID 34802)
-- Dependencies: 1403
-- Data for Name: tipo_documento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tipo_documento (iddocumento, tipo, descrizione) FROM stdin;
2	DDT	DOCUMENTO DI TRASPORTO
4	AL BANCO	SCONTRINO FISCALE
5	NC	NOTA DI CREDITO
0	ORDINE	ORDINE
3	FT	FATTURA
\.


--
-- TOC entry 2019 (class 0 OID 34804)
-- Dependencies: 1404
-- Data for Name: tmp_etichette; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tmp_etichette (id, codice, descrizione, prezzo, note) FROM stdin;
0			0	
2	1683691466PBC	AGIO JUNIOR TIP	2	CONFEZIONE DA 5 PEZZI
\.


--
-- TOC entry 2020 (class 0 OID 34809)
-- Dependencies: 1405
-- Data for Name: tmp_etichette_fornitori; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tmp_etichette_fornitori (idfornitore, nome, via, cap, citta, provincia) FROM stdin;
\.


--
-- TOC entry 2021 (class 0 OID 34814)
-- Dependencies: 1406
-- Data for Name: tmp_scelti; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY tmp_scelti (descrizione, qta, prezzo, totale) FROM stdin;
NO EXTRA	0	0	0
NO EXTRA	0	0	0
NO EXTRA	0	0	0
NO EXTRA	0	0	0
\.


--
-- TOC entry 2038 (class 0 OID 35848)
-- Dependencies: 1423
-- Data for Name: u88fax; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY u88fax (id, codice_aams, kilogrammi, grammi) FROM stdin;
\.


--
-- TOC entry 1999 (class 0 OID 34704)
-- Dependencies: 1378
-- Data for Name: um; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY um (idum, nome, descrizione) FROM stdin;
1	NR	NUMERO
2	PZ	PEZZI
3	CM	CENTIMETRI
4	CL	COLLI
5	KG	KILOGRAMMO
6	LT	LT
\.


--
-- TOC entry 2039 (class 0 OID 35855)
-- Dependencies: 1424
-- Data for Name: utenti; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY utenti (idutente, nome, pwd, lettura, scrittura, esecuzione, note) FROM stdin;
\.


SET search_path = doc, pg_catalog;

--
-- TOC entry 1786 (class 2606 OID 34822)
-- Dependencies: 1363 1363
-- Name: pk_acconto; Type: CONSTRAINT; Schema: doc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY acconto
    ADD CONSTRAINT pk_acconto PRIMARY KEY (id);


--
-- TOC entry 1790 (class 2606 OID 34824)
-- Dependencies: 1365 1365
-- Name: pk_consegna; Type: CONSTRAINT; Schema: doc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY consegna
    ADD CONSTRAINT pk_consegna PRIMARY KEY (id);


--
-- TOC entry 1792 (class 2606 OID 34826)
-- Dependencies: 1366 1366
-- Name: pk_ddt; Type: CONSTRAINT; Schema: doc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ddt
    ADD CONSTRAINT pk_ddt PRIMARY KEY (id);


--
-- TOC entry 1794 (class 2606 OID 34828)
-- Dependencies: 1367 1367
-- Name: pk_dettaglio_documento; Type: CONSTRAINT; Schema: doc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dettaglio_documento
    ADD CONSTRAINT pk_dettaglio_documento PRIMARY KEY (id);


--
-- TOC entry 1796 (class 2606 OID 34830)
-- Dependencies: 1368 1368
-- Name: pk_documento; Type: CONSTRAINT; Schema: doc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT pk_documento PRIMARY KEY (id);


--
-- TOC entry 1798 (class 2606 OID 34832)
-- Dependencies: 1369 1369
-- Name: pk_fattura; Type: CONSTRAINT; Schema: doc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fattura
    ADD CONSTRAINT pk_fattura PRIMARY KEY (id);


--
-- TOC entry 1788 (class 2606 OID 34834)
-- Dependencies: 1364 1364
-- Name: pk_id_bolla; Type: CONSTRAINT; Schema: doc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY bolla
    ADD CONSTRAINT pk_id_bolla PRIMARY KEY (id);


--
-- TOC entry 1800 (class 2606 OID 34838)
-- Dependencies: 1370 1370
-- Name: pk_ordine; Type: CONSTRAINT; Schema: doc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ordine
    ADD CONSTRAINT pk_ordine PRIMARY KEY (id);


--
-- TOC entry 1802 (class 2606 OID 34840)
-- Dependencies: 1371 1371
-- Name: pk_porto; Type: CONSTRAINT; Schema: doc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY porto
    ADD CONSTRAINT pk_porto PRIMARY KEY (id);


--
-- TOC entry 1804 (class 2606 OID 34842)
-- Dependencies: 1372 1372
-- Name: pk_ricevuta; Type: CONSTRAINT; Schema: doc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ricevuta
    ADD CONSTRAINT pk_ricevuta PRIMARY KEY (id);


--
-- TOC entry 1806 (class 2606 OID 34844)
-- Dependencies: 1373 1373
-- Name: pk_stato; Type: CONSTRAINT; Schema: doc; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY stato
    ADD CONSTRAINT pk_stato PRIMARY KEY (id);


SET search_path = public, pg_catalog;

--
-- TOC entry 1808 (class 2606 OID 34846)
-- Dependencies: 1374 1374
-- Name: articoli_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY articolo
    ADD CONSTRAINT articoli_pkey PRIMARY KEY (idarticolo);


--
-- TOC entry 1879 (class 2606 OID 35773)
-- Dependencies: 1408 1408
-- Name: articoli_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY articoli
    ADD CONSTRAINT articoli_pkey1 PRIMARY KEY (idarticolo);


--
-- TOC entry 1838 (class 2606 OID 34848)
-- Dependencies: 1384 1384
-- Name: aspetto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY aspetto
    ADD CONSTRAINT aspetto_pkey PRIMARY KEY (idaspetto);


--
-- TOC entry 1881 (class 2606 OID 35780)
-- Dependencies: 1409 1409
-- Name: banca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY banca
    ADD CONSTRAINT banca_pkey PRIMARY KEY (idbanca);


--
-- TOC entry 1813 (class 2606 OID 34850)
-- Dependencies: 1375 1375
-- Name: carichi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY carico
    ADD CONSTRAINT carichi_pkey PRIMARY KEY (idcarico);


--
-- TOC entry 1883 (class 2606 OID 35784)
-- Dependencies: 1410 1410
-- Name: carichi_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY carichi
    ADD CONSTRAINT carichi_pkey1 PRIMARY KEY (idcarico);


--
-- TOC entry 1843 (class 2606 OID 34852)
-- Dependencies: 1386 1386
-- Name: causale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY causale
    ADD CONSTRAINT causale_pkey PRIMARY KEY (idcausale);


--
-- TOC entry 1827 (class 2606 OID 34854)
-- Dependencies: 1380 1380
-- Name: clienti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT clienti_pkey PRIMARY KEY (idcliente);


--
-- TOC entry 1885 (class 2606 OID 35791)
-- Dependencies: 1411 1411
-- Name: clienti_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY clienti
    ADD CONSTRAINT clienti_pkey1 PRIMARY KEY (idcliente);


--
-- TOC entry 1887 (class 2606 OID 35795)
-- Dependencies: 1412 1412
-- Name: conto_bancario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY conto_bancario
    ADD CONSTRAINT conto_bancario_pkey PRIMARY KEY (idconto);


--
-- TOC entry 1889 (class 2606 OID 35799)
-- Dependencies: 1413 1413
-- Name: dettagli_documenti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dettagli_documenti
    ADD CONSTRAINT dettagli_documenti_pkey PRIMARY KEY (id);


--
-- TOC entry 1817 (class 2606 OID 34856)
-- Dependencies: 1376 1376 1376
-- Name: dettaglio_carichi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dettaglio_carico
    ADD CONSTRAINT dettaglio_carichi_pkey PRIMARY KEY (idarticolo, idcarico);


--
-- TOC entry 1891 (class 2606 OID 35803)
-- Dependencies: 1414 1414 1414
-- Name: dettaglio_carichi_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dettaglio_carichi
    ADD CONSTRAINT dettaglio_carichi_pkey1 PRIMARY KEY (idarticolo, idcarico);


--
-- TOC entry 1893 (class 2606 OID 35807)
-- Dependencies: 1415 1415 1415
-- Name: dettaglio_ordine_manuale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dettaglio_ordine_manuale
    ADD CONSTRAINT dettaglio_ordine_manuale_pkey PRIMARY KEY (id, ordine);


--
-- TOC entry 1830 (class 2606 OID 34858)
-- Dependencies: 1381 1381 1381
-- Name: dettaglio_ordini_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dettaglio_scarico
    ADD CONSTRAINT dettaglio_ordini_pkey PRIMARY KEY (idordine, idarticolo);


--
-- TOC entry 1895 (class 2606 OID 35811)
-- Dependencies: 1416 1416 1416
-- Name: dettaglio_ordini_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dettaglio_ordini
    ADD CONSTRAINT dettaglio_ordini_pkey1 PRIMARY KEY (idordine, idarticolo);


--
-- TOC entry 1897 (class 2606 OID 35815)
-- Dependencies: 1417 1417
-- Name: documenti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY documenti
    ADD CONSTRAINT documenti_pkey PRIMARY KEY (id);


--
-- TOC entry 1821 (class 2606 OID 34860)
-- Dependencies: 1377 1377
-- Name: fornitori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fornitore
    ADD CONSTRAINT fornitori_pkey PRIMARY KEY (idfornitore);


--
-- TOC entry 1899 (class 2606 OID 35822)
-- Dependencies: 1418 1418
-- Name: fornitori_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY fornitori
    ADD CONSTRAINT fornitori_pkey1 PRIMARY KEY (idfornitore);


--
-- TOC entry 1841 (class 2606 OID 34862)
-- Dependencies: 1385 1385
-- Name: id_primary_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categoria
    ADD CONSTRAINT id_primary_key PRIMARY KEY (id);


--
-- TOC entry 1854 (class 2606 OID 34864)
-- Dependencies: 1395 1395
-- Name: id_primarykey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY immagine_articolo
    ADD CONSTRAINT id_primarykey PRIMARY KEY (id);


--
-- TOC entry 1875 (class 2606 OID 34866)
-- Dependencies: 1405 1405
-- Name: key_fornitori; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tmp_etichette_fornitori
    ADD CONSTRAINT key_fornitori PRIMARY KEY (idfornitore);


--
-- TOC entry 1901 (class 2606 OID 35829)
-- Dependencies: 1419 1419
-- Name: movimento_banca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY movimento_banca
    ADD CONSTRAINT movimento_banca_pkey PRIMARY KEY (idmov);


--
-- TOC entry 1836 (class 2606 OID 34868)
-- Dependencies: 1382 1382
-- Name: ordini_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY scarico
    ADD CONSTRAINT ordini_pkey PRIMARY KEY (idordine);


--
-- TOC entry 1903 (class 2606 OID 35836)
-- Dependencies: 1420 1420
-- Name: ordini_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ordini
    ADD CONSTRAINT ordini_pkey1 PRIMARY KEY (idordine);


--
-- TOC entry 1861 (class 2606 OID 34870)
-- Dependencies: 1398 1398
-- Name: pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pagamento
    ADD CONSTRAINT pagamento_pkey PRIMARY KEY (idpagamento);


--
-- TOC entry 1864 (class 2606 OID 34872)
-- Dependencies: 1399 1399
-- Name: pannelli_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY pannelli
    ADD CONSTRAINT pannelli_pkey PRIMARY KEY (idpannelli);


--
-- TOC entry 1866 (class 2606 OID 34874)
-- Dependencies: 1400 1400
-- Name: pk_anno; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY progressivi
    ADD CONSTRAINT pk_anno PRIMARY KEY (anno);


--
-- TOC entry 1877 (class 2606 OID 35517)
-- Dependencies: 1407 1407
-- Name: pk_codici_iva; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY codici_iva
    ADD CONSTRAINT pk_codici_iva PRIMARY KEY (id);


--
-- TOC entry 1846 (class 2606 OID 34876)
-- Dependencies: 1387 1387
-- Name: pk_destinazione; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY destinazione
    ADD CONSTRAINT pk_destinazione PRIMARY KEY (id);


--
-- TOC entry 1848 (class 2606 OID 34878)
-- Dependencies: 1388 1388 1388
-- Name: pk_dettaglio_ordine_manuale; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY dettaglio_scarico_manuale
    ADD CONSTRAINT pk_dettaglio_ordine_manuale PRIMARY KEY (id, ordine);


--
-- TOC entry 1873 (class 2606 OID 34880)
-- Dependencies: 1403 1403
-- Name: pk_documento; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY tipo_documento
    ADD CONSTRAINT pk_documento PRIMARY KEY (iddocumento);


--
-- TOC entry 1850 (class 2606 OID 34882)
-- Dependencies: 1389 1389
-- Name: pk_documento_cliente; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY documento_cliente
    ADD CONSTRAINT pk_documento_cliente PRIMARY KEY (id);


--
-- TOC entry 1852 (class 2606 OID 34884)
-- Dependencies: 1390 1390
-- Name: pk_ente; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ente
    ADD CONSTRAINT pk_ente PRIMARY KEY (idente);


--
-- TOC entry 1868 (class 2606 OID 34886)
-- Dependencies: 1401 1401
-- Name: pk_idprovincia; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY provincia
    ADD CONSTRAINT pk_idprovincia PRIMARY KEY (idprovincia);


--
-- TOC entry 1856 (class 2606 OID 34888)
-- Dependencies: 1396 1396
-- Name: pk_nazionalita; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY nazionalita
    ADD CONSTRAINT pk_nazionalita PRIMARY KEY (idnazionalita);


--
-- TOC entry 1858 (class 2606 OID 34890)
-- Dependencies: 1397 1397
-- Name: pk_paese; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY paese
    ADD CONSTRAINT pk_paese PRIMARY KEY (id);


--
-- TOC entry 1905 (class 2606 OID 35843)
-- Dependencies: 1421 1421
-- Name: prenotazione_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY prenotazione
    ADD CONSTRAINT prenotazione_pkey PRIMARY KEY (id);


--
-- TOC entry 1871 (class 2606 OID 34892)
-- Dependencies: 1402 1402
-- Name: reparti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY reparto
    ADD CONSTRAINT reparti_pkey PRIMARY KEY (idreparto);


--
-- TOC entry 1907 (class 2606 OID 35847)
-- Dependencies: 1422 1422
-- Name: reparti_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY reparti
    ADD CONSTRAINT reparti_pkey1 PRIMARY KEY (idreparto);


--
-- TOC entry 1909 (class 2606 OID 35854)
-- Dependencies: 1423 1423
-- Name: u88fax_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY u88fax
    ADD CONSTRAINT u88fax_pkey PRIMARY KEY (id);


--
-- TOC entry 1825 (class 2606 OID 34894)
-- Dependencies: 1378 1378
-- Name: um_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY um
    ADD CONSTRAINT um_pkey PRIMARY KEY (idum);


--
-- TOC entry 1911 (class 2606 OID 35858)
-- Dependencies: 1424 1424 1424 1424 1424 1424 1424 1424
-- Name: utenti_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY utenti
    ADD CONSTRAINT utenti_pkey PRIMARY KEY (idutente, nome, pwd, lettura, scrittura, esecuzione, note);


--
-- TOC entry 1809 (class 1259 OID 34895)
-- Dependencies: 1374
-- Name: idx_articoli1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_articoli1 ON articolo USING btree (idreparto);


--
-- TOC entry 1810 (class 1259 OID 34896)
-- Dependencies: 1374
-- Name: idx_articoli2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_articoli2 ON articolo USING btree (um);


--
-- TOC entry 1811 (class 1259 OID 34897)
-- Dependencies: 1374
-- Name: idx_articoli4; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idx_articoli4 ON articolo USING btree (idarticolo);


--
-- TOC entry 1839 (class 1259 OID 34898)
-- Dependencies: 1384
-- Name: idx_aspetto1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idx_aspetto1 ON aspetto USING btree (idaspetto);


--
-- TOC entry 1814 (class 1259 OID 34899)
-- Dependencies: 1375
-- Name: idx_carichi1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idx_carichi1 ON carico USING btree (idcarico);


--
-- TOC entry 1815 (class 1259 OID 34900)
-- Dependencies: 1375
-- Name: idx_carichi2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_carichi2 ON carico USING btree (idfornitore);


--
-- TOC entry 1844 (class 1259 OID 34901)
-- Dependencies: 1386
-- Name: idx_causale1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idx_causale1 ON causale USING btree (idcausale);


--
-- TOC entry 1828 (class 1259 OID 34902)
-- Dependencies: 1380
-- Name: idx_clienti1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idx_clienti1 ON cliente USING btree (idcliente);


--
-- TOC entry 1818 (class 1259 OID 34903)
-- Dependencies: 1376
-- Name: idx_dettaglio_carichi1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dettaglio_carichi1 ON dettaglio_carico USING btree (idcarico);


--
-- TOC entry 1819 (class 1259 OID 34904)
-- Dependencies: 1376
-- Name: idx_dettaglio_carichi2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dettaglio_carichi2 ON dettaglio_carico USING btree (idarticolo);


--
-- TOC entry 1831 (class 1259 OID 34905)
-- Dependencies: 1381
-- Name: idx_dettaglio_ordini1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dettaglio_ordini1 ON dettaglio_scarico USING btree (idordine);


--
-- TOC entry 1832 (class 1259 OID 34906)
-- Dependencies: 1381
-- Name: idx_dettaglio_ordini2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_dettaglio_ordini2 ON dettaglio_scarico USING btree (idarticolo);


--
-- TOC entry 1822 (class 1259 OID 34907)
-- Dependencies: 1377
-- Name: idx_fornitori1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idx_fornitori1 ON fornitore USING btree (idfornitore);


--
-- TOC entry 1833 (class 1259 OID 34908)
-- Dependencies: 1382
-- Name: idx_ordini1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_ordini1 ON scarico USING btree (idcliente);


--
-- TOC entry 1834 (class 1259 OID 34909)
-- Dependencies: 1382
-- Name: idx_ordini2; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idx_ordini2 ON scarico USING btree (idordine);


--
-- TOC entry 1859 (class 1259 OID 34910)
-- Dependencies: 1398
-- Name: idx_pagamento1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idx_pagamento1 ON pagamento USING btree (idpagamento);


--
-- TOC entry 1862 (class 1259 OID 34911)
-- Dependencies: 1399
-- Name: idx_pannelli1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE INDEX idx_pannelli1 ON pannelli USING btree (idpannelli);


--
-- TOC entry 1869 (class 1259 OID 34912)
-- Dependencies: 1402
-- Name: idx_reparti1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idx_reparti1 ON reparto USING btree (idreparto);


--
-- TOC entry 1823 (class 1259 OID 34913)
-- Dependencies: 1378
-- Name: idx_um1; Type: INDEX; Schema: public; Owner: postgres; Tablespace: 
--

CREATE UNIQUE INDEX idx_um1 ON um USING btree (idum);


SET search_path = doc, pg_catalog;

--
-- TOC entry 1920 (class 2606 OID 35543)
-- Dependencies: 1876 1407 1367
-- Name: dettaglio_documento_iva_fkey; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY dettaglio_documento
    ADD CONSTRAINT dettaglio_documento_iva_fkey FOREIGN KEY (iva) REFERENCES public.codici_iva(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1912 (class 2606 OID 34939)
-- Dependencies: 1369 1363 1797
-- Name: fk_acconto_fattura; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY acconto
    ADD CONSTRAINT fk_acconto_fattura FOREIGN KEY (fattura) REFERENCES fattura(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1913 (class 2606 OID 34944)
-- Dependencies: 1368 1364 1795
-- Name: fk_bolla_documento; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY bolla
    ADD CONSTRAINT fk_bolla_documento FOREIGN KEY (id) REFERENCES documento(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1921 (class 2606 OID 34949)
-- Dependencies: 1380 1368 1826
-- Name: fk_cliente; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY documento
    ADD CONSTRAINT fk_cliente FOREIGN KEY (cliente) REFERENCES public.cliente(idcliente) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1914 (class 2606 OID 34954)
-- Dependencies: 1842 1366 1386
-- Name: fk_ddt_causale; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY ddt
    ADD CONSTRAINT fk_ddt_causale FOREIGN KEY (causale) REFERENCES public.causale(idcausale) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1915 (class 2606 OID 34959)
-- Dependencies: 1366 1365 1789
-- Name: fk_ddt_consegna; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY ddt
    ADD CONSTRAINT fk_ddt_consegna FOREIGN KEY (consegna_a_mezzo) REFERENCES consegna(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1916 (class 2606 OID 34964)
-- Dependencies: 1845 1366 1387
-- Name: fk_ddt_destinazione; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY ddt
    ADD CONSTRAINT fk_ddt_destinazione FOREIGN KEY (destinazione) REFERENCES public.destinazione(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1917 (class 2606 OID 34969)
-- Dependencies: 1398 1366 1860
-- Name: fk_ddt_pagamento; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY ddt
    ADD CONSTRAINT fk_ddt_pagamento FOREIGN KEY (pagamento) REFERENCES public.pagamento(idpagamento) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1918 (class 2606 OID 34974)
-- Dependencies: 1371 1366 1801
-- Name: fk_ddt_porto; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY ddt
    ADD CONSTRAINT fk_ddt_porto FOREIGN KEY (porto) REFERENCES porto(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1919 (class 2606 OID 34984)
-- Dependencies: 1368 1367 1795
-- Name: fk_dettagliodocumento_documento; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY dettaglio_documento
    ADD CONSTRAINT fk_dettagliodocumento_documento FOREIGN KEY (documento) REFERENCES documento(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1922 (class 2606 OID 34989)
-- Dependencies: 1368 1369 1795
-- Name: fk_fattura_documento; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY fattura
    ADD CONSTRAINT fk_fattura_documento FOREIGN KEY (id) REFERENCES documento(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1923 (class 2606 OID 34994)
-- Dependencies: 1398 1369 1860
-- Name: fk_fattura_pagamento; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY fattura
    ADD CONSTRAINT fk_fattura_pagamento FOREIGN KEY (pagamento) REFERENCES public.pagamento(idpagamento) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1924 (class 2606 OID 34999)
-- Dependencies: 1368 1370 1795
-- Name: fk_ordine_documento; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY ordine
    ADD CONSTRAINT fk_ordine_documento FOREIGN KEY (id) REFERENCES documento(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1925 (class 2606 OID 35004)
-- Dependencies: 1398 1370 1860
-- Name: fk_ordine_pagamento; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY ordine
    ADD CONSTRAINT fk_ordine_pagamento FOREIGN KEY (pagamento) REFERENCES public.pagamento(idpagamento) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1927 (class 2606 OID 35009)
-- Dependencies: 1368 1372 1795
-- Name: fk_ricevuta_documento; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY ricevuta
    ADD CONSTRAINT fk_ricevuta_documento FOREIGN KEY (id) REFERENCES documento(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1928 (class 2606 OID 35014)
-- Dependencies: 1860 1398 1372
-- Name: fk_ricevuta_pagamento; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY ricevuta
    ADD CONSTRAINT fk_ricevuta_pagamento FOREIGN KEY (pagamento) REFERENCES public.pagamento(idpagamento) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1926 (class 2606 OID 35019)
-- Dependencies: 1805 1373 1370
-- Name: fk_stato; Type: FK CONSTRAINT; Schema: doc; Owner: postgres
--

ALTER TABLE ONLY ordine
    ADD CONSTRAINT fk_stato FOREIGN KEY (stato) REFERENCES stato(id) ON UPDATE CASCADE ON DELETE CASCADE;


SET search_path = public, pg_catalog;

--
-- TOC entry 1929 (class 2606 OID 35059)
-- Dependencies: 1374 1870 1402
-- Name: articoli_idreparto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY articolo
    ADD CONSTRAINT articoli_idreparto_fkey FOREIGN KEY (idreparto) REFERENCES reparto(idreparto);


--
-- TOC entry 1930 (class 2606 OID 35064)
-- Dependencies: 1374 1378 1824
-- Name: articoli_um_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY articolo
    ADD CONSTRAINT articoli_um_fkey FOREIGN KEY (um) REFERENCES um(idum);


--
-- TOC entry 1931 (class 2606 OID 35069)
-- Dependencies: 1374 1863 1399
-- Name: articolo_idpannello; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY articolo
    ADD CONSTRAINT articolo_idpannello FOREIGN KEY (idpannello) REFERENCES pannelli(idpannelli);


--
-- TOC entry 1932 (class 2606 OID 35518)
-- Dependencies: 1876 1407 1374
-- Name: articolo_iva_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY articolo
    ADD CONSTRAINT articolo_iva_fkey FOREIGN KEY (iva) REFERENCES codici_iva(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1933 (class 2606 OID 35074)
-- Dependencies: 1377 1375 1820
-- Name: carichi_idfornitore_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carico
    ADD CONSTRAINT carichi_idfornitore_fkey FOREIGN KEY (idfornitore) REFERENCES fornitore(idfornitore);


--
-- TOC entry 1934 (class 2606 OID 35079)
-- Dependencies: 1375 1872 1403
-- Name: carico_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carico
    ADD CONSTRAINT carico_documento FOREIGN KEY (iddocumento) REFERENCES tipo_documento(iddocumento);


--
-- TOC entry 1935 (class 2606 OID 35523)
-- Dependencies: 1876 1407 1375
-- Name: carico_iva_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carico
    ADD CONSTRAINT carico_iva_fkey FOREIGN KEY (iva_documento) REFERENCES codici_iva(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1936 (class 2606 OID 35084)
-- Dependencies: 1374 1807 1376
-- Name: dettaglio_carichi_idarticolo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dettaglio_carico
    ADD CONSTRAINT dettaglio_carichi_idarticolo_fkey FOREIGN KEY (idarticolo) REFERENCES articolo(idarticolo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1937 (class 2606 OID 35089)
-- Dependencies: 1376 1812 1375
-- Name: dettaglio_carichi_idcarico_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dettaglio_carico
    ADD CONSTRAINT dettaglio_carichi_idcarico_fkey FOREIGN KEY (idcarico) REFERENCES carico(idcarico) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1943 (class 2606 OID 35094)
-- Dependencies: 1807 1374 1381
-- Name: dettaglio_ordini_idarticolo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dettaglio_scarico
    ADD CONSTRAINT dettaglio_ordini_idarticolo_fkey FOREIGN KEY (idarticolo) REFERENCES articolo(idarticolo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1944 (class 2606 OID 35099)
-- Dependencies: 1382 1381 1835
-- Name: dettaglio_ordini_idordine_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dettaglio_scarico
    ADD CONSTRAINT dettaglio_ordini_idordine_fkey FOREIGN KEY (idordine) REFERENCES scarico(idordine) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1945 (class 2606 OID 35528)
-- Dependencies: 1381 1407 1876
-- Name: dettaglio_scarico_iva_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dettaglio_scarico
    ADD CONSTRAINT dettaglio_scarico_iva_fkey FOREIGN KEY (iva) REFERENCES codici_iva(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1955 (class 2606 OID 35533)
-- Dependencies: 1388 1876 1407
-- Name: dettaglio_scarico_manuale_iva_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dettaglio_scarico_manuale
    ADD CONSTRAINT dettaglio_scarico_manuale_iva_fkey FOREIGN KEY (iva) REFERENCES codici_iva(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1974 (class 2606 OID 35939)
-- Dependencies: 1420 1902 1416
-- Name: fk1dbc9d975c93fa50; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dettaglio_ordini
    ADD CONSTRAINT fk1dbc9d975c93fa50 FOREIGN KEY (idordine) REFERENCES ordini(idordine);


--
-- TOC entry 1973 (class 2606 OID 35934)
-- Dependencies: 1416 1408 1878
-- Name: fk1dbc9d97616f28b2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dettaglio_ordini
    ADD CONSTRAINT fk1dbc9d97616f28b2 FOREIGN KEY (idarticolo) REFERENCES articoli(idarticolo);


--
-- TOC entry 1962 (class 2606 OID 35879)
-- Dependencies: 1410 1418 1898
-- Name: fk2106b16f66007e1a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carichi
    ADD CONSTRAINT fk2106b16f66007e1a FOREIGN KEY (idfornitore) REFERENCES fornitori(idfornitore);


--
-- TOC entry 1963 (class 2606 OID 35884)
-- Dependencies: 1410 1872 1403
-- Name: fk2106b16f7764e3c6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY carichi
    ADD CONSTRAINT fk2106b16f7764e3c6 FOREIGN KEY (iddocumento) REFERENCES tipo_documento(iddocumento);


--
-- TOC entry 1970 (class 2606 OID 35919)
-- Dependencies: 1878 1408 1414
-- Name: fk2cf0bbb616f28b2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dettaglio_carichi
    ADD CONSTRAINT fk2cf0bbb616f28b2 FOREIGN KEY (idarticolo) REFERENCES articoli(idarticolo);


--
-- TOC entry 1971 (class 2606 OID 35924)
-- Dependencies: 1882 1410 1414
-- Name: fk2cf0bbb76942038; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dettaglio_carichi
    ADD CONSTRAINT fk2cf0bbb76942038 FOREIGN KEY (idcarico) REFERENCES carichi(idcarico);


--
-- TOC entry 1967 (class 2606 OID 35904)
-- Dependencies: 1389 1411 1849
-- Name: fk334b85fe1e6724d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clienti
    ADD CONSTRAINT fk334b85fe1e6724d FOREIGN KEY (documento) REFERENCES documento_cliente(id);


--
-- TOC entry 1964 (class 2606 OID 35889)
-- Dependencies: 1411 1396 1855
-- Name: fk334b85fe4335dc81; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clienti
    ADD CONSTRAINT fk334b85fe4335dc81 FOREIGN KEY (nazionalita) REFERENCES nazionalita(idnazionalita);


--
-- TOC entry 1965 (class 2606 OID 35894)
-- Dependencies: 1401 1411 1867
-- Name: fk334b85feca050bc7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clienti
    ADD CONSTRAINT fk334b85feca050bc7 FOREIGN KEY (provincia) REFERENCES provincia(idprovincia);


--
-- TOC entry 1966 (class 2606 OID 35899)
-- Dependencies: 1411 1851 1390
-- Name: fk334b85fee615563a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY clienti
    ADD CONSTRAINT fk334b85fee615563a FOREIGN KEY (rilasciato_da) REFERENCES ente(idente);


--
-- TOC entry 1983 (class 2606 OID 35989)
-- Dependencies: 1385 1840 1422
-- Name: fk4137f483c5ec56d3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reparti
    ADD CONSTRAINT fk4137f483c5ec56d3 FOREIGN KEY (categoria) REFERENCES categoria(id);


--
-- TOC entry 1969 (class 2606 OID 35914)
-- Dependencies: 1413 1417 1896
-- Name: fk4583fe937430dbab; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dettagli_documenti
    ADD CONSTRAINT fk4583fe937430dbab FOREIGN KEY (id_documento) REFERENCES documenti(id);


--
-- TOC entry 1975 (class 2606 OID 35944)
-- Dependencies: 1418 1867 1401
-- Name: fk6e203436ca050bc7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fornitori
    ADD CONSTRAINT fk6e203436ca050bc7 FOREIGN KEY (provincia) REFERENCES provincia(idprovincia);


--
-- TOC entry 1976 (class 2606 OID 35954)
-- Dependencies: 1419 1886 1412
-- Name: fk6f2516ca451d2517; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY movimento_banca
    ADD CONSTRAINT fk6f2516ca451d2517 FOREIGN KEY (idconto) REFERENCES conto_bancario(idconto);


--
-- TOC entry 1972 (class 2606 OID 35929)
-- Dependencies: 1420 1902 1415
-- Name: fk7b7d12b317496d75; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dettaglio_ordine_manuale
    ADD CONSTRAINT fk7b7d12b317496d75 FOREIGN KEY (ordine) REFERENCES ordini(idordine);


--
-- TOC entry 1956 (class 2606 OID 35324)
-- Dependencies: 1374 1807 1395
-- Name: fk_articolo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY immagine_articolo
    ADD CONSTRAINT fk_articolo FOREIGN KEY (articolo) REFERENCES articolo(idarticolo) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1957 (class 2606 OID 35329)
-- Dependencies: 1840 1385 1402
-- Name: fk_categoria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY reparto
    ADD CONSTRAINT fk_categoria FOREIGN KEY (categoria) REFERENCES categoria(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1953 (class 2606 OID 35334)
-- Dependencies: 1387 1397 1857
-- Name: fk_destinazione_paese; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY destinazione
    ADD CONSTRAINT fk_destinazione_paese FOREIGN KEY (paese) REFERENCES paese(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1954 (class 2606 OID 35339)
-- Dependencies: 1388 1382 1835
-- Name: fk_dettaglio_ordine_manuale2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dettaglio_scarico_manuale
    ADD CONSTRAINT fk_dettaglio_ordine_manuale2 FOREIGN KEY (ordine) REFERENCES scarico(idordine);


--
-- TOC entry 1939 (class 2606 OID 35344)
-- Dependencies: 1849 1389 1380
-- Name: fk_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT fk_documento FOREIGN KEY (documento) REFERENCES documento_cliente(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1946 (class 2606 OID 35349)
-- Dependencies: 1384 1837 1382
-- Name: fk_idaspetto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scarico
    ADD CONSTRAINT fk_idaspetto FOREIGN KEY (idaspetto) REFERENCES aspetto(idaspetto) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1947 (class 2606 OID 35354)
-- Dependencies: 1382 1386 1842
-- Name: fk_idcausale; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scarico
    ADD CONSTRAINT fk_idcausale FOREIGN KEY (idcausale) REFERENCES causale(idcausale) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1948 (class 2606 OID 35359)
-- Dependencies: 1398 1382 1860
-- Name: fk_idpagamento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scarico
    ADD CONSTRAINT fk_idpagamento FOREIGN KEY (idpagamento) REFERENCES pagamento(idpagamento) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1940 (class 2606 OID 35364)
-- Dependencies: 1855 1380 1396
-- Name: fk_nazionalita; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT fk_nazionalita FOREIGN KEY (nazionalita) REFERENCES nazionalita(idnazionalita);


--
-- TOC entry 1949 (class 2606 OID 35369)
-- Dependencies: 1398 1382 1860
-- Name: fk_pagamento2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scarico
    ADD CONSTRAINT fk_pagamento2 FOREIGN KEY (pagamento) REFERENCES pagamento(idpagamento);


--
-- TOC entry 1941 (class 2606 OID 35374)
-- Dependencies: 1380 1401 1867
-- Name: fk_provincia; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT fk_provincia FOREIGN KEY (provincia) REFERENCES provincia(idprovincia) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1942 (class 2606 OID 35379)
-- Dependencies: 1380 1390 1851
-- Name: fk_rilasciatoda; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY cliente
    ADD CONSTRAINT fk_rilasciatoda FOREIGN KEY (rilasciato_da) REFERENCES ente(idente) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1961 (class 2606 OID 35874)
-- Dependencies: 1408 1378 1824
-- Name: fkb6c0de4f1d09f963; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY articoli
    ADD CONSTRAINT fkb6c0de4f1d09f963 FOREIGN KEY (um) REFERENCES um(idum);


--
-- TOC entry 1958 (class 2606 OID 35859)
-- Dependencies: 1906 1422 1408
-- Name: fkb6c0de4f483dc33e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY articoli
    ADD CONSTRAINT fkb6c0de4f483dc33e FOREIGN KEY (idreparto) REFERENCES reparti(idreparto);


--
-- TOC entry 1960 (class 2606 OID 35869)
-- Dependencies: 1408 1898 1418
-- Name: fkb6c0de4f66007e1a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY articoli
    ADD CONSTRAINT fkb6c0de4f66007e1a FOREIGN KEY (idfornitore) REFERENCES fornitori(idfornitore);


--
-- TOC entry 1959 (class 2606 OID 35864)
-- Dependencies: 1408 1863 1399
-- Name: fkb6c0de4f73530abe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY articoli
    ADD CONSTRAINT fkb6c0de4f73530abe FOREIGN KEY (idpannello) REFERENCES pannelli(idpannelli);


--
-- TOC entry 1968 (class 2606 OID 35909)
-- Dependencies: 1409 1880 1412
-- Name: fkb8db3cda6a8400c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY conto_bancario
    ADD CONSTRAINT fkb8db3cda6a8400c FOREIGN KEY (idbanca) REFERENCES banca(idbanca);


--
-- TOC entry 1980 (class 2606 OID 35974)
-- Dependencies: 1420 1411 1884
-- Name: fkc3df71632c64e62a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ordini
    ADD CONSTRAINT fkc3df71632c64e62a FOREIGN KEY (idcliente) REFERENCES clienti(idcliente);


--
-- TOC entry 1981 (class 2606 OID 35979)
-- Dependencies: 1860 1420 1398
-- Name: fkc3df71636876bab9; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ordini
    ADD CONSTRAINT fkc3df71636876bab9 FOREIGN KEY (pagamento) REFERENCES pagamento(idpagamento);


--
-- TOC entry 1977 (class 2606 OID 35959)
-- Dependencies: 1837 1420 1384
-- Name: fkc3df716371754802; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ordini
    ADD CONSTRAINT fkc3df716371754802 FOREIGN KEY (idaspetto) REFERENCES aspetto(idaspetto);


--
-- TOC entry 1978 (class 2606 OID 35964)
-- Dependencies: 1420 1386 1842
-- Name: fkc3df7163838d36e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ordini
    ADD CONSTRAINT fkc3df7163838d36e FOREIGN KEY (idcausale) REFERENCES causale(idcausale);


--
-- TOC entry 1979 (class 2606 OID 35969)
-- Dependencies: 1872 1420 1403
-- Name: fkc3df7163b9473f36; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ordini
    ADD CONSTRAINT fkc3df7163b9473f36 FOREIGN KEY (tipo_documento) REFERENCES tipo_documento(iddocumento);


--
-- TOC entry 1982 (class 2606 OID 35984)
-- Dependencies: 1420 1860 1398
-- Name: fkc3df7163e6f43bfe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ordini
    ADD CONSTRAINT fkc3df7163e6f43bfe FOREIGN KEY (idpagamento) REFERENCES pagamento(idpagamento);


--
-- TOC entry 1938 (class 2606 OID 35499)
-- Dependencies: 1401 1377 1867
-- Name: fornitori_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY fornitore
    ADD CONSTRAINT fornitori_fk FOREIGN KEY (provincia) REFERENCES provincia(idprovincia) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 1950 (class 2606 OID 35504)
-- Dependencies: 1403 1872 1382
-- Name: ordine_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scarico
    ADD CONSTRAINT ordine_documento FOREIGN KEY (tipo_documento) REFERENCES tipo_documento(iddocumento);


--
-- TOC entry 1951 (class 2606 OID 35509)
-- Dependencies: 1826 1380 1382
-- Name: ordini_idcliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scarico
    ADD CONSTRAINT ordini_idcliente_fkey FOREIGN KEY (idcliente) REFERENCES cliente(idcliente);


--
-- TOC entry 1952 (class 2606 OID 35538)
-- Dependencies: 1382 1407 1876
-- Name: scarico_iva_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY scarico
    ADD CONSTRAINT scarico_iva_fkey FOREIGN KEY (iva_documento) REFERENCES codici_iva(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2044 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2010-08-08 18:43:17

--
-- PostgreSQL database dump complete
--

