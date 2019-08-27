*** Settings ***
Resource          ../../KeyWords/Biz/数据上链业务.robot
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot
Resource          ../../KeyWords/Biz/准备测试环境.robot

*** Test Cases ***
用户未开户，消费数据正常，消费失败
    新用户正常开户    0    $.busiInfo.operType=(int)3
    校验应答返回码信息    0000
    ${tid}    获取请求某字段数据    $.pubInfo.tid
    校验上链交易流水    1    tid='${tid}'    #交易状态不正确，下一个版本修改

用户已开户，消费数据正常，消费成功
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Evaluate    random.randint(20,50)    random
    ${credit}    Evaluate    ${credit1}-${credit2}
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    校验上链交易流水    1    tid='${tid}'    oper_type=3    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000
    Sleep    ${G_Chain_Delay}
    校验链上用户余额    ${uid}    ${credit}
    获取回调请求数据    ${ctrlUri}
    校验回调请求参数    0000

用户已开户，积分值为0，消费成功
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Evaluate    0
    ${credit}    Evaluate    ${credit1}-${credit2}
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    校验上链交易流水    1    tid='${tid}'    oper_type=3    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000
    Sleep    ${G_Chain_Delay}
    校验链上用户余额    ${uid}    ${credit}
    获取回调请求数据    ${ctrlUri}
    校验回调请求参数    0000

用户已开户，积分值为负值，消费失败
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Evaluate    -10
    ${credit}    Evaluate    ${credit1}-${credit2}
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9997

用户已开户，积分值带字母，消费失败
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Set Variable    C10
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9997

用户已开户，积分值是小数，消费失败
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Evaluate    3.45
    ${credit}    Evaluate    ${credit1}-${credit2}
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9997

用户已开户，积分值大于用户余额，消费失败
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(10,30)    random
    ${credit2}    Evaluate    random.randint(60,500)    random
    ${credit}    Evaluate    ${credit1}-${credit2}
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    校验上链交易流水    1    tid='${tid}'    oper_type=3    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000
    Sleep    ${G_Chain_Delay}
    校验链上用户余额    ${uid}    ${credit1}

用户已开户，abstr节点不存在，消费成功
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Evaluate    random.randint(20,50)    random
    ${credit}    Evaluate    ${credit1}-${credit2}
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    删除请求节点    $.busiInfo.params.abstr
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    校验上链交易流水    1    tid='${tid}'    oper_type=3    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000
    Sleep    ${G_Chain_Delay}
    校验链上用户余额    ${uid}    ${credit}
    获取回调请求数据    ${ctrlUri}
    校验回调请求参数    0000

用户已开户，operTime值大于当前时间，记录该时间，消费成功
    ${tran_time}    Get Time    epoch    time_=NOW+5hour
    ${tran_time}    Convert Date    ${tran_time}    result_format=%Y%m%d%H%M%S
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Evaluate    random.randint(20,50)    random
    ${credit}    Evaluate    ${credit1}-${credit2}
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    校验上链交易流水    1    tid='${tid}'    oper_type=3    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000
    Sleep    ${G_Chain_Delay}
    校验链上用户余额    ${uid}    ${credit}
    获取回调请求数据    ${ctrlUri}
    校验回调请求参数    0000

用户已开户，开户数据正常，cbUrl地址无能访问，消费成功
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Evaluate    random.randint(20,50)    random
    ${credit}    Evaluate    ${credit1}-${credit2}
    ${cbUrl}    Set Variable    http://aspire.test.com
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}    $.pubInfo.cbUrl=${cbUrl}
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    校验上链交易流水    1    tid='${tid}'    oper_type=3    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000
    Sleep    ${G_Chain_Delay}
    校验链上用户余额    ${uid}    ${credit}

用户已开户，开户数据正常，cbUrl地址为空，消费成功
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Evaluate    random.randint(20,50)    random
    ${credit}    Evaluate    ${credit1}-${credit2}
    ${cbUrl}    Set Variable    ${EMPTY}
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}    $.pubInfo.cbUrl=${cbUrl}
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    校验上链交易流水    1    tid='${tid}'    oper_type=3    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000
    Sleep    ${G_Chain_Delay}
    校验链上用户余额    ${uid}    ${credit}

用户已开户，积分值超大，但不超过20位，消费成功
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(90000000000000000000,99999999999999999999)    random
    ${credit2}    Evaluate    random.randint(80000000000000000000,88888888888888888888)    random
    ${credit}    Evaluate    ${credit1}-${credit2}
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    校验上链交易流水    1    tid='${tid}'    oper_type=3    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000
    Sleep    ${G_Chain_Delay}
    校验链上用户余额    ${uid}    ${credit}
    获取回调请求数据    ${ctrlUri}
    校验回调请求参数    0000

用户在A点开户，在B点消费，消费成功
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    random.randint(56,150)    random
    ${credit2}    Evaluate    random.randint(20,50)    random
    ${credit}    Evaluate    ${credit1}-${credit2}
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验链上用户余额    ${uid}    ${credit1}
    ${tran_time}    生成指定时间串
    更新请求时间与TID    $.busiInfo.operType=(int)3    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit2}    $.busiInfo.params.operDesc=验证消费
    发送Reqx请求    ${req_flag}
    校验上链交易流水    1    tid='${tid}'    oper_type=3    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000
    Sleep    ${G_Chain_Delay}
    校验链上用户余额    ${uid}    ${credit}
    获取回调请求数据    ${ctrlUri}
    校验回调请求参数    0000
