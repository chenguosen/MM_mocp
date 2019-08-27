*** Settings ***
Library           ../../Library/EtherumLibs.py
Library           ../../Library/JSONLibrary.py

*** Keywords ***
查询用户积分余额
    [Arguments]    ${host_idx}    ${userID}
    ${host_infos}    Get From Dictionary    ${G_Contracts}    ${host_idx}
    ${host_info}    String.Split String    ${host_infos}    ,
    Comment    ${abi_info}=    OperatingSystem.Get File    ${EXECDIR}${/}Resources${/}Contract${/}0x${host_info[1]}.abi
    ${abi_info}    Set Variable    ${EXECDIR}${/}Resources${/}Contract${/}0x${host_info[1]}.abi
    Comment    ${abi_info}    Replace String    ${abi_info}    \t
    Comment    ${abi_info}    Replace String    ${abi_info}    \n
    Comment    ${abi_info}    Replace String    ${abi_info}    \r
    log    我的信息
    log    ${abi_info}
    Comment    ${abi_obj}    json.loads    ${abi_info}    encoding=utf-8
    Comment    ${abi_info}    JSONLibrary.Get Value From Json    ${abi_obj}    $.abi
    Comment    ${user_info}    queryUser    ${host_info[0]}    0x${host_info[1]}    ${abi_info}    ${userID}
    ${user_info}    queryUser    ${host_info[0]}    0x${host_info[1]}    ${abi_info}     ${userID}
    [Return]    ${user_info}
