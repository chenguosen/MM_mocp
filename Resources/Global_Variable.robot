*** Settings ***
Library           random
Library           DateTime
Library           OperatingSystem
Library           String    # Library    ../Library/robotPatch.py

*** Variables ***
&{G_GateWay_Servs}    A=http://10.12.8.220:38080    B=http://10.12.8.219:38080    Adz=http://10.12.8.220:8088
&{G_Contracts}    A=http://10.1.32.23:8545,7874ab4b02c4313a840bad86337a6a743303eadb    B=http://10.12.8.217:8501,2de48d370e2660e174c3ef7dfd06cce49ddcd460    C1=http://10.1.32.23:8545,7874ab4b02c4313a840bad86337a6a743303eadb    A1=http://10.12.8.219:8501,2de48d370e2660e174c3ef7dfd06cce49ddcd460
${G_SimGateWay}    http://10.12.8.219:8099    # 模拟器请求地址
${G_RuntimePath}    ${EMPTY}
${G_MysqlConnStr}    host='10.12.3.235', port=3310,user='aspchain_tst', passwd='aspchain_tst', db='db2_chain', charset='utf8'
${G_MysqlConnStr1}    host='10.12.8.229', port=3310,user='recover', passwd='chp654000', db='db2_chain', charset='utf8'
${G_RedisStr}     10.12.8.220,6378,0,aspire+888
${kafkaServers}    10.5.2.194:9092,10.5.2.194:9093
${kafkaTopic}     test
${kafkaTimeOut}    20000
${kafkagroupid}    xiecs_IP
&{G_AppsInfo}     104567=abcdghj-2019090_201029301abc    101305=abcdghj-2019090_201029301abc    123456=chenguosen_chenguosen_sdfd
&{G_ResultCode}    9001=无效的接口请求时间    0000=成功    9002=无效的接口版本号    9998=无效的请求参数    9997=无效的params适配参数    1102=黑名单限制    1101=无效的应用ID
...               9005=无效的签名    9999=其他错误    9003=无效的交易流水号
&{G_Chain_Code}    0000=成功    0001=交易失败(交易已上链)    0002=上链中    9999=通用失败
&{G_GateWay_Hosts}    A=10.12.8.220,tstchain,tchn#220$,bzlog    B=10.12.8.217,sudoroot,aspire+888,/opt
&{G_ASPChain_Hosts}    A=10.12.8.216,aspchain,chn@216!,node    B=10.12.8.217,aspchain,chn@217!,node
&{G_GateWay_Logs}    A=10.12.8.216,chaintst,aspire+888,log    B=10.12.8.217,sudoroot,aspire+888,/opt
@{G_interface_names}    sendAspSmsCode    querydata    queryresult    querystatements    generateDailyReconciliationFile    # 0-sendAspSmsCode 1-querydata 2-queryresult 3-querystatements
@{G_dzfile_path}    .\/gateway_adapter\/dzf    .\/bizlog
${G_Chain_Delay}    15
${G_dzfile_Delay}    10
&{TNC_GateWay_Servs}    client=http://10.12.8.201:9999    server=http://10.1.5.192:8082
@{TNC_interface_names}    sendAspSmsCode    realNameAuth    getOnlineStatus    getOnlineTime    none    verifyMobile
${TNC_MysqlConnStr}    host='10.1.4.48', port=3306,user='mm_tnc', passwd='mm_tnc', db='tnc_db2', charset='utf8'
${TNC_RedisStr}    10.12.8.200,7000,1,mm_tnc
${TNC_token}      eyJjIjoiaXl0dFA1Z2F0SU5jYTlYYTB6WFAvL0tlM3FQaG5Namc5dUd5U2dNZ2NIcUVjaVR2UWJKR05FT2pzZmZBIFd4TVBpR0RiSGpSUUUzMXYyZ3FMR0NvTmJZUmxDR3EzbkFWMXBGeEM3YXJib2xNTlROUjFEV2xnZXlvRCB3K2EzNkRyZDNGUU9PVDNZSURCTVNtV25zQjFFcGlxcENkVHdFWkgrL2tLU0xJc0RIMGllYU5tRGtJMWEgRkdpUGtzZ0xEYWZjQUR5cnc3cnp6MVB0bTludHhVb2MzRm9MbVh3LzdrblV0eWd2dlRvRWxlL25iMGpJIDdsbjh2TklwOGlCbWcvN2MvQlNONHAxdlk3dndwZ2NBTzdYK2p1d25WbmluZUg2VVpUdHd0WThTbHNzdSBNWVlLV0I0b2MxNFRFbVhaZzV6ZzBWQXpaWGxXWU5ISFh6S3dJVGZXQ1hZK3Nib28wRWFSUDFwTmVwQVggWEE5YnVtM0RtNHBML3VGOHQwdHVhTVhWYm5sUjBERmJxUlNCSGhTdWF1aDFzbzRYY29SMnBtZ3lvM29FIEtvZnNNQmtKMG9KQldGbXNueCt2eXZEK1lzcG9Cb2ZEdWEwT2tMeWpQbXY3OEpNb3VrWExIb3RuSE5QSiAzUW9YRWtLMHY1aE41NStqRU9GUHdPTHFuRHk3US81T2s5T1lYdlErNjZCYVo1Q1JRaFNCUW5VMU84eHYgYjRBdUJNUk0wTm1pUGRqMTBSMlJWVVd4ejlmLzUvQWQ2bUEzL01YMCtzYVNHNERvU1RKR28vZE5QZlBuIDBNUkNrU2VTcytDMm5idVZmMlk9IiwiayI6Ik5YZmhnelFxdUdLWWJXaFA2dWZDTi83Tk8xYkxoYmljTDZxOUR3c1Y1cTFYYmJuSllXTEltNFpRQ1NXUWkwY0huY2tQQVVxVGNEVC9RK0k2VS9vTEJyTm5LUTgvN0l2emdkKzlkRmwvWGlsK0N3SnVvN0FibjBORUh6ZkZQclJ5QkwwVjNJRzUwMlB5N3djRXZZMklhb1pnajJURnhEcERvUmxKdDZsNlpXQlJ2TlpVMGxjcGlIODg5Ty9HVGVWT3hQSmFMUUdmK0FJakFYQjQzeVBiRXErS1NzV0dCaFJpUW0yWmNSRkJEY2xXaFdhNXltV1RRQk9KblVydVBBRW5DaVMwMWVZMTRmYmZFL2lNOHpHM0haTTVGRDJIUzJqazFqdkhORXBReVJRWjF4VXpocjk5UE9LUWhBQkFYZG1RdHVybU1zNzRuK3o5bENZRVpCM3lSUT09IiwibyI6IkFuZHJvaWQifQ==
&{TNC_Hosts}      A=10.12.8.200,mm_tnc,mm_tnc!@#1

*** Keywords ***
