*** Settings ***
Test Setup        获取appid、preLicenseID
Resource          ../../KeyWords/Biz/手机号在网状态查询业务.robot
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot

*** Test Cases ***
appid节点不存在，校验失败，返回错误码
    读取手机号在网状态查询模板
    删除请求节点    $.msgReq.msgHeader.appId
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

appid值为空串，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgHeader.appId=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

appid值为空，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgHeader.appId=${None}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

appid长度超过50，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgHeader.appId=100000000000000000000000000000000000000000000000093
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200001

msgType节点不存在，校验失败，返回错误码
    读取手机号在网状态查询模板
    删除请求节点    $.msgReq.msgHeader.msgType
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

msgType值为空串，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgHeader.msgType=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

msgType值为空，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgHeader.msgType=${None}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

version节点不存在，校验失败，返回错误码
    读取手机号在网状态查询模板
    删除请求节点    $.msgReq.msgHeader.version
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

version值为空串，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgHeader.version=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

version值为空，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgHeader.version=${None}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

appType节点不存在，非必填项，不做校验
    读取手机号在网状态查询模板
    删除请求节点    $.msgReq.msgHeader.appType
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=0

appType值为空串，非必填项，不做校验
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgHeader.appType=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=0

appType值为空，非必填项，不做校验
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgHeader.appType=${None}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=0

systemTime节点不存在，校验失败，返回错误码
    读取手机号在网状态查询模板
    删除请求节点    $.msgReq.msgBody.systemTime
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

systemTime值为空串，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.systemTime=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

systemTime值为空，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.systemTime=${None}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

clientIp节点不存在，校验失败，返回错误码
    读取手机号在网状态查询模板
    删除请求节点    $.msgReq.msgBody.clientIp
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200006

clientIp值为空串，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.clientIp=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200006

clientIp值为空，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.clientIp=${None}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200006

operatorType节点不存在，校验失败，返回错误码
    读取手机号在网状态查询模板
    删除请求节点    $.msgReq.msgBody.operatorType
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200006

operatorType值为空串，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.operatorType=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200006

operatorType值为空，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.operatorType=${None}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200006

msisdn节点不存在，校验失败，返回错误码
    读取手机号在网状态查询模板
    删除请求节点    $.msgReq.msgBody.msisdn
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

msisdn值为空串，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.msisdn=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

msisdn值为空，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.msisdn=${None}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

clientState节点不存在，校验失败，返回错误码
    读取手机号在网状态查询模板
    删除请求节点    $.msgReq.msgBody.clientState
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

clientState值为空串，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.clientState=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

clientState值为空，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.clientState=${None}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

expandParams节点不存在，校验失败，返回错误码
    读取手机号在网状态查询模板
    删除请求节点    $.msgReq.msgBody.expandParams
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200006

expandParams值为空串，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.expandParams=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200006

expandParams值为空，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.expandParams=${None}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200006

sign节点不存在，校验失败，返回错误码
    读取手机号在网状态查询模板
    删除请求节点    $.msgReq.msgBody.sign
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

sign值为空串，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.sign=${EMPTY}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007

sign值为空，校验失败，返回错误码
    读取手机号在网状态查询模板
    更新节点数据    $.msgReq.msgBody.sign=${None}
    TNC发送Reqx请求    /tnc/client/threeFuse/${req_flag}
    校验应答字段值    $.msgResp.msgBody.result=200007
