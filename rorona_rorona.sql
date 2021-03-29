create table rorona
(
    ID          int           not null,
    name        varchar(256)  not null,
    rule        varchar(512)  not null,
    date        varchar(256)  not null,
    description varchar(1024) not null,
    image       varchar(128)  not null,
    color1      varchar(128)  not null,
    color2      varchar(128)  not null
);

INSERT INTO rorona.rorona (ID, name, rule, date, description, image, color1, color2) VALUES (1, '모임', '5인 이상 모임 금지', '03-29 ~ 04-11', '(제외) ① 직계가족(8인까지) 또는 거주공간이 동일한 가족 등이 모이는
경우, ② 상견례(8인까지) ③ 영유아(6세 미만의 취학 전 아동)를 동반하는
경우(8인까지, 단 영유아를 제외한 인원은 4인까지 가능), ④ 아동‧노인‧
장애인 돌봄에 필요한 경우, ⑤ 임종 가능성이 있어 가족 등이 모이는
경우, ⑥ 시설 관리자가 있는 스포츠 영업시설에 스포츠 경기를 위해
모이는 경우, ⑦ 돌잔치 전문점', 'party', 'ff7b54', 'ffb26b');