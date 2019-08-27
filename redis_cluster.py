
#coding:utf-8


from rediscluster import StrictRedisCluster
import sys


def redis_cluster():
    redis_nodes = [ {"host": "10.12.8.201", "port": "7004"}]

    redisconn = StrictRedisCluster(startup_nodes=redis_nodes,password='mm_tnc',decode_responses=True)
    print("name is: ", redisconn.get('KEY_PRELICENSE_BALANCE_2000010017001'))
            
redis_cluster()