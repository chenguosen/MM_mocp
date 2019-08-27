*** Settings ***
Resource          ../../Resources/Global_Variable.robot
Library           DatabaseLibrary
Library           BuiltIn

*** Keywords ***
数据库查询_返回单值
    [Arguments]    ${sql}    ${mysqlConnStr}=${TNC_MysqlConnStr}
    [Documentation]    单值结果查询，如果查到结果，直接返回结果值的串，例如"ABC"；
    ...    没有查到结果，则返回字串"None"
    Connect To Database Using Custom Params    MySQLdb    ${mysqlConnStr}
    ${result}    Set Variable    None
    @{queryResults}    query    ${sql}
    Log Many    @{queryResults}
    Return From Keyword If    '''@{queryResults}'''=='''[]'''
    ${result}    Set Variable    @{queryResults[0]}[0]
    Disconnect From Database
    Set Test Variable    ${result}
    Set Test Variable    @{queryResults}
    [Return]    ${result}

数据库查询_返回单行
    [Arguments]    ${sql}    ${mysqlConnStr}=${TNC_MysqlConnStr}
    [Documentation]    单值结果查询，如果查到结果，直接返回结果值的串，例如"ABC"；
    ...    没有查到结果，则返回字串"None"
    Connect To Database Using Custom Params    MySQLdb    ${mysqlConnStr}
    ${result}    Set Variable    None
    @{queryResults}    query    ${sql}
    Log Many    @{queryResults}
    Return From Keyword If    "@{queryResults}"=="[]"
    ${result}    Set Variable    @{queryResults[0]}
    Disconnect From Database
    [Return]    ${result}

数据库查询
    [Arguments]    ${sql}    ${mysqlConnStr}=${TNC_MysqlConnStr}
    [Documentation]    单值结果查询，如果查到结果，直接返回结果值的串，例如"ABC"；
    ...    没有查到结果，则返回字串"None"
    Connect To Database Using Custom Params    MySQLdb    ${mysqlConnStr}
    ${result}    Set Variable    None
    @{queryResults}    query    ${sql}
    Log Many    @{queryResults}
    Return From Keyword If    @{queryResults}==[]
    ${result}    Set Variable    @{queryResults}
    Disconnect From Database
    [Return]    ${result}

数据库执行sql语句(非查询)
    [Arguments]    ${sql}    ${mysqlConnStr}=${TNC_MysqlConnStr}
    [Documentation]    一般的insert，update, delete， 不需要返回值
    Connect To Database Using Custom Params    MySQLdb    ${mysqlConnStr}
    Execute Sql String    ${sql}
    Disconnect From Database

数据库执行sql文件(非查询)
    [Arguments]    ${sqlfile}    ${mysqlConnStr}=${TNC_MysqlConnStr}
    [Documentation]    一般的insert，update, delete， 不需要返回值
    Connect To Database Using Custom Params    MySQLdb    ${mysqlConnStr}
    Execute Sql Script    ${sqlfile}
    Disconnect From Database

指定数据库查询_返回单值
    [Arguments]    ${dbconnStr}    ${sql}
    [Documentation]    单值结果查询，如果查到结果，直接返回结果值的串，例如"ABC"；
    ...    没有查到结果，则返回字串"None"
    Connect To Database Using Custom Params    MySQLdb    ${dbconnStr}
    ${result}    Set Variable    None
    @{queryResults}    query    ${sql}
    Log Many    @{queryResults}
    Return From Keyword If    "@{queryResults}"=="[]"
    ${result}    Set Variable    @{queryResults[0]}[0]
    Disconnect From Database
    [Return]    ${result}

指定数据库查询_返回单行
    [Arguments]    ${dbconnStr}    ${sql}
    [Documentation]    单值结果查询，如果查到结果，直接返回结果值的串，例如"ABC"；
    ...    没有查到结果，则返回字串"None"
    Connect To Database Using Custom Params    MySQLdb    ${dbconnStr}
    ${result}    Set Variable    None
    @{queryResults}    query    ${sql}
    Log Many    @{queryResults}
    Return From Keyword If    "@{queryResults}"=="[]"
    ${result}    Set Variable    @{queryResults[0]}
    Disconnect From Database
    [Return]    ${result}

指定数据库查询
    [Arguments]    ${dbconnStr}    ${sql}
    [Documentation]    单值结果查询，如果查到结果，直接返回结果值的串，例如"ABC"；
    ...    没有查到结果，则返回字串"None"
    Connect To Database Using Custom Params    MySQLdb    ${dbconnStr}
    ${result}    Set Variable    None
    @{queryResults}    query    ${sql}
    Log Many    @{queryResults}
    Return From Keyword If    "@{queryResults}"=="[]"
    ${result}    Set Variable    @{queryResults}
    Disconnect From Database
    [Return]    ${result}

指定数据库执行sql语句(非查询)
    [Arguments]    ${dbconnStr}    ${sql}
    [Documentation]    一般的insert，update, delete， 不需要返回值
    Connect To Database Using Custom Params    MySQLdb    ${dbconnStr}
    Execute Sql String    ${sql}
    Disconnect From Database

指定数据库执行sql文件(非查询)
    [Arguments]    ${dbconnStr}    ${sqlfile}
    [Documentation]    一般的insert，update, delete， 不需要返回值
    Connect To Database Using Custom Params    MySQLdb    ${dbconnStr}
    Execute Sql Script    ${sqlfile}
    Disconnect From Database

将键值对转为Where子句
    [Arguments]    @{key_value}
    ${wheres}    set test variable    ${None}
    ${length}    Get Length    ${key_value}
    Return From Keyword If    ${length} ==0    ;
    ${index}    Convert To Integer    0
    : FOR    ${kv}    IN    @{key_value}
    ${wheres}=    Run Keyword If    ${index} ==0    Catenate    SEPARATOR=\ \    where    ${kv}
    ...    ELSE    Catenate    SEPARATOR=\ And \    ${wheres}    ${kv}
    ${index}    Evaluate    ${index} +1
    ${wheres}    Catenate    SEPARATOR=    ${wheres}    ;
    [Return]    ${wheres}
