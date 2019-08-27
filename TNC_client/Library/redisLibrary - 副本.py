# -*- coding: utf-8 -*-

'''
Created on 2017-7-10

@author: wangmianjie

install:
 easy_install redis
'''
import redis
from rediscluster import RedisCluster

from rediscluster import StrictRedisCluster 

def getRedisConn(hostIp, port, isCluster, passwd=None):
    if isCluster == '1' :
        startup_nodes = [{"host": hostIp, "port": port}]
        return StrictRedisCluster(startup_nodes=startup_nodes, decode_responses=True)
    else :
        if(passwd is None):
            return redis.StrictRedis(hostIp, int(port))
        else:
            return redis.StrictRedis(hostIp, int(port), password=passwd)
        

def redisFlushall(hostIp, port, isCluster, passwd=None):
    """清空整个redis
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    redisConn.flushall()

''' String类型操作'''
def setString(hostIp, port, isCluster, passwd, key, value):
    """设置String类型的值
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    redisConn.set(key, value)  

def setStringForDict(hostIp, port, isCluster, passwd, redisDict):
    """批量设置String类型的 key和value，参数为dict类型
    """
    dictObj = eval(redisDict)
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    for (key, value) in dictObj.items():
        redisConn.set(key, value)

def getStringByKey(hostIp, port, isCluster, passwd, key):
    """根据key获取值
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    return redisConn.get(key) 

''' 集合操作 ''' 
def saddOne(hostIp, port, isCluster, passwd, key, value):
    """设置一条集合类型的值
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    redisConn.sadd(key, value)
        
def saddBatch(hostIp, port, isCluster, passwd, key, values):
    """向一个集合写入多个值， 值的格式为: a|b|c
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    valueList = values.split('|')
    for value in valueList:
        redisConn.sadd(key, value)

def sremOne(hostIp, port, isCluster, passwd, key, value):
    """删除一条集合类型的值
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    redisConn.srem(key, value)  
    
def sremBatch(hostIp, port, isCluster, passwd, key, values):
    """删除一条集合类型的多个值,， 值的格式为: a|b|c
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    for value in values.split('|'):
        redisConn.srem(key, value) 
        
def sismember(hostIp, port, isCluster, passwd, key, value):
    """查看集合的一个值是否存在
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    return redisConn.sismember(key, value)  
    
''' hash操作 '''
def hset(hostIp, port, isCluster, passwd, name, key, value):
    """设置hash类型的的值，一次一条
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    redisConn.hset(name, key, value)
    
def hsetByDict(hostIp, port, isCluster, passwd, name, dict):
    """向集合类型的key批量增加值，
    """
    dictObj = eval(dict)
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    for (key, value) in dictObj.items():
        redisConn.hset(name, key, value)
        
def hget(hostIp, port, isCluster, passwd, name, key):
    """取一个hash的某个key的值
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    return redisConn.hget(name, key)
    
def hdel(hostIp, port, isCluster, passwd, name, key):
    """删除hash类型数据的一个字段
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    redisConn.hdel(name, key)
        
def getVerifyCode(hostIp, port, isCluster, passwd, key):
    """
    获取value，string类型，value以：分隔
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    return redisConn.get(key).split(':')[1]
	
def getVerifyCodeIVR(hostIp, port, isCluster, passwd, key):
    """
    获取value，string类型，value以：分隔
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    return redisConn.get(key).split(',')[1]

def getVerifyCodePicSms(VerifyCode):
    smsVerifyCode = VerifyCode.split(';')[0].split(':')[1]
    pictureVerifyCode = VerifyCode.split(';')[1].split(':')[1]
    
    return smsVerifyCode, pictureVerifyCode  

def delete1(hostIp, port, isCluster, passwd, key):
    """删除key
    """
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    redisConn.delete(key)
    
def getFieldValueByHash(hostIp, port, isCluster, passwd, key, fieldName):
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    dict = redisConn.hgetall(key)
    return dict[fieldName]


def delFieldByHash(hostIp, port, isCluster, passwd, key, fieldName):
    redisConn = getRedisConn(hostIp, port, isCluster, passwd)
    redisConn.hdel(key, fieldName)
    
if __name__ == "__main__":

    hostIp = u'10.12.8.147'
    port = u'7000'
    
    isCluster = '1'
    name = 'dbcache_ProductInfo_011'
    key = '2a81897f3a8f4856a1b567ef3e9d55e9_13420000101'
    value = '100'
    
    # print getVerifyCode(hostIp, port, isCluster, key)

    # print hset(hostIp, port, isCluster, name, key, value)

    


    
    
    
    



    
    
