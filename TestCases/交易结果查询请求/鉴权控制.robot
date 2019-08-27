*** Settings ***
Suite Teardown    初始化IP等测试数据
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot
Resource          ../../KeyWords/Biz/准备测试环境.robot
Resource          ../../KeyWords/Biz/交易结果查询业务.robot

*** Test Cases ***
IP在缓存中无，数据库中有且允许，交易结果查询成功且加入缓存
    ${localhost}    get host ip
    ${expect_iptype}    Set Variable    1
    删除key    ${localhost}
    鉴权删除IP数据    ${localhost}
    鉴权插入IP数据    ${localhost}    ${expect_iptype}
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}
    校验应答返回码信息    0000
    校验上链交易流水    1    tid='${tid}'
    ${iptype}    根据key取String    ${localhost}
    Should Be Equal As Strings    ${expect_iptype}    ${iptype}

IP在缓存中无，数据库中有且禁止，交易结果查询请求失败且加入缓存
    ${localhost}    get host ip
    ${expect_iptype}    Set Variable    2
    删除key    ${localhost}
    鉴权删除IP数据    ${localhost}
    鉴权插入IP数据    ${localhost}    ${expect_iptype}
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}
    校验应答返回码信息    1102
    校验上链交易流水    0    tid='${tid}'
    ${iptype}    根据key取String    ${localhost}
    Should Be Equal As Strings    ${expect_iptype}    ${iptype}

IP在缓存中有，数据库中有且允许，交易结果查询请求成功
    ${localhost}    get host ip
    ${expect_iptype}    Set Variable    1
    删除key    ${localhost}
    鉴权删除IP数据    ${localhost}
    鉴权插入IP数据    ${localhost}    ${expect_iptype}
    写String    ${localhost}    ${expect_iptype}
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}
    校验应答返回码信息    0000
    校验上链交易流水    1    tid='${tid}'
    ${iptype}    根据key取String    ${localhost}
    Should Be Equal As Strings    ${expect_iptype}    ${iptype}

IP在缓存中有，数据库中有且禁止，交易结果查询请求失败
    ${localhost}    get host ip
    ${expect_iptype}    Set Variable    2
    删除key    ${localhost}
    鉴权删除IP数据    ${localhost}
    鉴权插入IP数据    ${localhost}    ${expect_iptype}
    写String    ${localhost}    ${expect_iptype}
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}
    校验应答返回码信息    1102
    校验上链交易流水    0    tid='${tid}'
    ${iptype}    根据key取String    ${localhost}
    Should Be Equal As Strings    ${expect_iptype}    ${iptype}

IP在缓存中无，数据库中无，交易结果查询请求失败
    ${localhost}    get host ip
    ${expect_iptype}    Set Variable    ${None}
    删除key    ${localhost}
    鉴权删除IP数据    ${localhost}
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}
    校验应答返回码信息    1102
    校验上链交易流水    0    tid='${tid}'
    ${iptype}    根据key取String    ${localhost}
    Should Be Equal As Strings    ${expect_iptype}    ${iptype}

APP在缓存中无，数据库中有，交易结果查询请求成功加入缓存
    ${localhost}    get host ip
    ${expect_iptype}    Set Variable    1
    删除key    ${localhost}
    鉴权删除IP数据    ${localhost}
    鉴权插入IP数据    ${localhost}    ${expect_iptype}
    ${appid}    Set Variable    101305
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${appid}
    鉴权删除APP数据    ${appid}
    鉴权插入APP数据    ${appid}
    删除key    ${appid}
    ${tran_time}    生成指定时间串
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.appId=${appid}
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    ${reqTime}    获取请求某字段数据    $.pubInfo.reqTime
    重新计算签名值    ${appid}    ${reqTime}    ${tid}    ${app_secret}
    发送Reqx请求    /${req_flag}
    Comment    校验应答返回码信息    0000
    校验上链交易流水    1    tid='${tid}'
    ${redis_secret}    根据key取String    ${appid}
    Should Be Equal As Strings    ${app_secret}    ${redis_secret}

APP在缓存中有，数据库中有，交易结果查询请求成功
    ${localhost}    get host ip
    ${expect_iptype}    Set Variable    1
    删除key    ${localhost}
    鉴权删除IP数据    ${localhost}
    鉴权插入IP数据    ${localhost}    ${expect_iptype}
    ${appid}    Set Variable    101305
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${appid}
    鉴权删除APP数据    ${appid}
    鉴权插入APP数据    ${appid}
    删除key    ${appid}
    写String    ${appid}    ${app_secret}
    ${tran_time}    生成指定时间串
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.appId=${appid}
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    ${reqTime}    获取请求某字段数据    $.pubInfo.reqTime
    重新计算签名值    ${appid}    ${reqTime}    ${tid}    ${app_secret}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    0000
    校验上链交易流水    1    tid='${tid}'
    ${redis_secret}    根据key取String    ${appid}
    Should Be Equal As Strings    ${app_secret}    ${redis_secret}

APP在缓存中无，数据库中无，交易结果查询请求失败
    ${localhost}    get host ip
    ${expect_iptype}    Set Variable    1
    删除key    ${localhost}
    鉴权删除IP数据    ${localhost}
    鉴权插入IP数据    ${localhost}    ${expect_iptype}
    ${appid}    Set Variable    101305
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    ${appid}
    鉴权删除APP数据    ${appid}
    删除key    ${appid}
    ${tran_time}    生成指定时间串
    ${req_flag}    Set Variable    ${G_interface_names[0]}
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    读取模板请求    commitusercredit.req.json
    更新节点数据    $.pubInfo.appId=${appid}
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    ${reqTime}    获取请求某字段数据    $.pubInfo.reqTime
    重新计算签名值    ${appid}    ${reqTime}    ${tid}    ${app_secret}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    1101
    校验上链交易流水    0    tid='${tid}'
    ${redis_secret}    根据key取String    ${appid}
    Should Be Equal As Strings    ${None}    ${redis_secret}
