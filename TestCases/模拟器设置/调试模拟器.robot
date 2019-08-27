*** Settings ***
Resource          ../../KeyWords/Biz/准备测试环境.robot
Resource          ../../KeyWords/Biz/数据上链业务.robot

*** Test Cases ***
调试模拟器
    Comment    监控链层节点数据    A    net.peerCount
    读取链上用户余额
