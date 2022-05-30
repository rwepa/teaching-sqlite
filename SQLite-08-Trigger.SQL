--file     : SQLite-08-Trigger.SQL
--author   : Ming-Chang Lee
--date     : 2022.05.30
--email    : alan9956@gmail.com
--RWEPA    : http://rwepa.blogspot.tw/
--GitHub   : https://github.com/rwepa
--Encoding : UTF-8

-- 參考: https://www.sqlitetutorial.net/sqlite-trigger/ 

-- 建立資料表
CREATE TABLE leads (
	id integer PRIMARY KEY,
	first_name text NOT NULL,
	last_name text NOT NULL,
	phone text NOT NULL,
	email text NOT NULL,
	source text NOT NULL
);

CREATE TRIGGER validate_email_before_insert_leads 
   BEFORE INSERT ON leads
BEGIN
   SELECT
      CASE
			WHEN NEW.email NOT LIKE '%_@__%.__%' THEN
   	  		RAISE (ABORT, '無效的電子郵件')
       	END;
END;

-- 測試-ERROR
INSERT INTO leads
VALUES(1,'ALAN','LEE','12345678','alan9956','RWEPA');

-- 測試-OK
INSERT INTO leads
VALUES(1,'ALAN','LEE','12345678','alan9956@gmail.com','RWEPA');

SELECT * FROM leads

-- 觸發-刪除
DROP TRIGGER validate_email_before_insert_leads;
-- end
