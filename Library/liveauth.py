#coding=utf-8

from jpype import *
import os.path

def getliveparam(content, keyStr):
    # 这里传参，参数两个content, keyStr
    # 这里传参可以先写默认值，我这里的默认值都是''空，有默认值时robotframework调用时可以不传参
    # 也可以不要默认值，不哟啊默认值在调用时必须传参，不然会报错，
    # 不要默认值上面该这样写：getliveparam(content, keyStr)
    """
    传入两个值content、keyStr并返回加密值base64param

    查看注释
    Example:
    | ${result}        | getliveparam          | content         | keyStr    |
    """
    # 获取jar包地址，os.path.abspath('.')返回当前工作地址，也就是robotframework项目文件夹
    home = os.path.abspath('.')
    print(home)
    jarpath = os.path.join(os.path.abspath(
        '.'), home + '/javalibs/CryptUtil.jar')
    # 上面那句也可以如下写成绝对地址，写成绝对地址时可以将jar包放在任意位置，但jar位置变了这里就得改
    #jarpath = os.path.join(os.path.abspath('.'), 'D:/test/javalibs/Execute02.jar')

    # 启动java虚拟机
    if not isJVMStarted():  # 如果jvm没启动才执行启动操作
        startJVM(getDefaultJVMPath(), "-ea",
                 "-Djava.class.path=%s" % jarpath)
    
    # 获取类，这里是包名和类名，报名从第一层开始写
    Execut = JClass('CryptUtil')
    # 或者通过JPackage引用Test类
    # com = JPackage('test.authentication').Execute02()

    # 调用相关方法函数
    t = Execut()
    #res = t.encryptBy3DesAndBase64(content, keyStr)
    res = t.encryptBy3DesAndBase64(content.encode("UTF-8"), keyStr)
    print(content)

    # 返回从java方法中获取的值
    return res
    shutdownJVM()


# 用完后记得关闭java虚拟机，当然python程序退出时JVM也会自动关闭
if __name__ == '__main__':
    res = getliveparam('15818640852', '26355dfec55345d4905b3bf93f6eb29c')
    print(res)
