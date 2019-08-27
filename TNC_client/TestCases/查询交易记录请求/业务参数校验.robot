*** Settings ***
Resource          ../../KeyWords/Biz/数据上链业务.robot
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot

*** Test Cases ***
userId节点不存在，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[2]}
    读取模板请求    querystatements.req.json    #querystatements
    删除请求节点    $.busiInfo.userId
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9998    #节点不存在9998

userId数据类型不对，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[2]}
    读取模板请求    querystatements.req.json    #querystatements
    更新节点数据    $.busiInfo.userId=(int)13810011001
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9998    #节点不存在9998

userId值为空串，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[2]}
    读取模板请求    querystatements.req.json    #querystatements
    更新节点数据    $.busiInfo.userId=${EMPTY}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9998    #节点不存在9998

userId值为空，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[2]}
    读取模板请求    querystatements.req.json    #querystatements
    更新节点数据    $.busiInfo.userId=${None}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9998    #节点不存在9998

userId值长度大于32，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[2]}
    读取模板请求    querystatements.req.json    #querystatements
    更新节点数据    $.busiInfo.userId=138100110011381001100113810011001
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    9998    #节点不存在9998

beginDate节点不存在，校验失败，返回错误码

beginDate数据类型不对，校验失败，返回错误码

beginDate值为空串，校验失败，返回错误码

beginDate值为空，校验失败，返回错误码

beginDate值长度大于32，校验失败，返回错误码

endDate节点不存在，校验失败，返回错误码

endDate数据类型不对，校验失败，返回错误码

endDate值为空串，校验失败，返回错误码

endDate值为空，校验失败，返回错误码

endDate值长度大于32，校验失败，返回错误码

beginDate大于endDate，校验失败，返回错误码

beginDate非空但不符合yyyyMMdd格式，校验失败，返回错误码

endDate非空但不符合yyyyMMdd格式，校验失败，返回错误码
