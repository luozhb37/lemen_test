*** Settings ***
Suite Setup       Run keywords    系统参数设置-费用核销模式
...               AND    登录
...               AND    新增海运出口业务
Suite Teardown    close all browsers
Test Setup        Reload Page
Resource          ../../../../../Resources/M3基础操作/M3--引用.txt
