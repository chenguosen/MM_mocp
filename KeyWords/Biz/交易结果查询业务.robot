*** Settings ***
Resource          通用业务逻辑处理.robot

*** Keywords ***
读取交易结果查询请求
    [Arguments]    @{kvs}
    Set Test Variable    ${req_flag}    ${G_interface_names[2]}
    读取模板请求    ${req_flag}.req.json    #commitusercredit
    Comment    更新节点数据    @{kvs}

校验交易结果信息
    [Arguments]    ${chain_code}
    ${resultmsg}    Get From Dictionary    ${G_Chain_Code}    ${chain_code}
    校验Http响应字段值    $.busiInfo.chainCode=${chain_code}    $.busiInfo.chainMsg=${resultmsg}

发送交易查询请求
    [Arguments]    ${serv_key}=A
    发送Reqx请求    /${req_flag}    ${serv_key}
