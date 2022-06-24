

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

* 문자열 함수는 문자열을 조작한다. 활용도가 **아주 높으므로** 잘 알아두자!

##### `ASCII(아스키 코드), CHAR(숫자)`

* 문자의 아스키 코드값을 돌려주거나 숫자의 아스키 코드값에 해당하는 문자를 돌려준다.

  ```mysql
  SELECT ASCII('A'), CHAR(65);
  ```

##### `BIT_LENGTH(문자열), CHAR_LENGTH(문자열), LENGTH(문자열)`

* 할당된 Bit 크기 또는 문자 크기를 반환한다. `CHAR_LENGTH()`는 문자의 개수를 반환하며 `LENGTH()`는 할당된 Byte수를 반환한다.

```mysql
SELECT BIT_LENGTH('abc') -- 24
SELECT CHAR_LENGTH('abc') -- 3
SELECT LENGTH('abc'); -- 3

SELECT BIT_LENGTH('가나다'); -- 72
SELECT CHAR_LENGTH('가나다'); -- 3
SELECT LENGTH('가나다'); -- 9

-- MySQL은 기본으로 UTF-8 코드를 사용하기 때문에 영문은 3Byte, 한글은 3x3 = 9Byte를 할당한다.
```

##### `CONCAT(문자열1, 문자열2), CONCAT_WS(구분자, 문자열1, 문자열2)`

* 문자열을 이어준다.

  ```MYSQL
  SELECT CONCAT_WS('/', '2025', '01', '01'); -- 2025/01/01
  ```

##### `ELT(위치, 문자열1, 문자열2), FIELD(찾을 문자열, 문자열1, 문자열2), FIND_IN_SET(찾을 문자열, 문자열 리스트), INSTR(기준 문자열, 부분 문자열), LOCATE(부분 문자열, 기준 문자열)`

* `ELT()`는 위치 번째에 해당하는 문자열을 반환한다.
* `FIELD()`는 찾을 문자열의 위치를 찾아서 반환한다.
* `FIND_IN_SET()`은 찾을 문자열을 문자열 리스트에서 찾아서 위치를 반환한다.
* `INSTR()`는 기준 문자열에서 부분 문자열을 찾아서 그 시작 위치를 반환한다.
* `LOCATE()`는 `INSTR()`와 동일하지만 파라미터의 순서가 반대로 되어 있다.

```mysql
SELECT ELT(2, '하나', '둘', '셋'), # 둘 
FIELD('둘', '하나', '둘', '셋'), # 2
FIND_IN_SET('둘', '하나,둘,셋'), # 2
INSTR('하나둘셋', '둘'), # 3
LOCATE('둘', '하나둘셋'); # 3
```

##### `FORMAT(숫자, 소수점 자릿수)`

```mysql
-- 숫자를 소수점 아래 자릿수까지 표현한다. 또한 1000단위마다 콤마(,)를 표시해 준다.
SELECT FORMAT(123456.123456, 4); -- 123,456.1235
```

```mysql
-- 2진수, 16진수, 8진수
SELECT BIN(31), HEX(31), OCT(31);
-- 각각 2진수 11111, 16진수 IF, 8진수 37을 반환함
```

##### `INSERT(기준 문자열, 위치, 길이, 삽입할 문자열)`

````mysql
# 기준 문자열의 위치부터 길이만큼을 지우고 삽입할 문자열을 끼워 넣는다.
SELECT INSERT('abcdefghi', 3, 4, '@@@@'), INSERT('abcdefghi', 3, 2, '@@@@');
# ab@@@@ghi, ab@@@@efghi
````

##### `LEFT(문자열, 길이), RIGHT(문자열, 길이)`

```mysql
# 왼쪽 또는 오른쪽에서 문자열의 길이 만큼 반환한다.
SELECT LEFT('abcdefghi', 3), RIGHT('abcdefghi', 3);
# abc, ghi
```

##### `UPPER(문자열), LOWER(문자열)`

```MYSQL
# 소문자 > 대문자, 대문자 > 소문자
SELECT LOWER('abcdEFGH'), UPPER('abcdEFGH')
# abcdefgh, ABCDEFGH
# LOWER() = LCASE()
# UPPER() = UCASE()
```

##### `LPAD(문자열, 길이, 채울 문자열), PRAD(문자열, 길이, 채울 문자열)`

```mysql
# 문자열을 길이만큼 늘린 후에, 빈 곳을 채울 문자열로 채운다.
SELECT LPAD('이것이', 5, '##'), PRAD('이것이', 5, '##')
# ##이것이, 이것이##
```

##### `LTRIM(문자열), RTRIM(문자열)`

```mysql
# 문자열의 왼쪽/오른쪽 공백을 제거한다. 중간의 공백은 제거되지 않는다.
SELECT LTRIM('	이것이'), RTRIM('이것이 	');
# 둘다 공백이 제거된 '이것이' 반환
```

##### `TRIM(문자열), TRIM(방향 자를_문자열 FROM 문자열)`

```mysql
# TRIM(문자열)은 문자열의 앞뒤 공백을 모두 없앤다.
# TRIM(방향 자를_문자열 FROM 문자열)에서 방향은 LEADING(앞), BOTH(양쪽), TRAILING(뒤)가 나올 수 있다.
SELECT TRIM('		이것이		'), TRIM(BOTH 'ㅋ', FROM 'ㅋㅋㅋ재밌어요.ㅋㅋㅋ');
# '이것이', '재밌어요'
```

##### `REPEAT(문자열, 횟수)`

```mysql
SELECT REPEAT('이것이', 3);
# '이것이이것이이것이'
```

##### `REPLACE(문자열, 원래 문자열, 바꿀 문자열)`

```mysql
SELECT REPLACE('이것이 MySQL이다', '이것이', 'This is');
# This is MySQL이다
```

##### `REVERSE(문자열)`

```mysql
# 문자열을 거꾸로 만듦
SELECT REVERSE('MySQL');
# LQsyM
```

##### `SAPCE(길이)`

```mysql
# 길이 만큼의 공백을 반환한다.
SELECT CONCAT('이것이', SPACE(10), 'MySQL이다');
# 이것이          MySQL이다
```

##### `SUBSTRING(문자열, 시작위치, 길이) 또는 SUBSTRING(문자열 FROM 시작위치 FOR 길이)`

```mysql
# 시작 위치부터 길이만큼 문자를 반환한다. 길이가 생략되면 문자열의 끝까지 반환된다.

SELECT SUBSTRIN('대한민국만세', 3, 2);
# 민국
# 동일한 함수: SUBSTRING(), SUBSTR(), MID()
```

##### `SUBSTRIN_IDNEX(문자열, 구분자, 횟수)`

```mysql
# 문자열에서 구분자가 왼쪽부터 횟수 번째 나오면 그 이후의 오른쪽은 버린다.
# 횟수가 음수면 오른쪽부터 세고 왼쪽을 버린다.

SELECT SUBSTRING_INDEX('cafe.namver.com', '.', 2), SUBSTRING_INDEX('cafe.naver.com', '.', -2);
# cafe.naver, naver.com
```

#### 수학함수

| 함수명                                                       | 설명                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| `ABS(숫자)`                                                  | 절대값을 계산                                                |
| `ACOS, ASIN, ATAN, ATAN2, SIN, COS, TAN`                     | 삼각함수 계산                                                |
| `CELING(숫자), FLOOR(숫자), ROUND(숫자)`                     | 올림, 내림, 반올림                                           |
| `CONV(숫자, 원래 진수, 변활한 진수)`                         | 숫자를 원래 진수에서 변환할 진수로 계산                      |
| `DEGREES(숫자), RADIANS(숫자), PI()`                         | 라디안 > 각도, 각도 > 라디안, 파이                           |
| `EXP, LN, LOG, LOG(밑수, 숫자), LOG2, LOG10`                 | 지수, 로그 관련                                              |
| `MOD(숫자1, 숫자) 또는 숫자1 % 숫자2 또는 숫자 1 MOD 숫자 2` | 모두 숫자1을 숫자2로 나눈 나머지 값                          |
| `POW(숫자1, 숫자2), SQRT(숫자)`                              | 거듭제곱, 제곱근                                             |
| `RAND()`<br /><br />`SELECT RAND(), FLOOR(1 + (RAND() * (7-1)) );` | 0이상 1미만의 실수를 구함. <br />만약 m <= 임의의 정수 < n을 구하고 싶다면<br />`FLOOR (m + RAND() * (n-m))`을 사용하면 됨 |
| `SIGN`                                                       | 숫자가 양수, 0, 음수인지를 구함<br />결과는 1, 0, -1 셋 중에 하나를 반환 |
| `TRUNCATE(숫자, 정수)`                                       | 숫자를 소수점 기준으로 정수 위치까지 구하고 나머지는 버린다. |

#### 날짜 및 시간 함수

##### `ADDDATE(날짜 , 차이), SUBDATE(날짜, 차이)`

```mysql
# 날짜를 기준으로 차이를 더하거나 뺀 날짜를 구한다.

SELECT ADDDATE('2025-01-01', INTERVAL 31 DAY), ADDDATE('2025-01-01', INTERVAL 1 MONTH);
SELECT SUBDATE('2025-01-01', INTERVAL 31 DAY), SUBDATE('2025-01-01', INTERVAL 1 MONTH);
# 31일 전 후, 한달 전후 계산
```

##### `ADDTIME(날짜/시간, 시간), SUBDATE(날짜/시간, 시간)`

* 위 함수와 동일한 매커니즘이다.

##### `CURDATE(), CURTIME(), NOW(), SYSDATE()`

* `CURDATE()`: 현재 연-월-일
* `CURTIME()`: 현재 시:분:초
* `NOW(), SYSDATE()`: 현재 연-월-일 시:분:초

##### `YEAR, MONTH, DAY, HOUR, MINUTE, SCOND, MICOSECOND`

* 현재 연, 월, 일 및 시, 분, 초 , 밀리초를 구함

##### `DATE(), TIME()`

* DATETIME 형식에서 연-월-일 및 시:분:초만 추출한다.

  ```mysql
  SELECT DATE(NOW()), TIME(NOW());
  ```

#### 시스템 정보 함수

* `USER(), DATABASE()`:현재 사용자 및 현재 선택된 데이터베이스를 구한다.
* `FOUND_ROWS()`: 바로 앞 `SELECT`문에서 조회된 행의 개수를 구한다.
* `ROW_COUNT()`: 바로 앞의 `INSERT, UPDATE, DELETE`문에서 입력, 수정, 삭제된 행의 개수를 구한다.
  `CREATE, DROP`문은 0을 반환하고, `SELECT`문은 -1을 반환한다.

#### 실습 

```mysql
# 실습 2

-- Step 1.
CREATE DATABASE moviedb;
USE moviedb;

CREATE TABLE movietbl (
	movie_id		INT,
    movie_title		VARCHAR(30),
    movie_director	VARCHAR(20),
    movie_star		VARCHAR(20),
    movie_script	LONGTEXT,
    movie_film		LONGBLOB
) DEFAULT CHARSET = utf8mb4;

-- Step 2.
INSERT INTO movietbl VALUES(1, '쉰들러 러스트', '스필버그', '리암 니슨',
	LOAD_FILE('/Users/choibyeonghwi/Desktop/HwiSQL/movies/Schindler.txt'),
    LOAD_FILE('/Users/choibyeonghwi/Desktop/HwiSQL/movies/Schindler.mp4'));

SELECT * FROM movietbl;

-- Step 3.
/* 
영화 대본과 영화 동영상이 입력되지 않은 이유는 두 가지다.
먼저 최대 패킷 크기(=최대 파일 크기)가 설정된 시스템 변수인 max_allowed_packet 값을 조회해보자.
*/
SHOW variables LIKE 'max_allowed_packet';
/*
파일을 업로드/다운로드할 폴더 경로를 별도로 허용해 줘야만 한다.
시스템 변수인 secure_file_priv 값을 조회해보자. 이 경로도 수정해야 한다.
*/
SHOW variables LIKE 'secure_file_priv';
```

### 피벗의 구현

* 피벗(Pivot)은 한 열에 포함된 여러 값을 출력하고, 이를 여러 열로 변환하여 테이블 반환 식을 회전하고, 필요하면 집계까지 수행하는 것을 말한다.

#### 실습

```mysql
# 실습3. 간단한 피벗 테이블을 실습해보자.

-- Step 1. 샘플 데이터 생성
USE sqldb;
CREATE TABLE pivotTest (
	uName 	CHAR(3),
    season 	CHAR(2),
    amount	INT
);

-- Step 2. 데이터 입력
INSERT INTO pivotTest VALUES
	('김범수', '겨울', 10), ('윤종신', '여름', 15), ('김범수', '가을', 25), ('김범수', '봄', 3),
    ('김범수', '봄', 37), ('윤종신', '겨울', 40), ('김범수', '여름', 14), ('김범수', '겨울', 22),
    ('윤종신', '여름', 64);
SELECT * FROM pivotTest;

-- Step 3. 다양한 함수를 활용하자
SELECT uName,
	SUM(IF(season = '봄', amount, 0)) AS '봄',
    SUM(IF(season = '여름', amount, 0)) AS '여름',
    SUM(IF(season = '가을', amount, 0)) AS '가을',
    SUM(IF(season = '겨울', amount, 0)) AS '겨울',
    SUM(amount) AS '합계'
FROM pivotTest
GROUP BY uName;

SELECT * FROM pivotTest;

SELECT season,
	SUM(IF(uName = '김범수', amount, 0)) AS '김범수',
    SUM(IF(uName = '윤종신', amount, 0)) AS '윤종신',
    SUM(amount) AS '합계'
FROM pivotTest
GROUP BY season
ORDER BY season;
```

### 7.2 조인

* 조인(Join): 두 개 이상의 테이블을 서로 묶어서 하나의 결과 집합으로 만들어 내는 것을 말한다.

데이터 베이스의 테이블은 중복과 공간 낭비를 피하고 데이터의 무결성을 위해서 여러 개의 테이블로 분리하여 저장한다.
그 중에서 간단하지만 가장 많이 사용되는 보편적인 관계가 sqldb의 usertbl <> buytbl 관계인 '1대다' 관계이다.

만약, 구매 테이블의 아이디 열을 회원 테이블과 동일하게 **Primary Key**로 지정한다면 어떻게 될까.
Primary Key는 한 번만 들어갈 수 있으므로 같은 아이디를 가진 사람은 물건을 한번 구매한 이후에는, 두 번 다시 쇼핑몰에서 물건을 살 수가 없다.
한 명의 회원이 당연히 여러 건의 구매를 할 수 있도록 설정되어야 한다.

이러한 설정이 바로 1대다 관계의 설정인 것이다.

#### 7.2.1 INNER JOIN(내부 조인)

* 조인 중에서 가장 많이 사용되는 조인. 일반적으로 JOIN이라고 얘기하는 것이 INNER JOIN을 지칭하는 것.

```mysql
USE sqldb;

SELECT *
FROM buytbl INNER JOIN usertbl 
    ON buytbl.userID = usertbl.userID
WHERE buytbl.userID = 'JYP';

# WHERE을 쓰지 않을 경우
SELECT *
FROM buytbl INNER JOIN usertbl
	ON buytbl.userID = usertbl.userID
ORDER BY num;

SELECT buytbl.userID, name, prodName, addr, CONCAT(mobile1, mobile2) AS '연락처'
FROM buytbl INNER JOIN usertbl
	ON buytbl.userID = usertbl.userID
ORDER BY num;

# 각 테이블에 별칭 주기
SELECT B.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM buytbl B INNER JOIN usertbl U
	ON B.userID = U.userID
WHERE B.userID = 'JYP'
ORDER BY B.num;

SELECT B.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM buytbl B INNER JOIN usertbl U
	ON B.userID = U.userID
ORDER BY U.userID;

# DISTINCT
SELECT DISTINCT U.userID, U.name, U.addr
FROM usertbl U INNER JOIN buytbl B
	ON U.userID = B.userID
ORDER BY U.userID;

# EXISTS
SELECT U.userID, U.name, U.addr
FROM usertbl U
WHERE EXISTS (
	SELECT *
    FROM buytbl B
    WHERE U.userID = B.userID );
```

##### 실습

```mysql
# 실습 4. 세 개의 테이블을 조인하자

-- Step 1. 테이블 생성 및 데이터 입력
USE sqldb;
CREATE TABLE stdTbl (
	stdName		VARCHAR(10) NOT NULL PRIMARY KEY,
    addr		CHAR(4) NOT NULL
);
CREATE TABLE clubTbl (
	clubName	VARCHAR(10) NOT NULL PRIMARY KEY,
    roomNo		CHAR(4) NOT NULL
);
CREATE TABLE stdclubTbl (
	num			int AUTO_INCREMENT NOT NULL PRIMARY KEY,
    stdName		VARCHAR(10) NOT NULL,
    clubName	VARCHAR(10) NOT NULL,
    FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
    FOREIGN KEY(clubName) REFERENCES clubtbl(clubName)
);
INSERT INTO stdtbl VALUES ('김범수', '경남'), ('성시경', '서울'), ('조용필', '경기'), ('은지원', '경북'), ('바비킴', '서울');
INSERT INTO clubtbl VALUES ('수영', '101호'), ('바둑', '102호'), ('축구', '103호'), ('봉사', '104호');
INSERT INTO stdclubtbl VALUES(NULL, '김범수', '바둑'), (NULL, '김범수', '축구'), (NULL, '조용필', '축구'),
							 (NULL, '은지원', '축구'), (NULL, '은지원', '봉사'), (NULL, '바비킴', '봉사');
                             
-- Step 2.
SELECT S.stdName, S.addr, C.clubName, C.roomNo
FROM stdtbl S 
		INNER JOIN stdclubtbl SC
			ON S.stdName = SC.stdName
		INNER JOIN clubtbl C
			ON SC.clubName = C.clubName
ORDER BY S.stdName;

-- Step 3. 동아리 기준으로 가입한 학생 목록 출력하기
SELECT C.clubName, C.roomNo, S.stdName, S.addr
FROM stdtbl S
	INNER JOIN stdclubtbl SC
		ON SC.stdName = S.stdName
	INNER JOIN clubtbl C
		ON SC.clubName = C.clubName
ORDER BY C.clubName;
```

#### 7.2.2 OUTER JOIN(외부 조인)

* `OUTER JOIN`은 조인의 조건에 만족되지 않는 행까지도 포함시키는 것이다.

```mysql
USE sqldb;
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM usertbl U
	LEFT OUTER JOIN buytbl B
		ON U.userID = B.userID
ORDER BY U.userID;
-- LEFT 기준에 있는 것은 모두 출력되어야 함

USE sqldb;
SELECT U.userID, U.name, B.prodName, U.addr, CONCAT(U.mobile1, U.mobile2) AS '연락처'
FROM usertbl U
	RIGHT OUTER JOIN buytbl B
		ON U.userID = B.userID
ORDER BY U.userID;
```

