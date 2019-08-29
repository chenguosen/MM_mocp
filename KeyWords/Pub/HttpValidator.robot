*** Settings ***
Library           String
Library           Collections
Library           jsonschema
Library           ../../Library/robotPatch.py
Resource          JsonObjLib.robot
Library           ../../Library/utilLibrary.py

*** Keywords ***
获取响应状态码
    [Return]    ${resp.status_code}

获取返回包
    Comment    Set Variable    ${resp_content}    ${resp.content}
    [Return]    ${resp.content}

获取返回包头
    [Arguments]    ${key}
    [Documentation]    传入key,拿到value
    log    ${resp.headers}
    ${value}    Collections.Get From Dictionary    ${resp.headers}    ${key}
    [Return]    ${value}

校验Http响应状态码
    [Arguments]    ${http_status_code}=200
    Should Be Equal As Strings    ${resp.status_code}    ${http_status_code}

校验Http响应消息头
    [Arguments]    @{rest}
    : FOR    ${Li}    IN    @{rest}
    \    ${key_value}    String.Split String    ${Li}    =
    \    ${key}    Collections.Get From List    ${key_value}    0
    \    ${expect_value}    Collections.Get From List    ${key_value}    1
    \    ${real_value}    Collections.Get From Dictionary    ${resp.headers}    ${key}
    \    ${expect_value}    robotPatch.Custom Json Value Lstrip    ${expect_value}
    \    Run Keyword If    '${expect_value}'=='*'    Return From Keyword
    \    Should Be Equal As Strings    ${real_value}    ${expect_value}

校验Http响应字段值
    [Arguments]    @{rest}
    ${json_obj}    解析Json串    ${resp.content}
    : FOR    ${Li}    IN    @{rest}
    \    log    ${Li}
    \    ${key_value}    String.Split String    ${Li}    =
    \    ${key}    Collections.Get From List    ${key_value}    0
    \    ${expect_value}    Collections.Get From List    ${key_value}    1
    \    ${real_value}    获取Json变量值    ${json_obj}    ${key}
    \    ${expect_value}    robotPatch.Custom Json Value Lstrip    ${expect_value}
    \    Run Keyword If    '${expect_value}'=='*'    Return From Keyword
    \    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${real_value}    ${expect_value}

校验Http响应字段长度
    [Arguments]    ${jsonpath}    ${expect_list_length}=1
    ${json_obj}    解析Json串    ${resp.content}
    ${results_obj}    获取Json变量值    ${json_obj}    ${jsonpath}
    ${list_len}    Get Length    ${results_obj}
    log    ${list_len}
    Should Be Equal As Strings    ${list_len}    ${expect_list_length}

校验Http响应字段应包含
    [Arguments]    ${jsonpath}    @{list_elements}
    ${json_obj}    解析Json串    ${resp.content}
    ${results_obj}    获取Json变量值    ${json_obj}    ${jsonpath}
    : FOR    ${element_str}    IN    @{list_elements}
    \    Should Contain    ${results_obj}    ${element_str}

校验Http响应列表字段
    [Arguments]    ${jsonpath}    ${expectList}
    [Documentation]    校验制定json路径下的数组对象${jsonpath} | ${expectList}
    ...    ${expectList}：在业务层封装成List对象
    ${json_obj}    解析Json串    ${resp.content}
    ${realList}    获取Json变量值    ${json_obj}    ${jsonpath}
    ${result}    utilLibrary.comp List    ${realList}    ${expectList}
    Should Be Equal As Strings    ${result}    True

获取返回包字段值
    [Arguments]    ${key}
    ${json_obj}    解析Json串    ${resp.content}
    ${value}    获取Json变量值    ${json_obj}    ${key}
    [Return]    ${value}
