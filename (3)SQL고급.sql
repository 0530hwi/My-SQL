# CREATE TABLE AS SELECT city 테이블과 똑같은 city2 테이블 생성
CREATE TABLE city2 AS SELECT * FROM city;
SELECT * FROM city2;

# CREATE DATABASE, USE문으로 새 데이터베이스를 사용
CREATE DATABASE hwi;
USE hwi;

SELECT * FROM test;

CREATE TABLE test2(
	id INT NOT NULL PRIMARY KEY,
    col1 INT NULL,
    col2 FLOAT NULL,
    col3 VARCHAR(45) NULL
);

SELECT * FROM test2;

# ALTER TABLE 문과 함께 ADD 문을 사용하면, 테입르에 컬럼을 추가할 수 있음
ALTER TABLE test2
ADD col4 INT NULL;
SELECT * FROM test2;
DESC test2;

# --- 
ALTER TABLE test2
MODIFY col4 VARCHAR(45);
DESC test2;

#---
ALTER TABLE test2
DROP col4;
DESC test2;

# INDEX
CREATE INDEX Col1Idx
ON test (col1);

SHOW INDEX FROM test; # PRIMARY 키는 기본적인 인덱스라고 생각하면 된다

CREATE UNIQUE INDEX Col2Idx
ON test (col2);
SHOW INDEX FROM test;

# FULLTEXT INDEX는 일반적인 인덱스와는 달리 매우 빠르게 테이블의 모든 텍스트 컬럼을 검색
ALTER TABLE test
ADD FULLTEXT Col3Idx(col3);

SHOW INDEX FROM test;

# INDEX 삭제
ALTER TABLE test
DROP INDEX Col3Idx;
SHOW INDEX FROM test;

DROP INDEX Col2Idx ON test;
SHOW INDEX FROM test;

# VIEW

CREATE VIEW testView AS
SELECT Col1, Col2
FROM test;
SELECT * FROM testView;

# VIEW 수정
ALTER VIEW testView AS
SELECT Col1, Col2, Col3
FROM test;

SELECT * FROM testView;

# VIEW 삭제
DROP VIEW testView;

# city, country, countrylanguage 테이블을 JOIN 하고, 한국에 대한 정보만 뷰 생성하기
USE world;

CREATE VIEW allView AS
SELECT city.Name, country.SurfaceArea, city.Population, countrylanguage.Language
FROM city
JOIN country ON city.CountryCode = country.Code
JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
WHERE city.CountryCode = 'KOR';

SELECT * FROM allView;

# INSERT
# 테이블의 컬럼 수와 INSET 하는 수의 갯수가 같아야 함
USE hwi;
INSERT INTO test
VALUE(1, 123, 1.1, "Test");

SELECT * FROM test;

INSERT INTO test2 SELECT * FROM test;
SELECT * FROM test2;

# UPDATE
UPDATE test
SET col1 = 1, col2 = 1.0, col3 = 'test'
WHERE id = 1; # WHERE을 쓰지 않으면 모든 값이 다 바뀜 주의!

SELECT * FROM test;

# DELETE
DELETE FROM test
WHERE id = 1; # WHERE을 쓰지 않으면 전체 행이 다 날라가니 주의!

SELECT * FROM test;

# TRUNCATE
# 용량이 줄어 들고, 인덱스 등도 모두 삭제
# 테이블은 삭제 하지 않고, 데이터만 삭제
# 한꺼번에 다 지워야 함
# 삭제 후 되돌릴 수 없음 (DELETE랑 다름)
TRUNCATE TABLE test;
SELECT * FROM test;

DROP TABLE test;
SELECT * FROM test; # 실행 안 됨

DROP DATABASE hwi;
