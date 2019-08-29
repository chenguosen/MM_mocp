*** Settings ***
Resource          通用业务逻辑处理.robot
Library           ../../Library/liveauth.py

*** Keywords ***
读取卓信通短信消息模板
    [Arguments]    @{kvs}
    Set Test Variable    ${req_flag}    ${TNC_interface_names[0]}
    ${reqx}    读取包结构    ${req_flag}.req.json
    ${systemtime}    时间戳
    ${b}    Evaluate    random.randint(1000,9999)    random
    ${clientState}    Set Variable    92876156325${b}${systemtime}
    ${appkey}    数据库查询_返回单值    select appkey from t_appinfo where appid='${appid}';
    ${tel}    set variable    13187802375
    ${sign}    Set Variable    ${appkey}clientIp=192.168.16.1clientState=${clientState}expandParams=key:1msisdn=${tel}operatorType=1systemTime=${systemtime}${appkey}
    ${md5}    evaluate    hashlib.md5('${sign}'.encode(encoding='utf8')).hexdigest()    hashlib
    ${md5}    Convert To Uppercase    ${md5}
    ${TNC_misiscd}    getliveparam    ${tel}    ${appkey}
    重置节点数据    $.msgReq.msgBody.systemTime=${systemtime}    $.msgReq.msgBody.clientState=${clientState}    $.msgReq.msgBody.sign=${md5}    $.msgReq.msgBody.msisdn=${TNC_misiscd} \ \    $.msgReq.msgHeader.appId=${appId}
    Set Test Variable    ${clientState}
    Set Test Variable    ${TNC_misiscd}

获取appid、preLicenseID
    ${appid}    Set Variable    100000000093
    ${preLicenseID}    数据库查询_返回单值    SELECT preLicenseID FROM T_PreLicense WHERE preLicenseID IN (SELECT preLicenseID FROM T_PreLicense4App WHERE appid='${appid}' \ and LEVEL in (SELECT min(level) FROM T_PreLicense4App WHERE appid='${appid}')) and status=0;
    Set Suite Variable    ${appid}
    Set Suite Variable    ${preLicenseID}
    [Return]    ${appid}    ${preLicenseID}

扣费记录数据库入库检查
    ${saleprice}    数据库查询_返回单值    SELECT salePrice \ FROM t_product WHERE productID \ in (SELECT productID FROM t_account4product where accountID in (select accountID FROM T_PreLicense WHERE preLicenseID IN (SELECT preLicenseID FROM T_PreLicense4App WHERE appid='${appid}' and LEVEL in (SELECT min(level) FROM T_PreLicense4App WHERE appid='${appid}')) and status ='0')) and capabilityType='5';    #获取销售品的客户售价
    ${basisPrice}    数据库查询_返回单值    SELECT basisPrice FROM t_product WHERE productID \ in (SELECT productID FROM t_account4product where accountID in (select accountID FROM T_PreLicense WHERE preLicenseID IN (SELECT preLicenseID FROM T_PreLicense4App WHERE appid='${appid}' and LEVEL in (SELECT min(level) FROM T_PreLicense4App WHERE appid='${appid}')) and status ='0')) and capabilityType='5';    #获取销售品的运营商购买价
    数据库查询_返回单值    select count(*) from t_smscode4aspirelog t where t.clientState='${clientState}' and t.isVerify='0' and t.fee='${saleprice}' and t.prefee='${basisPrice}';
    Should Be Equal As Strings    ${result}    1
    Set Test Variable    ${saleprice}
