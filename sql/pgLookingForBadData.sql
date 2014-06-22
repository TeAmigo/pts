----------------------------------------------------------------------
-- File path:     /share/sql/pgLookingForBadData.sql
-- Version:       
-- Description:   Fishing for data that seems questionable
-- Author:        Rick Charon <rickcharon@gmail.com>
-- Created at:    Tue Feb  8 17:38:09 2011
-- Modified at:   Tue Feb  8 17:45:00 2011
----------------------------------------------------------------------
select high,
       volume
 from quotes1min
 where symbol = 'JPY' and datetime < '2011-02-04 06:00' and datetime > '2011-02-04 05:00';

select distinct symbol, multiplier, pricemagnifier from futurescontractdetails;
