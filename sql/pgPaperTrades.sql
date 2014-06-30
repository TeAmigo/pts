----------------------------------------------------------------------
-- File path:     /share/sql/pgPaperTrades.sql
-- Version:       
-- Description:   Various ways of checking PaperTrades
-- plsql-sql-block-indent puts it in the right place;
-- Author:        Rick Charon <rickcharon@gmail.com>
-- Created at:    Wed Jan 26 21:49:58 2011
-- Modified at:   Sat Jun 28 13:09:34 2014
----------------------------------------------------------------------
select ul, ordertype, price, translatedprice, bartime, entrytimestamp from paperorders
       where orderid = parentid and entrytimestamp > '01-01-2014' order by bartime desc;


select ul, ordertype, price, translatedprice, bartime, entrytimestamp from paperorders
       where orderid = parentid order by ul, bartime;

select ul, ordertype, bartime from paperorders where ul = 'CAD' and orderid = parentid order by
bartime desc;



select * from paperorders where orderid = parentid order by ul, bartime;



select symbol, round(sum(outcome), 2)  from papertrades
       where symbol in (select distinct symbol from papertrades)
       group by symbol order by sum(outcome) desc;

delete from papertrades where symbol = 'DX';
       
select ul, ordertype, price, translatedprice, bartime, lossorgain
    from paperorders
   where ul = 'JPY' and bartime > '2011-04-30';

 
select * from papertrades where enteredindb > '2014-01-01';

select symbol, enteredindb, begintradedatetime, exittradedatetime, outcome  from papertrades
       where enteredindb = (select max(enteredindb) from papertrades);

select symbol, enteredindb, begintradedatetime, exittradedatetime, outcome  from papertrades
       where symbol = 'JPY' order by exittradedatetime desc;
       
select symbol, sum(outcome) from papertrades
       where symbol in (select distinct symbol from papertrades)
       group by symbol order by sum(outcome) desc;

       
select sum(outcome) from papertrades where symbol = 'CAD' and enteredindb > '2014-04-01';

select symbol, enteredindb, begintradedatetime, exittradedatetime, outcome  from papertrades
       where symbol = 'CAD' and enteredindb > '2014-04-01';

select count(*) from papertrades;
select count(*) from papertrades where outcome < 0;
select count(*) from papertrades where outcome > 0;

select sum(outcome) from papertrades;

select outcome from papertrades where enteredindb > '2011-03-26';

select max(enteredindb) from papertrades;
select max(exittradedatetime) from papertrades;

select symbol, position, begintradedatetime, exittradedatetime,
         (exittradedatetime - begintradedatetime) as timeInTrade, outcome, enteredindb
             from papertrades order by symbol, begintradedatetime;

  select distinct symbol from papertrades order by symbol;
select count(*) from papertrades where symbol = 'ZF';
select * from paperorders where ul = 'ES';
select max(exittradedatetime) from papertrades where symbol = 'DX';
select sum(outcome) from papertrades;
select sum(outcome) from papertrades where symbol = 'DX';
select min(begintradedatetime) as startDT, max(exittradedatetime) as endDT,
   max(exittradedatetime) - min(begintradedatetime) as Span from papertrades where symbol = 'AUD';


--<2010-12-13 Mon 12:27> Getting the paperorders and papertrades to work in postgres
CREATE TYPE paperordertype AS ENUM
   ('BuyToOpen',
    'SellToOpen',
    'SellProfitToClose',
    'SellLossToClose',
    'BuyProfitToClose',
    'BuyLossToClose');
ALTER TYPE status OWNER TO trader1;

CREATE TABLE paperorders
(
  idx integer NOT NULL DEFAULT nextval('paperorders_idx_seq'::regclass),
  ul character varying(12) NOT NULL,
  ordertype paperordertype NOT NULL,
  price numeric NOT NULL DEFAULT 0::numeric,
  translatedprice numeric NOT NULL DEFAULT 0::numeric,
  bartime timestamp without time zone NOT NULL,
  lossorgain numeric NOT NULL DEFAULT 0::numeric,
  orderid integer NOT NULL,
  parentid integer,
  entrytimestamp timestamp without time zone NOT NULL,
  CONSTRAINT paperorders_pkey PRIMARY KEY (idx)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE paperorders OWNER TO trader1;

INSERT INTO paperorders(ul, ordertype, price, translatedprice, bartime, lossorgain, 
                        orderid, parentid, entrytimestamp)
                                           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);

-----------------------------------------------------------------------------------








-- <2011-01-01 Sat 15:24> -- Papertrades table
CREATE TABLE papertrades
(
  id serial NOT NULL,
  enteredindb timestamp without time zone NOT NULL DEFAULT now(),
  begintradedatetime timestamp without time zone NOT NULL,
  symbol character varying(12) NOT NULL,
  "position" buysellpos NOT NULL,
  entry numeric NOT NULL,
  stoploss numeric NOT NULL,
  stoprisk numeric NOT NULL,
  stopprofit numeric NOT NULL,
  profitpotential numeric NOT NULL,
  outcome numeric NOT NULL,
  exittradedatetime timestamp without time zone NOT NULL,
  CONSTRAINT papertrades_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);



-- <2010-12-31 Fri 14:46> Old paperorders, meant to interop with IB

CREATE TABLE paperorders
(
  idx serial NOT NULL DEFAULT nextval('paperorders_idx_seq'::regclass),
  ul character varying(12) NOT NULL,
  expiry integer NOT NULL,
  buysell character varying(8) NOT NULL,
  totalquantity integer NOT NULL DEFAULT 0,
  filledquantity integer NOT NULL DEFAULT 0,
  remainingquantity integer DEFAULT 0,
  limitprice numeric NOT NULL DEFAULT 0::numeric,
  auxprice numeric NOT NULL DEFAULT 0::numeric,
  avgfillprice numeric NOT NULL DEFAULT 0::numeric,
  ordertype character varying(8) NOT NULL,
  tif character varying(8) NOT NULL,
  translatedprice numeric NOT NULL,
  bartime timestamp without time zone NOT NULL,
  lossorgain numeric,
  ocagroup character varying(24) DEFAULT NULL::character varying,
  ocatype smallint DEFAULT 2::smallint,
  orderid integer NOT NULL,
  parentid integer,
  permid integer,
  entrytimestamp timestamp without time zone NOT NULL,
  executedtimestamp timestamp without time zone,
  status status NOT NULL DEFAULT 'PendingSubmit'::status,
  CONSTRAINT paperorders_pkey PRIMARY KEY (idx)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE paperorders OWNER TO trader1;


-- nextval('paperorders_idx_seq'::regclass) is the way the idx is updated in paperorders, but by
-- default, the sequence starts at 1, so have to remove default value for idx, to drop and recreate
-- the sequence so it starts at the idx after the largest current from mysql
-- new definition <2010-12-31 Fri 14:36> redefining paperorders table

CREATE SEQUENCE paperorders_idx_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 7
  CACHE 1;
ALTER TABLE paperorders_idx_seq OWNER TO trader1;
-- then
ALTER TABLE paperorders ALTER COLUMN idx SET DEFAULT nextval('paperorders_idx_seq'::regclass);

-- nextval('papertrades_id_seq'::regclass) is same idea for paptertrades

INSERT INTO paperorders
              (ul, expiry, buysell, totalquantity, filledquantity, remainingquantity, 
               limitprice, auxprice, avgfillprice, ordertype, tif, translatedprice, 
               bartime, lossorgain, ocagroup, ocatype, orderid, parentid, permid, 
               entrytimestamp, executedtimestamp, status)
                        VALUES ('CAD',20101214,'SELL',1,0,0,0.92856060916736,0,0,'LMT','DAY',92856.060916736,'2009-09-11 13:11:49',NULL,NULL,NULL,1,1,NULL,'2010-12-13 15:28:34','2010-12-13 15:28:34','Filled');

INSERT INTO papertrades(
                        id, enteredindb, begintradedatetime, symbol, "position", entry, 
                        stoploss, stoprisk, stopprofit, profitpotential, outcome, exittradedatetime)
                        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);

