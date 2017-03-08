DROP TABLE IF EXISTS atab;
CREATE TABLE IF NOT EXISTS atab (ks_uid BIGINT, sr_uid STRING, sr_id STRING, tstamp STRING, m_id STRING, act STRING, at_sr_uid STRING, tstamp_type STRING, original_m_id STRING, original_tstamp STRING, registered_flag TINYINT, at_ks_uid BIGINT) PARTITIONED BY (dt STRING,nt STRING);
LOAD DATA LOCAL INPATH '../../data/files/v1.txt' INTO TABLE atab PARTITION (dt='20130311', nt='tw');

DROP TABLE IF EXISTS  mstab;
CREATE TABLE  mstab(ks_uid INT, csc INT) PARTITIONED BY (dt STRING);
LOAD DATA LOCAL INPATH '../../data/files/v2.txt' INTO TABLE mstab PARTITION (dt='20130311');

EXPLAIN
WITH a AS ( SELECT  *  FROM atab WHERE dt='20130311' AND nt='tw' AND ks_uid=1111 LIMIT 2 ),
b AS ( SELECT * FROM mstab WHERE mstab.dt='20130311' )
SELECT * FROM a JOIN b
ON a.ks_uid = b.ks_uid;

WITH a AS ( SELECT  *  FROM atab WHERE dt='20130311' AND nt='tw' AND ks_uid=1111 LIMIT 2 ),
b AS ( SELECT * FROM mstab WHERE mstab.dt='20130311' )
SELECT * FROM a JOIN b
ON a.ks_uid = b.ks_uid;