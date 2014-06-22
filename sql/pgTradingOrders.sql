----------------------------------------------------------------------
-- File path:     /share/sql/pgTradingOrders.sql
-- Version:       
-- Description:   Views of orders and trades
-- Author:        Rick Charon <rickcharon@gmail.com>
-- Created at:    Thu Dec 30 15:20:17 2010
-- Modified at:   Thu Dec 30 18:16:01 2010
----------------------------------------------------------------------


select symbol, outcome, begintradedatetime, exittradedatetime, position  from papertrades;

select ul, bartime from paperorders where ul = 'AUD' and bartime = '2010-03-03 01:29:01.635';

select buysell, auxprice, limitprice,  ordertype from paperorders
where ul = 'AUD' and bartime = '2010-03-03 01:29:01.635';

select * from paperorders
where ul = 'AUD' and bartime = '2010-03-03 01:29:01.635';

