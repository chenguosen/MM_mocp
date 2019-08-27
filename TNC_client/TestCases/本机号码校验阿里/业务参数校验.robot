*** Settings ***
Test Setup        获取appid、preLicenseID
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot
Resource          ../../KeyWords/Biz/本机号码校验业务.robot

*** Test Cases ***
appid节点不存在，校验失败，返回错误码
    读取本机号码校验请求
    删除请求节点     $.msgReq.msgHeader.appId
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007    $.msgResp.msgBody.message=请求字段验证失败

appid值为空串，校验失败，返回错误码
    读取本机号码校验请求
    更新节点数据    $.msgReq.msgHeader.appId=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007    $.msgResp.msgBody.message=请求字段验证失败

appid值为空，校验失败，返回错误码
    读取本机号码校验请求
    更新节点数据    $.msgReq.msgHeader.appId=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007    $.msgResp.msgBody.message=请求字段验证失败

appid长度超过50，校验失败，返回错误码
    读取本机号码校验请求
    更新节点数据    $.msgReq.msgHeader.appId=100000000000000000000000000000000000000000000000093
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200001    $.msgResp.msgBody.message=系统内部错误

msgType节点不存在，校验失败，返回错误码
    读取本机号码校验请求
    删除请求节点     $.msgReq.msgHeader.msgType
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007    $.msgResp.msgBody.message=请求字段验证失败
