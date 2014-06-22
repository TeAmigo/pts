--- /share/sql/postgresDateTimes.sql
--- <2010-11-17 Wed 15:19> rpc - Interesting date and time and timestamp stuff

SELECT * FROM generate_series(CAST('2009-01-01 00:00' As timestamp),
       CAST('2009-3-01 00:00' As timestamp), '7 days');

SELECT CAST(generate_series(CAST('2009-01-01' As date), 
    CAST('2009-12-01' As date), '10 days') as date) As aday;


SELECT CAST(generate_series(CAST('2009-12-09 03:39:00' As timestamp), 
    CAST('2009-12-09 15:00:00' As timestamp), '10 minutes') as timestamp);
'2009-12-09 03:00:00', '2009-12-09 15:00:00'


select min(datetime) from quotes1min where symbol='AUD';

SELECT EXTRACT(EPOCH FROM TIMESTAMP WITH TIME ZONE '2010-01-01 00:00');
1262332800
SELECT EXTRACT(EPOCH FROM TIMESTAMP WITH TIME ZONE '2010-01-02dt00:00');
1262419200 - 1262332800 = [86400]
1262419200 +  86400 = [1262505600]
Epoch converter at http://www.epochconverter.com/
SELECT extract(epoch FROM now());

SELECT current_date;
SELECT date_trunc('hour', now());
SELECT date_trunc('day', now());
SELECT date_trunc('week', now());  --- gives the Monday date, day 1.
SELECT date_trunc('month', now()); -- gives 1st day of month.
select date('2001-09-28') + integer '7';
select date(now()) + integer '7';
SELECT EXTRACT(DOW FROM now());
select :tt;
select 6 % 4 ;

SELECT EXTRACT(EPOCH FROM INTERVAL '1 secs');
SELECT EXTRACT(EPOCH FROM TIMESTAMP '2009-12-08 00:00:00'); -- essentially the long timestamp is
-- called epoch
SELECT EXTRACT(WEEK FROM TIMESTAMP '1970-01-01 00:00:00' );

-- Here is how you can convert an epoch value back to a time stamp: 
SELECT TIMESTAMP WITHOUT TIME ZONE 'epoch' + 1260259200 * INTERVAL '1 second';


\set
-- Populate the aggregate_number column of quotes1min with the proper value,
-- given an aggregation factor, which could be minutes, hours, days, weeks, months...
-- Require a begin date, default to beginning of data in db


CREATE OR REPLACE FUNCTION createCompressedTimeSeries(beginTime timestamp,
                                          endTime timestamp, compressionFactor int)
   RETURNS SETOF timestamp AS
$$
DECLARE
   retrow timestamp;
BEGIN   
   FOR retRow in EXECUTE 'SELECT CAST(generate_series(CAST(''' || beginTime || ''' As timestamp), 
    CAST(''' || endTime || ''' As timestamp), ''' || compressionFactor || ' minutes'') as timestamp)' LOOP
      RETURN NEXT retRow;
   END LOOP;
   RETURN;
END;
$$ LANGUAGE plpgsql;

select * from testTimeSeries('2009-12-09 03:00:00', '2009-12-09 15:00:00', 60);

SELECT CAST(generate_series(CAST('2009-12-09 03:00:00' As timestamp), 
    CAST('2009-12-09 15:00:00' As timestamp), '60 minutes') as timestamp);