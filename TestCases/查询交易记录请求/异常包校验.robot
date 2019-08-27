*** Settings ***
Resource          ../../KeyWords/Biz/通用业务逻辑处理.robot

*** Test Cases ***
根节点不闭合，不处理，返回请求异常
    ${req_flag}    Set Variable    ${G_interface_names[3]}
    ${reqx}    Set Variable    {\"pubInfo\": {\"appId\": \"12345678\",\"reqTime\": \"20170308100000\",\"ver\": \"1.0\",\"tid\": \"0fad858e5e16c289409d9aa54f627c72\",\"cbUrl\": \"http://www.busiabc.com/openaccountnotice\",\"sign\": \"80e5adaec47d41748628e1715d903ad\"},\"busiInfo\": {\"operType\": 1,\"params\": {\"userId\": \"12345678\",\"credit\": \"60\",\"operTime\": \"20170308100000\",\"abstr\": \"test\"}}
    Set Test Variable    ${reqx}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    1102

pubInfo节点不闭合，不处理，返回请求异常
    ${req_flag}    Set Variable    ${G_interface_names[3]}
    ${reqx}    Set Variable    {"pubInfo": "appId": "12345678","reqTime": "20170308100000","ver": "1.0","tid": "0fad858e5e16c289409d9aa54f627c72","cbUrl": "http://www.busiabc.com/openaccountnotice","sign": "80e5adaec47d41748628e1715d903ad"},"busiInfo": {"operType": 1,"params": {"userId": "12345678 ","credit": "60","operTime": "20170308100000","abstr": "test"}}}
    Set Test Variable    ${reqx}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    1102

pageInfo节点不闭合，不处理，返回请求异常
    ${req_flag}    Set Variable    ${G_interface_names[3]}
    ${reqx}    Set Variable    {"pageInfo":{"currentPage":"0","pageSize":"10","pubInfo": {"appId": "12345678","reqTime": "20170308100000","ver": "1.0","tid": "0fad858e5e16c289409d9aa54f627c72","cbUrl": "http://www.busiabc.com/openaccountnotice","sign": "80e5adaec47d41748628e1715d903ad"},"busiInfo": {"operType": 1,"params": {"userId": "12345678 ","credit": "60","operTime": "20170308100000","abstr": "test"}}}
    Set Test Variable    ${reqx}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    1102

busiInfo节点不闭合，不处理，返回请求异常
    ${req_flag}    Set Variable    ${G_interface_names[3]}
    ${reqx}    Set Variable    {"pageInfo":{"currentPage":"0","pageSize":"10"},"pubInfo": {"appId": "12345678","reqTime": "20170308100000","ver": "1.0","tid": "0fad858e5e16c289409d9aa54f627c72","cbUrl": "http://www.busiabc.com/openaccountnotice","sign": "80e5adaec47d41748628e1715d903ad"},"busiInfo": "operType": 1,"params": {"userId": "12345678 ","credit": "60","operTime": "20170308100000","abstr": "test"}}}
    Set Test Variable    ${reqx}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    1102

节点名称中少单引号，不处理，返回请求异常
    ${req_flag}    Set Variable    ${G_interface_names[3]}
    ${reqx}    Set Variable    {"pageInfo":{'currentPage:"0","pageSize":"10"},"pubInfo": {"appId": "12345678","reqTime": "20170308100000","ver": "1.0","tid": "0fad858e5e16c289409d9aa54f627c72","cbUrl": "http://www.busiabc.com/openaccountnotice","sign": "80e5adaec47d41748628e1715d903ad"},"busiInfo": {"operType": 1,"params": {"userId": "12345678 ","credit": "60","operTime": "20170308100000","abstr": "test"}}}
    Set Test Variable    ${reqx}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    1102

节点名称中少双引号，不处理，返回请求异常
    ${req_flag}    Set Variable    ${G_interface_names[3]}
    ${reqx}    Set Variable    {"pageInfo":{"currentPage:"0","pageSize":"10"},"pubInfo": {"appId": "12345678","reqTime": "20170308100000","ver": "1.0","tid": "0fad858e5e16c289409d9aa54f627c72","cbUrl": "http://www.busiabc.com/openaccountnotice","sign": "80e5adaec47d41748628e1715d903ad"},"busiInfo": {"operType": 1,"params": {"userId": "12345678 ","credit": "60","operTime": "20170308100000","abstr": "test"}}}
    Set Test Variable    ${reqx}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    1102

节点中括号比闭合，不处理，返回请求异常
    ${req_flag}    Set Variable    ${G_interface_names[3]}
    ${reqx}    Set Variable    {"pageInfo":{"currentPage":[,"pageSize":"10"},"pubInfo": {"appId": "12345678","reqTime": "20170308100000","ver": "1.0","tid": "0fad858e5e16c289409d9aa54f627c72","cbUrl": "http://www.busiabc.com/openaccountnotice","sign": "80e5adaec47d41748628e1715d903ad"},"busiInfo": {"operType": 1,"params": {"userId": "12345678 ","credit": "60","operTime": "20170308100000","abstr": "test"}}}
    Set Test Variable    ${reqx}
    发送Reqx请求    /${req_flag}
    校验应答返回码信息    1102
