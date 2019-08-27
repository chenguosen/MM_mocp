*** Settings ***
Library           ../../Library/redisLibrary.py
Resource          ../../resources/global_variable.robot

*** Keywords ***
清空redis所有数据
    ${redis}    String.Split String    ${G_RedisStr}    ,
    redisFlushall    ${redis[0]}    ${redis[1]}    ${redis[2]}    ${redis[3]}

删除key
    [Arguments]    ${key}    #key
    ${redis}    String.Split String    ${TNC_RedisStr}    ,
    delete1    ${redis[0]}    ${redis[1]}    ${redis[2]}    ${redis[3]}    ${key}

写String
    [Arguments]    ${key}    ${value}
    ${redis}    String.Split String    ${TNC_RedisStr}    ,
    setString    ${redis[0]}    ${redis[1]}    ${redis[2]}    ${redis[3]}    ${key}    ${value}

批量写String
    [Arguments]    ${dict}
    setStringForDict    ${redisIp}    ${redisPort}    ${isRedisCluster}    ${dict}

根据key取String
    [Arguments]    ${key}    #key
    ${redis}    String.Split String    ${TNC_RedisStr}    ,
    ${value}    getStringByKey    ${redis[0]}    ${redis[1]}    ${redis[2]}    ${redis[3]}    ${key}
    [Return]    ${value}

删除集合一个值
    [Arguments]    ${key}    ${value}    #集合名|值
    ${redis}    String.Split String    ${TNC_RedisStr}    ,
    sremOne    ${redis[0]}    ${redis[1]}    ${redis[2]}    ${redis[3]}    ${key}    ${value}

向集合写一个值
    [Arguments]    ${key}    ${value}    #集合名|值
    ${redis}    String.Split String    ${TNC_RedisStr}    ,
    saddOne    ${redis[0]}    ${redis[1]}    ${redis[2]}    ${redis[3]}    ${key}    ${value}

向一个集合写入多个值
    [Arguments]    ${name}    ${values}    #集合名|列表值
    saddBatch    ${redisIp}    ${redisPort}    ${isRedisCluster}    ${name}    ${values}

查询集合是否存在值
    [Arguments]    ${name}    ${value}    #集合名|值
    ${result}    sismember    ${redisIp}    ${redisPort}    ${isRedisCluster}    ${name}    ${value}
    log    ${result}
    [Return]    ${result}    #查询结果True|False

向hash写一个key value
    [Arguments]    ${name}    ${key}    ${value}
    hset    ${redisIp}    ${redisPort}    ${isRedisCluster}    ${name}    ${key}    ${value}

根据hash name和key名取值
    [Arguments]    ${name}    ${key}
    ${value}    hget    ${redisIp}    ${redisPort}    ${isRedisCluster}    ${name}    ${key}
    [Return]    ${value}

删除hash的一个key
    [Arguments]    ${name}    ${key}
    hdel    ${redisIp}    ${redisPort}    ${isRedisCluster}    ${name}    ${key}
    log    redis清理成功

根据hash name和key取值a
    [Arguments]    ${name}    ${key}
    ${value}    hget    ${redisIp}    ${redisPort}    ${isRedisCluster}    ${name}    ${key}
    [Return]    ${value}

获取String value
    [Arguments]    ${key}
    ${value}    getVerifyCode    ${redisIp}    ${redisPort}    \    ${key}
    [Return]    ${value}

获取String value IVR
    [Arguments]    ${key}
    ${value}    getVerifyCodeIVR    ${redisIp}    ${redisPort}    ${isRedisCluster}    ${key}
    [Return]    ${value}

向有序集合写一个值
    [Arguments]    ${key}    ${score}    ${value}
    ${redis}    String.Split String    ${TNC_RedisStr}    ,
    zaddOne    ${redis[0]}    ${redis[1]}    ${redis[2]}    ${redis[3]}    ${key}    ${score}
    ...    ${value}
