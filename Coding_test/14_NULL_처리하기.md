# 14. NULL 처리하기
![제목 없음](https://user-images.githubusercontent.com/86516594/170821029-0be7c59a-1267-41ae-a413-9bfad1ad0018.png)

```mysql
SELECT ANIMAL_TYPE, CASE WHEN NAME IS NULL THEN 'No name' ELSE NAME END AS 'NAME', SEX_UPON_INTAKE
FROM ANIMAL_INS 
ORDER BY ANIMAL_ID
```

1. 이 문제는 `CASE WHEN`을 통하여 간단하게 풀 수 있다.
2. 만약 NAME 컬럼에 NULL값이 존재한다면 'No name'을 할당하고 그게 아니라면 본연의 값을 할당해준다.
