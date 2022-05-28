# 14. NULL 처리하기
![제목 없음](https://user-images.githubusercontent.com/86516594/170821220-56c4ab76-cddf-4e5d-b3b3-75173e2cfa57.png)

```mysql
SELECT ANIMAL_TYPE, CASE WHEN NAME IS NULL THEN 'No name' ELSE NAME END AS 'NAME', SEX_UPON_INTAKE
FROM ANIMAL_INS 
ORDER BY ANIMAL_ID ASC;
```

1. 이 문제는 `CASE WHEN`을 통하여 간단하게 풀 수 있다.
2. 만약 NAME 컬럼에 NULL값이 존재한다면 'No name'을 할당하고 그게 아니라면 본연의 값을 할당해준다.

```mysql
SELECT ANIMAL_TYPE, IFNULL(NAME, 'No name') AS NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
ORDER BY ANIMAL_ID ASC;
```
1. `IFNULL`을 통하여도 문제를 풀 수가 있다.
2. SQL은 대화형 방식이라 말 그대로 만약 NAME 컬럼에 NULL 값이 있다면 'No name'을 할당하라라는 뜻이다.
3. 마찬가지로 아이디 순으로 조회해야 하므로 `ORDER BY`를 통해 정렬해준다.
