#!/usr/bin/env sh
# Distributed under the terms of GNU General Public License (GPL) 2.0

psql -d postgres -c "CREATE EXTENSION plpythonu;"
psql -d postgres -c "CREATE EXTENSION plpython3u;"

psql -d postgres -c "CREATE EXTENSION postgis;"

psql -d postgres -c "CREATE EXTENSION postgis_topology;"
psql -d postgres -c "CREATE EXTENSION postgis_sfcgal;"

MAKEFLAGS='-j1' pgxn install madlib \
    && pgxn load madlib

/usr/local/madlib/bin/madpack -s madlib -p postgres -c postgres@localhost:5432/postgres install
/usr/local/madlib/bin/madpack -s madlib -p postgres -c postgres@localhost:5432/postgres install-check
