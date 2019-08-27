*** Settings ***
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot
Resource          ../../KeyWords/Biz/卓信通短信获取.robot
Resource          ../../KeyWords/Pub/JsonObjLib.robot
Resource          ../../Resources/Global_Variable.robot

*** Test Cases ***
appid节点不存在，校验失败，返回错误码
    读取卓信通短信消息模板
    删除请求节点    $.msgReq.msgHeader.appId
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007    $.msgResp.msgBody.message=请求字段验证失败

appid值为空串，校验失败，返回错误码
    读取卓信通短信消息模板
    更新节点数据    $.msgReq.msgHeader.appId=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    log    ${resp}
    校验应答字段值    $.msgResp.msgBody.result=200007    $.msgResp.msgBody.message=请求字段验证失败

appid值为空，校验失败，返回错误码
    读取卓信通短信消息模板
    更新节点数据    $.msgReq.msgHeader.appId=${None}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    log    ${resp}
    校验应答字段值    $.msgResp.msgBody.result=200007    $.msgResp.msgBody.message=请求字段验证失败

appid数据类型不对，校验失败，返回错误码
    读取卓信通短信消息模板
    更新节点数据    $.msgReq.msgHeader.appId=(int)100000000093
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    log    ${resp}
    校验应答字段值    $.msgResp.msgBody.result=400005    $.msgResp.msgBody.message=短信平台请求错误

appid长度超过50，校验失败，返回错误码
    读取卓信通短信消息模板
    更新节点数据    $.msgReq.msgHeader.appId=100000000000000000000000000000000000000000000000093
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    log    ${resp}
    校验应答字段值    $.msgResp.msgBody.result=200001    $.msgResp.msgBody.message=系统内部错误
