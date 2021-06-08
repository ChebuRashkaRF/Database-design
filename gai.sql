DROP TABLE IF EXISTS accounting_cards CASCADE;
DROP TABLE IF EXISTS ts CASCADE;
DROP TABLE IF EXISTS tehos CASCADE;
DROP TABLE IF EXISTS color_codes CASCADE;
DROP TABLE IF EXISTS traffic_police CASCADE;
DROP TABLE IF EXISTS pts CASCADE;
DROP TABLE IF EXISTS owner_ts CASCADE;


---создание таблиц---
CREATE TABLE color_codes (
   color_code           CHAR(1)              NOT NULL,
   name_color_code      VARCHAR(15)          NOT NULL,
   PRIMARY KEY(color_code)
);

CREATE TABLE traffic_police (
   id_traffic_police    INT4                 NOT NULL,
   fio_police           VARCHAR(255)         NOT NULL,
   position             VARCHAR(30)          NOT NULL,
   PRIMARY KEY(id_traffic_police)
);

CREATE TABLE pts (
   series_pts           CHAR(4)              NOT NULL,
   number_pts           NUMERIC(6)           NOT NULL,
   data_pts             DATE                 NOT NULL,
   PRIMARY KEY(series_pts, number_pts)
);

CREATE TABLE owner_ts (
   id_code_owner        INT4                 NOT NULL,
   fio_owner            VARCHAR(255)         NOT NULL,
   data_owner           DATE                 NOT NULL,
   city                 VARCHAR(20)          NOT NULL,
   series_vy            NUMERIC(4)           NOT NULL,
   numder_vy            NUMERIC(6)           NOT NULL,
   valid_vy             DATE                 NOT NULL,
   PRIMARY KEY(id_code_owner)
);

CREATE TABLE tehos (
   series_to            CHAR(4)              NOT NULL,
   number_to            NUMERIC(6)           NOT NULL,
   id_traffic_police    INT4                 NOT NULL,
   data_to              DATE                 NOT NULL,
   PRIMARY KEY(series_to, number_to),
   FOREIGN KEY( id_traffic_police ) REFERENCES traffic_police ( id_traffic_police ) 
);

CREATE TABLE ts (
   state_sign           CHAR(9)              NOT NULL,
   vin                  CHAR(17)             NOT NULL UNIQUE,
   model                VARCHAR(100)         NOT NULL,
   data_ts              NUMERIC(4)           NOT NULL,
   color_code           CHAR(1)              NOT NULL,
   PRIMARY KEY(state_sign),
   FOREIGN KEY( color_code ) REFERENCES color_codes( color_code )
);

CREATE TABLE accounting_cards (
   id_cards             INT4                 NOT NULL,
   id_traffic_police    INT4                 NOT NULL,
   id_code_owner        INT4                 NOT NULL,
   series_pts           CHAR(4)              NOT NULL,
   number_pts           NUMERIC(6)           NOT NULL,
   series_to            CHAR(4)              NOT NULL,
   number_to            NUMERIC(6)           NOT NULL,
   state_sign           CHAR(9)              NOT NULL,
   data_card            DATE                 NOT NULL,
   PRIMARY KEY(id_cards),
   FOREIGN KEY( id_traffic_police ) REFERENCES traffic_police ( id_traffic_police ),
   FOREIGN KEY( id_code_owner ) REFERENCES owner_ts( id_code_owner ),
   FOREIGN KEY( series_pts, number_pts ) REFERENCES pts( series_pts, number_pts ),
   FOREIGN KEY( series_to, number_to ) REFERENCES tehos( series_to, number_to ),
   FOREIGN KEY( state_sign) REFERENCES ts( state_sign )
);


---добавление данных---
INSERT INTO color_codes VALUES ( 0, 'Белый' ),
			       ( 1, 'Желтый' ),
		               ( 2, 'Коричневый'),
		 	       ( 3, 'Красный'),
			       ( 4, 'Оранжевый'),
			       ( 5, 'Фиолетовый'),
 		 	       ( 6, 'Синий'),
 			       ( 7, 'Зеленый'),
 			       ( 8, 'Черный'),
 			       ( 9, 'Иные цвета');

INSERT INTO traffic_police VALUES ( 1, 'Лесовой А.С', 'инспектор' ),
			          ( 2, 'Иванов И.И.', 'старший инспектор'),
		                  ( 3, 'Красвнов А.С.', 'инспектор'),
		 	          ( 4, 'Моряков М.К.', 'старший инспектор'),
			          ( 5, 'Петров П.П.', 'инспектор');

INSERT INTO pts VALUES ( '15СВ', 123456, '2015-02-09' ), 
		       ( '58МП', 365748, '2018-01-23' ),
		       ( '39АФ', 235418, '2018-10-09' ),  
		       ( '42НА', 935842, '2015-08-25' ), 
		       ( '38ХП', 658221, '2017-03-21' ),
                       ( '54ЗБ', 384522, '2015-02-09' ),
                       ( '18ДК', 115896, '2016-11-07' ), 
                       ( '91ЛН', 842287, '2017-09-12' ), 
                       ( '46СР', 884746, '2017-07-15' ),
                       ( '88ВВ', 669852, '2014-02-20' ); 

INSERT INTO owner_ts VALUES ( 1, 'Королев Н.П.', '1973-02-18', 'Москва',  1992, 123456, '2022-01-09' ),
		            ( 2, 'Жуков А.В.', '1975-08-15', 'Санкт-Петербург', 2885, 205793, '2028-08-19' ),
		            ( 3, 'Быков И.М.', '1969-06-27', 'Грозный', 1736, 886521, '2024-07-05' ),
                            ( 4, 'Иванов П.О.', '1983-02-14', 'Смоленск', 3895, 200753, '2029-02-18' ),
		            ( 5, 'Жуков А.В.', '1975-08-15', 'Смоленск', 2050, 336895, '2026-03-03' ),
                            ( 6, 'Дорохов Ф.С.', '1982-06-24', 'Краснодар', 2168, 590078, '2022-08-15' ),
                            ( 7, 'Васильев В.В.', '1989-10-04', 'Краснодар', 8523, 654789, '2021-09-03' );

INSERT INTO tehos VALUES ( '23СВ', 100456, 1, '2015-02-11' ), 
		         ( '55РР', 204748, 3, '2018-01-25' ),
		         ( '86ФФ', 222418, 2, '2018-10-15' ), 
		         ( '47ЛК', 978842, 5, '2015-08-28' ), 
		         ( '11ДК', 658221, 1, '2017-03-22' ),
                         ( '72ЛБ', 384599, 3, '2015-02-12' ),
                         ( '10ЛЛ', 215836, 1, '2016-11-10' ), 
                         ( '99НА', 847987, 5, '2017-09-20' ), 
                         ( '72СР', 835746, 1, '2017-07-23' ),
                         ( '77ВП', 669952, 4, '2014-02-26' ); 

INSERT INTO ts VALUES ( 'Т627РХ77', 'XMCXNZ34A5F083831', 'MITSUBISHI COLT VI', 2010, 2 ),           
		      ( 'Н617КХ67', 'TMBBK21Z7D2085344', 'SKODA OCTAVIA II', 2015, 1 ),
		      ( 'К092ЕТ95', 'WDB2110041A918247', 'MERCEDES-BENZ E-CLASS', 2016, 0 ),    
		      ( 'С023ТР23', 'VF1BB130A28211347', 'RENAULT CLIO II', 2003, 6 ),
		      ( 'С514РС78', 'JF1BP9LLA6G056712', 'SUBARU OUTBACK', 2009, 8 ),                
                      ( 'В675МР23', 'KMHJN81VP8U848251', 'HYUNDAI TUCSON', 2016, 0 ),
                      ( 'М863МС77', 'VF36BTHY291037647', 'PEUGEOT 605', 2019, 3 ),                  
                      ( 'Е624КС67', 'VF7VV4HK8BU905248', 'CITROEN C-CROSSER', 2020, 8 ),
                      ( 'В853НТ77', 'W0L0AHL4855161762', 'OPEL ASTRA H',  2017, 7 ),                 
                      ( 'Т323ЕК78', 'VF34H5FXH55304437', 'PEUGEOT 308 SW', 2009,  8 );             

INSERT INTO accounting_cards VALUES ( 1, 2, 1, '15СВ', 123456, '23СВ', 100456, 'Т627РХ77', '2015-02-11' ),
		                    ( 2, 1, 1, '18ДК', 115896, '10ЛЛ', 215836, 'М863МС77', '2016-11-10' ),
		                    ( 3, 3, 1, '91ЛН', 842287, '99НА', 847987, 'В853НТ77', '2017-09-20' ),
		                    ( 4, 4, 2, '39АФ', 235418, '86ФФ', 222418, 'С514РС78', '2018-10-15' ),
		                    ( 5, 5, 2, '42НА', 935842, '47ЛК', 978842, 'Т323ЕК78', '2015-08-28' ),
                                    ( 6, 1, 3, '88ВВ', 669852, '77ВП', 669952, 'К092ЕТ95', '2014-02-26' ),
                                    ( 7, 2, 4, '58МП', 365748, '55РР', 204748, 'Н617КХ67', '2018-01-25' ),
                                    ( 8, 2, 5, '38ХП', 658221, '11ДК', 658221, 'Е624КС67', '2017-03-22' ),
                                    ( 9, 3, 6, '54ЗБ', 384522, '72ЛБ', 384599, 'С023ТР23', '2015-02-12' ),
                                    ( 10, 5, 7, '46СР', 884746, '72СР', 835746, 'В675МР23', '2017-07-23' );


---хранимые функции---

---функция, показывающая список автомобилей по фио владельца---
--DROP FUNCTION car_search(character);

CREATE OR REPLACE FUNCTION car_search( fio_owner_ CHAR(255) )
RETURNS TABLE(fio_owner CHAR(255), model CHAR(100), state_sign CHAR(9)) AS $$
SELECT o.fio_owner, t.model, t.state_sign FROM owner_ts o JOIN accounting_cards a ON o.id_code_owner = a.id_code_owner
JOIN ts t ON a.state_sign = t.state_sign WHERE o.fio_owner = fio_owner_;
$$ LANGUAGE sql;

SELECT * FROM car_search('Королев Н.П.');

---функция, показывающая автомобили, тех. осмотор которых был произведен заданным сотрудником---
CREATE OR REPLACE FUNCTION car_search_tehos( fio_police_ CHAR(255) )
RETURNS TABLE(fio_police CHAR(255), model CHAR(100), state_sign CHAR(9), data_to DATE) AS $$
SELECT p.fio_police, t.model, t.state_sign, th.data_to FROM traffic_police p JOIN tehos th ON p.id_traffic_police = th.id_traffic_police
JOIN accounting_cards a ON p.id_traffic_police = a.id_traffic_police JOIN ts t ON a.state_sign = t.state_sign WHERE p.fio_police = fio_police_ ;
$$ LANGUAGE sql;

SELECT * FROM car_search_tehos('Иванов И.И.');



---триггеры---
---Проверка, чтобы владелец автомобиля был старше 16 лет---
CREATE OR REPLACE FUNCTION add_owner_16()
RETURNS trigger AS
$$
BEGIN
IF NEW.data_owner + '16 years'::interval > current_timestamp  
THEN RAISE EXCEPTION 'Owner under 16. Cannot insert';
ELSE          
IF ( TG_OP = 'UPDATE' ) 
THEN RETURN NEW;
ELSIF ( TG_OP = 'INSERT' ) 
THEN RETURN NEW;     
END IF;     
RETURN NULL;   
END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER add_owner_16 BEFORE INSERT OR UPDATE ON owner_ts
FOR EACH ROW EXECUTE PROCEDURE add_owner_16();


---Проверка, год выпуска ТС не должен быть больше нынешнего года---
CREATE OR REPLACE FUNCTION validate_data_ts()
RETURNS trigger AS
$$
BEGIN
IF NEW.data_ts > to_char(current_date, 'yyyy')::NUMERIC 
THEN RAISE EXCEPTION 'Wrong year. Cannot insert';
ELSE          
IF ( TG_OP = 'UPDATE' ) 
THEN RETURN NEW;
ELSIF ( TG_OP = 'INSERT' ) 
THEN RETURN NEW;     
END IF;     
RETURN NULL;   
END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER validate_data_ts BEFORE INSERT OR UPDATE ON ts
FOR EACH ROW EXECUTE PROCEDURE validate_data_ts();



---запросы---

---1. перечислить список владельцев, у которых больше одного ТС стоит на учете--- 
SELECT nb.fio_owner, b.model, aa.state_sign, aa.data_card 
FROM ( SELECT o.fio_owner, a.id_code_owner, count( * ) 
FROM owner_ts o JOIN accounting_cards a ON o.id_code_owner = a.id_code_owner  
GROUP BY o.fio_owner, a.id_code_owner HAVING count( * ) > 1 ) AS nb 
JOIN accounting_cards aa ON  nb.id_code_owner = aa.id_code_owner 
JOIN ts b ON b.state_sign = aa.state_sign
ORDER BY nb.fio_owner;


--запрос с использованием табличного выражения---
--2. подсчитать количество каждого цвета ТС, который был поставлен на учет---
WITH color AS(
	SELECT c.name_color_code, t.model
	FROM color_codes c JOIN ts t ON c.color_code = t.color_code
)
SELECT clr.name_color_code, count(*) FROM color clr
GROUP BY clr.name_color_code;


--запрос с использованием оконной функции---
--3. подсчитать количество поставленных ТС на учет в каждом году---
SELECT o.fio_owner, t.model, extract( 'year' from a.data_card ) AS year, extract( 'month' from a.data_card ) AS month, extract( 'day' from a.data_card ) AS day, 
count( * ) OVER ( PARTITION BY date_trunc( 'year', a.data_card ) 
ORDER BY a.data_card ) AS count 
FROM accounting_cards a JOIN owner_ts o ON o.id_code_owner = a.id_code_owner JOIN ts t ON a.state_sign = t.state_sign 
ORDER BY a.data_card;


---составить список технического обслуживания, дата осмотра у которых больше 4-х лет---
SELECT p.fio_police, p.position, th.series_to, th.number_to, th.data_to 
FROM tehos th JOIN traffic_police p ON th.id_traffic_police = p.id_traffic_police 
WHERE th.data_to + '4 years'::interval < current_date
ORDER BY th.data_to;


---задание на защиту---
---написать запрос, который показывает число водительских удостоверений, срок действия которых заканчивается в каждом году---
SELECT extract( 'year' from valid_vy ) AS year, count( * ) 
FROM owner_ts GROUP BY year ORDER BY year;


