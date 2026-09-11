DROP TABLE product_illya CASCADE CONSTRAINTS;

CREATE TABLE product_illya (
    p_id           VARCHAR2(20) NOT NULL,
    p_name         VARCHAR2(100) NOT NULL,
    p_unitPrice    NUMBER NOT NULL,
    p_description  VARCHAR2(2000),
    p_category     VARCHAR2(50),
    p_manufacturer VARCHAR2(50),
    p_unitsInStock NUMBER DEFAULT 0 NOT NULL,
    p_condition    VARCHAR2(20),
    p_fileName     VARCHAR2(100),
    p_quantity     NUMBER DEFAULT 1,
    CONSTRAINT pk_product_illya PRIMARY KEY (p_id)
);

INSERT INTO product_illya
(p_id, p_name, p_unitPrice, p_description, p_category,
 p_manufacturer, p_unitsInStock, p_condition, p_fileName, p_quantity)
VALUES
(
    'P1234',
    '알파 A6700',
    5000000,
    '상품번호: 9081181844 / 제조사: 소니 / 브랜드: 소니 / 모델명: 알파 A6700 / 품목: 미러리스 / 용도별: 전문가용 / CMOS: APS-C(1:1.5크롭)',
    'computer device',
    'SONY',
    1000,
    'New',
    'P1234.png',
    1
);

INSERT INTO product_illya
(p_id, p_name, p_unitPrice, p_description, p_category,
 p_manufacturer, p_unitsInStock, p_condition, p_fileName, p_quantity)
VALUES
(
    'P1235',
    '노트북-16인치-Win11-16/512',
    858000,
    '상품번호: 11149376385 / 제조사: 베이직스 / 브랜드: 베이직스 / 모델명: 노트북-16인치-Win11-16/512 / 품번: BB1624FW-S / 출시년도: 2024년',
    'computer device',
    '베이직스',
    2000,
    'New',
    'P1235.png',
    1
);

INSERT INTO product_illya
(p_id, p_name, p_unitPrice, p_description, p_category,
 p_manufacturer, p_unitsInStock, p_condition, p_fileName, p_quantity)
VALUES
(
    'P1236',
    '넨도로이드 돌 세이버 사복 버전 l 페이트 스테이 나이트',
    97400,
    '상품번호: 13643688586 / 제조사: 굿스마일컴퍼니 / 브랜드: 굿스마일컴퍼니 / 모델명: 넨도로이드 돌 세이버 사복 버전 l 페이트 스테이 나이트 / 원산지: 중국산 / 시리즈: 넨도로이드 / 작품테마: FATE',
    'computer device',
    '굿스마일컴퍼니',
    3000,
    'New',
    'P1236.png',
    1
);



INSERT INTO product_illya
(p_id, p_name, p_unitPrice, p_description, p_category,
 p_manufacturer, p_unitsInStock, p_condition, p_fileName, p_quantity)
VALUES
(
    'P1237',
    '리아나 메이드 Ver. 1/6 스케일 피규어',
    253000,
    '인기 일러스트레이터 Riichu의 오리지널 캐릭터 리아나 메이드 Ver. 피규어 / 스케일: 1/6 / 크기: 약 285mm / 재질: ATBC-PVC, ABS / 구성: 피규어 본체, 베이스 / JAN CODE: 4589642716075 / 발매: 2026년 9월 예정',
    'figure',
    'Union Creative',
    100,
    'New',
    'P1237.png',
    1
);


INSERT INTO product_illya
(p_id, p_name, p_unitPrice, p_description, p_category,
 p_manufacturer, p_unitsInStock, p_condition, p_fileName, p_quantity)
VALUES
(
    'P1238',
    '하츠네 미쿠 Luminasta Conceptual series Vol.1 남국 Ver.',
    29000,
    'SEGA Prize 하츠네 미쿠 Luminasta Conceptual series Vol.1 남국 Ver. / 캐릭터: 하츠네 미쿠 / 시리즈: Luminasta / 크기: 약 7 x 21cm / 2026년 8월 출시 / Art by 히센 카에데',
    'figure',
    'SEGA',
    100,
    'New',
    'P1238.png',
    1
);



INSERT INTO product_illya
(p_id, p_name, p_unitPrice, p_description, p_category,
 p_manufacturer, p_unitsInStock, p_condition, p_fileName, p_quantity)
VALUES
(
    'P1239',
    '붕괴 스타레일 반디 1/7 스케일 피규어',
    220600,
    '붕괴: 스타레일 반디 1/7 스케일 피규어 / 제조사: 굿스마일컴퍼니 / JAN CODE: 4580828666870 / 재질: 플라스틱 / 크기: 약 265mm(베이스 포함) / 구성: 피규어 본체, 베이스 / 발매: 2026년 12월 예정',
    'figure',
    '굿스마일컴퍼니',
    100,
    'New',
    'P1239.png',
    1
);






INSERT INTO product_illya
(p_id, p_name, p_unitPrice, p_description, p_category,
 p_manufacturer, p_unitsInStock, p_condition, p_fileName, p_quantity)
VALUES
(
    'P1240',
    '원피스 롤로노아 조로 삼도류 삼천세계 피규어',
    7050,
    '원피스 롤로노아 조로 삼도류 삼천세계 피규어 / 약 26cm / 애니메이션 원피스 캐릭터 굿즈 / 해외 판매 상품 / 11번가 가격비교 기준 최저가 상품',
    'figure',
    'OEM',
    100,
    'New',
    'P1241.png',
    1
);


INSERT INTO product_illya
(p_id, p_name, p_unitPrice, p_description, p_category,
 p_manufacturer, p_unitsInStock, p_condition, p_fileName, p_quantity)
VALUES
(
    'P1241',
    '짱구&맹구 대형 우비 피규어 45.5cm',
    55900,
    '짱구는 못말려 짱구&맹구 대형 우비 피규어 / 크기: 약 45.5cm / 정품 캐릭터 굿즈 / 대형 피규어 / 핫트랙스 판매 상품',
    'figure',
    'LETOGMS',
    100,
    'New',
    'P1242.png',
    1
);




DESC product_illya;
SELECT * FROM product_illya;
COMMIT;
