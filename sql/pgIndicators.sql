----------------------------------------------------------------------
-- File path:     /share/sql/pgIndicators.sql
-- Version:       
-- Description:   Checking indicator code
-- Author:        Rick Charon <rickcharon@gmail.com>
-- Created at:    Thu Feb 10 11:23:38 2011
-- Modified at:   Thu Feb 10 18:23:56 2011
----------------------------------------------------------------------

select open * 100000 as Open from createCompressedTable('AUD', '2009-12-09 00:00:00', '2009-12-09 18:00:00', 60);

select multiplier from futurescontractdetails where symbol = 'AUD' limit 1;
