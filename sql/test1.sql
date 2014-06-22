trading=#
select symbol, round(sum(outcome), 2)  from papertrades
       where symbol in (select distinct symbol from papertrades)
       group by symbol order by sum(outcome) desc;

 symbol |        sum         
--------+--------------------
 CAD    |  6841.751373240713
 ZW     |  6258.906279538680
 EUR    |  3461.651241907271
 GBP    |  2386.733335423240
 ZF     | 1417.7997054334698
 ZN     |   993.771647354282
 AUD    |    11.049769018300
 DX     |  -600.940750455281
(8 rows)
