*** Keywords ***
将字符串转为时间
    [Arguments]    ${str_time}    ${format}=%Y%m%d%H%M%S%f
    ${_time}    Evaluate    datetime.datetime.strptime(\"${str_time}\",\"${format}\")    modules=datetime
    [Return]    ${_time}

校验字符串时间偏差
    [Arguments]    ${str_time}    ${diff}    ${format}=%Y%m%d%H%M%S
    ${_time}    Evaluate    datetime.datetime.strptime(\"${str_time}\",\"${format}\")    modules=datetime
    ${_now}    Get Time    epoch    time_=NOW-${diff}second
    ${_now}    Convert Date    ${_now}    result_format=%Y-%m-%d %H:%M:%S.%f
    ${_result}    Evaluate    \'${_time}\' > \'${_now}\'
    Should Be True    ${_result}

校验A时间大于B时间
    [Arguments]    ${a_time}    ${b_time}    ${format}=%Y%m%d%H%M%S%f
    ${_a_time}    Evaluate    datetime.datetime.strptime(\"${a_time}\",\"${format}\")    modules=datetime
    ${_b_time}    Evaluate    datetime.datetime.strptime(\"${b_time}\",\"${format}\")    modules=datetime
    ${_result}    Evaluate    \'${_a_time}\' > \'${_b_time}\'
    Should Be True    ${_result}

获取两时间的毫秒差
    [Arguments]    ${a_time}    ${b_time}    ${format}=%Y%m%d%H%M%S%f
    [Documentation]    时间相减后获得timedelta，他通过天，秒，微秒来表达时间差，暂时先不考虑天
    ${_micros}    Evaluate    (datetime.datetime.strptime(\"${a_time}\",\"${format}\")-datetime.datetime.strptime(\"${b_time}\",\"${format}\")).microseconds    modules=datetime
    ${_seconds}    Evaluate    (datetime.datetime.strptime(\"${a_time}\",\"${format}\")-datetime.datetime.strptime(\"${b_time}\",\"${format}\")).seconds    modules=datetime
    Comment    ${_days}    Evaluate    (datetime.datetime.strptime(\"${a_time}\",\"${format}\")-datetime.datetime.strptime(\"${b_time}\",\"${format}\")).days    modules=datetime
    ${_diff_time}    Evaluate    ${_micros}/1000+${_seconds}*1000
    ${_diff_time}    Convert to Integer    ${_diff_time}
    [Return]    ${_diff_time}

校验时间字符串长度
    [Arguments]    ${str_time}    ${ex_len}
    [Documentation]    \#暂时不需要实现
    Length Should Be    ${str_time}    ${ex_len}

获取指定格式的日期
    [Arguments]    ${offset_day}    ${format}=%Y%m%d
    ${date_set}    Get Time    epoch    time_=NOW-${offset_day}day
    ${date_set}    Convert Date    ${date_set}    result_format=${format}
    [Return]    ${date_set}
