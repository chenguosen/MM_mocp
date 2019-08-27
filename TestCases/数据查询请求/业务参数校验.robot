*** Test Cases ***
userId节点不存在，校验失败，返回错误码
    ${req_flag}    Set Variable    ${G_interface_names[1]}
    读取模板请求    querystatements.req.json    #querystatements
    删除请求节点    $.busiInfo.userId
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    0000    #节点不存在9998
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    获取服务器请求日志    A    ${tid}
    Comment    获取服务器应答日志    A    ${tid}
    校验请求日志内容

userId数据类型不对，校验失败，返回错误码

userId值为空串，校验失败，返回错误码

userId值为空，校验失败，返回错误码

userId值长度大于32，校验失败，返回错误码
