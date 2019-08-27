DELETE FROM t_ipctl WHERE ipctl_name LIKE '自动化测试%';


DELETE FROM t_app_flowpolicy WHERE app_id IN (SELECT a.app_id FROM t_app a WHERE a.app_name LIKE '自动化%');
DELETE FROM t_app WHERE app_name LIKE '自动化%';

INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES(
'104567', '104567', 'abcdghj-2019090_201029301abc', 'abcdghj-104567_201029301callback', '自动化限流应用104567', '0', SYSDATE(), SYSDATE() + INTERVAL 3 DAY, '自动化测试', SYSDATE(), SYSDATE());
INSERT INTO t_app_flowpolicy (app_id, time_unit, app_limit, create_time, lastupdate_time)VALUES(
'104567', '1', 0, SYSDATE(), SYSDATE());


INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES(
'101101', '101101', 'abcdghj-2019090_201029301abc', 'abcdghj-101101_201029301callback', '自动化正常应用101101', '0', SYSDATE(), SYSDATE() + INTERVAL 3 DAY, '自动化测试', SYSDATE(), SYSDATE());
INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES(
'101102', '101102', 'abcdghj-2019090_201029301abc', 'abcdghj-101102_201029301callback', '自动化正常应用101102', '0', SYSDATE(), SYSDATE() + INTERVAL 3 DAY, '自动化测试', SYSDATE(), SYSDATE());
INSERT INTO t_app_flowpolicy (app_id, time_unit, app_limit, create_time, lastupdate_time)VALUES(
'101101', '1', 0, SYSDATE(), SYSDATE());
# 101102 不配置
INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES(
'101201', '101201', 'abcdghj-2019090_201029301abc', 'abcdghj-101201_201029301callback', '自动化状态禁用101201', '1', SYSDATE(), SYSDATE() + INTERVAL 3 DAY, '自动化测试', SYSDATE(), SYSDATE());
INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES(
'101202', '101202', 'abcdghj-2019090_201029301abc', 'abcdghj-101202_201029301callback', '自动化过期应用101202', '0', SYSDATE(), SYSDATE(), '自动化测试', SYSDATE(), SYSDATE());

INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES(
'101301', '101301', 'abcdghj-2019090_201029301abc', 'abcdghj-101301_201029301callback', '自动化限流应用101301', '0', SYSDATE(), SYSDATE() + INTERVAL 3 DAY, '自动化测试', SYSDATE(), SYSDATE());
INSERT INTO t_app_flowpolicy (app_id, time_unit, app_limit, create_time, lastupdate_time)VALUES(
'101301', '1', 0, SYSDATE(), SYSDATE());
INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES(
'101302', '101302', 'abcdghj-2019090_201029301abc', 'abcdghj-101302_201029301callback', '自动化限流应用101302', '0', SYSDATE(), SYSDATE() + INTERVAL 3 DAY, '自动化测试', SYSDATE(), SYSDATE());
INSERT INTO t_app_flowpolicy (app_id, time_unit, app_limit, create_time, lastupdate_time)VALUES(
'101302', '1', 2, SYSDATE(), SYSDATE());

INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES(
'101303', '101303', 'abcdghj-2019090_201029301abc', 'abcdghj-101303_201029301callback', '自动化限流应用101303', '0', SYSDATE(), SYSDATE() + INTERVAL 3 DAY, '自动化测试', SYSDATE(), SYSDATE());
INSERT INTO t_app_flowpolicy (app_id, time_unit, app_limit, create_time, lastupdate_time)VALUES(
'101303', '2', 0, SYSDATE(), SYSDATE());
INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES(
'101304', '101304', 'abcdghj-2019090_201029301abc', 'abcdghj-101304_201029301callback', '自动化限流应用101304', '0', SYSDATE(), SYSDATE() + INTERVAL 3 DAY, '自动化测试', SYSDATE(), SYSDATE());
INSERT INTO t_app_flowpolicy (app_id, time_unit, app_limit, create_time, lastupdate_time)VALUES(
'101304', '2', 2, SYSDATE(), SYSDATE());

INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES(
'101305', '101305', 'abcdghj-2019090_201029301abc', 'abcdghj-101305_201029301callback', '自动化限流应用101305', '0', SYSDATE(), SYSDATE() + INTERVAL 3 DAY, '自动化测试', SYSDATE(), SYSDATE());
INSERT INTO t_app_flowpolicy (app_id, time_unit, app_limit, create_time, lastupdate_time)VALUES(
'101305', '3', 0, SYSDATE(), SYSDATE());
INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES(
'101306', '101306', 'abcdghj-2019090_201029301abc', 'abcdghj-101306_201029301callback', '自动化限流应用101306', '0', SYSDATE(), SYSDATE() + INTERVAL 3 DAY, '自动化测试', SYSDATE(), SYSDATE());
INSERT INTO t_app_flowpolicy (app_id, time_unit, app_limit, create_time, lastupdate_time)VALUES(
'101306', '3', 2, SYSDATE(), SYSDATE());

INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES(
'101307', '101307', 'abcdghj-2019090_201029301abc', 'abcdghj-101307_201029301callback', '自动化限流应用101307', '0', SYSDATE(), SYSDATE() + INTERVAL 3 DAY, '自动化测试', SYSDATE(), SYSDATE());
INSERT INTO t_app_flowpolicy (app_id, time_unit, app_limit, create_time, lastupdate_time)VALUES(
'101307', '4', 0, SYSDATE(), SYSDATE());
INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES(
'101308', '101308', 'abcdghj-2019090_201029301abc', 'abcdghj-101308_201029301callback', '自动化限流应用101308', '0', SYSDATE(), SYSDATE() + INTERVAL 3 DAY, '自动化测试', SYSDATE(), SYSDATE());
INSERT INTO t_app_flowpolicy (app_id, time_unit, app_limit, create_time, lastupdate_time)VALUES(
'101308', '2', 2, SYSDATE(), SYSDATE());
COMMIT;
