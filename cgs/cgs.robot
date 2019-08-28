*** Settings ***
Library           ../Library/count.py
Resource          ../Resources/Global_Variable.robot
Library           Collections
Resource          ../KeyWords/Pub/MySQLLibs.robot
Resource          ../KeyWords/Pub/RedisLibs.robot
Resource          ../KeyWords/Biz/手机号实名简项认证业务.robot
Resource          ../KeyWords/Biz/server端同步查询接口.robot
Library           ../Library/liveauth.py

*** Test Cases ***
333
    log    ${G_interface_names[2]}
    LOG    ${G_interface_names[0]}
    Set Global Variable    ${req_flag}    ${G_interface_names[0]}
    log    ${req_flag}

444
    log    ${req_flag}

555
    ${app_secret}    Get From Dictionary    ${G_AppsInfo}    123456
    log    ${app_secret}

SQL
    Comment    数据库执行sql语句(非查询)    DELETE from wb_user where id='316670214546653184';
    数据库查询_返回单值    select count(*) from t_realnameauthlog t where t.clientState='92876156325144620190725104602495' and t.isVerify='0' and preFee='5000';
    Should Be Equal As Strings    ${result}    1

redis
    删除key    KEY_APP_DAILY_TIMES_USING_100000000251
    写String    KEY_APP_DAILY_TIMES_USING_100000000251    13
    ${a}    根据key取String    KEY_PRELICENSE_BALANCE_2000010017001
    log    ${a}
    log    ${a}

redis2
    ${r}    Redis

两个返回值
    [Setup]    cgs
    log    ${appid}
    log    ${preLicenseID}

写集合
    向有序集合写一个值    KEY_APP_PRELICENSE_ORDERS_900000000285    2000010023002

替换
    ${test01}    Set Variable    "{\"appDesc\":\"在线认证44\",\"appFingerPrint\":\"saf\",\"appId\":100000000285,\"appInfoExt\":{\"pageNum\":0,\"pageSize\":0,\"startIndex\":0,\"totalCount\":0},\"appKey\":\"05bc4cd796b44d9483ae64858ef321b3\",\"appLogo\":\"101068\",\"appName\":\"在线认证44\",\"appPackageName\":\"sasf\",\"appType\":\"1\",\"appTypeChange\":\"软件\",\"compName\":\"勿动测试\",\"createTime\":\"2019-07-19 10:42:27\",\"createUser\":\"316665779426689024\",\"pageNum\":0,\"pageSize\":0,\"spCode\":\"1000001\",\"startIndex\":0,\"status\":4,\"statusChange\":\"使用中\",\"totalCount\":0,\"uaType\":\"1\",\"uaTypeChange\":\"安卓\"}"
    ${result}    Replace String    ${test01}    status\":4    status\":3
    log    ${result}

chenguosen用例
    log    ${G_interface_names[2]}
    LOG    ${G_interface_names[0]}
    Set Global Variable    ${req_flag}    ${G_interface_names[0]}
    log    ${req_flag}

SSH操作
    ${output}    某路径执行命令    /opt/aspire/product/mm_tnc/tnc_client/log/debug/cgs    df -h
    log    ${output}
    log    ${output}

上传文件
    ${host_infos}    Get From Dictionary    ${TNC_Hosts}    A
    ${host_info}    String.Split String    ${host_infos}    ,
    远程登录后台    ${host_info[0]}    ${host_info[1]}    ${host_info[2]}    utf-8
    上传本地文件    D:\\work    new_name.txt    /opt/aspire/product/mm_tnc/tnc_client/log/debug/cgs
    关闭当前远程连接

下载远程文件
    ${host_infos}    Get From Dictionary    ${TNC_Hosts}    A
    ${host_info}    String.Split String    ${host_infos}    ,
    远程登录后台    ${host_info[0]}    ${host_info[1]}    ${host_info[2]}    utf-8
    SSHLibrary.Get File    /opt/aspire/product/mm_tnc/tnc_client/log/debug/log-debug-2019-06-14.0.log    D:\\\\work\\\\new_name.txt
    log    下载完成......
    关闭当前远程连接

调用Java库
    ${res}    getliveparam    15818640852    26355dfec55345d4905b3bf93f6eb29c
    log    ${res}
    log    ${res}

JAVA
    ${res}    liveauth.getliveparam    15818640852    26355dfec55345d4905b3bf93f6eb29c
    log    ${res}
    log    ${res}