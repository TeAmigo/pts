INSERT INTO quotes1min
VALUES (AUD, 20101213 , 2010-10-29 13:59:00.000000 -07:00:00, 0.9789, 0.979, 0.9789, 0.979, 2);

select min(datetime), max(datetime) from quotes1min where symbol='CAD';



create table quotes1min-dx as select * from quotes1min where symbol='DX' and datetime < '2010-10-30';

select count(*) from qtest;
select min(datetime), max(datetime) from qtest;

delete from qtest where datetime = '2010-10-29 14:00';

select count(*) from qtest where datetime > '2010-10-29 13:00';

INSERT INTO qtest
VALUES ('AUD', 20101213 , '2010-10-29 14:00', 0.9789, 0.979, 0.9789, 0.976, 2);

select * from qtest where datetime='2010-10-29 14:00';

select max(datetime) from quotes1min where symbol='JPY';