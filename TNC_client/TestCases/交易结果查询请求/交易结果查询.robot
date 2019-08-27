*** Settings ***
Resource          ../../KeyWords/Biz/交易结果查询业务.robot
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot
Resource          ../../KeyWords/Biz/准备测试环境.robot

*** Test Cases ***
tid对应业务不存在，查询失败，返回空信息
    ${req_flag}    Set Variable    ${G_interface_names[2]}
    读取模板请求    ${req_flag}.req.json    #querystatements
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    0000
    校验交易结果信息    9999

查询开户业务，业务已处理完成，查询成功，返回交易信息
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.credit=${credit1}
    #获取回调的请求消息,延时确保回调被发起
    Sleep    5
    校验链上用户余额    ${uid}    ${credit1}
    ${orgTid}    Set Variable    ${tid}
    读取交易结果查询请求    $.busiInfo.tid=${orgTid}
    发送交易查询请求
    校验应答返回码信息    0000    #节点不存在9998
    校验交易结果信息    0000

查询开户业务，业务未处理完成，查询成功，返回无交易信息
    #场景存在，但不具有测试性

查询消费业务，业务已处理完成，查询成功，返回交易信息
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Evaluate    random.randint(20,50)    random
    ${credit}    Evaluate    ${credit1}-${credit2}
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.credit=${credit1}
    #获取回调的请求消息,延时确保回调被发起
    Sleep    5
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    Sleep    5
    校验链上用户余额    ${uid}    ${credit}
    ${orgTid}    Set Variable    ${tid}
    读取交易结果查询请求    $.busiInfo.tid=${orgTid}
    发送交易查询请求
    校验应答返回码信息    0000    #节点不存在9998
    校验交易结果信息    0000

查询消费业务，业务未处理完成，查询成功，返回无交易信息
    #场景存在，但不具有测试性

查询充值业务，业务已处理完成，查询成功，返回交易信息
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Evaluate    random.randint(20,50)    random
    ${credit}    Evaluate    ${credit1}+${credit2}
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.credit=${credit1}
    #获取回调的请求消息,延时确保回调被发起
    Sleep    5
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)2    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    Sleep    5
    校验链上用户余额    ${uid}    ${credit}
    ${orgTid}    Set Variable    ${tid}
    读取交易结果查询请求    $.busiInfo.tid=${orgTid}
    发送交易查询请求
    校验应答返回码信息    0000    #节点不存在9998
    校验交易结果信息    0000

查询充值业务，业务未处理完成，查询成功，返回无交易信息
    #场景存在，但不具有测试性

交易在A节点完成，在B节点查询交易结果，查询成功，返回交易信息
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.credit=${credit1}
    #获取回调的请求消息,延时确保回调被发起
    Sleep    5
    校验链上用户余额    ${uid}    ${credit1}
    ${orgTid}    Set Variable    ${tid}
    读取交易结果查询请求    $.busiInfo.tid=${orgTid}
    发送交易查询请求    B
    校验应答返回码信息    0000    #节点不存在9998
    校验交易结果信息    0000

查询未开户直接消费，业务已处理完成，查询成功，返回交易失败信息
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    新用户正常开户    0    $.busiInfo.operType=(int)3    $.busiInfo.params.credit=${credit1}
    #获取回调的请求消息,延时确保回调被发起
    Sleep    5
    校验链上用户余额    ${uid}    0
    ${orgTid}    Set Variable    ${tid}
    读取交易结果查询请求    $.busiInfo.tid=${orgTid}
    发送交易查询请求
    校验应答返回码信息    0000    #节点不存在9998
    校验交易结果信息    0001

查询未开户直接充值，业务已处理完成，查询成功，返回交易失败信息
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    新用户正常开户    0    $.busiInfo.operType=(int)2    $.busiInfo.params.credit=${credit1}
    #获取回调的请求消息,延时确保回调被发起
    Sleep    5
    Comment    校验链上用户余额    ${uid}    0
    ${orgTid}    Set Variable    ${tid}
    读取交易结果查询请求    $.busiInfo.tid=${orgTid}
    发送交易查询请求
    校验应答返回码信息    0000    #节点不存在9998
    校验交易结果信息    0001
