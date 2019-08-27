*** Settings ***
Resource          ../../KeyWords/Biz/server端同步查询接口.robot
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot

*** Test Cases ***
预授权供应商查询接口,数据库、redis、消息响应数据一致
    读取空消息体
    Server发送Reqx请求    /web/tnc/server/redis/findProvider
    校验应答字段值    $.msg=成功    $.code=0000
    校验消息体和reids缓存一致

预授权供应商同步接口，删除redis数据，接口同步数据成功
    ${num}    数据库查询_返回单值    select count(*) from t_PROVIDER;    #数据库供应商数量
    ${result}    数据库查询_返回单值    select ID from t_PROVIDER ORDER BY ID;
    : FOR    ${n}    IN RANGE    ${num}
    \    ${a}    BuiltIn.Convert To String    @{queryResults[${n}]}
    \    删除key    KEY_PRELICENSE_PROVIDER_${a}
    \    读取空消息体
    \    Server发送Reqx请求    /web/tnc/server/redis/syncProvider    #触发同步接口
    \    校验应答字段值    $.msg=成功    $.code=0000
    \    ${redis_value}    根据key取String    KEY_PRELICENSE_PROVIDER_${a}    #reids中的供应商信息
