*** Settings ***
Resource          通用业务逻辑处理.robot

*** Keywords ***
读取本机号码校验请求
    [Arguments]    @{kvs}
    Set Test Variable    ${req_flag}    ${TNC_interface_names[5]}
    ${reqx}    读取包结构    ${req_flag}.req.json
    ${systemtime}    时间戳
    ${b}    Evaluate    random.randint(1000,9999)    random
    ${clientState}    Set Variable    92876156325${b}${systemtime}
    ${appkey}    数据库查询_返回单值    select appkey from t_appinfo where appid='${appid}';
    ${tel}    set variable    15093289783
    ${sign}    Set Variable    ${appkey}clientIp=192.168.16.1clientState=${clientState}expandParams=key:1msisdn=${tel}operatorType=5systemTime=${systemtime}token=${TNC_token}${appkey}
    log    ${sign}
    ${md5}    evaluate    hashlib.md5('${sign}'.encode(encoding='utf8')).hexdigest()    hashlib
    ${md5}    Convert To Uppercase    ${md5}
    ${TNC_misiscd}    Set Variable    QHImMj3z2DnXZ+NZn47LTA==
    重置节点数据    $.msgReq.msgBody.systemTime=${systemtime}    $.msgReq.msgBody.clientState=${clientState}    $.msgReq.msgBody.sign=${md5}    $.msgReq.msgBody.msisdn=${TNC_misiscd}    $.msgReq.msgHeader.appId=${appid}    $.msgReq.msgBody.token=${TNC_token}
    Set Test Variable    ${clientState}

获取appid、preLicenseID
    ${appid}    Set Variable    100000000331
    ${preLicenseID}    数据库查询_返回单值    SELECT preLicenseID FROM T_PreLicense WHERE preLicenseID IN (SELECT preLicenseID FROM T_PreLicense4App WHERE appid='${appid}') and status=0
    Set Suite Variable    ${appid}
    Set Suite Variable    ${preLicenseID}
    [Return]    ${appid}    ${preLicenseID}

扣费记录数据库入库检查
    ${saleprice}    获取销售品的客户售单价    ${appid}    2    #2代表能力的类型为在本机号码验证
    ${basisPrice}    获取销售品的运营商购买价    ${appid}    2    #2代表能力的类型为在本机号码验证
    数据库查询_返回单值    select count(*) from t_mobilevertifylog t where t.clientState='${clientState}' and t.isVerify='0' and t.fee='${saleprice}' and t.prefee='${basisPrice}';    #流水表检查
    Should Be Equal As Strings    ${result}    1
    ${price1}    Evaluate    ${validAmount_DB_start}-${validAmount_DB_end}
    Should Be Equal As Strings    ${price1}    ${saleprice}
    Set Test Variable    ${saleprice}
