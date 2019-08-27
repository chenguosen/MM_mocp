*** Settings ***
Resource          通用业务逻辑处理.robot

*** Keywords ***
获取网关对账文件
    [Arguments]    ${host_index}    ${file_index}
    ${host_infos}    Get From Dictionary    ${G_GateWay_logs}    ${host_index}
    ${host_info}    String.Split String    ${host_infos}    ,
    ${command}    Set Variable    cat CREDIT_RECONCILIATION_YYYYMMDD_${file_index}_OK
    远程登录后台    ${host_info[0]}    ${host_info[1]}    ${host_info[2]}    utf-8
    ${runLog}    远程目录执行命令并获取返回执行结果    ${host_info[3]}    ${command}
    log    ${runLog}
    ${trans}    String.Split String    ${runLog}    \n
    log    ${trans}

生成交易记录数据
    [Arguments]    ${appId}    ${count}    ${day_offset}
    ${expect_trans}    Create List
    : FOR    ${indx}    IN RANGE    ${count}
    \    ${Ra}    Evaluate    random.randint(1000,19999999)    random
    \    ${Rb}    Evaluate    random.randint(2000,29999999)    random
    \    ${t_time}    Get Time    epoch    time_=NOW-${day_offset}
    \    ${t_time}    Convert Date    ${t_time}    result_format=%Y%m%d%H%M%S
    \    ${tid}    Set Variable    ${Ra}-${t_time}-${Rb}
    \    ${uid}    Set Variable    U${Ra}-${t_time}
    \    ${oper_type}    Evaluate    random.randint(1,3)    random
    \    ${credit}    Evaluate    random.randint(1,3000)    random
    \    ${params}    Set Variable    {"abstr":"TRANS-AUTOTEST","credit":"${credit}","userId":"${uid}","operTime":"${t_time}"}
    \    ${cb_url}    Set Variable    http://10.12.3.220/aspchain/test
    \    ${cb_flag}    Evaluate    random.randint(0,1)    random
    \    ${tx_hash}    Set Variable    0xa468028d91be501ff43dd4443d418fe113e9a211482b4e055aad9128301e0d3c
    \    ${create_time}    Get Time    epoch    time_=NOW-${day_offset}
    \    ${create_time}    Convert Date    ${create_time}    result_format=%Y-%m-%d %H:%M:%S
    \    ${tran_date}    Convert Date    ${create_time}    result_format=%Y%m%d
    \    ${upd_offset}    Evaluate    random.randint(0,1)    random
    \    ${lastupdate_time}    Get Time    epoch    time_=NOW-${upd_offset} \ \ day
    \    ${lastupdate_time}    Convert Date    ${lastupdate_time}    result_format=%Y-%m-%d %H:%M:%S
    \    ${code_idx}    Evaluate    random.randint(0,2)    random
    \    ${code_keys}    Get Dictionary Keys    ${G_Chain_Code}
    \    ${result_code}    Get From List    ${code_keys}    ${code_idx}
    \    ${result_msg}    Get From Dictionary    ${G_Chain_Code}    ${result_code}
    \    ${cb_lasttime}    Convert Date    ${lastupdate_time}    result_format=%Y-%m-%d %H:%M:%S
    \    ${cb_count}    Evaluate    random.randint(0,2)    random
    \    ${sql_str}    Set Variable    INSERT INTO t_statement (tid, oper_type, user_id, params, cb_url, cb_flag, tx_hash, create_time, lastupdate_time, app_id, result_code, result_msg, cb_lasttime, cb_count, req_time)VALUES('${tid}', ${oper_type}, '${uid}', '${params}', '${cb_url}', ${cb_flag}, '${tx_hash}', '${create_time}', '${lastupdate_time}', '${appId}', '${result_code}', '${result_msg}', '${cb_lasttime}', ${cb_count}, '${t_time}');\t
    \    sleep    1    #造成时间差
    \    数据库执行sql语句(非查询)    ${sql_str}
    \    ${result}    Convert To Integer    ${result_code}
    \    Run Keyword If    '${result_code}'=='9999'    Set Test Variable    ${result}    2
    \    Append To List    ${expect_trans}    ${uid},${t_time},${tid},${credit},${result}
    [Return]    ${expect_trans}

重命令表操作
    [Arguments]    ${oldTableName}    ${newTableName}
    数据库执行sql语句(非查询)    ALTER TABLE ${oldTableName} RENAME TO ${newTableName}; \

触发对账文件生成
    [Arguments]    ${dz_date}    ${serv_key}=A
    ${headers}    Create Dictionary    content-type=application/json    accept=application/json
    ${sURL}    Get From Dictionary    ${G_GateWay_Servs}    ${serv_key}
    ${reqx}    Set Variable    {"executeDay":"${dz_date}"}
    Set Test Variable    ${reqx}
    POST消息reqx    ${sURL}    ${G_interface_names[4]}    ${headers}

某路径执行命令
    [Arguments]    ${path}    ${cmd}    ${host_index}=A
    ${host_infos}    Get From Dictionary    ${G_GateWay_Hosts}    ${host_index}
    ${host_info}    String.Split String    ${host_infos}    ,
    远程登录后台    ${host_info[0]}    ${host_info[1]}    ${host_info[2]}    utf-8
    ${output}    远程目录执行命令并获取返回执行结果    ${path}    ${cmd}
    关闭当前远程连接
    [Return]    ${output}

校验对账文件结果
    [Arguments]    ${cnt}    ${app_Id}    ${file_info}    @{expect_trans}
    ${real_trans}    Get SubString    ${file_info}    \    -1
    ${real_trans}    String.Split String    ${real_trans}    \r\n
    Should Be Equal As Strings    ${real_trans[0]}    ${cnt},${app_Id}
    : FOR    ${indx}    IN RANGE    1    ${cnt}
    \    List Should Contain Value    @{expect_trans}    ${real_trans[${indx}]}
