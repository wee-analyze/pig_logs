-- resultatet visar antal besök, datum, första besökstiden, sista besökstiden med url som innehålls linqtosql, bara 
-- dagar som har fler än 80 besök och är sorterat fallande per antal besök. Om två dagar har dessutom lika antal 
-- hamnar dessa i datumordning.

lines = LOAD '/data/2018_jan.txt' USING PigStorage(' ') AS (logdate: chararray, time: chararray, category: chararray, method: chararray, url: chararray);

-- tas bort första 2 radarna med version och headers
linqtosqlurl = FILTER lines BY url MATCHES '.*/linqtosql.*';
-- alternativ  
-- lineswithurl = FILTER lines BY url MATCHES '^/.*'
;

group_by_day = GROUP linqtosqlurl by logdate;
DESCRIBE group_by_day; 

agg_group_by_day = FOREACH group_by_day GENERATE COUNT(linqtosqlurl) AS number_visits, group AS date, MIN(linqtosqlurl.time) AS first_visit, MAX(linqtosqlurl.time) AS last_visit;
ordered_agg_group = ORDER agg_group_by_day BY number_visits DESC, date ASC;
greater_80_visitors = FILTER ordered_agg_group BY number_visits > 80;

-- skrivs på skärmen
DUMP greater_80_visitors;

-- mapp kommer att skapas och lagras i hdfs
STORE greater_80_visitors INTO '/data/results' USING PigStorage(',');