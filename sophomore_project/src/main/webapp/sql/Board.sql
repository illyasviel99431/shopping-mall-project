DROP TABLE board_illya CASCADE CONSTRAINTS;

DROP SEQUENCE board_illya_seq;


CREATE TABLE board_illya (

    num NUMBER PRIMARY KEY,

    id VARCHAR2(20) NOT NULL,

    name VARCHAR2(30) NOT NULL,

    subject VARCHAR2(100) NOT NULL,

    content CLOB NOT NULL,

    hit NUMBER DEFAULT 0 NOT NULL,

    ip VARCHAR2(50),

    regist_day DATE DEFAULT SYSDATE NOT NULL,

    update_day DATE DEFAULT SYSDATE NOT NULL
);


CREATE SEQUENCE board_illya_seq

START WITH 1

INCREMENT BY 1

NOCACHE
NOCYCLE;


-- 테스트 게시글

INSERT INTO board_illya
(
    num,
    id,
    name,
    subject,
    content,
    hit,
    ip,
    regist_day,
    update_day
)
VALUES
(
    board_illya_seq.NEXTVAL,
    'admin',
    '관리자',
    'Q&A 게시판 이용 안내',
    '상품 문의와 배송 문의를 남겨주세요.',
    12,
    '127.0.0.1',
    SYSDATE,
    SYSDATE
);


INSERT INTO board_illya
(
    num,
    id,
    name,
    subject,
    content,
    hit,
    ip,
    regist_day,
    update_day
)
VALUES
(
    board_illya_seq.NEXTVAL,
    'illya',
    '이리야',
    '상품 배송은 얼마나 걸리나요?',
    '주문 후 배송 기간이 궁금합니다.',
    5,
    '127.0.0.1',
    SYSDATE,
    SYSDATE
);


INSERT INTO board_illya
(
    num,
    id,
    name,
    subject,
    content,
    hit,
    ip,
    regist_day,
    update_day
)
VALUES
(
    board_illya_seq.NEXTVAL,
    'admin',
    '관리자',
    '재입고 예정 상품 문의',
    '재입고 일정이 정해졌는지 궁금합니다.',
    8,
    '127.0.0.1',
    SYSDATE,
    SYSDATE
);

COMMIT;


SELECT *
FROM board_illya

ORDER BY num DESC;