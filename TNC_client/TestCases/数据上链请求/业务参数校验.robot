*** Settings ***
Resource          ../../KeyWords/Biz/数据上链业务.robot
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot

*** Variables ***

*** Test Cases ***
operType节点不存在，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    删除请求节点    $.busiInfo.operType
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9998    #节点不存在9998
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    校验上链交易流水    0    tid='${tid}'

operType数据类型不对，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.busiInfo.operType=1
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9998
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    校验上链交易流水    1    tid='${tid}'

operType值为负数，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    ${req_flag}.req.json
    更新节点数据    $.busiInfo.operType=(int)-1
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9998
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    校验上链交易流水    0    tid='${tid}'

operType值为空，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    ${req_flag}.req.json
    更新节点数据    $.busiInfo.operType=${None}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9998
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    校验上链交易流水    0    tid='${tid}'

operType值未定义，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    ${req_flag}.req.json
    更新节点数据    $.busiInfo.operType=(int)5
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9998
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    校验上链交易流水    0    tid='${tid}'

userId节点不存在，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    读取模板请求    commitusercredit.req.json
    删除请求节点    $.busiInfo.params.userId
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9998    #节点不存在9998
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    校验上链交易流水    0    tid='${tid}'

userId数据类型不对，校验失败，返回错误码

userId值为空串，校验失败，返回错误码

userId值为空，校验失败，返回错误码

userId值长度大于32，校验失败，返回错误码

params节点不存在，校验失败，返回错误码

credit节点不存在，校验失败，返回错误码

credit数据类型不对，校验失败，返回错误码

credit值为空串，校验失败，返回错误码

credit值为空，校验失败，返回错误码

credit值长度大于20，校验失败，返回错误码

operTime节点不存在，校验失败，返回错误码

operTime数据类型不对，校验失败，返回错误码

operTime值为空串，校验失败，返回错误码

operTime值为空，校验失败，返回错误码

operTime值格式不是YYYYMMDDHHMMSS，校验失败，返回错误码

abstr字段不存在，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    ${tran_time}    生成指定时间串
    读取模板请求    commitusercredit.req.json
    删除请求节点    $.busiInfo.params.abstr
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9997

abstr数据类型不对，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    ${tran_time}    生成指定时间串
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.busiInfo.params.abstr=(int)248
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9997

abstr值为空串，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    ${tran_time}    生成指定时间串
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.busiInfo.params.abstr=${EMPTY}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9997

abstr值为空，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    ${tran_time}    生成指定时间串
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.busiInfo.params.abstr=${None}
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9997

abstr值长度大于256，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    ${tran_time}    生成指定时间串
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.busiInfo.params.abstr=长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256长度测试256
    发送Reqx请求    /${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9997
