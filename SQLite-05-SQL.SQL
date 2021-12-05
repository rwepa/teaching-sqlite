--file     : Chapter 5-createtable.SQL
--title    : SQLite-05.結構化查詢語言(SQL)
--author   : Ming-Chang Lee
--date     : 2021.12.06
--email    : alan9956@gmail.com
--RWEPA    : http://rwepa.blogspot.tw/
--GitHub   : https://github.com/rwepa
--Encoding : UTF-8

-- 練習 - 建立選課3個資料表

-- 步驟1 學生表(學號, 姓名, 性別, 手機, 電子郵件)
CREATE TABLE 學生表
(
學號 CHR(10), 
姓名 CHR(20) NOT NULL, 
性別 CHR(1) NOT NULL, 
手機 CHAR(10), 
電子郵件 CHAR(50),
PRIMARY KEY(學號),
UNIQUE(手機)
)

-- 步驟2 課程表(課號, 學年度, 學期, 課名, 學分數, 必選修)
CREATE TABLE 課程表
(
課號   CHR(10),
學年度 INT NOT NULL,
學期   INT NOT NULL,
課名   CHR(20) NOT NULL,
學分數 INT DEFAULT 3,
必選修 CHAR(2),
PRIMARY KEY(課號)
)

-- 步驟3 選課表(選課表編號, 學號, 課號, 成績, 選課日期)
CREATE TABLE 選課表
(
選課表編號  INTEGER PRIMARY KEY AUTOINCREMENT,
學號       CHR(10),
課號       CHR(10),
成績       INT,
選課日期   DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY(學號) REFERENCES 學生表(學號),
FOREIGN KEY(課號) REFERENCES 課程表(課號)
)

-- 更改資料表名稱
ALTER TABLE 選課表
RENAME TO 選課表_NEW

-- 新增欄位
ALTER TABLE 學生表
ADD COLUMN 地址 CHAR(50)

-- 刪除資料表
DROP TABLE 學生表

-- 5-3 DML 語言

-- 5.3.1 INSERT 新增記錄

-- 新增1筆記錄
INSERT INTO 學生表
VALUES ('20211201', '育達1', '男', '0918123451', 'ydu20211201@ydu.edu.tw');

-- 輸入重複手機, ERROR! UNIQUE constraint
INSERT INTO 學生表
VALUES ('20211202', '育達2', '男', '0918123451', 'ydu20211202@ydu.edu.tw');

-- 輸入重複學號, ERROR! UNIQUE constraint
INSERT INTO 學生表
VALUES ('20211201', '育達2', '男', '0918123452', 'ydu20211202@ydu.edu.tw');

-- 新增9筆記錄, 全部10筆記錄
INSERT INTO 學生表
VALUES 
('20211202', '育達2',   '男', '0918123452',  'ydu20211202@ydu.edu.tw'),
('20211203', '育達3',   '男', '0918123453',  'ydu20211203@ydu.edu.tw'),
('20211204', '育達4',   '男', '0918123454',  'ydu20211204@ydu.edu.tw'),
('20211205', '育達5',   '女', '0918123455',  'ydu20211205@ydu.edu.tw'),
('20211206', '育達6',   '男', '0918123456',  'ydu20211206@ydu.edu.tw'),
('20211207', '育達7',   '男', '0918123457',  'ydu20211207@ydu.edu.tw'),
('20211208', '育達8',   '女', '0918123458',  'ydu20211208@ydu.edu.tw'),
('20211209', '育達9',   '女', NULL        ,  'ydu20211209@ydu.edu.tw'),
('202112010', '育達10', '男', '09181234510', 'ydu202112010@ydu.edu.tw');

-- 新增記錄, 使用 INSERT SELECT
INSERT INTO 學生表_new
SELECT * FROM 學生表;

-- 5.3.2 UPDATE 修改記錄

-- 修改記錄1, 使用 UPDATE WHERE
UPDATE 學生表
SET 手機 = '999'
WHERE 手機 IS NULL AND 學號 = '20211209';

-- 新增 課程表 5筆紀錄
INSERT INTO 課程表
VALUES
('A0001', 110, 1, '資料庫管理系統(管理)', 4, '必修'),
('A0002', 110, 1, '智慧家庭實務', 3, '必修'),
('A0003', 110, 1, '電子商務平台應用', 3, '必修'),
('A0004', 110, 1, '管理資訊系統', 4, '必修'),
('A0005', 110, 1, '專案管理', 2, '選修');

-- 修改記錄2, 使用 UPDATE WHERE
UPDATE 課程表
SET 學分數 = 3, 必選修 = '選修'
WHERE 課號 = 'A0001';

-- 5.3.3 DELETE 刪除記錄

-- 刪除記錄 DELETE
DELETE FROM 學生表_new
WHERE 姓名 = '育達1';

-- 5.3.4 SELECT 查詢記錄

-- 查詢記錄 SELECT
SELECT * FROM 學生表
WHERE 性別 = '女';

-- 查詢記錄 SELECT GROUP BY
SELECT COUNT(學號) AS 人數 FROM 學生表;
GROUP BY 性別
-- END
