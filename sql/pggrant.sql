######################################################################
## File path:     /share/sql/pggrant.sql
## Version:       
## Description:   You can copy/paste all of these at once into the trading=# *SQL* buffer
## Author:        Rick Charon <rickcharon@gmail.com>
## Created at:    Mon Nov 29 14:48:25 2010
## Modified at:   Mon Nov 29 14:50:08 2010
######################################################################


ALTER FUNCTION compressrows(character varying, timestamp without time zone, timestamp without time
                            zone, integer) OWNER TO trader1;
ALTER FUNCTION createcompressiontable(character varying) OWNER TO trader1;
ALTER FUNCTION datedrangebysymbol(character varying, timestamp without time zone,
                                  timestamp without time zone) OWNER TO trader1;
ALTER FUNCTION distinctquotesymbols() OWNER TO trader1;
ALTER FUNCTION fcd() OWNER TO trader1;
ALTER FUNCTION howmanyquotes() OWNER TO trader1;

ALTER TABLE quotes1min OWNER to trader1;
ALTER TABLE futurescontractdetails OWNER to trader1;
ALTER TABLE paperorders OWNER to trader1;
ALTER TABLE papertrades OWNER to trader1;
ALTER TABLE trades OWNER to trader1;
ALTER TABLE tradesandresults OWNER to trader1;
