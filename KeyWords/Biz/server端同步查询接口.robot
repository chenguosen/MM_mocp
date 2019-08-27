*** Settings ***
Resource          通用业务逻辑处理.robot

*** Keywords ***
读取空消息体
    [Arguments]    @{kvs}
    Set Test Variable    ${req_flag}    ${TNC_interface_names[4]}
    ${reqx}    读取包结构    ${req_flag}.req.json

校验消息体和reids缓存一致
    ${num}    数据库查询_返回单值    select count(*) from t_PROVIDER;    #数据库供应商数量
    ${result}    数据库查询_返回单值    select ID from t_PROVIDER ORDER BY ID;
    : FOR    ${n}    IN RANGE    ${num}
    \    ${a}    BuiltIn.Convert To String    @{queryResults[${n}]}
    \    ${redis_value}    根据key取String    KEY_PRELICENSE_PROVIDER_${a}    #reids中的供应商信息
    \    ${xml_value}    获取Json变量值    ${json_obj}    $.data.results[${n}].value    #消息返回的供应商信息
    \    ${redis_value}    evaluate    ${redis_value}.strip(\)    #前后去\符号
    \    ${xml_value}    evaluate    ${xml_value}.strip(\)
    \    校验两个json串    ${xml_value}    ${redis_value}

某路径执行命令
    [Arguments]    ${path}    ${cmd}    ${host_index}=A
    ${host_infos}    Get From Dictionary    ${TNC_Hosts}    ${host_index}
    ${host_info}    String.Split String    ${host_infos}    ,
    远程登录后台    ${host_info[0]}    ${host_info[1]}    ${host_info[2]}    utf-8
    ${output}    远程目录执行命令并获取返回执行结果    ${path}    ${cmd}
    关闭当前远程连接
    [Return]    ${output}
