-- <2014-06-27 Fri 13:28> I need to create tables of the 1-hour bars to avoid the huge amount of time
-- that it takes to draw the charts from the quotes1min table. Might be easiest to keep downloading the
-- 1 min data and create the hour tables locally. (Could just download  hour tables!).

--- ZW, ZC, JPY, AUD, GBP, EUR, CAD, ZB, ZN, CL, ES, GC, ZF, ZS
-- <2014-06-28 Sat 03:29> Created the individual tables.
-- trading=# CREATE TABLE zw AS SELECT DISTINCT * FROM quotes1min WHERE symbol='ZW';
-- SELECT 129386
CREATE UNIQUE INDEX "zw_idx" ON "public"."zw" USING BTREE ("datetime");
-- trading=# CREATE TABLE zc AS SELECT DISTINCT * FROM quotes1min WHERE symbol='ZC';
-- SELECT 129285
-- CREATE UNIQUE INDEX "zc_idx" ON "public"."zc" USING BTREE ("datetime");
-- trading=# CREATE TABLE jpy AS SELECT DISTINCT * FROM quotes1min WHERE symbol='JPY';
-- SELECT 172365
-- CREATE UNIQUE INDEX "jpy_idx" ON "public"."jpy" USING BTREE ("datetime");
-- trading=# CREATE TABLE aud AS SELECT DISTINCT * FROM quotes1min WHERE symbol='AUD';
-- SELECT 172366
-- CREATE UNIQUE INDEX "aud_idx" ON "public"."aud" USING BTREE ("datetime");
-- trading=# CREATE TABLE gbp AS SELECT DISTINCT * FROM quotes1min WHERE symbol='GBP';
-- SELECT 172664
-- CREATE UNIQUE INDEX "gbp_idx" ON "public"."gbp" USING BTREE ("datetime");
-- trading=# CREATE TABLE eur AS SELECT DISTINCT * FROM quotes1min WHERE symbol='EUR';
-- SELECT 173745
-- CREATE UNIQUE INDEX "eur_idx" ON "public"."eur" USING BTREE ("datetime");
-- trading=# CREATE TABLE cad AS SELECT DISTINCT * FROM quotes1min WHERE symbol='CAD';
-- SELECT 172356
-- CREATE UNIQUE INDEX "cad_idx" ON "public"."cad" USING BTREE ("datetime");
-- trading=# CREATE TABLE zb AS SELECT DISTINCT * FROM quotes1min WHERE symbol='ZB';
-- SELECT 172424
-- CREATE UNIQUE INDEX "zb_idx" ON "public"."zb" USING BTREE ("datetime");
-- trading=# CREATE TABLE zn AS SELECT DISTINCT * FROM quotes1min WHERE symbol='ZN';
-- SELECT 172424
-- CREATE UNIQUE INDEX "zn_idx" ON "public"."zn" USING BTREE ("datetime");
-- trading=# CREATE TABLE es AS SELECT DISTINCT * FROM quotes1min WHERE symbol='ES';
-- SELECT 172320
-- CREATE UNIQUE INDEX "es_idx" ON "public"."es" USING BTREE ("datetime");
-- trading=# CREATE TABLE gc AS SELECT DISTINCT * FROM quotes1min WHERE symbol='GC';
-- SELECT 175231
-- CREATE UNIQUE INDEX "gc_idx" ON "public"."gc" USING BTREE ("datetime");
-- trading=# CREATE TABLE zf AS SELECT DISTINCT * FROM quotes1min WHERE symbol='ZF';
-- SELECT 165216
-- CREATE UNIQUE INDEX "zf_idx" ON "public"."zf" USING BTREE ("datetime");
-- trading=# CREATE TABLE zs AS SELECT DISTINCT * FROM quotes1min WHERE symbol='ZS';
-- SELECT 128072
-- CREATE UNIQUE INDEX "zs_idx" ON "public"."zs" USING BTREE ("datetime");


select * from compressrowsspecifyintable('CL', 'CL', '2014-05-14 07:00:00', '2014-05-14 07:59');

select * from createCompressedTableSpecifyInTable('CL', 'CL', '2014-05-14 00:00:00.0', '2014-05-16 15:40:40.901-07:00', 60);

CREATE TABLE es1 as SELECT DISTINCT * FROM es;  
drop table aud;
alter table aud1 rename to aud;
select count(*) from aud;

-- Get rid of duplicate datetime
SELECT datetime FROM gc group by datetime HAVING COUNT(*) > 1;
delete from aud where datetime = '2014-06-24 15:49:00' and volume = 0;
SELECT * FROM eur WHERE ctid NOT IN (SELECT max(ctid) FROM eur GROUP BY datetime);
DELETE FROM eur WHERE ctid NOT IN (SELECT max(ctid) FROM eur GROUP BY datetime);


-- None of below does anything useful.
select * from cl where datetime >= '2014-05-14 07:00:00' and datetime < '2014-05-14 08:00';
select open from (
select open, min(datetime) from cl where datetime >= '2014-05-14 07:00:00' and datetime < '2014-05-14 08:00'
       group by open;
