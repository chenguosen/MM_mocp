*** Settings ***
Resource          通用业务逻辑处理.robot

*** Keywords ***
校验上链交易流水
    [Arguments]    ${expect_count}    @{rest}
    ${wheres}    将键值对转为Where子句    @{rest}
    ${realCount}    数据库查询_返回单值    SELECT \ \ COUNT(tid) FROM t_statement ${wheres}
    ${expect_count}    Convert To Integer    ${expect_count}
    Should Be Equal As Integers    ${realCount}    ${expect_count}

校验回调请求参数
    [Arguments]    ${chain_code}=0000
    ${appId}    获取请求节点值    $.pubInfo.appId
    ${rtid}    获取请求节点值    $.pubInfo.tid
    ${appCbKey}    数据库查询_返回单值    SELECT \ t.app_cbkey FROM t_app t WHERE t.app_id='${appId} ';
    ${reqTime}    获取返回包字段值    $.pubInfo.reqTime
    Length Should Be    ${reqTime}    14
    校验字符串时间偏差    ${reqTime}    120
    ${tid}    获取返回包字段值    $.pubInfo.tid
    Length Should Be    ${tid}    32
    ${src_str}    Set Variable    ${appId}${reqTime}${tid}${appCbKey}
    log    ${src_str}
    ${sign}    Evaluate    hashlib.md5('${src_str}'.encode(encoding='utf8')).hexdigest()    hashlib
    ${sign}    Convert To Uppercase    ${sign}
    ${chainmsg}    Get From Dictionary    ${G_Chain_Code}    ${chain_code}
    校验Http响应字段值    $.pubInfo.appId =${appId}    $.pubInfo.ver =1.0    $.busiInfo.tid =${rtid}    $.pubInfo.sign =${sign}    $.busiInfo.chainCode =${chain_code}    $.busiInfo.chainMsg =${chainmsg}
    Should Not Be Equal As Strings    ${tid}    ${rtid}

读取数据上链请求
    [Arguments]    @{kvs}
    Set Test Variable    ${req_flag}    ${G_interface_names[0]}
    读取模板请求    ${req_flag}.req.json    #commitusercredit
    更新节点数据    $.pubInfo.cbUrl=${G_SimGateWay}/common/${req_flag}    $.busiInfo.params.userId=${uid}    @{kvs}

发送数据上链请求
    [Arguments]    ${serv_key}=A
    发送Reqx请求    /${req_flag}    ${serv_key}

校验数据库上链结果
    [Arguments]    ${tid}    ${expect_count}    ${chainCode}    ${chainMsg}
    ${realCount}    数据库查询_返回单值    SELECT \ \ COUNT(tid) FROM t_statement where tid=\'${tid}\' AND tx_hash IS NOT NULL AND block_hash IS NOT NULL AND block_number IS NOT NULL and result_code=\'${chainCode}\' and result_msg=\'${chainMsg}\';
    ${expect_count}    Convert To Integer    ${expect_count}
    Should Be Equal As Integers    ${realCount}    ${expect_count}
    \    Convert To String
