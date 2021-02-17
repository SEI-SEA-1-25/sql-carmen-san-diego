-- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been
-- traveling through Southern Europe. She's most likely traveling someplace where she won't be noticed,
-- so find the least populated country in Southern Europe, and we'll start looking for her there.
SELECT * FROM countries;
SELECT name , population FROM countries;
SELECT name, population, region FROM countries ORDER BY population ASC LIMIT 5 ;


-- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes in
-- this country's officially recognized language. Check our databases and find out what language is
-- spoken in this country, so we can call in a translator to work with you.
world=# SELECT name, code, region FROM countries ORDER BY population ASC 5;
 Holy See (Vatican Cities State)              | VAT  | Southern Europe
world=# SELECT countrycode, language FROM countrylanguages WHERE countrycode = 'VAT';
 countrycode | language
-------------+----------
 VAT         | Italian

-- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on
-- to a different country, a country where people speak only the language she was learning. Find out which
--  nearby country speaks nothing but that language.
world=# SELECT countrycode, language FROM countrylanguages WHERE language = 'Italian' ;
 countrycode | language
-------------+----------
 ITA         | Italian
 SMR         | Italian
 VAT         | Italian
 ARG         | Italian
 AUS         | Italian
 LIE         | Italian
 BEL         | Italian
 BRA         | Italian
 LUX         | Italian
 MCO         | Italian
 CHE         | Italian
 CAN         | Italian
 FRA         | Italian
 DEU         | Italian
 USA         | Italian
(15 rows)

world=# SELECT name, code, region FROM countries WHERE region = 'Southern Europe';
              name               | code |     region
---------------------------------+------+-----------------
 Albania                         | ALB  | Southern Europe
 Andorra                         | AND  | Southern Europe
 Bosnia and Herzegovina          | BIH  | Southern Europe
 Spain                           | ESP  | Southern Europe
 Gibraltar                       | GIB  | Southern Europe
 Italy                           | ITA  | Southern Europe
 Yugoslavia                      | YUG  | Southern Europe
 Greece                          | GRC  | Southern Europe
 Croatia                         | HRV  | Southern Europe
 Macedonia                       | MKD  | Southern Europe
 Malta                           | MLT  | Southern Europe
 Portugal                        | PRT  | Southern Europe
 San Marino                      | SMR  | Southern Europe
 Slovenia                        | SVN  | Southern Europe
 Holy See (Vatican Cities State) | VAT  | Southern Europe
(15 rows)
world=# SELECT countrycode, language, percentage FROM countrylanguages WHERE language = 'Italian';
 countrycode | language | percentage
-------------+----------+------------
 ITA         | Italian  |       94.1
 SMR         | Italian  |        100
 VAT         | Italian  |          0
 ARG         | Italian  |        1.7
 AUS         | Italian  |        2.2
 LIE         | Italian  |        2.5
 BEL         | Italian  |        2.4
 BRA         | Italian  |        0.4
 LUX         | Italian  |        4.6
 MCO         | Italian  |       16.1
 CHE         | Italian  |        7.7
 CAN         | Italian  |        1.7
 FRA         | Italian  |        0.4
 DEU         | Italian  |        0.7
 USA         | Italian  |        0.6
(15 rows)

SAN MARINO OK

-- Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time.
 -- There are only two cities she could be flying to in the country. One is named the same as the country – that
 -- would be too obvious. We're following our gut on this one; find out what other city in that country she might
 --  be flying to.
world=# SELECT countrycode, name FROM cities WHERE countrycode = 'SMR';
 countrycode |    name
-------------+------------
 SMR         | Serravalle
 SMR         | San Marino


-- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally different
-- parts of the globe! She's headed to South America as we speak; go find a city whose name is like the one we were
-- headed to, but doesn't end the same. Find out the city, and do another search for what country it's in. Hurry!

world=# SELECT countrycode, name FROM cities WHERE name LIKE 'Serr%';
 countrycode |    name
-------------+------------
 BRA         | Serra
 SMR         | Serravalle

 world=# SELECT name FROM countries WHERE code = 'BRA';
  name
--------
 Brazil

-- Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
 -- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll
 -- follow right behind you!
world=# SELECT name, capital FROM countries WHERE code = 'BRA';
  name  | capital
--------+---------
 Brazil |     211
   name
----------
 Bras�lia

-- Clue #7: She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to
 -- the boarding gates. We have one chance to catch her, we just have to know where she's heading and beat her to the
 -- landing dock.
-- Lucky for us, she's getting cocky. She left us a note, and I'm sure she thinks she's very clever, but
-- if we can crack it, we can finally put her where she belongs – behind bars.

-- Our play date of late has been unusually fun –
-- As an agent, I'll say, you've been a joy to outrun.
-- And while the food here is great, and the people – so nice!
-- I need a little more sunshine with my slice of life.
-- So I'm off to add one to the population I find
-- In a city of ninety-one thousand and now, eighty five.


-- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet her at the gates with bells on.

world=# SELECT name, population FROM cities WHERE population = 91084;
     name     | population
--------------+------------
 Santa Monica |      91084

-- She's in ___________________SANTA MONICA_________!
