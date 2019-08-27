#-*- coding:utf-8 -*-
'''robot补丁
'''
from robot.api import logger

import JsonValidator
from JsonValidator import JsonValidatorError
from jsonpath_rw.parser import DatumInContext, Index, Fields
def update_json_patch(self, json_string, expr, value, index=0):
    # patch start
    #logger.trace('value:%s' % value)
    if value.lower().startswith('(int)'):
        value = int(value.lstrip('(int)'))
    elif value.lower().startswith('(bool)'):
        #logger.trace('value startswith bool! %s  ' % value.lower())
        if value.lower().find('true') != -1:
            #logger.trace('value find true, so , True')
            value = True
        else:
            #logger.trace('value not find true, so , False')
            value = False
    else:
        pass
    if value == u"None":
        value = None
    # patch end
        
    load_input_json = self.string_to_json(json_string)
    matches = self._json_path_search(load_input_json, expr)

    datum_object = matches[int(index)]

    if not isinstance(datum_object, DatumInContext):
        raise JsonValidatorError("Nothing found by the given json-path")

    path = datum_object.path

    # Edit the directory using the received data
    # If the user specified a list
    if isinstance(path, Index):
        datum_object.context.value[datum_object.path.index] = value
    # If the user specified a value of type (string, bool, integer or complex)
    elif isinstance(path, Fields):
        datum_object.context.value[datum_object.path.fields[0]] = value

    return load_input_json

JsonValidator.JsonValidator.update_json = update_json_patch

def custom_json_value_lstrip(custom_str):
    '''由于自定了json中的value，所以在校验时，需要对可能存在的类型定义做lstrip的动作
       例如json_value, 由(int)10,转换为10
       目前处理(int),(bool),(long)
    '''
    result_str = custom_str
    for prefix in ['(int)', '(bool)', '(long)']:
        if custom_str.startswith(prefix):
            logger.trace(u'发现需要处理的prefix，直接lstrip()，prefix:%s' % prefix)
            result_str = custom_str.lstrip(prefix)
            break
    return result_str