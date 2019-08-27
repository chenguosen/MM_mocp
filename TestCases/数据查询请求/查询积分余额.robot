*** Settings ***
Resource          ../../KeyWords/Biz/数据查询业务.robot
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot
Resource          ../../KeyWords/Biz/准备测试环境.robot

*** Test Cases ***
用户未开户查询余额，返回失败信息
    ${req_flag}    Set Variable    ${G_interface_names[1]}
    读取模板请求    ${req_flag}.req.json    #querystatements
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${Rb}    Evaluate    random.randint(10000000,19999999)    random
    ${req_time}    生成指定时间串
    ${uid}    Set Variable    ${Ra}-${req_time}-${Rb}
    更新节点数据    $.busiInfo.params.userId=${uid}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    0000    #节点不存在9998
    校验应答字段值    $.busiInfo.params.userId=${EMPTY}    $.busiInfo.params.credit=0

用户已开户余额为0，查询成功，余额为0
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=0
    #获取回调的请求消息,延时确保回调被发起
    Sleep    5
    Comment    校验链上用户余额    ${uid}    0
    ${orgUid}    Set Variable    ${uid}
    读取数据查询请求    $.busiInfo.params.userId=${orgUid}
    发送数据查询请求
    校验应答返回码信息    0000    #节点不存在9998
    校验数据查询结果    $.busiInfo.params.userId=${orgUid}    $.busiInfo.params.credit=0

用户已开户余额为正常，查询成功，余额与链上一致
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Evaluate    random.randint(20,50)    random
    ${credit}    Evaluate    ${credit1}-${credit2}
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    #获取回调的请求消息,延时确保回调被发起
    Sleep    5
    Comment    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    Sleep    5
    Comment    校验链上用户余额    ${uid}    ${credit}
    ${orgUid}    Set Variable    ${uid}
    读取数据查询请求    $.busiInfo.params.userId=${orgUid}
    发送数据查询请求
    校验应答返回码信息    0000    #节点不存在9998
    校验数据查询结果    $.busiInfo.params.userId=${orgUid}    $.busiInfo.params.credit=${credit}

用户已开户余额为20位，查询成功，余额与链上一致
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit}    Set Variable    999999999999999999
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit}
    #获取回调的请求消息,延时确保回调被发起
    Sleep    5
    校验链上用户余额    ${uid}    ${credit}
    ${orgUid}    Set Variable    ${uid}
    读取数据查询请求    $.busiInfo.params.userId=${orgUid}
    发送数据查询请求
    校验应答返回码信息    0000    #节点不存在9998
    校验数据查询结果    $.busiInfo.params.userId=${orgUid}    $.busiInfo.params.credit=${credit}

用户在A点开户，在B点查询成功，余额与链上一致
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Evaluate    random.randint(20,50)    random
    ${credit}    Evaluate    ${credit1}-${credit2}
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    #获取回调的请求消息,延时确保回调被发起
    Sleep    5
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}    A
    Sleep    5
    校验链上用户余额    ${uid}    ${credit}
    ${orgUid}    Set Variable    ${uid}
    读取数据查询请求    $.busiInfo.params.userId=${orgUid}
    发送数据查询请求    B
    校验应答返回码信息    0000
    校验数据查询结果    $.busiInfo.params.userId=${orgUid}    $.busiInfo.params.credit=${credit}

用户充值未回调网关，查询成功，余额与链上一致
    #同步模式，无法控制网关
