

# CHAPTER 07. SQL 고급

## 7.1 MySQL의 데이터 형식

### 7.1.1 MySQL에서 지원하는 데이터 형식의 종류

* MySQL에서 데이터 형식의 종류는 30개 가까이 된다.
* 자주 사용되는 것은 이름 앞에 별표(⭐️)를 해놓자.

#### 숫자 데이터 형식

|            l데이터 형식             | 바이트 수 |      숫자 범위       |                             설명                             |
| :---------------------------------: | :-------: | :------------------: | :----------------------------------------------------------: |
|               BIT(N)                |    N/8    |                      |            1~64bit를 표현. b'0000' 형식으로 표현             |
|               TINYINT               |     1     |       -128~127       |                             정수                             |
|              ⭐️SMALLINT              |     2     |    -32,768~32,767    |                             정수                             |
|              MEDIUMINT              |     3     | -8,388,608~8,388,607 |                             정수                             |
|          ⭐️INT<br />INTEGER          |     4     |    약 -21억~+21억    |                             정수                             |
|               ⭐️BIGINT               |     8     |   약 -900경~+900경   |                             정수                             |
|               ⭐️FLOAT                |     4     | -3.40E+38~-1.17E-38  |                  소수점 아래 7자리까지 표현                  |
|          DOUBLE<br />REAL           |     8     | -1.22E-308~1.79E+308 |                  소수점 아래15자리까지 표현                  |
| ⭐️DECIMAL(m,[d])<br />NUMERIC(m,[d]) |   5~17    | -10^38+1 ~ +10^38-1  | 전체 자릿수(m)와 소수점 이하 자릿수(d)를 가진 숫자형<br />예)decimal(5,2) 전체 자릿수를 5자리로 하되, 그 중 소수점 이하를 2자리로 하겠다. |

* `DECIMAL`데이터 형식은 정확한 수치를 저장하게 되고 `FLOAT, DOUBLE`은 근사치의 숫자를 저장한다.
  대신 `FLOAT, DOUBLE`은 상당히 큰 숫자를 저장할 수 있다는 장점이 있음.
* 소수점이 들어간 실수를 저장하려면 되도록 `DECIMAL`을 사용하는 것이 바람직하다.
  예) -999999.99부터 +999999.99까지의 숫자를 저장할 경우에는 `DECIMAL(9,2)`로 설정한다.
* 부호없는 정수를 지정할 때는 `UNSIGNED`예약어를 뒤에 붙여준다.

#### 문자 데이터 형식

|  데이터 형식  | 바이트 수  |                             설명                             |
| :-----------: | :--------: | :----------------------------------------------------------: |
|   ⭐️CHAR(n)    |   1~255    | 고정길이 문자형.<br />n을 1부터 255까지 지정한다.<br />그냥 CHAR만 쓰면 CHAR(1)과 동일하다. |
|  ⭐️VARCHAR(n)  |  1~65535   | 가변길이 문자형.<br />n을 사용하면 1부터 65535까지 지정한다.<br />Variable character의 약자이다. |
|   BINARY(n)   |   1~255    |                  고정길이의 이진 데이터 값                   |
| VARBINARY(n)  |   1~255    |                  가변길이의 이진 데이터 값                   |
|   TINYTEXT    |   1~255    |                      255 크기의 TEXT 값                      |
|     TEXT      |  1~65535   |                       N크기의 TEXT 값                        |
|  MEDIUMTEXT   | 1~16777215 |                   16777215 크기의 TEXT 값                    |
|   ⭐️LONGTEXT   |   1~4GB    |                      최대 4GB의 TEXT 값                      |
|   TINYBLOB    |   1~255    |                   255크기의 BLOB 데이터 값                   |
|     BLOB      |  1~65535   |                   N 크기의 BLOB 데이터 값                    |
|  MEDIUMBLOB   | 1~16777215 |                1677215 크기의 BLOB 데이터 값                 |
|   ⭐️LONGBLOB   |   1~4GB    |                최대 4GB 크기의 BLOB 데이터 값                |
| ENUM(값들...) |   1또는2   |               최대 65535개의 열거형 데이터 값                |
| SET(값들...)  | 1,2,3,4,8  |               최대 64개의 서로 다른 데이터 값                |

* `CHAR`형식은 고정길이 문자형으로 자릿수가 고정되어 있다. 
  예를 들어, `CHAR(100)`에 'ABC' 3글자만 저장해도 100자리를 모두 확보한 후에 앞에 3자리를 사용하고, 뒤 97자리는 낭비한다.
* `VARCHAR`형식은 가변길이 문자형으로 `VARCHAR(100)`에 'ABC' 3글자를 저장할 경우에 3자리만 사용하게 된다.
  공간을 효율적으로 사용할 수 있다.
* 하지만 `CHAR`형식으로 설정하는 것이 `INSERT/UPDATE`시에 일반적으로 더 좋은 성능을 발휘한다.
* `BINARY`와 `VARBINARY`는 바이트 단위의 이진 데이터 값을 지정하는 데 사용된다.
* `TEXT`형식은 대용량의 글자를 저장하기 위한 형식으로 필요한 크기에 따라 `TINYTEXT, TEXT, MEDIUMTEXT, LONGTEXT`등의 형식을 사용할 수 있다.
* `BLOB(Binary Large Object)`은 사진 파일, 동영상 파일, 문서 파일 등의 대용량 이진 데이터를 저장하는 데 사용될 수 있다.
* `ENUM`은 열거형 데이터를 사용할 때 사용될 수 있다.(월, 화, 수, 목, 금, 토, 일)을 `ENUM`형식으로 설정할 수 있다.
* `SET`은 최대 64개를 준비한 후에 입력은 그 중에서 2개씩 세트로 데이터를 저장시키는 방식을 사용한다. 

#### 날짜와 시간 데이터 형식

| 데이터 형식 | 바이트 수 | 설명                                                         |
| :---------: | :-------: | ------------------------------------------------------------ |
|    ⭐DATE    |     3     | 날짜는 1001-01-01 ~ 9999~12~31까지 저장되며 날짜 형식만 사용<br />'YYYY-MM-DD' 형식으로 사용 |
|    TIME     |     3     | 'HH:MM:SS' 형식으로 사용                                     |
|  ⭐DATETIME  |     8     | 'YYYY-MM-DD HH:MM:SS' 형식으로 사용                          |
|  TIMESTAMP  |     4     | 'YYYY-MM-DD HH:MM:SS' 형식으로 사용. <br />time_zone 시스템 변수와 관련이 있으며 UTC 시간대 변환하여 저장 |
|    YEAR     |     1     | 1901 ~ 2155까지 저장. 'YYYY' 형식으로 사용                   |

```mysql
SELECT CAST('2022-06-18 20:13:29.123' AS DATE) AS 'DATE'; -- 2022-06-28
SELECT CAST('2022-06-18 20:13:29.123' AS TIME) AS 'TIME'; -- 20:13:29
SELECT CAST('2022-06-18 20:13:29.123' AS DATETIME) AS 'DATETIME'; -- 2022-06-18 20:13:29
```

#### 기타 데이터 형식

| 데이터 형식 | 바이트 수 |                             설명                             |
| :---------: | :-------: | :----------------------------------------------------------: |
|  ⭐GEOMETRY  |    N/A    | 공간데이터 형식으로 선, 점 및 다각형 같은 공간 데이터 개체를 저장하고 조작 |
|    ⭐JSON    |     8     |         JSON(JavaScript Object Notation) 문서를 저장         |

#### `LONGTEXT, LONGBLOB`

MySQL은 LOB(Large Object: 대량의 데이터)을 저장하기 위해서 위의 형식을 지원한다.

예로 장편소설과 같은 큰 덱스트 파일이라면, 그 내용을 전부 `LONGTEXT`형식으로 지정된 하나의 컬럼에 넣을 수 있고,

동영상 파일과 같은 큰 바이너리 파일이라면 그 내용을 전부 `LONGBLOB` 형식으로 지정된 하나의 컬럼에 넣을 수 있다.

<영화테이블>

| 영화id | 영화 제목    | 감독     | 주연배우    | 영화 대본(`LONGTEXT`) | 영화 동영상(`LONGBLOB`) |
| ------ | ------------ | -------- | ----------- | --------------------- | ----------------------- |
| 0001   | 쉰들러러스트 | 스필버그 | 리암 니슨   | ####                  | ####                    |
| 0002   | 철수와 영희  | 김덕순   | 철수와 영희 | ####                  | ####                    |
| 0003   | 사과         | 애플     | 스티븐 잡스 | ####                  | ####                    |

### 7.1.2 변수의 사용

```mysql
SET @변수이름 = 변수의 값;		-- 변수의 선언 및 값 대입
SELECT @변수이름;						-- 변수의 값 출력
```

```mysql
-- 실습1. 변수의 사용 실습
USE sqldb;

SET @myVar1 = 5;
SET @myVar2 = 3;
SET @myVar3 = 4.25;
SET @myVar4 = '가수 이름--> ';

SELECT @myVar1;								-- 5
SELECT @myVar2 + @myVar3;			-- 7.250000000000000000

SELECT @myVar4, Name
FROM usertbl
WHERE height > 180; -- 가수이름--> 임재범

-- STEP2. LIMIT에는 원칙적으로 변수를 사용할 수 없으나 PREPARE와 EXECUTE문을 활용하면 된다.
SET @myVar1 = 3;
PREPARE myQuery
	FROM 'SELECT name, height FROM usertbl ORDER BY height LIMIT ?';
EXECUTE myQuery USING @myVAR1;
```

* `LIMIT`는 `LIMIT 3`과 같이 직접 숫자를 넣어야 한다. `LIMIT @변수`형식으로 사용하면 오류가 발생한다.
* `PREPARE 쿼리이름 FROM '쿼리문'`은 쿼리이름에 '쿼리문'을 준비만 해놓고 실행하지는 않는다.
* `EXECUTE`를 만나는 순간에 실행되며 '쿼리문'에서 ?으로 처리해놓은 부분에 대입이 된다.

### 7.1.3 데이터 형식과 형 변환

* 데이터 형식과 관련된 함수는 자주 사용되므로 잘 기억하자.

#### 데이터 형식 변환 함수

```mysql
형식:
CAST ( expresstion AS 데이터형식 [ (길이) ])
CONVERT ( expression, 데이터형식 [ (길이) ])
```

데이터 형식 중 사용 가능한 것들 `BINARY, CHAR, DATE, DATETIME, DECIMAL, JSON, SIGNED INTEGER, TIME, UNSIGNED INTERGER`등.

```mysql
USE sqldb;
SELECT AVG(amount) AS '평균 구매 개수' FROM buytbl; -- 2.9167

SELECT CAST(AVG(amount) AS SIGNED INTEGER) AS '평균 구매 개수'
FROM buytbl;
SELECT CONVERT(AVG(amount), SIGNED INTEGER) AS '평균 구매 개수' 
FROM buytbl;
-- 두 구문 모두 3을 출력함
```

```MYSQL
SELECT CAST('2020$12$12' AS DATE);
SELECT CAST('2020/12/12' AS DATE);
SELECT CAST('2020%12%12' AS DATE);
SELECT CAST('2020@12@12' AS DATE);
-- 모두 2020-12-12를 출력함
```

#### 임시적인 형 변환

* 명시적인 변환(Explicit conversion): `CAST(), CONVERT()`

* 임시적인 변환 예)
  ```mysql
  -- 임시적인 형 변환
  SELECT '100' + '200'; -- 문자와 문자를 더함(정수로 변환돼서 연산됨)
  SELECT CONCAT('100', '200'); -- 문자와 문자를 연결(문자로 처리)
  SELECT CONCAT(100, '200'); -- 정수와 문자를 연결(정수가 문자로 변환돼서 처리
  SELECT 1 > '2mega'; -- 정수인 2로 변한되어서 비교
  SELECT 3 > '2MEGA'; -- 정수인 2로 변환되어서 비교
  SELECT 0 = 'mega2'; -- 문자는 0으로 변한됨
  ```
  

### 7.1.4 MySQL 내장 함수

#### 제어 흐름 함수

* 제어 흐름 함수는 프로그램의 흐름을 제어한다

##### `IF`(수식, 참, 거짓)

* 수식이 참 또는 거짓인지 결과에 따라 2중 분기한다.

  ```mysql
  SELECT IF (100 > 200, '참이다', '거짓이다'); -- 거짓이다 출력
  ```

##### `IFNULL`(수식1, 수식2)

* 수식1이 NULL이 아니면 수식1이 반환되고, 수식1이 NUL이면 수식2가 반환된다.

  ```mysql
  SELECT IFNULL(NULL, '널이군요'), IFNULL(100, '널이군요');
  ```

##### `NULLIF`(수식1, 수식2)

* 수식1과 수식2가 같으면 NULL을 반환하고, 다르면 수식1을 반환한다.

  ```MYSQL
  SELECT NULLIF(100, 100), NULLIF(200, 100);
  ```

##### `CASE ~ WHEN ~ ELSE ~ END`

* `CASE`는 내장 함수는 아니고 연산자(Operator)로 분류된다. 다중 분기에 사용될 수 있으므로 내장함수와 같이 알아두면 좋다.

  ```mysql
  SELECT CASE 10
  			WHEN 1 THEN '일'
        WHEN 5 THEN '오'
  			WHEN 10 THEN '십'
  			ELSE '모름'
  	END AS 'CASE연습';
  ```

  `CASE`뒤의 값이 10이므로 세 번째 WHEN이 수행되어 '십'이 반환된다.
  만약 해당하는 사항이 없다면 `ELSE`부분이 반환된다. 마지막 `END AS`뒤에는 출력될 열의 별칭을 써주면 된다.

#### 문자열 함수

