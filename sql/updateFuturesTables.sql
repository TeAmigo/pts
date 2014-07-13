-- <2014-07-12 Sat 15:49> Update the futures tables to contain all the latest relevant data.

-- update futurestables set mindate = mindt, maxdate = maxdt, expirylatest = maxexpiry
--        FROM (SELECT min(datetime) as mindt, max(datetime) as maxdt, max(expiry) as maxexpiry FROM aud) t where name = 'aud';

-- update futurestables set multiplier = multi, pricemagnifier = pm, mintick = mt, fullname = fn
--        FROM (select multiplier as multi, pricemagnifier as pm, mintick as mt, fullname as fn from futurescontractdetails where
--              symbol = 'AUD' and expiry = (select max(expiry) from aud)) t where name = 'aud';


CREATE OR REPLACE FUNCTION updateFuturesTables()
  RETURNS VOID  AS
$$
DECLARE
nameIn character varying(15);
exeStr text;
BEGIN
        FOR nameIn IN SELECT name FROM futurestables LOOP
                exeStr = 'UPDATE futurestables set mindate = mindt, maxdate = maxdt, expirylatest = maxexpiry
                       FROM (SELECT min(datetime) as mindt, max(datetime) as maxdt, max(expiry) as maxexpiry FROM '
                       || nameIn::regclass || ') t where name = ''' || nameIn || ''';';

                EXECUTE exeStr;

                exeStr = 'UPDATE futurestables set multiplier = multi, pricemagnifier = pm, mintick = mt, fullname = fn
                       FROM (select multiplier as multi, pricemagnifier as pm, mintick as mt, fullname as fn
                       FROM futurescontractdetails where symbol = upper(''' || nameIn || ''')
                       and expiry = (select max(expiry) from ' || nameIn::regclass || ')) t
                       where name = ''' || nameIn || ''';';
                EXECUTE exeStr;
                -- raise notice '%', exeStr;
        END LOOP;
        raise notice 'Loop done.';
        RETURN;
END;
$$
LANGUAGE plpgsql;

select * from updateFuturesTables();
