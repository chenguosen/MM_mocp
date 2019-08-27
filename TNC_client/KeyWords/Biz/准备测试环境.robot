*** Settings ***
Resource          ../../Resources/Global_Variable.robot
Resource          ../Pub/MySQLLibs.robot
Resource          ../Pub/HttpRequest.robot
Resource          ../Pub/HttpValidator.robot
Resource          ../Pub/JsonObjLib.robot
Library           ../../Library/utilLibrary.py
Resource          ../Pub/RedisLibs.robot
Resource          ../Pub/SSHLibs.robot
Resource          ../Pub/EtherumLibs.robot

*** Variables ***
${init_data_sql}    init_data.sql
${ctrl_template}    invokeCtrl_req.json
${ctrl_uri}       /pyttool

*** Keywords ***
初始化IP等测试数据
    数据库执行sql文件(非查询)    ${EXECDIR}${/}Resources${/}Sql${/}${init_data_sql}
    ${localhost}    get host ip
    数据库执行sql语句(非查询)    Delete from t_ipctl where ipctl_name like '自动化测试%';
    数据库执行sql语句(非查询)    INSERT INTO t_ipctl (ipctl_name, ipctl_desc, ipctl_type, ip, create_time, lastupdate_time)VALUES( '自动化测试${localhost}', '自动化测试${localhost}', '1', '${localhost}', SYSDATE(), SYSDATE());
    删除key    ${localhost}

读取并初始回调应答请求
    [Arguments]    @{kvs}
    读取包结构    ${ctrl_template}
    重置节点数据    @{kvs}

更新回调应答节点数据
    [Arguments]    @{kv}
    重置节点数据    @{kv}

发送回调应答包请求
    ${headers}    Create Dictionary    content-type=application/json    accept=application/json
    POST消息reqx    ${G_SimGateWay}    ${ctrl_uri}    ${headers}

删除回调应答包节点
    [Arguments]    @{keys}
    删除不用节点    @{keys}

增加控制应答包新节点
    [Arguments]    ${obj_path}    ${obj_value}
    添加新节点    ${obj_path}    ${obj_value}

获取回调请求数据
    [Arguments]    ${key_uri}
    获取SESSION    session    ${G_SimGateWay}
    ${headers}    Create Dictionary    content-type=application/json
    ${params}    Create Dictionary    request_uri=${key_uri}
    提交GET请求    session    ${ctrl_uri}    headers=${headers}    params=${params}

监控链层节点数据
    [Arguments]    ${host_idx}=A    @{keys}
    ${host_infos}    Get From Dictionary    ${G_ASPChain_Hosts}    ${host_idx}
    ${host_info}    String.Split String    ${host_infos}    ,
    ${command}    Set Variable    ./attach.sh
    : FOR    ${cmd}    IN    @{keys}
    \    ${command}    Catenate    SEPARATOR=\r    ${command}    ${cmd}
    远程登录后台    ${host_info[0]}    ${host_info[1]}    ${host_info[2]}    utf-8
    ${runLog}    远程目录执行命令并获取返回执行结果    ${host_info[3]}    ${command}\r
    log    ${runLog}
    关闭所有远程连接

读取链上用户余额
    ${userInfo}    查询用户积分余额    A    3246
    log    ${userInfo}

鉴权插入IP数据
    [Arguments]    ${ip}    ${iptype}
    数据库执行sql语句(非查询)    INSERT INTO t_ipctl (ipctl_name, ipctl_desc, ipctl_type, ip, create_time, lastupdate_time)VALUES( '自动化测试${ip}', '自动化测试类型${ip}', '${iptype}', '${ip}', SYSDATE(), SYSDATE());

鉴权删除IP数据
    [Arguments]    ${ip}
    数据库执行sql语句(非查询)    Delete from t_ipctl where ip='${ip}';

鉴权删除APP数据
    [Arguments]    ${appid}
    数据库执行sql语句(非查询)    DELETE FROM t_app_flowpolicy WHERE app_id='${appid}';
    数据库执行sql语句(非查询)    DELETE FROM t_app WHERE app_id='${appid}';

鉴权插入APP数据
    [Arguments]    ${appid}
    数据库执行sql语句(非查询)    INSERT INTO t_app (app_id, app_key, app_secret, app_cbkey, app_name, STATUS, begin_time, end_time, create_name, create_time, lastupdate_time)VALUES('${appid}', '${appid}', 'abcdghj-2019090_201029301abc', 'abcdghj-101101_201029301callback', '自动化正常应用${appid}', '0', SYSDATE(), SYSDATE() + INTERVAL 3 DAY, '自动化测试', SYSDATE(), SYSDATE());
    数据库执行sql语句(非查询)    INSERT INTO t_app_flowpolicy (app_id, time_unit, app_limit, create_time, lastupdate_time)VALUES('${appid}', '1', 0, SYSDATE(), SYSDATE());
