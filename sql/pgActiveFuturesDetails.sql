----------------------------------------------------------------------
-- File path:     /share/sql/pgActiveFuturesDetails.sql
-- Version:       
-- Description:   Active Futures in the quotes1min db and details for those 
-- Author:        Rick Charon <rickcharon@gmail.com>
-- Created at:    <2010-12-20 Mon 14:19>
-- Modified at:   Tue Feb 28 09:10:38 2012
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
----------------------------------------------------------------------


-- <2010-12-20 Mon 14:19> A composite type for general contract info,
-- <2011-04-13 Wed 13:12> Updated to include mintick
-- Type: activefuturestype

-- DROP TYPE activefuturestype;

CREATE TYPE activefuturestype AS
   (symbol character varying(8),
    exchange character varying(8),
    multiplier integer,
    pricemagnifier integer,
    mintick numeric,
    fullname character varying(56),
    mindate timestamp without time zone,
    maxdate timestamp without time zone,
    maxexpiry integer);
ALTER TYPE activefuturestype OWNER TO rickcharon;


-- Function: activefuturesdetails()
-- <2011-04-13 Wed 13:11> Updated to include mintick
-- DROP FUNCTION activefuturesdetails();
CREATE OR REPLACE FUNCTION activefuturesdetails()
  RETURNS SETOF activefuturestype AS
$BODY$
  SELECT fc.symbol, fc.exchange, fc.multiplier, fc.priceMagnifier, fc.mintick, fc.fullname,
       qm.minDate, qm.maxDate, qm.maxActiveExpiry
  FROM (SELECT distinct  symbol, exchange, multiplier,
                         priceMagnifier, mintick,
                         fullName FROM futuresContractDetails) as fc,
       (SELECT symbol, min(datetime) as minDate, max(datetime) as maxDate,
          max(expiry) as maxActiveExpiry FROM quotes1min
         group by symbol) as qm where qm.symbol = fc.symbol;
$BODY$
  LANGUAGE 'sql' VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION activefuturesdetails() OWNER TO rickcharon;

select * from activeFuturesDetails();

