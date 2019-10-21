#-*- coding:utf-8 -*-
import time
import os
import types

def data_split(datavalue,fh=" "):

    if not fh:
        fh=" ";
    return datavalue.split(fh);

def steplog(msg):
    '''
    写入格式如:
    2015-12-14   XXXXX
    '''
#    print type(msg)
    #RF传入的是UnicodeType,先转成str
    if type(msg) is types.UnicodeType:
        msg=msg.encode('utf-8')
    path=os.getcwd()
    projectpath=os.path.abspath(os.path.join(os.path.dirname(__file__), os.pardir))
    logpath=projectpath+os.sep+"steplog"
    if not os.path.exists(logpath):
        logpath=os.mkdir(projectpath+os.sep+"steplog")
    print logpath
    try:
        with open(logpath+os.sep+time.strftime("%Y-%m-%d")+'log.txt','a') as logs:
            logs.write(time.strftime("%H:%M:%S") + "    "+msg+"\n")
    except Exception, e:
        raise e

def click_alert(self,YesOrNo="yes"):
    '''
    |yes|点击确认
    |no|点击取消
    '''
    alert =self._current_browser().switch_to_alert()
    if not alert:
        #return 'No Alert!'
        pass
    elif YesOrNo=="yes":
        alert.accept()
    else:
        alert.dismiss()