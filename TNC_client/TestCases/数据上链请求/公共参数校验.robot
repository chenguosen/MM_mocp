*** Settings ***
Resource          ../../KeyWords/Biz/数据上链业务.robot
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot
Resource          ../../KeyWords/Biz/准备测试环境.robot

*** Test Cases ***
pubInfo节点不存在，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    删除请求节点    $.pubInfo
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    1102

appId节点不存在，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    删除请求节点    $.pubInfo.appId
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    1101

appId数据类型不正确，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.appId=(int)104567
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9998

appId值是空串，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.appId=${EMPTY}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    1101

appId值为空，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.appId=${None}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    1101

appId值长度大于32，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.appId=1234567890123456789012345678901234567890
    log    ${reqx}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    1101

reqTime节点不存在，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    删除请求节点    $.pubInfo.reqTime
    ${app_key}    获取请求某字段数据    $.pubInfo.appId
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    重新计算签名值    ${app_key}    ${EMPTY}    ${tid}    ${app_secret}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9005

reqTime数据类型不正确，校验失败，返回错误码
    ${reqTime}    生成指定时间串    0
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.reqTime=(int)${reqTime}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9998

reqTime值是空串，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.reqTime=${EMPTY}
    ${app_key}    获取请求某字段数据    $.pubInfo.appId
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    重新计算签名值    ${app_key}    ${EMPTY}    ${tid}    ${app_secret}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9001

reqTime值为空，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.reqTime=${None}
    ${app_key}    获取请求某字段数据    $.pubInfo.appId
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    重新计算签名值    ${app_key}    ${EMPTY}    ${tid}    ${app_secret}
    更新节点数据    $.pubInfo.reqTime=${None}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9005

reqTime值格式不是YYYYMMDDHHMMSS，校验失败，返回错误码
    ${reqTime}    生成指定时间串    0    %Y-%m-%d %H:%M:%S
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.reqTime=${reqTime}
    ${app_key}    获取请求某字段数据    $.pubInfo.appId
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    重新计算签名值    ${app_key}    ${reqTime}    ${tid}    ${app_secret}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9001

ver节点不存在，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    删除请求节点    $.pubInfo.ver
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9002

ver数据类型不正确，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.ver=(int)1
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9998

ver值是空串，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.ver=${EMPTY}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9002

ver值为空，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.ver=${None}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9002

ver值长度大于6，不校验，匹配失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.ver=1011021
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9999

ver值不是1.0，不校验匹配失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.ver=2.0
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9999

tid节点不存在，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    删除请求节点    $.pubInfo.tid
    ${app_key}    获取请求某字段数据    $.pubInfo.appId
    ${reqTime}    获取请求某字段数据    $.pubInfo.reqTime
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    重新计算签名值    ${app_key}    ${reqTime}    ${EMPTY}    ${app_secret}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9005

tid数据类型不正确，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.tid=(int)999999999
    ${app_key}    获取请求某字段数据    $.pubInfo.appId
    ${reqTime}    获取请求某字段数据    $.pubInfo.reqTime
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    重新计算签名值    ${app_key}    ${reqTime}    999999999    ${app_secret}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9003

tid值是空串，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.tid=${EMPTY}
    ${app_key}    获取请求某字段数据    $.pubInfo.appId
    ${reqTime}    获取请求某字段数据    $.pubInfo.reqTime
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    重新计算签名值    ${app_key}    ${reqTime}    ${EMPTY}    ${app_secret}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9998

tid值为空，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.tid=${None}
    ${app_key}    获取请求某字段数据    $.pubInfo.appId
    ${reqTime}    获取请求某字段数据    $.pubInfo.reqTime
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    重新计算签名值    ${app_key}    ${reqTime}    ${EMPTY}    ${app_secret}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9005

tid值已存在，校验失败，返回错误码
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}
    校验上链交易流水    1    tid='${tid}'    oper_type=1    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000    #节点不存在9998
    #获取回调的请求消息,延时确保回调被发起
    ${credit}    获取请求某字段数据    $.busiInfo.params.credit
    Sleep    ${G_Chain_Delay}
    ${chainCode}    Set Variable    0000
    ${chainmsg}    Get From Dictionary    ${G_Chain_Code}    ${chainCode}
    校验数据库上链结果    ${tid}    1    ${chainCode}    ${chainmsg}
    ${reqTime}    生成指定时间串
    更新节点数据    $.pubInfo.reqTime=${reqTime}    $.busiInfo.params.userId=NEWID${reqTime}
    ${app_key}    获取请求某字段数据    $.pubInfo.appId
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    重新计算签名值    ${app_key}    ${reqTime}    ${tid}    ${app_secret}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9999

sign节点不存在，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    删除请求节点    $.pubInfo.sign
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9005

sign数据类型不正确，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.sign=(int)1234
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9005

sign值是空串，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.sign=${EMPTY}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9005

sign值为空，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.sign=${None}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9005

sign值不等于MD5(appId+reqTime+tid+appSecret)，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    ${reqTime}    获取请求某字段数据    $.pubInfo.reqTime
    ${app_key}    获取请求某字段数据    $.pubInfo.appId
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    重新计算签名值    ${app_key}    ${reqTime}    ${tid}    +${app_secret}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9005

cbUrl值长度大于256，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.cbUrl=http://10.1.31.103:8088/common/xxadfadafdafaf/adfsdfasdfa/adfadfadfa/adafdafaf/adafdadf/adfadfad/adf/adfsdfasdfa/adfadfadfa/adafdafaf/adafdadf/adfadfad/adf/common/xxadfadafdafaf/adfsdfasdfa/adfadfadfa/adafdafaf/adafdadf/adfadfad/adf/adfsdfasdfa/adfadfadfa/adafdafaf/adafdadf/adfadfad/adf
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9999    #链上已经成功了

请求时间与当前时间差超过10分钟，校验失败，返回错误应答码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    ${reqTime}    生成指定时间串    12 minute
    更新节点数据    $.pubInfo.reqTime=${reqTime}
    ${app_key}    获取请求某字段数据    $.pubInfo.appId
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${app_key}
    重新计算签名值    ${app_key}    ${reqTime}    ${tid}    ${app_secret}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'    oper_type=1    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    9001

operTime与当前时间差超过10分钟，不校验operTime
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    ${operTime}    生成指定时间串    12 minute
    更新节点数据    $.busiInfo.params.operTime=${operTime}
    ${uid}    获取请求某字段数据    $.busiInfo.params.userId
    发送Reqx请求    /${req_flag}
    校验上链交易流水    1    tid='${tid}'    oper_type=1    user_id='${uid}'
    校验应答返回码信息    0000
