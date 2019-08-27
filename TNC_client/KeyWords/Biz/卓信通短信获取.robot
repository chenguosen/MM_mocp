*** Settings ***
Resource          通用业务逻辑处理.robot

*** Keywords ***
读取卓信通短信消息模板
    [Arguments]    @{kvs}
    Set Test Variable    ${req_flag}    ${TNC_interface_names[0]}
    ${reqx}    读取包结构    ${req_flag}.req.json
    ${systemtime}    时间戳
    ${b}    Evaluate    random.randint(1000,9999)    random
    ${clientState}    Set Variable    92876156325${b}${systemtime}
    ${sign}    Set Variable    26355dfec55345d4905b3bf93f6eb29cclientIp=192.168.16.1clientState=${clientState}expandParams=key:1msisdn=13187802375operatorType=1systemTime=${systemtime}26355dfec55345d4905b3bf93f6eb29c
    ${md5}    evaluate    hashlib.md5('${sign}'.encode(encoding='utf8')).hexdigest()    hashlib
    ${md5}    Convert To Uppercase    ${md5}
    ${TNC_misiscd}    Set Variable    pbbNo7zKBEc9NXzBymGavw==
    重置节点数据    $.msgReq.msgBody.systemTime=${systemtime}    $.msgReq.msgBody.clientState=${clientState}    $.msgReq.msgBody.sign=${md5}    $.msgReq.msgBody.msisdn=${TNC_misiscd} \ \
