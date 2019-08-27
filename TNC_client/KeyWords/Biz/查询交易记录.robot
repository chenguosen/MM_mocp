*** Settings ***
Resource          通用业务逻辑处理.robot

*** Keywords ***
生成用户交易记录数据
    [Arguments]    ${appId}    ${userId}    ${count}    ${day_offset}
    ${sql_str}    Set Variable    ${EMPTY}
    : FOR    ${indx}    IN RANGE    ${count}
    \    ${Ra}    Evaluate    random.randint(1000,19999999)    random
    \    ${Rb}    Evaluate    random.randint(20000000,29999999)    random
    \    ${t_time}    Get Time    epoch    time_=NOW-${day_offset} day
    \    ${t_time}    Convert Date    ${t_time}    result_format=%Y%m%d%H%M%S
    \    ${tid}    Set Variable    ${Ra}-${t_time}-${Rb}
    \    ${uid}    Set Variable    ${userId}    #U${Ra}-${t_time}
    \    ${oper_type}    Evaluate    random.randint(1,3)    random
    \    ${credit}    Evaluate    random.randint(1,3000)    random
    \    ${params}    Set Variable    {"abstr":"TRANS-AUTOTEST","credit":"${credit}","userId":"${uid}","operTime":"${t_time}"}
    \    ${cb_url}    Set Variable    http://10.12.3.220/aspchain/test
    \    ${cb_flag}    Evaluate    random.randint(0,1)    random
    \    ${tx_hash}    Set Variable    0xa468028d91be501ff43dd4443d418fe113e9a211482b4e055aad9128301e0d3c
    \    ${create_time}    Get Time    epoch    time_=NOW-${day_offset} day
    \    ${create_time}    Convert Date    ${create_time}    result_format=%Y-%m-%d %H:%M:%S
    \    ${tran_date}    Convert Date    ${create_time}    result_format=%Y%m%d
    \    ${upd_offset}    Evaluate    ${day_offset}-random.randint(0,1)    random
    \    ${lastupdate_time}    Get Time    epoch    time_=NOW-${upd_offset} \ \ day
    \    ${lastupdate_time}    Convert Date    ${lastupdate_time}    result_format=%Y-%m-%d %H:%M:%S
    \    ${code_idx}    Evaluate    random.randint(0,2)    random
    \    ${code_keys}    Get Dictionary Keys    ${G_Chain_Code}
    \    ${result_code}    Get From List    ${code_keys}    ${code_idx}
    \    ${result_msg}    Get From Dictionary    ${G_Chain_Code}    ${result_code}
    \    ${cb_lasttime}    Convert Date    ${lastupdate_time}    result_format=%Y-%m-%d %H:%M:%S
    \    ${cb_count}    Evaluate    random.randint(0,2)    random
    \    ${sql_str}    Set Variable    INSERT INTO t_statement (tid, oper_type, user_id, params, cb_url, cb_flag, tx_hash, create_time, lastupdate_time, app_id, result_code, result_msg, cb_lasttime, cb_count, req_time)VALUES('${tid}', ${oper_type}, '${uid}', '${params}', '${cb_url}', ${cb_flag}, '${tx_hash}', '${create_time}', '${lastupdate_time}', '${appId}', '${result_code}', '${result_msg}', '${cb_lasttime}', ${cb_count}, '${create_time}');\t
    \    sleep    1    #造成时间差
    \    数据库执行sql语句(非查询)    ${sql_str}

读取交易记录查询请求
    [Arguments]    @{kvs}
    Set Test Variable    ${req_flag}    ${G_interface_names[3]}
    读取模板请求    ${req_flag}.req.json
    更新节点数据    @{kvs}

校验交易记录查询
    [Arguments]    ${curPage}    ${pageSize}    # 首页从0开始
    ${uid}    获取请求节点值    $.busiInfo.userId
    ${sdate}    获取请求节点值    $.busiInfo.beginDate
    ${edate}    获取请求节点值    $.busiInfo.endDate
    ${cnt}    数据库查询_返回单值    SELECT COUNT(t.tid) FROM t_statement t WHERE t.user_id = \'${uid}\' AND DATE_FORMAT(t.create_time,'%Y-%m-%d') >= DATE_FORMAT(\'${sdate}\','%Y-%m-%d') AND DATE_FORMAT(t.create_time,'%Y-%m-%d') <= DATE_FORMAT(\'${edate}\','%Y-%m-%d')
    Run Keyword And Return If    ${cnt}==0    校验应答字段值    $.busiInfo=${None}    $.pageInfo=${None}
    ${curPage}    Evaluate    ${curPage}*${pageSize}
    ${sqlstr}    Set Variable    SELECT CONCAT(\'{\"operType\":\',t.oper_type,\'\,\"userId\":\"\',t.user_id,\'\",\"params\":\',t.params,\'}\') FROM t_statement t WHERE t.user_id = \'${uid}\' AND DATE_FORMAT(t.create_time,'%Y-%m-%d') >= DATE_FORMAT(\'${sdate}\','%Y-%m-%d') AND DATE_FORMAT(t.create_time,'%Y-%m-%d') <= DATE_FORMAT(\'${edate}\','%Y-%m-%d') ORDER BY t.create_time DESC LIMIT ${curPage},${pageSize};
    ${db_trans}    数据库查询    ${sqlstr}
    ${resp_trans}    获取应答某字段数据    $.busiInfo.records
    ${resp_len}    Get Length    ${resp_trans}
    : FOR    ${indx}    IN RANGE    ${resp_len}
    \    ${resp_tran}    Evaluate    str(${resp_trans[${indx}]})
    \    ${db_tran}    Json.Loads    ${db_trans[${indx}][0]}
    \    ${db_tran}    获取Json对象节点    ${db_tran}    $
    \    Should Be Equal As Strings    ${db_tran[0]}    ${resp_trans[${indx}]}

发送交易记录查询请求
    [Arguments]    ${serv_key}=A
    发送Reqx请求    /${req_flag}    ${serv_key}

删除用户交易数据
    [Arguments]    ${userId}
    数据库执行sql语句(非查询)    DELETE FROM t_statement WHERE user_id=\'${userId}\';
