*** Settings ***
Resource          ../../KeyWords/Biz/对账文件处理.robot

*** Test Cases ***
应用A未发生交易，生成空文件
    Comment    生成交易记录数据    104678    20    1
    某路径执行命令    ${G_dzfile_path[0]}    rm -rf 10*
    某路径执行命令    ${G_dzfile_path[1]}    rm -rf 10*
    Comment    触发对账文件生成    20190613    C

应用A为未超过记录上线，生成1个文件
    ${dz_offset}    Set Variable    1 day
    ${appId}    Set Variable    101301
    数据库执行sql语句(非查询)    DELETE FROM t_statement where app_id = \'${appId}\';
    ${expect_trans}    生成交易记录数据    ${appId}    7    ${dz_offset}
    生成交易记录数据    ${appId}    3    2 day
    某路径执行命令    ${G_dzfile_path[0]}    rm -rf 10*
    某路径执行命令    ${G_dzfile_path[1]}    rm -rf 10*
    ${dz_date}    生成指定时间串    ${dz_offset}    %Y%m%d
    触发对账文件生成    ${dz_date}    Adz
    Sleep    ${G_dzfile_Delay}
    ${dz_fileInfo}    某路径执行命令    ${G_dzfile_path[1]}\/${appId}\/dz\/${dz_date}    cat CREDIT_RECONCILIATION_${dz_date}_00_OK
    校验对账文件结果    6    ${appId}    ${dz_fileInfo}    ${expect_trans}
    ${dz_fileInfo}    某路径执行命令    ${G_dzfile_path[1]}\/${appId}\/dz\/${dz_date}    cat CREDIT_RECONCILIATION_${dz_date}_01_OK
    校验对账文件结果    1    ${appId}    ${dz_fileInfo}    ${expect_trans}

应用A交易记录数有2个文件，生成2个文件

应用A交易记录数有3个文件，生成3个文件

应用A无交易，应用B有交易，不超过1个文件，应用C有交易超1个文件

应用A无交易，应用B存在多日交易，昨日不超过1个文件，应用C有多日交易，昨日超1个文件

交易状态成功，生成文件

交易状态失败，生成文件

交易状态交易中，生成文件

交易积分为0，生成文件

交易积分值是正常数据，生成文件

交易积分值20位数字，生成文件

对账文件根路径配置验证

应用A前2日有交易，前1日无交易，当日有交易，生成文件
