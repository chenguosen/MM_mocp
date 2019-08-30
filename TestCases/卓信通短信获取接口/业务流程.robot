*** Settings ***
Test Setup        获取appid、preLicenseID
Test Teardown
Resource          ../../KeyWords/Biz/卓信通短信获取业务.robot
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot

*** Test Cases ***
信息正确，状态查询成功，扣费成功
    ${validAmount_start}    ${validAmount_DB_start}    读取请求前的预授权余额
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=0    $.msgResp.msgBody.message=成功
    ${validAmount_end}    ${validAmount_DB_end}    读取请求后的预授权余额
    扣费记录数据库入库检查
    扣费成功redis预授权余额检查
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

redis里key不存在，返回错误码
    ${c}    根据key取String    KEY_PRELICENSE_BALANCE_${preLicenseID}
    删除key    KEY_PRELICENSE_BALANCE_${preLicenseID}
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=300203
    写String    KEY_PRELICENSE_BALANCE_${preLicenseID }    ${c}    #恢复缓存数据
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

预授权余额=阀值+单价+0.1厘，扣费成功
    ${validAmount_start}    ${validAmount_DB_start}    读取请求前的预授权余额
    删除key    KEY_PRELICENSE_BALANCE_${preLicenseID}
    ${saleprice}    获取销售品的客户售单价    ${appid}    5    #5，短信验证能力
    ${validAmount}    Evaluate    ${saleprice}+500000+1    #阀值为500000
    写String    KEY_PRELICENSE_BALANCE_${preLicenseID }    ${validAmount}    #准备数据
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=0
    ${validAmount_end}    ${validAmount_DB_end}    读取请求后的预授权余额
    ${value}    Evaluate    ${validAmount}-${validAmount_end}
    Run Keyword And Continue On Failure    Should Be Equal As Strings    ${value}    ${saleprice}
    ${c}    Evaluate    ${validAmount_start}-${saleprice}
    恢复预授权缓存数据    ${c}
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

预授权余额=阀值+单价，扣费失败，返回错误码
    ${validAmount_start}    ${validAmount_DB_start}    读取请求前的预授权余额
    删除key    KEY_PRELICENSE_BALANCE_${preLicenseID}
    ${saleprice}    获取销售品的客户售单价    ${appid}    5    #5，短信验证能力
    ${validAmount}    Evaluate    ${saleprice}+500000    #阀值为500000
    写String    KEY_PRELICENSE_BALANCE_${preLicenseID }    ${validAmount}    #准备数据
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=300105
    ${validAmount_end}    ${validAmount_DB_end}    读取请求后的预授权余额
    ${value}    Evaluate    ${validAmount}-${validAmount_end}
    Should Be Equal As Strings    ${value}    0
    恢复预授权缓存数据    ${validAmount_start}
    恢复预授权和应用关联关系
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

预授权余额=阀值+单价-0.1厘，扣费失败，返回错误码
    ${validAmount_start}    ${validAmount_DB_start}    读取请求前的预授权余额
    删除key    KEY_PRELICENSE_BALANCE_${preLicenseID}
    ${saleprice}    获取销售品的客户售单价    ${appid}    5    #5，短信验证能力
    ${validAmount}    Evaluate    ${saleprice}+500000-1    #阀值为500000
    写String    KEY_PRELICENSE_BALANCE_${preLicenseID }    ${validAmount}    #准备数据
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=300105
    ${validAmount_end}    ${validAmount_DB_end}    读取请求后的预授权余额
    ${value}    Evaluate    ${validAmount}-${validAmount_end}
    Should Be Equal As Strings    ${value}    0
    恢复预授权缓存数据    ${validAmount_start}
    恢复预授权和应用关联关系
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

IP在缓存中无，数据库中有，鉴权失败，返回错误码
    ${localhost}    get host ip
    ${spCode}    数据库查询_返回单值    select spCode from t_appinfo where appid='${appid}';
    数据库执行sql语句(非查询)    DELETE from T_CompIP where spCode in (select spCode from t_appinfo where appid='${appid}') \ and ipaddress='${localhost}';    #数据库中删除IP白名单
    数据库执行sql语句(非查询)    INSERT INTO T_CompIP (`spCode`, `IPAddress`, `createTime`, `createUser`, `updateTime`, `updateUser`, `IPType`, `dataType`, `IPAddressEnd`) VALUES ('${spCode}', '${localhost}', '2019-07-26 14:23:31', NULL, NULL, '-999', NULL, NULL, NULL);    #数据库中插入IP白名单
    删除集合一个值    KEY_WHITE_IP_SET_${spCode}    "${localhost}"    #删除redisIP白名单
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200011
    向集合写一个值    KEY_WHITE_IP_SET_${spCode}    "${localhost}"    #redis添加IP白名单
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

IP在缓存中无，数据库中无，鉴权失败，返回错误码
    ${localhost}    get host ip
    ${spCode}    数据库查询_返回单值    select spCode from t_appinfo where appid='${appid}';
    数据库执行sql语句(非查询)    DELETE from T_CompIP where spCode in (select spCode from t_appinfo where appid='${appid}') \ and ipaddress='${localhost}';    #数据库中删除IP白名单
    删除集合一个值    KEY_WHITE_IP_SET_${spCode}    "${localhost}"    #删除redisIP白名单
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200011
    向集合写一个值    KEY_WHITE_IP_SET_${spCode}    "${localhost}"    #redis添加IP白名单
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

clientState请求重复，校验失败，返回错误码
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=0
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200005
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

appid不存在，校验失败，返回错误码
    读取卓信通短信消息模板
    重置节点数据    $.msgReq.msgHeader.appId=900000000285
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=300101
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

应用状态为待审批，校验失败，返回错误码
    ${app_info}    根据key取String    KEY_APP_INFO_${appid}
    ${app_info_new}    Replace String    ${app_info}    :4,    :1,
    写String    KEY_APP_INFO_${appid}    ${app_info_new}
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=300103
    写String    KEY_APP_INFO_${appid}    ${app_info}    #恢复reids数据
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

应用状态为草稿，校验失败，返回错误码
    ${app_info}    根据key取String    KEY_APP_INFO_${appid}
    ${app_info_new}    Replace String    ${app_info}    :4,    :2,
    写String    KEY_APP_INFO_${appid}    ${app_info_new}
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=300103
    写String    KEY_APP_INFO_${appid}    ${app_info}    #恢复reids数据
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

应用状态为配置完成，校验失败，返回错误码
    ${app_info}    根据key取String    KEY_APP_INFO_${appid}
    ${app_info_new}    Replace String    ${app_info}    :4,    :3,
    写String    KEY_APP_INFO_${appid}    ${app_info_new}
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=300103
    写String    KEY_APP_INFO_${appid}    ${app_info}    #恢复reids数据
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

应用状态为已驳回，校验失败，返回错误码
    ${app_info}    根据key取String    KEY_APP_INFO_${appid}
    ${app_info_new}    Replace String    ${app_info}    :4,    :5,
    写String    KEY_APP_INFO_${appid}    ${app_info_new}
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=300103
    写String    KEY_APP_INFO_${appid}    ${app_info}    #恢复reids数据
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

签名错误，请求签名验证失败，返回错误码
    读取卓信通短信消息模板
    重置节点数据    $.msgReq.msgBody.sign=1234567890
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200006
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

预授权的运营商丢失，校验失败，返回错误码
    删除key    KEY_PRELICENSE_PROVIDER_500
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=300204    $.msgResp.msgBody.message=该预授权的能力提供方没有对应的供应商信息
    Server发送Reqx请求    /web/tnc/server/redis/syncProvider
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375

同一应用、手机号码10秒内不能重复请求
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=0    $.msgResp.msgBody.message=成功
    读取卓信通短信消息模板
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200013    $.msgResp.msgBody.message=同一app的短信号码提交重复
    sleep    11    #同一个应用、手机号测试环境限制10内不能重复请求，现网配置120秒KEY_REPEATED_MOBILE_VALID_100000000093_13187802375
