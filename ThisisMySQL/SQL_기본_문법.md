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



## 이외 옵션

* `SHOW TABLE STATUS;`: 현재의 데이터베이스에 있는 테이블의 정보를 조회한다.
* `DESCRIBE emplyoees;` , `DESC employees;`: employees 테이블의 열이 무엇이 있는지 조회한다.