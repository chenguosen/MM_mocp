*** Settings ***
Library           OperatingSystem
Library           String
Library           Collections
Library           ../../Library/kafkaPatch.py
Library           ../../Library/JSONLibrary.py
Library           ../../Library/robotPatch.py

*** Keywords ***
生产者模板消息
    [Arguments]    ${template}    ${btServers}    ${topic}    @{key_value}
    #从模板中组织消息
    ${json_template}=    OperatingSystem.Get File    ${EXECDIR}${/}Resources${/}Template${/}${template}
    ${json_obj}    json.Loads    ${json_template}
    : FOR    ${kv}    IN    @{key_value}
    \    ${jsonpath_value}    String.Split String    ${kv}    =
    \    JSONLibrary.Update Value To Json    ${json_obj}    ${jsonpath_value[0]}    ${jsonpath_value[1]}
    ${json_str}    json.Dumps    ${json_obj}
    #发送消息
    kafkaSendMsg    ${btServers}    ${topic}    ${json_str}
    [Return]    ${json_str}

消费者链接请求
    [Arguments]    ${btServers}    ${topic}    ${groupid}    ${timeout}=10000
    kafkaStartToRecv    ${btServers}    ${topic}    ${groupid}    ${timeout}

消费者获取消息
    kafkaConsumeData    #无关键字
    ${kmessage}    getLastMessage
    set test variable    ${kmessage}

消费者消息字段校验
    [Arguments]    @{rest}
    ${json_obj}    json.Loads    ${kmessage}
    : FOR    ${Li}    IN    @{rest}
    \    ${key_value}    String.Split String    ${Li}    =
    \    ${key}    Collections.Get From List    ${key_value}    0
    \    ${expect_value}    Collections.Get From List    ${key_value}    1
    \    ${real_value}    JSONLibrary.Get Value From Json    ${json_obj}    ${key}
    \    ${expect_value}    robotPatch.Custom Json Value Lstrip    ${expect_value}
    \    Run Keyword If    '${expect_value}'=='*'    Return From Keyword
    \    Should Be Equal As Strings    ${real_value[0]}    ${expect_value}
