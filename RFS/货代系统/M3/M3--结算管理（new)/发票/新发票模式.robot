*** Settings ***
Suite Setup       RUN KEYWORDS    系统参数设置-新发票模式
...               AND    登录
...               AND    新增海运出口业务
Suite Teardown    close all browsers
Test Setup        Reload Page
Resource          ../../../../Resources/M3基础操作/M3--引用.txt

*** Test Cases ***
明细开票（收入）-按对账单-新增发票页面
    [Tags]    ok
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${row}    新增收入费用-选定费用
    关闭所有弹出框
    点击业务管理
    点击结算管理
    等待    1
    #生成对账单
    点击对账
    点击新增对账单
    新增对账单列表查询    ${BUSINESSNO-SUIT-SEAEXPORT}    rec    false
    列表页面-全选记录
    点击选择
    新增对账单列表页面-点击生成对账单
    ${model_fi_debitcredits_debitcreditno}    生成对账单
    #按对账单明细开票
    点击发票
    新增发票-按对账单列表查询    ${model_fi_debitcredits_debitcreditno}    ${BUSINESSNO-SUIT-SEAEXPORT}
    列表页面-全选记录
    新增发票-点击开票
    进入详情框架后-全选记录
    ${write_invoiceno}    按对账单明细开票    ${model_fi_debitcredits_debitcreditno}
    关闭所有弹出框
    发票管理-收入列表查询    qy_mains_datatype=1    write_invoiceno=${write_invoiceno}
    ${content}    获取列表记录数
    应该包含    ${content}    共1条
    点击结算管理
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${fee_invoiceno}    费用列表获取收入费用发票号    ${row}
    应该要相等    ${fee_invoiceno}    ${write_invoiceno}

明细开票-按账单（debit）-新增发票页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${row}    新增收入费用-选定费用
    #保存账单
    费用信息页面点击对账
    点击生成CreditNote/DebitNote
    点击保存账单-生成CreditNote/DebitNote页面
    ${debitno}    生成账单
    点击业务管理
    #开票
    点击结算管理
    点击发票
    点击新增发票
    新增发票-点击按账单
    新增发票-按对账单列表查询    ${debitno}    EXP1910130
    列表页面-全选记录
    新增发票-点击开票
    进入详情框架后-全选记录
    ${sign_invoiceno}    按对账单明细开票    ${debitno}
    关闭所有弹出框
    发票管理-收入列表查询    ${sign_invoiceno}
    ${content}    获取列表记录数
    应该包含    ${content}    共1条
    点击结算管理
    #费用列表中验证发票号
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    EXP1910130
    勾选包含业务编号的台帐    EXP1910130
    从业务列表进入费用页面
    ${fee_invoiceno}    费用列表获取收入费用发票号    ${row}
    应该要相等    ${fee_invoiceno}    ${sign_invoiceno}

应付登记发票-按对账单-新增发票页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增支出费用-选定费用    2000
    费用信息页面-点击对账
    从费用信息页面-生成对账单    pay
    ${check_no}    生成对账单
    点击业务管理
    点击结算管理
    点击发票
    新增发票-按对账单列表查询    ${check_no}    ${BUSINESSNO-SUIT-SEAEXPORT}
    列表页面-全选记录
    新增发票-点击开票
    ${invoiceno}    按对账单-应付登记发票
    点击发票管理
    发票管理-支出列表查询    ${invoiceno}
    ${content1}    获取列表记录数
    应该包含    ${content1}    共1条
    点击结算管理
    #费用列表显示发票号
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${fee_debitcredit_invoiceno}    费用列表获取支出费用发票号    ${row}
    应该要相等    ${fee_debitcredit_invoiceno}    ${invoiceno}

汇总开票-按业务（两个业务）-新增发票页面
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

明细开票-按业务-新增发票页面
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

标记开票-按业务-新增发票页面
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

对账并标记开票（收入）-新增对账单页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${row}    新增收入费用-选定费用
    关闭所有弹出框
    点击业务管理
    #生成对账单并标记开票
    点击结算管理
    点击对账
    点击新增对账单
    新增对账单列表查询    ${BUSINESSNO-SUIT-SEAEXPORT}    rec    false
    列表页面-全选记录
    点击选择
    ${model_fi_debitcredits_debitcreditno}    ${model_fi_debitcredits_invoiceno}    对账并标记开票    ${BUSINESSNO-SUIT-SEAEXPORT}
    #查询对账单
    查询对账单    fi_checkaccounts_checkaccountno=${model_fi_debitcredits_debitcreditno}
    ${content}    获取列表记录数
    应该包含    ${content}    共1条
    #查询发票
    点击发票
    点击发票管理
    发票管理-收入列表查询    qy_mains_datatype=1    write_invoiceno=${model_fi_debitcredits_invoiceno}
    ${content1}    获取列表记录数
    应该包含    ${content1}    共1条
    点击结算管理
    #费用列表显示对账单号、发票号
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${fee_check_account_no}    费用列表获取收入费用对账单号    ${row}
    应该要相等    ${fee_check_account_no}    ${model_fi_debitcredits_debitcreditno}
    ${fee_debitcredit_invoiceno}    费用列表获取收入费用发票号    ${row}
    应该要相等    ${fee_debitcredit_invoiceno}    ${model_fi_debitcredits_invoiceno}

对账并登记发票（支出）-新增对账单页面
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
    点击对账
    点击新增对账单
    新增对账单列表查询    ${BUSINESSNO-SUIT-SEAEXPORT}    pay    false
    列表页面-全选记录
    点击选择
    ${model_fi_debitcredits_debitcreditno}    ${model_fi_debitcredits_invoiceno}    对账并登记发票-新增对账单页面    ${BUSINESSNO-SUIT-SEAEXPORT}
    #查询对账单
    查询对账单    fi_checkaccounts_checkaccountno=${model_fi_debitcredits_debitcreditno}
    ${content}    获取列表记录数
    应该包含    ${content}    共1条
    #查询发票
    点击发票
    点击发票管理
    发票管理-支出列表查询    write_invoiceno=${model_fi_debitcredits_invoiceno}
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
    应该要相等    ${fee_debitcredit_invoiceno}    ${model_fi_debitcredits_invoiceno}

汇总开票-按对账单-对账单管理列表
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row_rec}    新增收入费用-选定费用    2000
    费用信息页面-点击对账
    从费用信息页面-生成对账单    rec
    ${check_no_rec}    生成对账单
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row-pay}    新增支出费用-选定费用    300
    费用信息页面-点击对账
    从费用信息页面-生成对账单    pay
    ${check_no_pay}    生成对账单
    点击业务管理
    点击结算管理
    点击对账
    查询对账单    qy_businessno=${BUSINESSNO-SUIT-SEAEXPORT}
    列表页面-全选记录
    点击开票-对账单管理列表
    ${invoiceno}    汇总开票-对账单管理页面
    点击发票
    点击发票管理
    发票管理-收入列表查询    ${invoiceno}
    ${content1}    获取列表记录数
    应该包含    ${content1}    共1条
    点击结算管理
    #费用列表显示发票号
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${pay_invoiceno}    费用列表获取支出费用发票号    ${row-pay}
    应该要相等    ${pay_invoiceno}    ${invoiceno}
    ${rec_invoiceno}    费用列表获取收入费用发票号    ${row_rec}
    应该要相等    ${rec_invoiceno}    ${invoiceno}

标记开票-按对账单-对账单管理列表
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row_rec}    新增收入费用-选定费用    300
    费用信息页面-点击对账
    从费用信息页面-生成对账单    rec
    ${check_no_rec}    生成对账单
    点击业务管理
    点击结算管理
    点击对账
    查询对账单    fi_checkaccounts_checkaccountno=${check_no_rec}
    列表页面-全选记录
    点击开票-对账单管理列表
    ${invoiceno}    标记开票-对账单管理页面
    点击发票
    点击发票管理
    发票管理-收入列表查询    ${invoiceno}
    ${content1}    获取列表记录数
    应该包含    ${content1}    共1条
    点击结算管理
    #费用列表显示发票号
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    勾选包含业务编号的台帐    ${BUSINESSNO-SUIT-SEAEXPORT}
    从业务列表进入费用页面
    ${rec_invoiceno}    费用列表获取收入费用发票号    ${row_rec}
    应该要相等    ${rec_invoiceno}    ${invoiceno}
