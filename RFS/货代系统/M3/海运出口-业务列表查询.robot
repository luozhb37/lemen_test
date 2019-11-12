*** Settings ***
Suite Setup       登录
Suite Teardown    close all browsers
Resource          ../../Resources/M3基础操作/M3--引用.txt

*** Test Cases ***
查询-日期按
    [Documentation]    审核日期、装箱日期缺失
    #接单日期
    日期初始化
    ${BUSINESSNO-SUIT-SEAEXPORT}    新增海运出口-查询    ${PLAN-ETD-DATE}    ${ETD-DATE}    ${ETA-DATE}    ${COMPLETE-DATE}    ${ETC-DATE}
    ...    ${PUTCABIN-DATE}
    查询    result=1    value1=1    start-date=${ACCEPT-DATE}    end-date=${ACCEPT-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #离港日期
    查询    result=0    value1=2    start-date=${ACCEPT-DATE}    end-date=${ACCEPT-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=1    value1=2    start-date=${ETD-DATE}    end-date=${ETD-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #抵港日期
    查询    result=0    value1=3    start-date=${ETD-DATE}    end-date=${ETD-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=1    value1=3    start-date=${ETA-DATE}    end-date=${ETA-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #完结日期
    查询    result=0    value1=4    start-date=${ETA-DATE}    end-date=${ETA-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=1    value1=4    start-date=${COMPLETE-DATE}    end-date=${COMPLETE-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #截关日期
    查询    result=0    value1=6    start-date=${COMPLETE-DATE}    end-date=${COMPLETE-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=1    value1=6    start-date=${ETC-DATE}    end-date=${ETC-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #放舱日期
    查询    result=0    value1=7    start-date=${ETC-DATE}    end-date=${ETC-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=1    value1=7    start-date=${PUTCABIN-DATE}    end-date=${PUTCABIN-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #预配船期
    查询    result=0    value1=8    start-date=${PUTCABIN-DATE}    end-date=${PUTCABIN-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=1    value1=8    start-date=${PLAN-ETD-DATE}    end-date=${PLAN-ETD-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #创建日期
    查询    result=0    value1=10    start-date=${PLAN-ETD-DATE}    end-date=${PLAN-ETD-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=1    value1=10    start-date=${ACCEPT-DATE}    end-date=${ACCEPT-DATE}    value8=${BUSINESSNO-SUIT-SEAEXPORT}

查询-退关状态
    ${BUSINESSNO-SUIT-SEAEXPORT}    新增海运出口-查询
    查询    result=1    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    批量操作-标记退关
    查询    result=1    value2=true    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #查询未退关
    查询    result=0    value2=false    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #查询全部
    查询    result=1    value2=-1    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    批量操作-取消退关
    #查询未退关
    查询    result=1    value2=false    value8=${BUSINESSNO-SUIT-SEAEXPORT}

查询-服务类型
    [Setup]    个性设置-勾选所有服务
    ${BUSINESSNO-SUIT-SEAEXPORT}    新增海运出口-查询
    #订舱服务
    查询    result=1    value5=bookingservice    yesorno2=true    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=0    value5=bookingservice    yesorno2=false    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #陆运服务
    查询    result=1    value5=landservice    yesorno2=true    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=0    value5=landservice    yesorno2=false    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #报关服务
    查询    result=1    value5=customerservice    yesorno2=true    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=0    value5=customerservice    yesorno2=false    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #报检服务
    查询    result=1    value5=inspectservice    yesorno2=true    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=0    value5=inspectservice    yesorno2=false    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #押箱服务
    查询    result=1    value5=pawnservice    yesorno2=true    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=0    value5=pawnservice    yesorno2=false    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #内装（进仓）
    查询    result=1    value5=sendgoodsservice    yesorno2=true    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=0    value5=sendgoodsservice    yesorno2=false    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    #请选择
    查询    result=1    value5=-1    yesorno2=true    value8=${BUSINESSNO-SUIT-SEAEXPORT}

查询-托运类型
    ${BUSINESSNO-SUIT-SEAEXPORT}    新增海运出口-查询
    #查询FCL
    查询    result=1    value6=1    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    修改台帐    ${BUSINESSNO-SUIT-SEAEXPORT}    2
    #再查询FCL为0，查询LCL有 \
    查询    result=0    value6=1    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=1    value6=2    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    修改台帐    ${BUSINESSNO-SUIT-SEAEXPORT}    3
    查询    result=0    value6=2    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=1    value6=3    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    修改台帐    ${BUSINESSNO-SUIT-SEAEXPORT}    5
    查询    result=0    value6=3    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=1    value6=5    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    查询    result=1    value6=-1    value8=${BUSINESSNO-SUIT-SEAEXPORT}

查询-状态按

*** Keywords ***
查询
    [Arguments]    ${result}    ${value1}=1    ${start-date}=    ${end-date}=    ${value2}=false    ${value3}=false
    ...    ${value4}=-1    ${yesorno1}=true    ${value5}=-1    ${yesorno2}=true    ${value6}=-1    ${value7}=-1
    ...    ${value8}=    # 结果：0,1
    海运出口业务列表查询    ${value1}    ${start-date}    ${end-date}    ${value2}    ${value3}    ${value4}
    ...    ${yesorno1}    ${value5}    ${yesorno2}    ${value6}    ${value7}    ${value8}
    ${pages}    获取列表记录数
    应该包含    ${pages}    共${result}条

新增海运出口-查询
    [Arguments]    ${plan-etd-date}=    ${etd-date}=    ${eta-date}=    ${complete-date}=    ${etc-date}=    ${putcabin-date}=
    ...    ${mblno}=    ${vesselname}=    ${voyno}=    # 预配船期、离港日期、抵港日期、完结日期、截关日期、放舱日期、主单号、船名、航次
    点击业务管理
    点击业务台帐
    点击海运出口
    进入列表页面框架
    点击    id=bt_add    #新增
    离开框架
    进入详情框架
    输入    id=bn_mains_mblno    ${mblno}    #主单号
    输入    id=bn_mains_vesselname    ${vesselname}    #船名
    输入    id=bn_mains_voyno    ${voyno}    #航次
    输入    id=bn_assistants_planetd    ${plan-etd-date}    #预配船期
    输入    id=bn_mains_customername    ${往来单位}    #${往来单位_CODE}
    输入    id=bn_mains_etd    ${etd-date}    #离港日期
    输入    id=bn_mains_eta    ${eta-date}    #抵港日期
    输入    id=bn_mains_completedate    ${complete-date}    #完结日期
    输入    id=bn_mains_etc    ${etc-date}    #截关日期
    输入    id=bn_mains_putcabindate    ${putcabin-date}    #放舱日期
    输入    id=bn_mains_bookingdate    2019-09-30 15:15:00    #订舱日期
    等待    1
    勾选记录    xpath=//input[@name='bn_mains_stblconfirmfinish_TempCheck']    #勾选提单确认
    点击    id=bt_save    #点击保存
    等待    1
    ${status}    run keyword and return status    confirm弹出框选择确认
    #等待直到定位到 业务编号
    Wait Until Page Contains Element    xpath=//span[@elementname='bn_mains_businessno']/span[2]
    离开框架
    ${BUSINESSNO-SUIT-SEAEXPORT}    业务台帐保存后获取业务编号-海运出口
    关闭所有弹出框
    [Return]    ${BUSINESSNO-SUIT-SEAEXPORT}

日期初始化
    ${ACCEPT-DATE}=    当前日期加减天数    +0    #接单日期
    ${etc-day}    当前日期加减天数    +1    #截关日期
    ${ETC-DATE}    catenate    ${etc-day}    09:06:08
    ${PLAN-ETD-DATE}    当前日期加减天数    +2    #预配船期
    ${ETD-DATE}    当前日期加减天数    +3    #离港日期
    ${ETA-DATE}    当前日期加减天数    +4    #抵港日期
    ${COMPLETE-DATE}    当前日期加减天数    +5    #完结日期
    ${putcabin-day}    当前日期加减天数    +6    #放舱日期
    ${PUTCABIN-DATE}    catenate    ${putcabin-day}    09:06:08
    Set Suite Variable    ${ACCEPT-DATE}
    Set Suite Variable    ${ETC-DATE}
    Set Suite Variable    ${PLAN-ETD-DATE}
    Set Suite Variable    ${ETD-DATE}
    Set Suite Variable    ${ETA-DATE}
    Set Suite Variable    ${COMPLETE-DATE}
    Set Suite Variable    ${PUTCABIN-DATE}

修改台帐
    [Arguments]    ${business-no}    ${value1}    # 业务编号、托运类型、
    [Documentation]    bn_mains_seaconsigntype ：
    ...    FCL:1 \ LCL:2 \ BULK:3 \ BREAK BULK:5
    进入台帐详情    ${business-no}
    进入详情框架
    下拉选择byValue    id=bn_mains_seaconsigntype    ${value1}    #托运类型
    点击    id=bt_save    #点击保存
    离开框架
    关闭所有弹出框

维护装箱信息
    ${mblno}    生成一个带有字符的随机数    mbl
    ${vesslname}    生成一个带有字符的随机数    vess
    ${voyno}    生成一个带有字符的随机数    vo
    ${sealno}    生成一个带有字符的随机数    seal
    ${ctnno}    生成一个带有字符的随机数    ctn
    ${BUSINESSNO-SUIT-SEAEXPORT}    新增海运出口-查询    mblno=${mblno}    vesslname=${vesslname}    voyno=${voyno}    etd-date=2019-09-30
    查询    result=1    value8=${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    业务信息-点击装箱
    装运信息-新增集装箱    sealno=${sealno}    ctnno=${ctnno}
    装运信息-标记已打印
    关闭所有弹出框

维护费用信息
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    新增收入费用    1000    1    RMB    1
    新增支出费用    300    1    RMB    1
    费用信息页面勾选收入费用    1
    费用确认
    费用信息页面勾选收入费用    1
    费用信息页面点击开票
    费用信息页面-明细开票
