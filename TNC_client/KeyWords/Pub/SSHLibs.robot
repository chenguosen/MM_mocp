*** Settings ***
Library           SSHLibrary

*** Keywords ***
远程登录后台
    [Arguments]    ${ip}    ${user}    ${passwd}    ${encoding}
    SSHLibrary.Open Connection    ${ip}    encoding=${encoding}
    SSHLibrary.login    ${user}    ${passwd}
    
系统时间同步
    [Arguments]    ${ip}    ${user}    ${passwd}
    ${time}=    Get Time
    ${time_string}=    Catenate    SEPARATOR=    "    ${time}    "
    SSHLibrary.Open Connection    ${ip}
    SSHLibrary.login    ${user}    ${passwd}
    ${command}=    Catenate    date -s    ${time_string}
    SSHLibrary.write    cd /;${command};clock -w
    SSHLibrary.Close Connection

上传本地文件
    [Arguments]    ${local_path}    ${file_name}    ${destination}
    SSHLibrary.put file    ${local_path}/${file_name}    ${destination}    mode=0775
    log    命令执行中......
    sleep    1s
    SSHLibrary.File Should Exist    ${destination}/${file_name}

获取远程文件
    [Arguments]    ${remote_path}    ${file_name}    ${local_path}
    SSHLibrary.Get File    ${remote_path}/${file_name}    ${local_path}
    log    命令执行中......
    sleep    1s

远程目录执行命令
    [Arguments]    ${remote_path}    ${command}
    ${command1}=    Catenate    cd    ${remote_path}
    ${command}=    Catenate    SEPARATOR=;    ${command1}    ${command}
    SSHLibrary.write    ${command}
    log    命令执行中......
    sleep    1s

远程目录执行命令并获取返回执行结果
    [Arguments]    ${remote_path}    ${command}
    ${command1}=    Catenate    cd    ${remote_path}
    ${command2}=    Catenate    SEPARATOR=;    ${command1}    ${command}
    ${output}=    SSHLibrary.Execute Command    ${command2}
    [Return]    ${output}

关闭当前远程连接
    log    Closes the current connection.
    SSHLibrary.Close Connection

关闭所有远程连接
    log    Closes all open connections.
    SSHLibrary.Close All Connections
