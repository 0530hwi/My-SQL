SHOW DATABASES; #보여줘 데이터베이스!
USE world; # world라는 데이터베이스를 사용하겠다!
SHOW TABLES; # table이 뭐가 있는지 보여줘!
SHOW TABLE STATUS; #table의 정보를 보여줘!

DESCRIBE city; # city라는 테이블에 어떤 것이 있는지 정보를 보여줘!
DESC city; # DESCRIBE 와 동일하다.

#country 테이블과 countrylanguage 테이블 정보 보기
DESCRIBE city;
DESC country;
DESC countrylanguage;

# SELECT
SELECT * FROM city;

# SELECT FROM WHERE
SELECT Name, Population
FROM city
WHERE Population < 8000000
AND Population > 7000000;

# 한국에 있는 도시
SELECT Name
FROM city
WHERE CountryCode = 'KOR';

# 미국에 있는 도시
SELECT Name
FROM city
WHERE CountryCode = 'USA';

# 한국에 있는 도시 중 인구 수가 1,000,000 이상인 도시
SELECT Name, Population
FROM city
WHERE CountryCode = 'KOR' 
AND Population >= 1000000;

# BETWEEN
SELECT Name, Population
FROM city
WHERE Population BETWEEN 7000000 AND 8000000;

# IN
SELECT *
FROM city
WHERE Name IN('Seoul', 'New York', 'Tokyo');

# 한국, 미국, 일본의 도시들 보기
SELECT *
FROM city
WHERE CountryCode IN('KOR', 'USA', 'JPN');

# LIKE
SELECT *
FROM city
WHERE CountryCode LIKE 'KO_'; # KO를 포함한 모든 결과가 나온다. 대신 문자 하나

SELECT *
FROM city
WHERE CountryCode LIKE 'K%'; # K를 포함한 어떠한 문자라도 가지고 옴.

SELECT *
FROM city
WHERE Name LIKE 'Tel %';

# 서브 쿼리(쿼리문 안에 또 쿼리문)
SELECT *
FROM city
WHERE CountryCode = (SELECT CountryCode
						FROM city
                        WHERE Name = 'Seoul'); # 서울의 CountryCode가 뭔지 모를 때 가지고 옴.

# ANY
SELECT *
FROM city
WHERE Population > ANY (SELECT Population
						FROM city
						WHERE District = 'New York'); # 이 결과에서 한 가지만 만족해도 출력한다. (최소값)
                            
SELECT *
FROM city
WHERE Population > ALL (SELECT Population
						FROM city
						WHERE District = 'New York'); # 이 결과에서 여러 개의 결과를 모두 만족 시켜야 함. (최대값)
                            
# ORDER BY
SELECT *
FROM city
ORDER BY Population DESC; #내림차순

SELECT *
FROM city
ORDER BY Population ASC; #오름차순(default값이라 생략 가능)

SELECT *
FROM city
ORDER BY Population; # 위와 동일한 결과

SELECT *
FROM city
ORDER BY CountryCode ASC, Population DESC;

# 인구수로 내림차순하여 한국에 있는 도시 보기
SELECT *
FROM city
WHERE CountryCode = 'KOR'
ORDER BY Population DESC;

# 국가 면적 크기로 내림차순하여 나라 보기
SELECT *
FROM country
ORDER BY SurfaceArea DESC;

# DISTINCT 중복된 것은 1개씩만 보여주면서 출력
SELECT DISTINCT CountryCode
FROM city;

# LIMIT 출력 개수를 제한
# 상위의 N개만 출력하는 'LIMIT N'구문
# 서버의 처리량을 많이 사용해 서버의 전반적인 성능을 나쁘게 하는 악성 쿼리문 개선을 사용할 때 사용함
SELECT *
FROM city
ORDER BY Population DESC;

# 그룹으로 묶어주는 역할
# 집계 함수 Aggregate Function를 함께 사용
# AVG(), MIN(), MAX(), COUNT(), COUNT(DISTINCT), STDEV(), VARIANCE()
# 읽기 좋게 하기 위해 별칭Alias를 사용한다
SELECT CountryCode, MAX(Population) AS 'Population'
FROM city
GROUP BY CountryCode; #CountryCode 중 Population의 최댓값으로 그룹을 묶어 출력함

# 도시는 몇개인가?, 도시들의 평균 인구수는?
SELECT CountryCode, COUNT(CountryCode)
FROM city
GROUP BY CountryCode
ORDER BY COUNT(CountryCode);

SELECT CountryCode, AVG(Population) AS 'Average Population'
FROM city
GROUP BY CountryCode;

SELECT COUNT(*)
FROM city;

SELECT AVG(Population)
FROM city;

# HAVING
# WHERE과 비슷한 개념으로 조건 제한
# 집계 함수에 대해서 조건 제한하는 편리한 개념
# HAVING절은 반드시 GROUP BY절 다음에 나와야 한다
SELECT CountryCode, MAX(Population)
FROM city
GROUP BY CountryCode
HAVING MAX(Population) > 8000000;

# 총합 또는 중간합계가 필요할 경우 사용
# GROUP BY절과 함께 WITH ROLLUP문 사용
SELECT CountryCode, Name, SUM(Population)
FROM city
GROUP BY CountryCode, Name WITH ROLLUP;

# JOIN: 데이터베이스 내의 여러 테이블에서 가져온 레코드를 조합하여 하나의 테이블이나 결과 집합으로 표현
SELECT *
FROM city
JOIN Country ON city.CountryCode = country.Code
JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode # 3개의 테이블 조인
ORDER BY ID;

