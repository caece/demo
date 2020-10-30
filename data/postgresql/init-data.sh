#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
CREATE TABLE scale_data (
   section NUMERIC NOT NULL,
   id1     NUMERIC NOT NULL,
   id2     NUMERIC NOT NULL
);

INSERT INTO scale_data
SELECT sections.*, gen.*
     , CEIL(RANDOM()*100) 
  FROM GENERATE_SERIES(1, 30)     sections,
       GENERATE_SERIES(1, 9000) gen
 WHERE gen <= sections * 30;
EOSQL
