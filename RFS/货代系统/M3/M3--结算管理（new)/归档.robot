*** Settings ***
Resource          ../../../Resources/M3基础操作/M3--引用.txt

*** Test Cases ***
呆坏账管理--强制结清并取消强制结清
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用
    关闭所有弹出框
    点击业务管理
    点击结算管理
    点击归档
    点击呆坏账管理
    强制结清后取消强制结清    ${BUSINESSNO-SUIT-SEAEXPORT}
    点击结算管理

凭证导出
    凭证导出系统参数初始化-步骤1
    新增海运出口业务台账
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    #新增费用
    新增收入费用    1000    1    RMB    1
    关闭所有弹出框
    点击业务管理
    #按业务明细开票
    点击结算管理
    点击发票
    点击新增发票
    点击按业务-新增发票
    查询-新增发票（按业务）    qyinv_datetype=1    qybu_elementname=businessno    qybu_elementvalue=${BUSINESSNO-SUIT-SEAEXPORT}    #按接单日期，业务编号查询
    全选记录-列表页面
    按业务列表页面点击开票
    Select Frame    xpath=//iframe[starts-with(@src,'about:blank?___')]
    #select frame by index    tag=iframe    -1
    点击    id=bt_invoice_detail    #明细开票
    等待    1
    离开框架
    Select Frame    xpath=.//h3[contains(text(),'填写发票号')]/../following-sibling::div[1]/iframe
    #select frame by index    tag=iframe    -1
    点击    id=bt_next_sum    #点击确认
    等待    1
    离开框架
    Select Frame    xpath=//iframe[starts-with(@src,'about:blank?___')]
    #select frame by index    tag=iframe    -1
    ${sign_invoiceno}    获取页面文本内容    xpath=.//*[contains(text(),"发票号")]/following-sibling::td[1]    #获取发票号
    离开框架
    关闭所有弹出框
    #查询发票管理中存在该发票
    发票管理-收入列表查询    qy_mains_datatype=1    write_invoiceno=${sign_invoiceno}
    ${content}    获取列表记录数
    应该包含    ${content}    共1条
    点击结算管理
    #费用列表查看发票号
    ${fee_invoiceno}    费用列表获取收入费用发票号    ${BUSINESSNO-SUIT-SEAEXPORT}
    应该要相等    ${fee_invoiceno}    ${sign_invoiceno}
    Reload Page
    点击结算管理
    点击归档
    点击财务接口
    进入列表页面框架
    输入    id=qycer_invoiceno    ${fee_invoiceno}
    点击    id=bt_query
    点击    name=SHEET_ROW_SELECT_ALL
    点击    id=bt_voucher_export
    离开框架
    sleep    3
