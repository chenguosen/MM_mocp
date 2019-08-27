*** Settings ***
Test Setup        获取appid、preLicenseID
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot
Resource          ../../KeyWords/Biz/本机号码校验业务.robot

*** Test Cases ***
信息正确，状态查询成功，扣费成功
    ${validAmount_start}    ${validAmount_DB_start}    读取请求前的预授权余额
    读取本机号码校验请求
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=0    $.msgResp.msgBody.isVerify=0
    ${validAmount_end}    ${validAmount_DB_end}    读取请求后的预授权余额
    扣费记录数据库入库检查
    扣费成功redis预授权余额检查
