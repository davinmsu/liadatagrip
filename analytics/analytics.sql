CREATE DATABASE master_data;


create table companies
(
    company_id       serial  not null primary key,
    name            varchar(128)   not null
);

create table company_project
(
    project_id       varchar(128)   not null,
    company_id       integer   not null
);

INSERT INTO company_project VALUES
('prod-83',1),
('prod-150',1),
('prod-188',2),
('prod-189',2),
('prod-363',2),
('prod-364',2),
('prod-140',3),
('prod-137',4),
('prod-167',5),
('prod-111',6),
('prod-428',7),
('prod-502',7),
('prod-279',8),
('prod-316',9),
('prod-125',10),
('prod-248',11),
('prod-131',12),
('prod-355',13),
('prod-436',13),
('prod-303',14),
('prod-182',15),
('prod-336',16),
('prod-406',16),
('prod-344',17),
('prod-370',18),
('prod-405',20),
('prod-403',19);



create table mau_pricing_ranges
(
    company_id       integer   not null,
    min       integer default 0   not null,
    price          real default 0 not null
);

