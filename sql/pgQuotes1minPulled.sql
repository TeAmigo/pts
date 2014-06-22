----------------------------------------------------------------------
-- File path:     /share/sql/pgQuotes1minPulled.sql
-- Version:       
-- Description:   Moving ZB ZF and ZN (Interest Rates) to new table, and reomving from
--                quotes1min table.
-- Author:        Rick Charon <rickcharon@gmail.com>
-- Created at:    Thu Mar 10 12:24:05 2011
-- Modified at:   Thu Apr 28 12:55:29 2011
----------------------------------------------------------------------

CREATE TABLE quotes1minpulled
(
  symbol character varying(15) NOT NULL,
  expiry integer NOT NULL,
  datetime timestamp without time zone NOT NULL,
  open numeric NOT NULL,
  high numeric NOT NULL,
  low numeric NOT NULL,
  "close" numeric NOT NULL,
  volume bigint NOT NULL,
  CONSTRAINT quotes1minpulled_pkey PRIMARY KEY (symbol, datetime)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE quotes1min OWNER TO trader1;

-- Rule: "replace_quotes1min ON quotes1min"

-- DROP RULE replace_quotes1min ON quotes1min;

CREATE OR REPLACE RULE replace_quotes1minpulled AS
    ON INSERT TO quotes1min
   WHERE (EXISTS ( SELECT 1
           FROM quotes1min
          WHERE quotes1min.symbol::text = new.symbol::text AND quotes1min.datetime = new.datetime)) DO INSTEAD  UPDATE quotes1min SET expiry = new.expiry, open = new.open, high = new.high, low = new.low, close = new.close, volume = new.volume
  WHERE quotes1min.symbol::text = new.symbol::text AND quotes1min.datetime = new.datetime;

SELECT symbol, expiry, datetime, open, high, low, "close", volume
  FROM quotes1min where symbol in ('ZB', 'ZF', 'ZN');

SELECT count(*) FROM quotes1min where symbol in ('ZB', 'ZF', 'ZN');

INSERT INTO quotes1minpulled select * from quotes1min where symbol in ('ZB', 'ZF', 'ZN');

INSERT INTO quotes1minpulled select * from quotes1min where symbol = 'ES';

SELECT count(*) FROM quotes1minpulled  where symbol = 'ES';

DELETE FROM quotes1min where symbol = 'ES';

SELECT distinct symbol FROM quotes1minpulled;

DELETE FROM quotes1min where symbol in ('ZB', 'ZF', 'ZN');

SELECT count(*) FROM quotes1min;

SELECT symbol,max(datetime) as maxDate, max(expiry)
      as maxExpiry FROM quotes1minpulled group by symbol order by symbol;

INSERT INTO quotes1min select * from quotes1minpulled;
