#!/usr/bin/python
# -*- coding: UTF-8 -*-

str = "$.msgReq.msgBody.systemTime=20190723095551746"
print (str.split('='))       # 以空格为分隔符，包含 \n
#print (str.split('=', 1))  # 以空格为分隔符，分隔成两个
