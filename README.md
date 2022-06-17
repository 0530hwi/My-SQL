# 데이터 분석가를 꿈꾸며
---
* 책 정보: 이것이 MySQL이다
<img width="334" alt="스크린샷 2022-05-23 오후 11 09 09" src="https://user-images.githubusercontent.com/86516594/169838439-8d0b292a-e085-4001-85a9-70bd3cc31ebc.png">

* 강의 정보: 이수안컴퓨터연구소 MySQL 한번에 끝내기 - [링크](https://www.youtube.com/watch?v=vgIc4ctNFbc&list=PL7ZVZgsnLwEGjReAO-qJtQiJB6e2MJ0ud)
* 올해의 목표: SQL 국가 공인 자격증 취득


# SQL문 표준 작성 가이드라인
* table, 칼럼변수는 소문자로 작성하고 그 이외의 내역은 대문자로 통일하여 작성한다.
* SQL 구문은 왼쪽으로 정렬한다.
* SQL 구문에 공백 라인이 없도록 작성한다.
* 컬럼과 컬럼사이, 테이블과 테이블 사이에는 하나의 개행(New Line)을 두어 구분한다.
* 가로 최대 길이가 80컬럼 이하가 되도록 작성하여 튜닝 혹은 유지보수시 사용이 용이하도록 한다.
* WHERE 절에는 가급적 긍정적인 조건을 사용한다.
* 불필요한 NVL()함수는 사용하지 않는다.
* 결과값과는 상관없이, OUTER JOIN을 사용하지 않는다.
* SQL 튜닝 편의를 위해서 모든 SQL구문 앞에는 주석(Remark) 를 추가해준다.
