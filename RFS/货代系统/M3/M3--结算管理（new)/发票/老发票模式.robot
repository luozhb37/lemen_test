*** Settings ***
Suite Setup       RUN KEYWORDS    系统参数设置-老发票模式
...               AND    登录
...               AND    新增海运出口业务
Suite Teardown    close all browsers
Test Setup        Reload Page
Resource          ../../../../Resources/M3基础操作/M3--引用.txt

*** Test Cases ***
汇总开票-按业务（两个业务）-新增发票页面1
    新增海运出口业务-删除专用    bn_mains_vesselname=${BN_MAINS_VESSELNAME}    #获得第一个业务台账新增的船名
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    #新增费用
    ${row}    新增收入费用-选定费用
    关闭所有弹出框
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT}
    从业务列表进入费用页面
    #新增费用
    ${row1}    新增收入费用-选定费用
    关闭所有弹出框
    点击业务管理
    #按业务汇总开票
    点击结算管理
    点击发票
    点击新增发票
    点击按业务
    新增发票-按业务未开票页面查询    qybu_elementvalue=${BN_MAINS_VESSELNAME}    qybu_elementname=vesselname
    列表页面-全选记录
    按业务列表页面点击开票
    ${sign_invoiceno}    汇总开票-新增发票页面
    关闭所有弹出框
    #查询发票管理中存在该发票
    发票管理-收入列表查询    ${sign_invoiceno}
    ${content}    获取列表记录数
    应该包含    ${content}    共1条
    点击结算管理
    #费用列表查看发票号
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${fee_invoiceno}    费用列表获取收入费用发票号    ${row}
    应该要相等    ${fee_invoiceno}    ${sign_invoiceno}
    关闭所有弹出框
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT}
    从业务列表进入费用页面
    ${fee_invoiceno1}    费用列表获取收入费用发票号    ${row1}
    应该要相等    ${fee_invoiceno1}    ${sign_invoiceno}

明细开票-按业务-新增发票页面1
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${row}    新增收入费用-选定费用
    关闭所有弹出框
    点击业务管理
    #按业务明细开票
    点击结算管理
    点击发票
    点击新增发票
    点击按业务
    新增发票-按业务未开票页面查询    ${BUSINESSNO-SUIT-SEAEXPORT}
    列表页面-全选记录
    按业务列表页面点击开票
    ${sign_invoiceno}    明细开票
    关闭所有弹出框
    #查询发票管理中存在该发票
    发票管理-收入列表查询    ${sign_invoiceno}
    ${content}    获取列表记录数
    应该包含    ${content}    共1条
    点击结算管理
    #费用列表查看发票号
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${fee_invoiceno}    费用列表获取收入费用发票号    ${row}
    应该要相等    ${fee_invoiceno}    ${sign_invoiceno}

标记开票-按业务-新增发票页面1
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    #新增费用
    ${row}    新增收入费用-选定费用
    关闭所有弹出框
    点击业务管理
    #按业务明细开票
    点击结算管理
    点击发票
    点击新增发票
    点击按业务
    新增发票-按业务未开票页面查询    ${BUSINESSNO-SUIT-SEAEXPORT}
    列表页面-全选记录
    按业务列表页面点击开票
    ${sign_invoiceno}    标记开票-新增发票页面
    关闭所有弹出框
    #查询发票管理中存在该发票
    发票管理-收入列表查询    ${sign_invoiceno}
    ${content}    获取列表记录数
    应该包含    ${content}    共1条
    点击结算管理
    #费用列表查看发票号
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${fee_invoiceno}    费用列表获取收入费用发票号    ${row}
    应该要相等    ${fee_invoiceno}    ${sign_invoiceno}

对账并发票登记（支出）-应付发票登记页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${row}    新增支出费用-选定费用
    关闭所有弹出框
    点击业务管理
    #生成对账单并标记开票
    点击结算管理
    点击应付发票
    点击应付发票登记
    应付发票登记列表查询    ${BUSINESSNO-SUIT-SEAEXPORT}
    列表页面-全选记录
    点击选择
    ${model_fi_debitcredits_debitcreditno}    对账并登记发票-应付发票登记页面    ${BUSINESSNO-SUIT-SEAEXPORT}
    #查询发票
    点击应付发票查询
    应付发票查询-支出列表查询    ${model_fi_debitcredits_debitcreditno}
    ${content1}    获取列表记录数
    应该包含    ${content1}    共1条
    点击结算管理
    #费用列表显示对账单号、发票号
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${fee_check_account_no}    费用列表获取支出费用对账单号    ${row}
    应该要相等    ${fee_check_account_no}    ${model_fi_debitcredits_debitcreditno}
    ${fee_debitcredit_invoiceno}    费用列表获取支出费用发票号    ${row}
    应该要相等    ${fee_debitcredit_invoiceno}    ${model_fi_debitcredits_debitcreditno}
