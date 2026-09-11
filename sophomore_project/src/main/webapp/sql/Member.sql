-- ============================================
-- 회원 테이블 삭제
-- ============================================

DROP TABLE member_illya CASCADE CONSTRAINTS;


-- ============================================
-- 회원 테이블 생성
-- ============================================

CREATE TABLE member_illya (
    id          VARCHAR2(20) NOT NULL,
    password    VARCHAR2(20) NOT NULL,
    name        VARCHAR2(30) NOT NULL,
    gender      VARCHAR2(10),
    birth       VARCHAR2(20),
    mail        VARCHAR2(30),
    phone       VARCHAR2(30),
    address     VARCHAR2(100),
    regist_day  VARCHAR2(30),
    mem_num     NUMBER PRIMARY KEY,
    logtime     DATE,
    updatetime  DATE,
    role        VARCHAR2(20) DEFAULT 'USER' NOT NULL,

    CONSTRAINT uk_member_id
        UNIQUE (id),

    CONSTRAINT uk_member_mail
        UNIQUE (mail),

    CONSTRAINT uk_member_phone
        UNIQUE (phone)
);


-- ============================================
-- 회원 번호 시퀀스
-- ============================================

DROP SEQUENCE member_seq;

CREATE SEQUENCE member_seq
START WITH 1
INCREMENT BY 1
NOCACHE;


-- ============================================
-- 관리자 계정
-- 아이디: admin
-- 비밀번호: 1234
-- ============================================

INSERT INTO member_illya
(
    id,
    password,
    name,
    gender,
    birth,
    mail,
    phone,
    address,
    regist_day,
    mem_num,
    logtime,
    updatetime,
    role
)
VALUES
(
    'admin',
    '1234',
    '관리자',
    NULL,
    NULL,
    'admin@illya.com',
    NULL,
    NULL,
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
    member_seq.NEXTVAL,
    SYSDATE,
    SYSDATE,
    'ADMIN'
);


-- ============================================
-- 테스트 일반 회원
-- 아이디: illya
-- 비밀번호: 1234
-- ============================================

INSERT INTO member_illya
(
    id,
    password,
    name,
    gender,
    birth,
    mail,
    phone,
    address,
    regist_day,
    mem_num,
    logtime,
    updatetime,
    role
)
VALUES
(
    'illya',
    '1234',
    '이리야',
    '여',
    '2005-10-27',
    'illya@illya.com',
    '010-1234-5678',
    '서울',
    TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'),
    member_seq.NEXTVAL,
    SYSDATE,
    SYSDATE,
    'USER'
);



COMMIT;



SELECT * FROM member_illya;