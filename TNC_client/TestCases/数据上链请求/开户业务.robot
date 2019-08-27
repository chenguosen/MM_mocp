*** Settings ***
Resource          ../../KeyWords/Biz/数据上链业务.robot
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot
Resource          ../../KeyWords/Biz/准备测试环境.robot

*** Test Cases ***
新用户开户，开户数据正常，开户成功
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}
    校验上链交易流水    1    tid='${tid}'    oper_type=1    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000    #节点不存在9998
    #日志需要重新梳理，暂无校验
    Comment    获取服务器请求日志    A    ${tid}
    Comment    获取服务器应答日志    A    ${tid}
    Comment    校验请求日志内容
    #获取回调的请求消息,延时确保回调被发起
    ${credit}    获取请求某字段数据    $.busiInfo.params.credit
    Sleep    ${G_Chain_Delay}
    ${chainCode}    Set Variable    0000
    ${chainmsg}    Get From Dictionary    ${G_Chain_Code}    ${chainCode}
    校验数据库上链结果    ${tid}    1    ${chainCode}    ${chainmsg}
    校验链上用户余额    ${uid}    ${credit}
    获取回调请求数据    ${ctrlUri}
    校验回调请求参数    0000

老用户开户，开户数据正常，开户失败
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}
    更新请求时间与TID
    ${tran_time}    获取请求某字段数据    $.pubInfo.reqTime
    更新节点数据    $.busiInfo.operType=(int)1    $.busiInfo.params.credit=3456    $.busiInfo.params.operTime=${tran_time}
    发送Reqx请求    /${req_flag}
    Sleep    ${G_Chain_Delay}
    校验上链交易流水    1    tid='${tid}'    oper_type=1    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000    #节点不存在9998
    ${chainCode}    Set Variable    0001
    ${chainmsg}    Get From Dictionary    ${G_Chain_Code}    ${chainCode}
    校验数据库上链结果    ${tid}    1    ${chainCode}    ${chainmsg}

新用户开户，积分数量为0，开户成功
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Evaluate    0    random
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验上链交易流水    1    tid='${tid}'    oper_type=1    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000    #节点不存在9998
    #获取回调的请求消息,延时确保回调被发起
    Sleep    ${G_Chain_Delay}
    ${chainCode}    Set Variable    0000
    ${chainmsg}    Get From Dictionary    ${G_Chain_Code}    ${chainCode}
    校验数据库上链结果    ${tid}    1    ${chainCode}    ${chainmsg}
    校验链上用户余额    ${uid}    ${credit1}
    获取回调请求数据    ${ctrlUri}
    校验回调请求参数    0000

新用户开户，积分值为负值，开户失败
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    ${credit1}    Evaluate    -56    random
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9997

新用户开户，积分值带字母，开户失败
    ${tran_time}    生成指定时间串
    ${credit1}    Set Variable    c123
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验上链交易流水    0    tid='${tid}'
    校验应答返回码信息    9997

新用户开户，operTime值大于当前时间，记录该时间，开户成功
    ${tran_time}    Get Time    epoch    time_=NOW+5hour
    ${tran_time}    Convert Date    ${tran_time}    result_format=%Y%m%d%H%M%S
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Set Variable    123
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}
    校验上链交易流水    1    tid='${tid}'    oper_type=1    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000    #节点不存在9998
    #获取回调的请求消息,延时确保回调被发起
    Sleep    ${G_Chain_Delay}
    ${chainCode}    Set Variable    0000
    ${chainmsg}    Get From Dictionary    ${G_Chain_Code}    ${chainCode}
    校验数据库上链结果    ${tid}    1    ${chainCode}    ${chainmsg}
    校验链上用户余额    ${uid}    ${credit1}

新用户开户，开户数据正常，cbUrl地址无能访问，开户成功
    ${tran_time}    Get Time    epoch    time_=NOW
    ${tran_time}    Convert Date    ${tran_time}    result_format=%Y%m%d%H%M%S
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Set Variable    123
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}    $.pubInfo.cbUrl=www.xiecs.com
    校验上链交易流水    1    tid='${tid}'    oper_type=1    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000    #节点不存在9998
    #获取回调的请求消息,延时确保回调被发起
    Sleep    ${G_Chain_Delay}
    ${chainCode}    Set Variable    0000
    ${chainmsg}    Get From Dictionary    ${G_Chain_Code}    ${chainCode}
    校验数据库上链结果    ${tid}    1    ${chainCode}    ${chainmsg}
    校验链上用户余额    ${uid}    ${credit1}

新用户开户，开户数据正常，cbUrl地址为空，开户成功
    ${tran_time}    Get Time    epoch    time_=NOW
    ${tran_time}    Convert Date    ${tran_time}    result_format=%Y%m%d%H%M%S
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${credit1}    Set Variable    123
    新用户正常开户    ${G_Chain_Delay}    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${credit1}    $.pubInfo.cbUrl=${EMPTY}
    校验上链交易流水    1    tid='${tid}'    oper_type=1    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000    #节点不存在9998
    #获取回调的请求消息,延时确保回调被发起
    Sleep    ${G_Chain_Delay}
    ${chainCode}    Set Variable    0000
    ${chainmsg}    Get From Dictionary    ${G_Chain_Code}    ${chainCode}
    校验数据库上链结果    ${tid}    1    ${chainCode}    ${chainmsg}
    校验链上用户余额    ${uid}    ${credit1}

新用户开户，积分值超大，但不超过32位，开户成功
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=99999999999999999999999999999999
    校验上链交易流水    1    tid='${tid}'    oper_type=1    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000    #节点不存在9998
    #获取回调的请求消息,延时确保回调被发起
    ${credit}    获取请求某字段数据    $.busiInfo.params.credit
    Sleep    ${G_Chain_Delay}
    ${chainCode}    Set Variable    0000
    ${chainmsg}    Get From Dictionary    ${G_Chain_Code}    ${chainCode}
    校验数据库上链结果    ${tid}    1    ${chainCode}    ${chainmsg}
    校验链上用户余额    ${uid}    ${credit}
    获取回调请求数据    ${ctrlUri}
    校验回调请求参数    0000

新用户开户，用户ID带字母，开户成功
    Comment    已有用例覆盖，不再重复

新用户开户，用户ID带中划线，开户成功
    Comment    已有用例覆盖，不再重复

新用户开户，用户ID带下划线，开户成功
    Comment    已有用例覆盖，不再重复

新用户开户，用户ID超长，但不超过32位，开户成功
    ${tran_time}    生成指定时间串
    #设置回调消息，顺序不能乱，保证测试变量不被覆盖
    ${ctrlUri}    Set Variable    /common/${G_interface_names[0]}
    读取并初始回调应答请求    $.target_req_uri=${ctrlUri}    $.target_req_ctrl_data.response.pubInfo.rspTime=${tran_time}
    发送回调应答包请求
    ${uid}    Set Variable    9999${tran_time}${tran_time}
    新用户正常开户    0    $.busiInfo.operType=(int)1    $.busiInfo.params.operTime=${tran_time}    $.busiInfo.params.credit=${uid}
    校验上链交易流水    1    tid='${tid}'    oper_type=1    user_id='${uid}'    cb_flag=1
    校验应答返回码信息    0000    #节点不存在9998
    #获取回调的请求消息,延时确保回调被发起
    ${credit}    获取请求某字段数据    $.busiInfo.params.credit
    Sleep    ${G_Chain_Delay}
    ${chainCode}    Set Variable    0000
    ${chainmsg}    Get From Dictionary    ${G_Chain_Code}    ${chainCode}
    校验数据库上链结果    ${tid}    1    ${chainCode}    ${chainmsg}
    校验链上用户余额    ${uid}    ${credit}
    获取回调请求数据    ${ctrlUri}
    校验回调请求参数    0000
