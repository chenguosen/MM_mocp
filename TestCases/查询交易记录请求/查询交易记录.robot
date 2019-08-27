*** Settings ***
Resource          ../../KeyWords/Biz/查询交易记录.robot

*** Test Cases ***
用户未开户，查询交易记录，返回空数据
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${userId}    Set Variable    U99999999-20190530082530    #用户不存在
    ${currentPage}    Set Variable    1
    ${pageSize}    Set Variable    10
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验交易记录查询    0    ${pageSize}
    删除用户交易数据    ${userId}

查询周期内，用户记录小于每页记录数，页码为负数，返回参数错误
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${Ra}-${Ra}
    ${currentPage}    Set Variable    -1
    ${pageSize}    Set Variable    10
    生成用户交易记录数据    104567    ${userId}    3    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    9998
    校验应答字段值    $.busiInfo=${None}    $.pageInfo=${None}
    删除用户交易数据    ${userId}

查询周期内，用户记录小于每页记录数，页码为0，返回参数错误
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${Ra}-${Ra}
    ${currentPage}    Set Variable    -1
    ${pageSize}    Set Variable    5
    生成用户交易记录数据    104567    ${userId}    3    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    9998
    校验应答字段值    $.busiInfo=${None}    $.pageInfo=${None}
    删除用户交易数据    ${userId}

查询周期内，用户记录小于每页记录数，页码为1，返回首页记录集
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    1
    ${pageSize}    Set Variable    10
    ${recSize}    Set Variable    3
    生成用户交易记录数据    104567    ${userId}    ${recSize}    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验交易记录查询    0    ${pageSize}
    校验应答字段值    $.pageInfo.recordCount=${recSize}
    删除用户交易数据    ${userId}

查询周期内，用户记录小于每页记录数，页码为2，返回空数据
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    2
    ${pageSize}    Set Variable    10
    生成用户交易记录数据    104567    ${userId}    3    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验应答字段值    $.busiInfo=${None}    $.pageInfo=${None}
    删除用户交易数据    ${userId}

查询周期内，用户记录是每页记录数1到2倍，页码为负数，返回参数错误
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${Ra}-${Ra}
    ${currentPage}    Set Variable    -1
    ${pageSize}    Set Variable    5
    生成用户交易记录数据    104567    ${userId}    10    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    9998
    校验应答字段值    $.busiInfo=${None}    $.pageInfo=${None}
    删除用户交易数据    ${userId}

查询周期内，用户记录是每页记录数1到2倍，页码为0，返回参数错误
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${Ra}-${Ra}
    ${currentPage}    Set Variable    0
    ${pageSize}    Set Variable    10
    生成用户交易记录数据    104567    ${userId}    3    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    9998
    校验应答字段值    $.busiInfo=${None}    $.pageInfo=${None}
    删除用户交易数据    ${userId}

查询周期内，用户记录是每页记录数1到2倍，页码为1，返回首页记录集
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    1
    ${pageSize}    Set Variable    5
    ${recSize}    Set Variable    10
    生成用户交易记录数据    104567    ${userId}    ${recSize}    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验交易记录查询    0    ${pageSize}
    校验应答字段值    $.pageInfo.recordCount=${recSize}
    删除用户交易数据    ${userId}

查询周期内，用户记录是每页记录数1到2倍，页码为2，返回尾页记录集
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    2
    ${pageSize}    Set Variable    5
    ${recSize}    Set Variable    10
    生成用户交易记录数据    104567    ${userId}    ${recSize}    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验交易记录查询    1    ${pageSize}
    校验应答字段值    $.pageInfo=${None}
    删除用户交易数据    ${userId}

查询周期内，用户记录是每页记录数1到2倍，页码为3，返回空数据
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    3
    ${pageSize}    Set Variable    5
    ${recSize}    Set Variable    9
    生成用户交易记录数据    104567    ${userId}    ${recSize}    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验应答字段值    $.busiInfo=${None}    $.pageInfo=${None}
    删除用户交易数据    ${userId}

查询周期内，用户记录是每页记录数1到3倍，页码为负数，返回参数错误
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    -2
    ${pageSize}    Set Variable    5
    ${recSize}    Set Variable    12
    生成用户交易记录数据    104567    ${userId}    ${recSize}    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    9998
    校验应答字段值    $.busiInfo=${None}    $.pageInfo=${None}
    删除用户交易数据    ${userId}

查询周期内，用户记录是每页记录数1到3倍，页码为0，返回参数错误
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    0
    ${pageSize}    Set Variable    5
    ${recSize}    Set Variable    12
    生成用户交易记录数据    104567    ${userId}    ${recSize}    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    9998
    校验应答字段值    $.busiInfo=${None}    $.pageInfo=${None}
    删除用户交易数据    ${userId}

查询周期内，用户记录是每页记录数1到3倍，页码为1，返回首页记录集
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    1
    ${pageSize}    Set Variable    5
    ${recSize}    Set Variable    13
    生成用户交易记录数据    104567    ${userId}    ${recSize}    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验交易记录查询    0    ${pageSize}
    校验应答字段值    $.pageInfo.recordCount=${recSize}
    删除用户交易数据    ${userId}

查询周期内，用户记录是每页记录数1到3倍，页码为2，返回第2页记录集
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    2
    ${pageSize}    Set Variable    5
    ${recSize}    Set Variable    13
    生成用户交易记录数据    104567    ${userId}    ${recSize}    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验交易记录查询    1    ${pageSize}
    校验应答字段值    $.pageInfo=${None}
    删除用户交易数据    ${userId}

查询周期内，用户记录是每页记录数1到3倍，页码为3，返回尾页记录集
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    3
    ${pageSize}    Set Variable    5
    ${recSize}    Set Variable    13
    生成用户交易记录数据    104567    ${userId}    ${recSize}    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验交易记录查询    2    ${pageSize}
    校验应答字段值    $.pageInfo=${None}
    删除用户交易数据    ${userId}

查询周期内，用户记录是每页记录数1到3倍，页码为4，返回尾页记录集
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    4
    ${pageSize}    Set Variable    5
    ${recSize}    Set Variable    11
    生成用户交易记录数据    104567    ${userId}    ${recSize}    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验应答字段值    $.busiInfo=${None}    $.pageInfo=${None}
    删除用户交易数据    ${userId}

endDate与beginDate之差是3个月，返回正确记录集
    ${sdate}    获取指定格式的日期    90
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    1
    ${pageSize}    Set Variable    5
    ${recSize}    Set Variable    13
    生成用户交易记录数据    104567    ${userId}    ${recSize}    89
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验交易记录查询    0    ${pageSize}
    校验应答字段值    $.pageInfo.recordCount=${recSize}
    删除用户交易数据    ${userId}

endDate与beginDate之差大于3个月，返回错误码
    ${sdate}    获取指定格式的日期    95
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    1
    ${pageSize}    Set Variable    5
    ${recSize}    Set Variable    13
    Comment    生成用户交易记录数据    104567    ${userId}    ${recSize}    89
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    9998
    Comment    校验交易记录查询    0    ${pageSize}
    Comment    校验应答字段值    $.pageInfo.recordCount=${recSize}
    删除用户交易数据    ${userId}

beginDate等于endDate，返回beginDate所在日记录集
    ${sdate}    获取指定格式的日期    0
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    1
    ${pageSize}    Set Variable    5
    ${recSize}    Set Variable    13
    生成用户交易记录数据    104567    ${userId}    ${recSize}    0
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验交易记录查询    0    ${pageSize}
    校验应答字段值    $.pageInfo.recordCount=${recSize}
    删除用户交易数据    ${userId}

endDate大于当前月，返回查询周期内的数据记录集，即不校验日期
    ${sdate}    获取指定格式的日期    2
    ${edate}    Get Time    epoch    time_=NOW+3day
    ${edate}    Convert Date    ${edate}    result_format=%Y%m%d
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    1
    ${pageSize}    Set Variable    5
    ${recSize}    Set Variable    13
    生成用户交易记录数据    104567    ${userId}    ${recSize}    2
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验交易记录查询    0    ${pageSize}
    校验应答字段值    $.pageInfo.recordCount=${recSize}
    删除用户交易数据    ${userId}

查询范围外存在数据，只返回周期内的分页数据。
    ${sdate}    获取指定格式的日期    4
    ${edate}    获取指定格式的日期    1
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    1
    ${pageSize}    Set Variable    2
    ${recSize}    Set Variable    4
    生成用户交易记录数据    104567    ${userId}    ${recSize}    5
    生成用户交易记录数据    104567    ${userId}    ${recSize}    2
    生成用户交易记录数据    104567    ${userId}    ${recSize}    1
    生成用户交易记录数据    104567    ${userId}    ${recSize}    0
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验交易记录查询    0    ${pageSize}
    校验应答字段值    $.pageInfo.recordCount=${recSize}
    删除用户交易数据    ${userId}

pageSize值大于100，返回参数错误
    ${sdate}    获取指定格式的日期    30
    ${edate}    获取指定格式的日期    0
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${Ra}-${Ra}
    ${currentPage}    Set Variable    1
    ${pageSize}    Set Variable    101
    生成用户交易记录数据    104567    ${userId}    3    3
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    9998
    校验应答字段值    $.busiInfo=${None}    $.pageInfo=${None}
    删除用户交易数据    ${userId}

pageSize值等于100，返回符合查询结果的交易记录
    ${sdate}    获取指定格式的日期    4
    ${edate}    获取指定格式的日期    1
    ${Ra}    Evaluate    random.randint(10000000,19999999)    random
    ${userId}    Set Variable    TRANU-${sdate}-${Ra}
    ${currentPage}    Set Variable    2
    ${pageSize}    Set Variable    2
    ${recSize}    Set Variable    4
    生成用户交易记录数据    104567    ${userId}    ${recSize}    5
    生成用户交易记录数据    104567    ${userId}    ${recSize}    2
    生成用户交易记录数据    104567    ${userId}    ${recSize}    1
    生成用户交易记录数据    104567    ${userId}    ${recSize}    0
    读取交易记录查询请求    $.busiInfo.userId=${userId}    $.busiInfo.beginDate=${sdate}    $.busiInfo.endDate=${edate}    $.pageInfo.currentPage=${currentPage}    $.pageInfo.pageSize=${pageSize}
    发送交易记录查询请求
    校验应答返回码信息    0000
    校验交易记录查询    1    ${pageSize}
    校验应答字段值    $.pageInfo.recordCount=${recSize}
    删除用户交易数据    ${userId}
