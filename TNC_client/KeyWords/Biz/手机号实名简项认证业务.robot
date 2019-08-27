*** Settings ***
Resource          通用业务逻辑处理.robot
Resource          ../Pub/RedisLibs.robot

*** Keywords ***
读取手机号码实名简项认证模板
    [Arguments]    @{kvs}
    Set Test Variable    ${req_flag}    ${TNC_interface_names[1]}
    ${reqx}    读取包结构    ${req_flag}.req.json
    ${systemtime}    时间戳
    ${b}    Evaluate    random.randint(1000,9999)    random
    ${clientState}    Set Variable    92876156325${b}${systemtime}
    ${appkey}    数据库查询_返回单值    select appkey from t_appinfo where appid='${appid}';
    ${tel}    set variable    15093289783
    ${sign}    Set Variable    ${appkey}clientIp=192.168.16.1clientState=${clientState}expandParams=key:1idCode=41272419920212449Xmsisdn=${tel}operatorType=1systemTime=${systemtime}userName=董康康${appkey}
    log    ${sign}
    ${md5}    evaluate    hashlib.md5('${sign}'.encode(encoding='utf8')).hexdigest()    hashlib
    ${md5}    Convert To Uppercase    ${md5}
    ${TNC_misiscd}    Set Variable    qmCo8S/c0V8b4WbsGDTKmg==
    ${idCode}    Set Variable    Nt9sU/e47auaCy58WKu0QWQnOzOGfZ0D
    重置节点数据    $.msgReq.msgBody.systemTime=${systemtime}    $.msgReq.msgBody.clientState=${clientState}    $.msgReq.msgBody.sign=${md5}    $.msgReq.msgBody.msisdn=${TNC_misiscd}    $.msgReq.msgBody.userName=董康康    $.msgReq.msgHeader.appId=${appid}
    ...    $.msgReq.msgBody.idCode=${idCode}
    Set Test Variable    ${clientState}

扣费记录数据库入库检查
    ${saleprice}    数据库查询_返回单值    SELECT salePrice FROM t_product WHERE productID \ in (SELECT productID FROM t_account4product where accountID in (select accountID FROM T_PreLicense where preLicenseID in (SELECT preLicenseID FROM T_PreLicense4App WHERE appid='${appid}'))) and capabilityType='3';    #获取销售品的客户售价
    ${basisPrice}    数据库查询_返回单值    SELECT basisPrice FROM t_product WHERE productID \ in (SELECT productID FROM t_account4product where accountID in (select accountID FROM T_PreLicense where preLicenseID in (SELECT preLicenseID FROM T_PreLicense4App WHERE appid='${appid}'))) and capabilityType='3';    #获取销售品的运营商购买价
    数据库查询_返回单值    select count(*) from t_realnameauthlog t where t.clientState='${clientState}' and t.isVerify='0' and t.fee='${saleprice}' and t.prefee='${basisPrice}';
    Should Be Equal As Strings    ${result}    1
    Set Test Variable    ${saleprice}

获取appid、preLicenseID
    ${appid}    Set Variable    100000000285
    ${preLicenseID}    数据库查询_返回单值    SELECT preLicenseID FROM T_PreLicense WHERE preLicenseID IN (SELECT preLicenseID FROM T_PreLicense4App WHERE appid='${appid}') and status=0
    Set Suite Variable    ${appid}
    Set Suite Variable    ${preLicenseID}
    [Return]    ${appid}    ${preLicenseID}
