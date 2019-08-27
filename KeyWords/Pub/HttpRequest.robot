*** Settings ***
Library           RequestsLibrary

*** Keywords ***
获取SESSION
    [Arguments]    ${alias}    ${url}=http://127.0.0.1
    [Documentation]    ${url}=http://127.0.0.1; 返回session对象.
    ...    创建连接时, header不设置,而是放在后面的请求中带入
    RequestsLibrary.Create Session    ${alias}    ${url}    debug=1

提交GET请求
    [Arguments]    ${alias}    ${uri}    ${headers}=${None}    ${params}=${None}
    [Documentation]    headers:dict;
    ${resp}    RequestsLibrary.Get Request    ${alias}    ${uri}    headers=${headers}    params=${params}    json=0
    Set Test Variable    ${resp}
    Log    ${resp.content}

提交POST请求
    [Arguments]    ${alias}    ${uri}    ${data}=${None}    ${headers}=${None}    ${params}=${None}
    [Documentation]    headers:dict;
    ${resp}    RequestsLibrary.Post Request    ${alias}    ${uri}    ${data}    headers=${headers}    params=${params}
    Set Test Variable    ${resp}

提交PUT请求
    [Arguments]    ${alias}    ${uri}    ${data}=${None}    ${headers}=${None}    ${params}=${None}
    [Documentation]    headers:dict;
    ${resp}    RequestsLibrary.Put Request    ${alias}    ${uri}    ${data}    headers=${headers}    params=${params}
    Set Test Variable    ${resp}

提交DELETE请求
    [Arguments]    ${alias}    ${uri}    ${data}=${None}    ${params}=${None}    ${headers}=${None}
    [Documentation]    headers:dict;
    ${resp}    RequestsLibrary.Delete Request    ${alias}    ${uri}    data=${data}    params=${params}    headers=${headers}
    Set Test Variable    ${resp}

POST上传文件
    [Arguments]    ${url}    ${uri}    ${headers}=${None}    ${files}=${None}
    ${url}    Set Variable    ${url}
    ${uri}    Set Variable    ${uri}
    获取SESSION    session    ${url}
    ${resp}    Post Request    session    ${uri}    ${None}    headers=${headers}    params=${None}
    ...    files=${files}
    Set Test Variable    ${resp}

POST消息reqx
    [Arguments]    ${url}    ${uri}    ${headers}=${None}
    [Documentation]    把常见的POST操作封装，headers已封死
    获取SESSION    session    ${url}
    提交POST请求    session    ${uri}    ${reqx}    headers=${headers}

获取请求节点值
    [Arguments]    ${key}
    [Documentation]    根据后面的k值删除json节点，返回json串，并设置为reqx
    ${json_obj}    json.Loads    ${reqx}
    log    ${json_obj}
    ${value}    JSONLibrary.Get Value From Json    ${json_obj}    ${key}
    Set Test Variable    ${value}
    [Return]    ${value[0]}
