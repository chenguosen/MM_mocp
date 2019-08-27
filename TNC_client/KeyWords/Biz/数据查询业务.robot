*** Settings ***
Resource          ../Pub/HttpRequest.robot
Resource          ../Pub/HttpValidator.robot
Resource          ../Pub/JsonObjLib.robot
Resource          ../../Resources/Global_Variable.robot
Resource          ../Pub/MySQLLibs.robot
Resource          通用业务逻辑处理.robot

*** Keywords ***
读取数据查询请求
    [Arguments]    @{kvs}
    Set Test Variable    ${req_flag}    ${G_interface_names[1]}
    读取模板请求    ${req_flag}.req.json    #commitusercredit
    更新节点数据    @{kvs}

发送数据查询请求
    [Arguments]    ${serv_key}=A
    发送Reqx请求    /${req_flag}    ${serv_key}

校验数据查询结果
    [Arguments]    @{kvs}
    校验Http响应字段值    @{kvs}
