*** Settings ***
Library           OperatingSystem
Library           json    # 尽管显示红色，但实际可以运行
Library           ../../Library/JSONLibrary.py
Library           String
Library           Collections
Library           json_compare

*** Keywords ***
读取包结构
    [Arguments]    ${template}
    [Documentation]    读取template目录下的模板文件，保存到测试变量reqx中
    ${json_template}=    OperatingSystem.Get File    ${EXECDIR}${/}Resources${/}Template${/}${template}
    ${json_obj}    json.Loads    ${json_template}    encoding=utf-8
    ${reqx}    json.Dumps    ${json_obj}
    Set Test Variable    ${reqx}
    [Return]    ${reqx}

删除不用节点
    [Arguments]    @{keys}
    [Documentation]    根据后面的k值删除json节点，返回json串，并设置为reqx
    ${json_obj}    json.Loads    ${reqx}
    : FOR    ${k}    IN    @{keys}
    \    JSONLibrary.Delete Object From Json    ${json_obj}    ${k}
    ${reqx}    json.Dumps    ${json_obj}
    Set Test Variable    ${reqx}
    [Return]    ${reqx}

添加新节点
    [Arguments]    ${obj_path}    ${obj_value}
    [Documentation]    根据后面的路径和字典值添加json节点，返回json串，并设置为reqx
    ${json_obj}    json.Loads    ${reqx}
    ${json_obj}    JSONLibrary.Add Object To Json    ${json_obj}    ${obj_path}    ${obj_value}
    ${reqx}    json.Dumps    ${json_obj}
    Set Test Variable    ${reqx}
    [Return]    ${reqx}

重置节点数据
    [Arguments]    @{key_value}
    [Documentation]    根据template目录下的模板文件名，根据后面的k=v修改json串，返回json串
    ${json_obj}    json.Loads    ${reqx}
    : FOR    ${kv}    IN    @{key_value}
    \    ${jsonpath_value}    String.Split String    ${kv}    =    1
    \    JSONLibrary.update_value_to_json    ${json_obj}    ${jsonpath_value[0]}    ${jsonpath_value[1]}
    \    Comment    log    ${json_obj}
    ${reqx}    json.Dumps    ${json_obj}
    Set Test Variable    ${reqx}
    [Return]    ${reqx}

字符串转Json对象
    [Arguments]    ${json_str}
    ${json_obj}    json.loads    ${json_str}
    [Return]    ${json_obj}

解析Json串
    [Arguments]    ${json_str}    ${encoding}=${None}
    [Documentation]    return json对象
    comment    由于还有特定的树组模式的返回，而且目前没有发现有多元素的情况，所以左右做trim
    log    ${json_str}
    Comment    ${json_str}    String.Decode Bytes To String    ${json_str}    encoding=unicode-escape
    ${json_str}    String.Decode Bytes To String    ${json_str}    encoding=utf-8
    ${json_str}    String.Strip String    ${json_str}    mode=left    characters=[
    ${json_str}    String.Strip String    ${json_str}    mode=right    characters=]
    log    ${json_str}
    ${json_obj}    json.Loads    ${json_str}
    Set Test Variable    ${json_obj}
    [Return]    ${json_obj}

获取Json变量值
    [Arguments]    ${json_obj}    ${json_path}
    [Documentation]    jsonpath的写法:
    ...    $为根; ..为多级目录; .为当前目录
    log    ${json_obj}
    log    ${json_path}
    ${value}    JSONLibrary.Get Value From Json    ${json_obj}    ${json_path}
    [Return]    ${value[0]}

更新Json变量值
    [Arguments]    ${json_obj}    ${json_path}    ${new_value}
    [Documentation]    jsonpath的写法:
    ...    $为根; ..为多级目录; .为当前目录
    ${json_obj}    JSONLibrary.Update Value To Json    ${json_obj}    ${json_path}    ${new_value}
    [Return]    ${json_obj}

删除Json节点
    [Arguments]    ${json_obj}    ${json_path}
    [Documentation]    jsonpath的写法:
    ...    $为根; ..为多级目录; .为当前目录
    log    ${json_path}
    ${json_obj}    JSONLibrary.Delete Object From Json    ${json_obj}    ${json_path}
    [Return]    ${json_obj}

添加Json节点
    [Arguments]    ${json_obj}    ${json_path}    ${new_obj}
    [Documentation]    ${new_obj}可以为串，也可以为dict
    ${json_obj}    JSONLibrary.Add Object To Json    ${json_obj}    ${json_path}    ${new_obj}
    [Return]    ${json_obj}

校验json_schema
    [Arguments]    ${json_obj}    ${schema_obj}    ${cls}=${None}
    jsonschema.Validate    ${json_obj}    ${schema_obj}    cls=${cls}

获取Json对象节点
    [Arguments]    ${json_obj}    ${json_path}
    [Documentation]    jsonpath的写法:
    ...    $为根; ..为多级目录; .为当前目录
    ${node_obj}    JSONLibrary.Get Value From Json    ${json_obj}    ${json_path}
    [Return]    ${node_obj}

用字典重置节点数据
    [Arguments]    ${dict}
    [Documentation]    读取template目录下的模板文件名，根据后面的k值添加json节点，返回json串，并设置为reqx
    ${json_obj}    json.Loads    ${reqx}
    @{keys}    Get Dictionary Keys    ${dict}
    Comment    log    @{keys}
    : FOR    ${key}    IN    @{keys}
    \    log    ${key}
    \    Comment    ${jsonpath_value}    String.Split String    ${kv}    =
    \    ${jsonpath_value}    Get From Dictionary    ${dict}    ${key}
    \    更新Json变量值    ${json_obj}    ${key}    ${jsonpath_value}
    ${reqx}    json.Dumps    ${json_obj}
    Set Test Variable    ${reqx}
    [Return]    ${reqx}

校验两个json串
    [Arguments]    ${json_a}    ${json_b}
    ${result}    json_compare.are Same    ${json_a}    ${json_b}
    log    ${result}
    Should be True    ${result[0]}
