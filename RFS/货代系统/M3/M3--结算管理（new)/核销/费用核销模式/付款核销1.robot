*** Settings ***
Resource          ../../../../../Resources/M3基础操作/M3--引用.txt

*** Test Cases ***
付款核销1（审核并核销）-费用信息页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增支出费用-选定费用    2000
    费用信息页面勾选支出费用    ${row}
    费用信息页面点击付款核销
    ${paybillno}    从费用信息页面-生成付款单并核销
    点击业务管理
    点击结算管理
    点击付款
    点击付款单管理
    付款单管理已核销列表查询    ${paybillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击付款单管理
    #费用列表查看收款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_paybillno}    ${paybillno}
    应该要相等    2,000.00    ${amount}

付款核销1（生成并核销）-费用信息页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增支出费用-选定费用    2000
    费用信息页面勾选支出费用    ${row}
    费用信息页面点击付款核销
    ${paybillno}    从费用信息页面-生成并核销付款单
    关闭所有弹出框
    点击业务管理
    点击结算管理
    点击付款
    点击付款单管理
    付款单管理已核销列表查询    ${paybillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击付款单管理
    #费用列表查看收款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_paybillno}    ${paybillno}
    应该要相等    2,000.00    ${amount}

付款核销1（生成并核销）-按费用明细-付款申请页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增支出费用-选定费用    2000
    关闭所有弹出框
    点击业务管理
    #生成付款单
    点击结算管理
    点击付款
    点击付款申请
    收（付）款登记-点击按费用明细
    收（付）登记-按费用明细-列表查询    ${BUSINESSNO-SUIT-SEAEXPORT}
    付款申请-按费用明细列表-勾选一条记录并点击选择
    付款申请列表（按费用明细）-点击生成付款单
    ${qypay_paybillno}    从付款申请-生成并核销付款单
    关闭所有弹出框
    点击付款单管理
    付款单管理已核销列表查询    ${qypay_paybillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击付款单管理
    #费用列表查看付款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_paybillno}    ${qypay_paybillno}
    应该要相等    2,000.00    ${amount}

付款核销1（生成并核销）-按账单-付款申请页面
    [Documentation]    新增费用到第8条就会点不到保存按钮？
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增支出费用-选定费用    2000
    费用信息页面点击应付账单/Crebitnote
    应收（付）账单/Debitnote-保存账单    应付账单/Creditnote
    ${debitno}    生成账单
    点击业务管理
    #生成收款单
    点击结算管理
    点击付款
    点击付款申请
    收（付）款登记-点击按账单
    收（付）款登记-按账单页面查询    ${debitno}
    付款申请-按账单列表-勾选一条记录并点击生成付款单
    付款核销选择页面-勾选记录并点击付款申请
    点击生成并核销收（付）款单    生成付款单
    ${qypay_paybillno}    付款单页面获取付款单号
    关闭所有弹出框
    点击付款单管理
    付款单管理已核销列表查询    ${qypay_paybillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击付款单管理
    #费用列表查看付款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_paybillno}    ${qypay_paybillno}
    应该要相等    2,000.00    ${amount}

付款核销1（生成并核销）-按对账单-付款申请页面
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
    #生成付款单
    点击结算管理
    点击付款
    点击付款申请
    收（付）款登记-点击按对账单
    收（付）款登记-按对账单页面查询    ${check_no}
    付款申请-按对账单列表-勾选一条记录并点击生成付款单
    付款核销选择页面-勾选记录并点击付款申请
    点击生成并核销收（付）款单    生成付款单
    ${qypay_paybillno}    付款单页面获取付款单号
    关闭所有弹出框
    点击付款单管理
    付款单管理已核销列表查询    ${qypay_paybillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击付款单管理
    #费用列表查看付款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_paybillno}    ${qypay_paybillno}
    应该要相等    2,000.00    ${amount}

付款核销1（生成并核销）-按发票-付款申请页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增支出费用-选定费用    2000
    #生成发票
    费用信息页面-点击对账
    从费用信息页面-生成对账单    pay
    ${check_no}    生成对账单
    点击业务管理
    点击结算管理
    点击发票
    新增发票-按对账单列表查询    ${check_no}    ${BUSINESSNO-SUIT-SEAEXPORT}
    列表页面-全选记录
    新增发票-点击开票
    ${write_invoiceno}    按对账单-应付登记发票
    关闭所有弹出框
    #生成付款单
    点击付款
    点击付款申请
    收（付）款登记-点击按发票
    收（付）款登记-按发票页面查询    ${write_invoiceno}
    付款申请-按发票列表-勾选一条记录并点击生成付款单
    ${qypay_paybillno}    从付款申请-生成并核销付款单
    关闭所有弹出框
    点击付款单管理
    付款单管理已核销列表查询    ${qypay_paybillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击付款单管理
    #费用列表查看付款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_paybillno}    ${qypay_paybillno}
    应该要相等    2,000.00    ${amount}

付款核销1（审核并核销）点击付款单号-付款单管理页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增支出费用-选定费用    3000
    费用信息页面勾选支出费用    ${row}
    费用信息页面点击付款核销
    进入特定页面框架    付款核销
    ${recbillno}    详情-生成付款单
    关闭所有弹出框
    点击业务管理
    点击结算管理
    点击付款
    点击付款单管理
    付款单管理待审核页面查询    ${recbillno}    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入收/付款单详情
    进入特定页面框架    付款单
    点击    id=bt_audit_real
    离开框架
    #付款单页面审核并核销    ${/}
    关闭所有弹出框
    付款单管理已核销列表查询    ${recbillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击付款单管理
    ${fee_recbillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${recbillno}
    应该要相等    3,000.00    ${amount}

付款核销1（审核后核销）点击付款单号-付款单管理页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增支出费用-选定费用    3000
    费用信息页面勾选支出费用    ${row}
    费用信息页面点击付款核销
    进入特定页面框架    付款核销
    ${recbillno}    详情-生成付款单
    关闭所有弹出框
    点击业务管理
    点击结算管理
    点击付款
    点击付款单管理
    付款单管理待审核页面查询    ${recbillno}    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入收/付款单详情
    付款单详情审核后核销
    关闭所有弹出框
    付款单管理已核销列表查询    ${recbillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击付款单管理
    ${fee_recbillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${recbillno}
    应该要相等    3,000.00    ${amount}
