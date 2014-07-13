create table futurescontractdetailsbackup as select * from futurescontractdetails;

-- delete from futurescontractdetails;

SELECT distinct symbol, multiplier, pricemagnifier, exchange, fullname FROM futuresContractDetails;
 -- WHERE symbol = 'ZB' limit 1;

  SELECT distinct symbol, expiry, exchange FROM futuresContractDetails where symbol in ('AUD', 'CAD',
                                                                                        'DX', 'ES',
                                                                                        'EUR', 'GBP',
                                                                                        'JPY', 'ZB',
                                                                                        'ZN', 'ZW')
     and expiry > 20111220 and expiry <= 20120600 order by symbol, expiry;


SELECT distinct symbol, expiry, exchange FROM futuresContractDetails where symbol in ('AUD', 'CAD', 'CL', 'DX', 'ES', 'EUR', 'GBP', 'GC', 'JPY', 'ZB', 'ZC', 'ZF', 'ZN', 'ZS', 'ZW') and expiry >= 20110915 and expiry <= 20120300 order by symbol, expiry;

SELECT distinct symbol, expiry, exchange FROM futuresContractDetails where symbol in ('ZF', 'ZS', 'GC') and expiry >= 20120113 and expiry <= 20120701 order by symbol, expiry;


SELECT distinct symbol, expiry, exchange FROM futuresContractDetails
   where symbol in ('CL', 'ZS', 'GC')  and expiry >= 20110830 and expiry <= 20111200 order by symbol,expiry;

  select mintick from futurescontractdetails where symbol = 'JPY';

select distinct symbol, mintick from futurescontractdetails where symbol in ('AUD', 'CAD', 'DX',
 'ES', 'EUR', 'GBP', 'JPY');


'AUD', 'CAD', 'CL', 'DX', 'ES', 'EUR', 'GBP', 'GC', 'JPY', 'ZB', 'ZC', 'ZF', 'ZN', 'ZS', 'ZW'




SELECT distinct symbol, expiry, exchange FROM futuresContractDetails where symbol in ('ZS', 'ZW', 'ZC') and
                            expiry >= 20110900 and expiry <= 20120100
                            order by symbol, expiry;

select distinct symbol FROM quotes1min order by symbol;

SELECT distinct symbol, expiry, exchange FROM futuresContractDetails where symbol in
                            (select distinct symbol FROM quotes1min) and
                            expiry >= 20110500 and expiry <= 20120700
                            order by symbol, expiry;

SELECT distinct symbol, exchange, expiry FROM futuresContractDetails where symbol = 'ZC' order by expiry;

SELECT distinct symbol FROM futuresContractDetails order by symbol;

--<2010-12-13 Mon 16:09>
  update futuresContractDetails
     set active='1'
   where symbol in (select distinct symbol FROM quotes1min)
     and expiry > 20101222
     and expiry < 20110501;

  update futuresContractDetails
     set begindate = '2010-12-13 00:00'
   where symbol in (select distinct symbol FROM quotes1min)
     and expiry > 20101222
     and expiry < 20110501;




       

SELECT distinct symbol, expiry FROM futuresContractDetails where active='1';
update futuresContractDetails set active='0';

SELECT multiplier, pricemagnifier, exchange, fullname FROM futuresContractDetails
 WHERE symbol = 'ZB' limit 1;

SELECT multiplier, pricemagnifier, exchange, fullname FROM futuresContractDetails
                                WHERE symbol = 'AUD' limit 1;

SELECT e.name  FROM (Select * from emp) as e, (Select * from map) as m;

SELECT fc.symbol, fc.exchange, fc.multiplier, fc.priceMagnifier, fc.fullname,
       qm.minDate, qm.maxDate, qm.maxExpiry
  FROM (SELECT distinct  symbol, exchange, multiplier,
                         priceMagnifier,
                         fullName FROM futuresContractDetails) as fc,
       (SELECT symbol, min(datetime) as minDate, max(datetime) as maxDate,
          max(expiry) as maxExpiry FROM quotes1min
         group by symbol) as qm where qm.symbol = fc.symbol limit 1;
                                                                         
                                                                         

SELECT symbol, min(datetime) as minDate, max(datetime) as maxDate,
          max(expiry) as maxExpiry FROM quotes1min
         group by symbol;

SELECT symbol, max(expiry) as maxExpiry FROM quotes1min group by symbol;
