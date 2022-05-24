# MySQL 내장함수
# 사용자의 편의를 위해 다양한 기능의 내장 함수를 미리 정의하여 제공한다
# 대표적인 내장 함수의 종류: 문자열 함수, 수학 함수, 날짜와 시간 함수

SELECT LENGTH('abcdefg'); # 문자열의 길이 제공
SELECT CONCAT('My', 'sql Op', 'en Source'); # 문자를 합쳐줌 
SELECT LOCATE('abc', 'avavavabcabab'); # abc의 위치를 반환, MySQL은 시작 인덱스가 1, 찾는 문자열이 없다면 0을 반환
SELECT LEFT('MySQL is an open source relational database manaement system', 5); # 왼쪽에서 5번째
SELECT RIGHT('MySQL is an open source relational database manaement system', 5); # 오른쪽에서 5번째
SELECT LOWER('MySQL is an open source relational database manaement system'); # 소문자로 전부 바꾸기
SELECT UPPER('MySQL is an open source relational database manaement system'); # 대문자로 전부 바꾸기
SELECT REPLACE('MSSQL', 'MS', 'My'); # MSSSQL에서 MS를 My로 바꾸기

# TRIM 문자열의 앞이나 뒤, 또는 양쪽 모두에 있는 특정 문자를 제거한다
# --- #
# TRIM() 함수에서 사용할 수 있는 지정자
# BOTH: 전달받은 문자열의 양 끝에 존재하는 특정 문자를 제거( 기본 설정 )
# LEADING: 전달받은 문자열 앞에 존재하는 특정 문자를 제거
# TRAILING: 전달받은 문자열 뒤에 존재하는 특정 문자를 제거
# 만약 지정자를 명시하지 않으면 자동으로 "BOTH"로 설정
# 제거할 문자를 명시하지 않으면 자동으로 공백을 제거

SELECT TRIM('            MySQL           '),
TRIM(LEADING '#' FROM '###MySQL###'),
TRIM(TRAILING '#' FROM '###MySQL###');

# FOERMAT() : 숫자 타입의 데이터를 세 자리마다 쉼표(,)를 사용하는 형식으로 반환
# 반환되는 데이터의 형식은 문자열 타입
# 두 번째 인수는 반올림할 소수 부분의 자릿수
SELECT FORMAT(1000000000, 3);

SELECT FLOOR(10.95), CEIL(10.95), ROUND(10.95); #순서대로 내림, 올림, 반올림

# SQRT(): 양의 제곱근, POW() 첫 번째 인수는 밑수, 두번째 인수는 지수, EXP(): e의 거듭제곱, LOG(): 자연로그
SELECT SQRT(4), POW(2, 3), EXP(3), LOG(3);

SELECT SIN(PI()/2), COS(PI()), TAN(PI()/4);
SELECT ABS(-3), RAND(), ROUND(RAND()*100, 0); #RAND(): 0.0보다 크고 1.0보다 작은 실수값 생성

SELECT NOW(), #현재 시간
CURDATE(), # 현재 날짜 YYYY-MM-DD, YYYYMMDD
CURTIME(); # HH:MM:SS, HHMMSS

SELECT
NOW(),
DATE(NOW()),
MONTH(NOW()),
DAY(NOW()),
HOUR(NOW()),
MINUTE(NOW()),
SECOND(NOW());

SELECT
NOW(),
MONTHNAME(NOW()),
DAYNAME(NOW());

SELECT
DAYOFWEEK(NOW()), # 일요일:1 토요일: 7
DAYOFMONTH(NOW()), # 0 ~ 31 값
DAYOFYEAR(NOW()); # 1 ~ 366 값

SELECT
DATE_FORMAT(NOW(), '%D %y %d %m %n %j'); # 더 자세한 정보는 https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html


