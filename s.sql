CREATE TABLE T3_vote(
    v_jumin CHAR(13) NOT NULL PRIMARY KEY,
    v_name VARCHAR2(20),
    c_no CHAR(1),
    v_time VARCHAR2(13),
    v_area VARCHAR2(20),
    v_confirm CHAR(1)
);

SELECT v_name,
    '19' || SUBSTR(v_jumin, 1, 2) || '년 ' || SUBSTR(v_jumin, 3, 2) || '월 ' || SUBSTR(v_jumin, 5, 2) || '일' birth,
    '만 ' || (2024-(TO_NUMBER('19' || SUBSTR(v_jumin, 1, 2)))) || '세' age,
    DECODE(SUBSTR(v_jumin, 7, 1), '1', '남', '2', '여') gender,
    c_no,
    SUBSTR(v_time, 1, 2) || ':' || SUBSTR(v_time, 3, 2) v_time,
    DECODE(v_confirm, 'Y', '확인', 'N', '미확인') v_confirm
FROM T3_vote;

SELECT * FROM T3_vote;

INSERT INTO T3_vote VALUES('9901011000001', '김유권', '1', '0930', '제1투표장', 'Y');
INSERT INTO T3_vote VALUES('8901011000002', '이유권', '2', '0930', '제2투표장', 'Y');
INSERT INTO T3_vote VALUES('6901011000003', '박유권', '3', '1030', '제3투표장', 'Y');
INSERT INTO T3_vote VALUES('5901011000004', '안유권', '4', '1030', '제1투표장', 'Y');
INSERT INTO T3_vote VALUES('7901011000005', '금유권', '5', '1130', '제2투표장', 'Y');
INSERT INTO T3_vote VALUES('8901012000006', '귀유권', '1', '1230', '제3투표장', 'N');
INSERT INTO T3_vote VALUES('5901012000007', '가유권', '1', '1230', '제4투표장', 'N');
INSERT INTO T3_vote VALUES('4901012000008', '나유권', '3', '1330', '제1투표장', 'N');
INSERT INTO T3_vote VALUES('7901012000009', '다유권', '3', '1330', '제2투표장', 'Y');
INSERT INTO T3_vote VALUES('8901012000010', '라유권', '4', '1000', '제3투표장', 'Y');
INSERT INTO T3_vote VALUES('9901012000011', '마유권', '5', '1010', '제4투표장', 'Y');
INSERT INTO T3_vote VALUES('6901012000012', '바유권', '1', '0920', '제1투표장', 'Y');

create table T3_candidate(
    c_no char(1) not null primary key,
    c_name varchar2(20),
    p_code varchar2(2),
    c_school char(1),
    c_jumin char(13),
    c_city varchar2(20)
);

SELECT * FROM T3_candidate;

SELECT A.c_no, A.c_name, B.p_name,
    DECODE(A.c_school, '1', '고졸', '2', '학사', '3', '석사', '4', '박사') c_school,
    SUBSTR(A.c_jumin, 1, 6) || '-' || SUBSTR(A.c_jumin, 7, 7) c_jumin,
    A.c_city,
    B.p_tel1 || '-' || B.p_tel2 || '-' || B.p_tel3 tel
FROM T3_candidate A, T3_party B
WHERE A.p_code = B.p_code
ORDER BY A.p_code;

INSERT INTO T3_candidate VALUES('1', '김후보', 'P1', '1', '6603011999991', '수선화동');
INSERT INTO T3_candidate VALUES('2', '이후보', 'P2', '3', '5503011999992', '민들레동');
INSERT INTO T3_candidate VALUES('3', '박후보', 'P3', '2', '7703011999993', '나팔꽃동');
INSERT INTO T3_candidate VALUES('4', '조후보', 'P4', '2', '8803011999994', '진달래동');
INSERT INTO T3_candidate VALUES('5', '최후보', 'P5', '3', '9903011999995', '개나리동');

create table T3_party(
    p_code char(2) not null primary key,
    p_name varchar2(20),
    p_indate date,
    p_leader varchar2(20),
    p_tel1 char(3),
    p_tel2 char(4),
    p_tel3 char(4)
);

SELECT A.c_no,
    B.c_name,
    C.p_name,
    COUNT(A.c_no) total,
    RANK() OVER(ORDER BY COUNT(A.c_no) DESC) RANK
FROM T3_vote A, T3_candidate B, T3_party C
WHERE A.c_no = B.c_no AND B.p_code = C.p_code AND A.v_confirm = 'Y'
GROUP BY A.c_no, B.c_name, C.p_name
ORDER BY RANK;

SELECT * FROM T3_party;

INSERT INTO T3_party VALUES('P1', 'A정당', '2010-01-01', '위대표', '02', '1111', '0001');
INSERT INTO T3_party VALUES('P2', 'B정당', '2010-02-01', '명대표', '02', '1111', '0002');
INSERT INTO T3_party VALUES('P3', 'C정당', '2010-03-01', '기대표', '02', '1111', '0003');
INSERT INTO T3_party VALUES('P4', 'D정당', '2010-04-01', '옥대표', '02', '1111', '0004');
INSERT INTO T3_party VALUES('P5', 'E정당', '2010-05-01', '임대표', '02', '1111', '0005');


