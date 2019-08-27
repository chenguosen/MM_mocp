*** Settings ***
Resource          ../../Resources/Global_Variable.robot
Resource          ../Pub/HttpValidator.robot
Resource          ../Pub/HttpRequest.robot
Resource          ../Pub/SSHLibs.robot
Resource          ../Pub/JsonObjLib.robot
Resource          ../Pub/TimeLibs.robot
Resource          ../Pub/EtherumLibs.robot
Resource          ../Pub/MySQLLibs.robot
Resource          ../Pub/RedisLibs.robot

*** Keywords ***
读取模板请求
    [Arguments]    ${req_template}    ${app_key}=101305
    [Documentation]    104567：缺省用于测试正常业务的appId
    读取包结构    ${req_template}
    ${req_time}    生成指定时间串
    #初始化tid
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${Rb}    Evaluate    random.randint(20000000,29999999)    random
    Set Test Variable    ${tid}    ${Ra}-${req_time}-${Rb}
    Set Test Variable    ${uid}    U${Ra}-${req_time}
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    log    ${app_secret}
    #初始化签名值
    ${src_str}    Set Variable    ${app_key}${req_time}${tid}${app_secret}
    ${sign}    Evaluate    hashlib.md5('${src_str}'.encode(encoding='utf8')).hexdigest()    hashlib
    ${sign}    Convert To Uppercase    ${sign}
    重置节点数据    $.pubInfo.appId=${app_key}    $.pubInfo.reqTime=${req_time}    $.pubInfo.tid=${tid}    $.pubInfo.sign=${sign}

更新节点数据
    [Arguments]    @{key_value}
    重置节点数据    @{key_value}

删除请求节点
    [Arguments]    @{keys}
    删除不用节点    @{keys}

添加请求节点
    [Arguments]    ${obj_path}    ${obj_value}
    添加新节点    ${obj_path}    ${obj_value}

发送Reqx请求
    [Arguments]    ${sURI}    ${serv_key}=A
    ${headers}    Create Dictionary    content-type=application/json    accept=application/json
    ${sURL}    Get From Dictionary    ${G_GateWay_Servs}    ${serv_key}
    POST消息reqx    ${sURL}    ${sURI}    ${headers}

校验应答返回码信息
    [Arguments]    ${resultcode}    ${status_code}=200
    校验Http响应状态码    ${status_code}
    ${resultmsg}    Get From Dictionary    ${G_ResultCode}    ${resultcode}
    校验Http响应字段值    $.pubInfo.code=${resultcode}    $.pubInfo.msg=${resultmsg}
    ${respTime}    获取返回包字段值    $.pubInfo.rspTime
    Comment    Length Should Be    ${respTime}    14
    Comment    ${respTime}    Convert Date    ${respTime}
    Comment    校验字符串时间偏差    ${respTime}    120

获取请求某字段数据
    [Arguments]    ${k}
    ${val}    获取请求节点值    ${k}
    [Return]    ${val}

获取应答某字段数据
    [Arguments]    ${k}
    ${val}    获取返回包字段值    ${k}
    [Return]    ${val}

获取服务器请求日志
    [Arguments]    ${host_index}=A    @{keys}
    [Documentation]    关键值自定义
    ${host_infos}    Get From Dictionary    ${G_GateWay_Logs}    ${host_index}
    ${host_info}    String.Split String    ${host_infos}    ,
    ${command}    Set Variable    cat *.log|grep req_content
    : FOR    ${key}    IN    @{keys}
    \    ${command}    Catenate    SEPARATOR=|grep\ \    ${command}    ${key}
    远程登录后台    ${host_info[0]}    ${host_info[1]}    ${host_info[2]}    utf-8
    ${reqLog}    远程目录执行命令并获取返回执行结果    ${host_info[3]}    ${command}
    Set Test Variable    ${reqLog}
    关闭当前远程连接
    [Return]    ${reqLog}

获取服务器应答日志
    [Arguments]    ${host_index}=A    @{keys}
    [Documentation]    关键值自定义
    ${host_infos}    Get From Dictionary    ${G_GateWay_Logs}    ${host_index}
    ${host_info}    String.Split String    ${host_infos}    ,
    ${command}    Set Variable    cat *.log|grep resp_content
    : FOR    ${key}    IN    @{keys}
    \    ${command}    Catenate    SEPARATOR=|grep\ \    ${command}    ${key}
    远程登录后台    ${host_info[0]}    ${host_info[1]}    ${host_info[2]}    utf-8
    ${runLog}    远程目录执行命令并获取返回执行结果    ${host_info[3]}    ${command}
    Set Test Variable    ${respLog}
    关闭当前远程连接
    [Return]    ${respLog}

校验请求日志内容
    校验两个json串    ${reqx}    ${reqx}
    Comment    ${_time}    将字符串转为时间    20190424123512002
    Comment    校验字符串时间偏差    20190425144012002    30
    Comment    ${_difftime}    获取两时间的毫秒差    20190525155013078    20190424144012002
    Comment    log    ${_difftime}
    Comment    Should Start With    ${reqLog}    tid:${tid},method:
    Comment    ${fields}    String.Split String    ${reqLog}    method:
    Comment    Comment    ${log_tid}    String.Get SubString    ${fields[0]}    7
    Comment    ${fields}    String.Split String    ${fields[1]}    ,appId:
    Comment    ${log_method}    Set Variable    ${fields[0]}
    Comment    ${fields}    String.Split String    ${fields[1]}    ,call_time:
    Comment    ${log_appid}    Set Variable    ${fields[0]}
    Comment    ${fields}    String.Split String    ${fields[1]}    ,req_content:
    Comment    ${log_reqtime}    Set Variable    ${fields[0]}
    Comment    ${log_req}    String.Get SubString    ${fields[1]}    \    -1
    Comment    Should Be Equal As Strings    ${log_method}    ${method}
    Comment    ${r_appId}    获取请求某字段数据    $.pubInfo.appId
    Comment    Should Be Equal As Strings    ${log_appid}    ${r_appId}
    Comment    校验字符串时间偏差    ${log_reqtime}    30
    Comment    Length Should Be    ${log_reqtime}    17
    Comment    Set Test Variable    ${log_reqtime}    #应答校验中使用

组织记录插入语句
    [Arguments]    ${sql_format}    @{values}
    ${quotv}    Set Variable
    : FOR    ${value}    IN    @{values}
    \    ${quotv}    Catenate    SEPARATOR=,    ${quotv}    ${value}
    ${quotv}    get substring    ${quotv}    1
    ${sql}    Set Variable    ${sql_format} values (${quotv});
    [Return]    ${sql}

更新请求时间与TID
    [Arguments]    @{kvs}
    # 更新请求时间
    ${req_time}    Get Time    epoch    time_=NOW
    ${req_time}    Convert Date    ${req_time}    result_format=%Y%m%d%H%M%S
    #更新tid
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${Rb}    Evaluate    random.randint(20000000,29999999)    random
    Set Test Variable    ${tid}    ${Ra}-${req_time}-${Rb}
    ${app_key}    获取请求某字段数据    $.pubInfo.appId
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    #初始化签名值
    ${src_str}    Set Variable    ${app_key}${req_time}${tid}${app_secret}
    ${sign}    Evaluate    hashlib.md5('${src_str}'.encode(encoding='utf8')).hexdigest()    hashlib
    ${sign}    Convert To Uppercase    ${sign}
    重置节点数据    $.pubInfo.reqTime=${req_time}    $.pubInfo.tid=${tid}    $.pubInfo.sign=${sign}    @{kvs}

生成指定时间串
    [Arguments]    ${offset}=0    ${format_str}=%Y%m%d%H%M%S
    ${tran_time}    Get Time    epoch    time_=NOW-${offset}
    ${tran_time}    Convert Date    ${tran_time}    result_format=${format_str}
    Comment    log    ${tran_time}
    [Return]    ${tran_time}

新用户正常开户
    [Arguments]    ${delay_time}=10    @{kvs}
    ${tran_time}    生成指定时间串
    Set Test Variable    ${req_flag}    ${G_interface_names[0]}
    读取模板请求    ${req_flag}.req.json    #commitusercredit
    更新节点数据    $.busiInfo.operType=(int)1    $.busiInfo.params.userId=${uid}    $.busiInfo.params.operTime=${tran_time}    $.pubInfo.cbUrl=${G_SimGateWay}/common/${req_flag}
    : FOR    ${kv}    IN    @{kvs}
    \    更新节点数据    ${kv}
    Comment    删除请求节点    $.busiInfo.params.operTime
    发送Reqx请求    /${req_flag}    A
    Sleep    ${delay_time}

校验应答字段值
    [Arguments]    @{kvs}
    校验Http响应字段值    @{kvs}

校验链上用户余额
    [Arguments]    ${userId}    ${expect_credit}    ${host_idx}=A
    ${userInfo}    查询用户积分余额    ${host_idx}    ${userId}
    ${real_credit}    Get From List    ${userInfo}    1
    ${real_credit}    Convert to Integer    ${real_credit}
    ${expect_credit}    Convert to Integer    ${expect_credit}
    Should Be Equal As Integers    ${real_credit}    ${expect_credit}
    [Return]    ${userInfo}

校验应答包时间字段
    [Arguments]    ${json_path}    ${ex_len}
    ${time_str}    获取应答某字段数据    ${json_path}
    校验字符串时间偏差    ${time_str}    30
    校验时间字符串长度    ${time_str}    ${ex_len}

重新计算签名值
    [Arguments]    ${app_key}    ${req_time}    ${tid}    ${app_secret}
    Comment    ${app_key}    获取请求某字段数据    $.pubInfo.appId
    Comment    ${tid}    获取请求某字段数据    $.pubInfo.tid
    Comment    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    #初始化签名值
    ${src_str}    Set Variable    ${app_key}${req_time}${tid}${app_secret}
    log    ${src_str}
    ${sign}    Evaluate    hashlib.md5('${src_str}'.encode(encoding='utf8')).hexdigest()    hashlib
    ${sign}    Convert To Uppercase    ${sign}
    重置节点数据    $.pubInfo.sign=${sign}

TNC发送Reqx请求
    [Arguments]    ${sURI}    ${serv_key}=client
    ${headers}    Create Dictionary    content-type=application/json    accept=application/json
    ${sURL}    Get From Dictionary    ${TNC_GateWay_Servs}    ${serv_key}
    POST消息reqx    ${sURL}    ${sURI}    ${headers}

时间戳
    ${yyyy}    ${mm}    ${dd}    ${hh}    ${min}    ${sec}    GET TIME
    ...    year month day hour min sec
    ${date}    set variable    ${yyyy}${mm}${dd}${hh}${min}${sec}
    ${a}    Evaluate    random.randint(100,999)    random
    ${systemtime}    set variable    ${date}${a}
    Comment    Comment    Set Test Variable    ${systemtime}
    Comment    Set Test Variable    ${date}
    [Return]    ${systemtime}

恢复预授权缓存数据
    [Arguments]    ${c}
    删除key    KEY_PRELICENSE_BALANCE_${preLicenseID}
    写String    KEY_PRELICENSE_BALANCE_${preLicenseID }    ${c}    #恢复缓存数据

读取请求后的预授权余额
    ${validAmount_end}    根据key取String    KEY_PRELICENSE_BALANCE_${preLicenseID}
    Set Test Variable    ${validAmount_end}
    ${validAmount_DB_end}    数据库查询_返回单值    SELECT validAmount FROM T_PreLicense WHERE preLicenseID IN (SELECT preLicenseID FROM T_PreLicense4App WHERE appid='${appid}') and status ='0';
    ${validAmount_DB_end}    BuiltIn.Convert To String    ${validAmount_DB_end}
    Set Test Variable    ${validAmount_DB_end}
    [Return]    ${validAmount_end}    ${validAmount_DB_end}

读取请求前的预授权余额
    ${validAmount_start}    根据key取String    KEY_PRELICENSE_BALANCE_${preLicenseID}
    Set Test Variable    ${validAmount_start}
    ${validAmount_DB_start}    数据库查询_返回单值    SELECT validAmount FROM T_PreLicense WHERE preLicenseID IN (SELECT preLicenseID FROM T_PreLicense4App WHERE appid='${appid}') and status ='0';
    ${validAmount_DB_start}    BuiltIn.Convert To String    ${validAmount_DB_start}
    Set Test Variable    ${validAmount_DB_start}
    [Return]    ${validAmount_start}    ${validAmount_DB_start}

获取销售品的客户售单价
    [Arguments]    ${appid}    ${capabilityType}
    ${saleprice}    数据库查询_返回单值    SELECT salePrice FROM t_product WHERE productID in (SELECT productID FROM t_account4product where accountID in (select accountID FROM T_PreLicense where preLicenseID in (SELECT preLicenseID FROM T_PreLicense4App WHERE appid='${appid}'))) and capabilityType='${capabilityType}';    #获取销售品的客户售单价
    [Return]    ${saleprice}

恢复预授权和应用关联关系
    向有序集合写一个值    KEY_APP_PRELICENSE_ORDERS_${appid}    1    ${preLicenseID}
    数据库执行sql语句(非查询)    update T_PreLicense set balanceFlag='0' where \ preLicenseID='${preLicenseID}';

扣费成功redis预授权余额检查
    ${price}    Evaluate    ${validAmount_start}-${validAmount_end} \
    Should Be Equal As Strings    ${price}    ${saleprice}    #检查redis里的预授权的剩余金额是否正确（扣费）

获取销售品的运营商购买价
    [Arguments]    ${appid}    ${capabilityType}
    ${basisPrice}    数据库查询_返回单值    SELECT basisPrice FROM t_product WHERE productID in (SELECT productID FROM t_account4product where accountID in (select accountID FROM T_PreLicense where preLicenseID in (SELECT preLicenseID FROM T_PreLicense4App WHERE appid='${appid}'))) and capabilityType='${capabilityType}';    #获取销售品的运营商购买价
    [Return]    ${basisPrice}

扣费失败redis预授权余额检查
    ${value}    Evaluate    ${validAmount}-${validAmount_end}
    Should Be Equal As Strings    ${value}    0    #余额不足，扣费失败

Server发送Reqx请求
    [Arguments]    ${sURI}    ${serv_key}=server
    ${headers}    Create Dictionary    content-type=application/json    accept=application/json
    ${sURL}    Get From Dictionary    ${TNC_GateWay_Servs}    ${serv_key}
    POST消息reqx    ${sURL}    ${sURI}    ${headers}
