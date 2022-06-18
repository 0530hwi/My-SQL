[TOC]





# SQL 기본 문법

```MYSQL
SELECT select_expr
	[FROM table_references]
	[WHERE where_condition]
	[GROUP BY {col_name | expr | position ]
	[HAVING where_condition]
	[ORDER BY {col_name | expr | position}]
--대괄호([])의 내용 생략가능
```

* 주석처리

```mysql
-- MySQL은 '--'이후부터 주석으로 처리된다. 주의할 점은 --뒤에 바로 붙여서 쓰지 않아야 하고, 공백이 하나 이상 있어야 한다.

-- 한 줄 주석 연습
SELECT first_name, last_name, gender -- 이름과 성별을 가져옴
FROM employees;

-- 여러줄 주석은 '/* */'로 묶는다.
/*
SELECT first_name, last_name, gender
FROM employees;
*/
```

```mysql
-- 책의 전 과정에서 사용할 데이터베이스와 테이블 생성
CREATE TABLE usertbl ( -- 회원 테이블
userID		CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
name		VARCHAR(10) NOT NULL, -- 이름
birthYear	INT NOT NULL, -- 출생년도
addr		CHAR(2) NOT NULL, -- 지역 경기, 서울, 경남 식으로 2글자만 입력
mobile1		CHAR(3), -- 휴대폰의 국번 010, 011 등
mobile2		CHAR(8), -- 휴대폰의 나머지 번호
height		SMALLINT, -- 키
mDate		DATE -- 회원 가입 일
);

CREATE TABLE buytbl (
num			INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
userID		CHAR(8) NOT NULL, -- 아이디(FK)
prodName	CHAR(6) NOT NULL, -- 물품명
groupName	CHAR(4), -- 분류
price		INT NOT NULL, -- 단가
amount		SMALLINT NOT NULL, -- 수량
FOREIGN KEY (userID) REFERENCES usertbl(userID)
);

-- 저작권 상 VALUE는 공개하지 않음.
```

### 데이터베이스 개체의 이름 규칙

* 데이터베이스(=스키마) 개체의 이름을 식별자(Identifier)라고 함.
  데이터베이스 개체란 데이터베이스, 테이블, 인덱스, 열 인덱스, 뷰, 트리거, 스토어드 프로시저 등과 같은 개체를 의미함.
* MySQL에서 이러한 개체를 정의할 때는 몇 가지 규칙을 따라야 함.
  - 알파벳 a~z, A~Z, 0~9, $, _를 사용할 수 있다. (기본 설정은 영문 소문자로 생성됨)
  - 개체 이름은 최대 64자로 제한된다.
  - 예약어를 사용하면 안 된다. `CREATE TABLE select(...)` 
  - 개체 이름은 원칙적으로 중간에 공백이 있으면 안되지만, 공백을 사용하려면 백틱 (\`\`\)으로 사용한다. `CREATE TABLE 'My Table'`은 가능
  - 개체에 이름을 줄 때는 되도록 알기 쉽게 주는 것이 좋다.
  - Linux에서는 데이터베이스 이름과 테이블 이름은 모두 소문자로 사용해야 함.

## 1. USE 구문

* `SELECT`문을 학습하려면 먼저 사용할 데이터 베이스를 지정해야 함.

  ```MYSQL
  USE 데이터베이스_이름;
  -- 만약 employees를 사용하기 위해서는 쿼리 창에서 다음과 같이 실행
  USE employees;
  ```

  이렇게 저장해 놓은 후에는 특별히 다시 `USE`문을 사용하거나 다른 DB를 사용하겠다고 명시하지 않는 이상 모든 SQL문은 employees에서 수행된다.

  

## 2. SELECT 구문

```mysql
USE employees;
SELECT * FROM employees; -- employees에서 모든 열을 가져옴
```

일반적으로 `*`은 '모든 것'을 의미한다.

### `AS`별칭

```mysql
-- 'AS'를 사용해도 되고, 생략해도 된다. 공백이 있다면
-- 권장사항으로는 ''안에 별칭을 사용하길 권장함.
SELECT first_name AS 이름, gender 성별, hire_date '회사 입사일'
FROM employees;
```



## 이외 옵션

* `SHOW TABLE STATUS;`: 현재의 데이터베이스에 있는 테이블의 정보를 조회한다.
* `DESCRIBE emplyoees;` , `DESC employees;`: employees 테이블의 열이 무엇이 있는지 조회한다.

## 2. WHERE 구문

* 기본적인 `WHERE`절

  ```MYSQL
  SELECT 필드이름 FROM 테이블이름 WHERE 조건식;
  
  SELECT * FROM usertbl WHERE name = '김경호'; -- name이 김경호인 것만 출력함
  ```

### 관계 연산자 사용

```mysql
SELECT userID, Name
FROM usertbl
WHERE birthYear >= 1970 AND height >= 182; -- and는 '그리고'이므로 두 조건을 만족해야 함
SELECT userID, Name
FROM usertbl
WHERE birthYear >= 1970 OR height >= 182; -- or는 '또는'이므로 한 조건만 만족해도 출력함
```

### BETWEEN, AND, IN(), LIKE

```mysql
SELECT name, height
FROM usertbl
WHERE height >= 180 AND height <= 183; -- 180이상 183이하

SELECT name, height
FROM usertbl
WHERE height BETWEEN 180 AND 183; -- 180 초과 183 미만, BETWEEN AND는 이산적인 값에 사용할 수 없음

SELECT name, height
FROM usertbl
WHERE addr = '경남' OR addr = '경북'; -- 경남 또는 경북

SELECT name, height
FROM usertbl
WHERE addr IN ('경남', '경북', '전남'); -- 경남 또는 경북 또는 전남

SELECT name, height
FROM usertbl
WHERE name LIKE '김%'; -- 성이 '김'씨이고 무엇이든 허용(%)
```

### ANY/ALL/SOME 그리고 서브쿼리(SubQuery, 하위쿼리)

```mysql
SELECT name, height
FROM usertbl
WHERE height > 177;

SELECT name, height
FROM usertbl
WHERE height > (SELECT height FROM usertbl WHERE name = '김경호');

/*
두 개의 쿼리는 동일한 값을 갖는다
SELECT height FROM usertbl WHERE name = '김경호'; 
는 177의 값을 갖는다 따라서 WHERE height > 177이 되는 것이다. 
*/
```

```mysql
SELECT name, height
FROM usertbl
WHERE height >= (SELECT height FROM usertbl WHERE addr = '경남');
-- ERROR Code 1242: Subquery returns more than 1 row
-- 즉, addr 중에 경남에 해당하는 height가 1개 보다 많아서 어느 조건을 만족시켜야 할지 모른다.

SELECT name, height
FROM usertbl
WHERE height >= ANY (SELECT height FROM usertbl WHERE addr = '경남');
-- ANY는 서브쿼리의 결과 중 어떠한 것이라도 만족하면 출력한다

SELECT name, height
FROM usertbl
WHERE height >= ALL (SELECT height FROM usertbl WHERE addr = '경남');
-- ALL은 서브쿼리의 결과 중 두가지 조건 모두 만족해야 한다.


-- 같은 결과 
SELECT name, height
FROM usertbl
WHERE height = ANY (SELECT height FROM usertbl WHERE addr = '경남');

SELECT name, height
FROM usertbl
WHERE height IN (SELECT height FROM usertbl WHERE addr = '경남');
```



## 3. 테이블을 복사하는 CREATE TABLE ... SELECT

```mysql
/* 형식
CREATE TABLE 새로운테이블 (SELECT 복사할열 FROM 기존테이블 */
```

```mysql
-- buytbl을 buytbl2로 복사하는 구문
USE sqldb;
CREATE TABLE buytbl2 (SELECT * FROM buytbl);
SELECT * FROM buytbl2;

-- 필요하다면 지정한 일부 열만 복사할 수도 있다.
CREATE TABLE buytbl3 (SELECT userID, prodName FROM buytbl);
SELECT * FROM buytbl;
```

> 그런데, `buytbl`은 Primary Key 및 Foreign Key가 지정되어 있다. Workbench의 [Nevigator]에서 확인해 보면 
>
> PK나 FK 등의 제약조건은 복사되지 않는 것을 알 수 있다.



## 4. GROUP BY 및 HAVING 그리고 집계 함수

```mysql
/* 
형식:
SELECT select_expr
	[FROM table_references]
	[WHERE where_condition]
	[GROUP BY {col_name | expr | position}]
	[HAVING where_condition]
	[ORDER BY {col_name | expr | postition}]
*/
```

말 그대로 그룹을 묶어주는 역할을 하는 `GROUP BY`

```mysql
SELECT userID, amount 
FROM buytbl
ORDER BY userID;

-- 결과를 보면 사용자별로 여러 번의 물건 구매가 이루어져, 각각의 행이 별도로 출력됨
-- 합계를 낼 때 이렇게 손이나 전자계산기를 두드려서 계산한다면 MySQL을 사용할 이유가 없음.

SELECT userID, SUM(amount)
FROM buytbl
GROUP BY userID;

-- 이렇게 그룹을 묶어서 출력할 경우 userID별로 SUM(amount) 즉, amount의 합산한 값을 출력한다.
```

```mysql
SELECT userID AS '사용자 아이디', SUM(amount) AS '총 구매 개수'
FROM buytbl
GROUP BY userID;

-- 별칭을 사용해서 컬럼 이름을 변경할 수도 있다.

SELECT userID AS '사용자 아이디', SUM(price*amount) AS '총 구매액'
FROM buytbl
GROUP BY userID;

-- 구매액의 총합을 출력하기
```

|      |
| ---- |
