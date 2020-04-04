*** Settings ***
Suite Setup       登录    # Run keywords
Suite Teardown    close all browsers
Test Setup        Reload Page
Resource          ../../../Resources/M3基础操作/M3--引用.txt

*** Test Cases ***
新增订单-海运出口
    点击订单管理
    点击订单查询
    进入列表页面框架
    点击    xpath=//a[@id='bt_add']    #点击新增按钮
    Selenium2Library.Unselect Frame
    进入框架    xpath=//iframe[contains(@id,'win_')]    #进入iframe
    输入    bn_bookings_customername    Air France    #委托单位
    清空输入框内容    xpath=//input[@id='bn_bookings_sales']
    输入    bn_bookings_sales    生产-自动化1    #销售员
    点击    xpath=//a[@id='bt_save']    #保存
    点击    xpath=//i[@class='icon-close']    # 关闭弹窗
