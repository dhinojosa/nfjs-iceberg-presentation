USE demo;

CREATE TABLE vroom.customers (
                           id BIGINT,
                           name STRING,
                           email STRING
) PARTITIONED BY (email);

INSERT INTO vroom.customers VALUES
                          (1, 'Alice Smith', 'alice@example.com'),
                          (2, 'Bob Johnson', 'bob@example.com'),
                          (3, 'Carol Adams', 'carol@example.com');

SELECT * FROM vroom.customers$snapshots;

INSERT INTO customers VALUES
                          (4, 'Diana Brooks', 'diana.brooks@example.com'),
                          (5, 'Roy Martinez', 'roy.martinez@example.com'),
                          (6, 'Bobby Chen', 'bobby.chen@example.com'),
                          (7, 'Raymond Singh', 'ray.singh@example.com'),
                          (8, 'John Taylor', 'john.taylor@example.com');

SELECT *,
       UNIX_TIMESTAMP(CAST(committed_at AS STRING)) * 1000 AS committed_unix_ms
FROM vroom.customers$snapshots;

SELECT * FROM customers /*+ OPTIONS ('as-of-timestamp' = '1752189366000') */;

SELECT * FROM customers /*+ OPTIONS ('snapshot-id' = '857744417093019701') */;

DROP TABLE customers;

CREATE TABLE customers (
                           id BIGINT,
                           name STRING,
                           email STRING,
                           region STRING
)
    PARTITIONED BY (bucket(region, 10));

INSERT INTO customers VALUES
                          (1, 'Alice Smith', 'alice.smith@example.com', 'us-east'),
                          (2, 'Bob Johnson', 'bob.johnson@example.com', 'us-west'),
                          (3, 'Carla Ruiz', 'carla.ruiz@example.com', 'europe-west'),
                          (4, 'Deepak Sharma', 'deepak.sharma@example.com', 'asia-south'),
                          (5, 'Fatima Noor', 'fatima.noor@example.com', 'middle-east'),
                          (6, 'George Li', 'george.li@example.com', 'asia-east'),
                          (7, 'Hiro Tanaka', 'hiro.tanaka@example.com', 'japan'),
                          (8, 'Isabelle Dupont', 'isabelle.dupont@example.com', 'europe-central'),
                          (9, 'Jack Brown', 'jack.brown@example.com', 'us-central'),
                          (10, 'Kofi Mensah', 'kofi.mensah@example.com', 'africa-west'),
                          (11, 'Laura Müller', 'laura.mueller@example.com', 'europe-north'),
                          (12, 'Mohammed Ali', 'mohammed.ali@example.com', 'middle-east'),
                          (13, 'Nina Petrova', 'nina.petrova@example.com', 'europe-east'),
                          (14, 'Omar El-Khatib', 'omar.khatib@example.com', 'north-africa'),
                          (15, 'Priya Desai', 'priya.desai@example.com', 'asia-south'),
                          (16, 'Quentin Zhang', 'quentin.zhang@example.com', 'asia-east'),
                          (17, 'Rosa Martinez', 'rosa.martinez@example.com', 'south-america-east'),
                          (18, 'Samir Khan', 'samir.khan@example.com', 'central-asia'),
                          (19, 'Tina Okafor', 'tina.okafor@example.com', 'africa-west'),
                          (20, 'Ursula Meier', 'ursula.meier@example.com', 'europe-central'),
                          (21, 'Victor Silva', 'victor.silva@example.com', 'south-america-west'),
                          (22, 'Wang Wei', 'wang.wei@example.com', 'china-north'),
                          (23, 'Ximena Rojas', 'ximena.rojas@example.com', 'south-america-east'),
                          (24, 'Yusuf Ibrahim', 'yusuf.ibrahim@example.com', 'africa-east'),
                          (25, 'Zara Khan', 'zara.khan@example.com', 'asia-south'),
                          (26, 'Andreas Papadopoulos', 'andreas.papa@example.com', 'europe-south'),
                          (27, 'Beatriz Costa', 'beatriz.costa@example.com', 'south-america-central'),
                          (28, 'Chike Obi', 'chike.obi@example.com', 'africa-west'),
                          (29, 'Dmitry Ivanov', 'dmitry.ivanov@example.com', 'europe-east'),
                          (30, 'Elena Rossi', 'elena.rossi@example.com', 'europe-south'),
                          (31, 'Fikile Dlamini', 'fikile.dlamini@example.com', 'africa-south'),
                          (32, 'Gabriel Mendes', 'gabriel.mendes@example.com', 'south-america-west'),
                          (33, 'Hannah Koch', 'hannah.koch@example.com', 'europe-central'),
                          (34, 'Ibrahim Diallo', 'ibrahim.diallo@example.com', 'africa-west'),
                          (35, 'Julia Novak', 'julia.novak@example.com', 'europe-north'),
                          (36, 'Khaled Hassan', 'khaled.hassan@example.com', 'middle-east'),
                          (37, 'Ling Zhang', 'ling.zhang@example.com', 'china-south'),
                          (38, 'Mariana López', 'mariana.lopez@example.com', 'south-america-east'),
                          (39, 'Nguyen Van Anh', 'nguyen.anh@example.com', 'asia-southeast'),
                          (40, 'Oksana Shevchenko', 'oksana.shevchenko@example.com', 'europe-east');
