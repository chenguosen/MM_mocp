*** Settings ***
Resource          ../../KeyWords/Biz/交易结果查询业务.robot
Resource          ../../KeyWords/Biz/准备测试环境.robot

*** Test Cases ***
tid节点不存在，校验失败，返回错误码
    读取交易结果查询请求
    删除请求节点    $.busiInfo.tid
    发送交易查询请求
    校验应答字段值    $.pubInfo.code=1102

tid数据类型不对，校验失败，返回错误码
    读取交易结果查询请求
    更新节点数据    $.busiInfo.tid=(int)1999
    发送交易查询请求
    校验应答字段值    $.busiInfo=${None}    $.pubInfo.code=9999

tid值为空串，校验失败，返回错误码
    读取交易结果查询请求
    更新节点数据    $.busiInfo.tid=${EMPTY}
    发送交易查询请求
    校验应答字段值    $.busiInfo=${None}    $.pubInfo.code=9999

tid值为空，校验失败，返回错误码
    读取交易结果查询请求
    更新节点数据    $.busiInfo.tid=${None}
    发送交易查询请求
    校验应答字段值    $.busiInfo=${None}    $.pubInfo.code=9999

tid值长度大于32，校验失败，返回错误码
    ${req_time}    生成指定时间串
    ${Ra}    Evaluate    random.randint(10000000000,19999999999)    random
    ${Rb}    Evaluate    random.randint(20000000000,29999999999)    random
    读取交易结果查询请求
    更新节点数据    $.busiInfo.tid=${Ra}-${req_time}-${Rb}
    发送交易查询请求
    校验应答字段值    $.busiInfo=${None}    $.pubInfo.code=9999

tid节点不存在，校验失败，返回错误码1
    读取交易结果查询请求
    log    ${reqx}

555
    ${a}    Set Variable     pbbNo7zKBEc9NXzBymGavw==
    log    ${a}
    log

tid节点不存在，校验失败，返回错误码2
    读取交易结果查询请求
    删除请求节点    $.busiInfo.tid    $.pubInfo.tid    $.pubInfo.appId
    发送交易查询请求
    校验应答字段值    $.pubInfo.code=1102    $.pubInfo.msg=黑名单限制

tid数据类型不对，校验失败，返回错误码2
    读取交易结果查询请求
    更新节点数据    $.busiInfo.tid=(int)1999
    发送交易查询请求
    校验应答字段值    $.pubInfo.code=1102    $.pubInfo.msg=黑名单限制

666
    校验Http响应状态码    200
    ${resultmsg}    Get From Dictionary    ${G_ResultCode}    9999
    校验Http响应字段值    $.pubInfo.code=${resultcode}    $.pubInfo.msg=${resultmsg}
    ${respTime}    获取返回包字段值    $.pubInfo.rspTime
    Comment    Length Should Be    ${respTime}    14
    Comment    ${respTime}    Convert Date    ${respTime}
    Comment    校验字符串时间偏差    ${respTime}    120

get localhost ip
    ${localhost}    get host ip
    log    ${localhost}
