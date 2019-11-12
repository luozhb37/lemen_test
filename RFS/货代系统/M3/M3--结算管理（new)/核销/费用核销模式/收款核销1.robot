*** Settings ***
Resource          ../../../../../Resources/M3基础操作/M3--引用.txt

*** Test Cases ***
收款核销1（审核并核销）-费用信息页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用    2000
    费用信息页面勾选收入费用    ${row}
    费用信息页面点击收款核销
    ${recbillno}    详情-生成收款单
    审核并核销(收款)
    关闭所有弹出框
    点击业务管理
    点击结算管理
    点击收款
    点击收款单管理
    收款单管理已核销列表查询    qyrec_datetype=1    qyrec_recbillno=${recbillno}    #按回款日期、收款单号查询
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款单管理
    #费用列表查看收款单号及实付金额
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${recbillno}
    应该要相等    2,000.00    ${amount}

收款核销1（生成并核销）-费用信息页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用    3000
    费用信息页面勾选收入费用    ${row}
    费用信息页面点击收款核销
    点击生成并核销收（付）款单    收款核销
    ${recbillno}    收款单页面获取收款单号    收款核销
    关闭所有弹出框
    点击业务管理
    点击结算管理
    点击收款
    点击收款单管理
    收款单管理已核销列表查询    qyrec_datetype=1    qyrec_recbillno=${recbillno}    #按回款日期、收款单号查询
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款单管理
    #费用列表查看收款单号及实付金额
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${recbillno}
    应该要相等    3,000.00    ${amount}

收款核销1（生成并核销）-按费用明细-收款登记页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用    3000
    关闭所有弹出框
    点击业务管理
    #生成收款单
    点击结算管理
    点击收款
    点击收款登记
    收（付）款登记-点击按费用明细
    收（付）登记-按费用明细-列表查询    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入列表页面框架
    勾选记录    xpath=//table[@id='qp_rec_invoice8_tbl5']/tbody/tr[2]//input    #勾选第一条记录
    #勾选记录    xpath=//*[contains(@name,"${CASENUMBER-SUIT}")]    #勾选包含该casenumber的记录
    点击    id=bt_select    #点击选择
    离开框架
    收款登记列表（按费用明细）-点击生成收款单
    点击生成并核销收（付）款单    生成收款单
    ${recbillno}    收款单页面获取收款单号
    关闭所有弹出框
    点击收款单管理
    收款单管理已核销列表查询    qyrec_datetype=1    qyrec_recbillno=${recbillno}    #按回款日期、收款单号查询
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款单管理
    #费用列表查看收款单号及实付金额
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${recbillno}
    应该要相等    3,000.00    ${amount}

收款核销1（生成并核销）-按发票-收款登记页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用    3000
    费用信息页面勾选收入费用    ${row}
    费用信息页面点击开票
    ${invoiceno}    费用信息页面-明细开票
    点击业务管理
    #生成收款单
    点击结算管理
    点击收款
    点击收款登记
    收（付）款登记-点击按发票
    收（付）款登记-按发票页面查询    ${invoiceno}
    进入列表页面框架
    勾选记录    xpath=//table[@id='qp_invoicen_mains_tbl5']/tbody/tr[2]//input    #勾选第一条记录
    离开框架
    收款登记列表页面-点击生成收款单
    点击生成并核销收（付）款单    生成收款单
    ${recbillno}    收款单页面获取收款单号
    关闭所有弹出框
    点击收款单管理
    收款单管理已核销列表查询    qyrec_datetype=1    qyrec_recbillno=${recbillno}    #按回款日期、收款单号查询
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款单管理
    #费用列表查看收款单号及实付金额
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${recbillno}
    应该要相等    3,000.00    ${amount}

收款核销1（生成并核销）-按对账单-收款登记页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用    3000
    费用信息页面-点击对账
    从费用信息页面-生成对账单    rec
    ${check_no}    生成对账单
    点击业务管理
    #生成收款单
    点击结算管理
    点击收款
    点击收款登记
    收（付）款登记-点击按对账单
    收（付）款登记-按对账单页面查询    ${check_no}
    进入列表页面框架
    勾选记录    xpath=//table[@id='qp_rec_checkaccount_tbl5']/tbody/tr[2]//input    #勾选第一条记录
    离开框架
    收款登记列表页面-点击生成收款单
    收款核销选择页面-勾选记录并点击收款登记
    点击生成并核销收（付）款单    生成收款单
    ${recbillno}    收款单页面获取收款单号
    关闭所有弹出框
    点击收款单管理
    收款单管理已核销列表查询    qyrec_datetype=1    qyrec_recbillno=${recbillno}    #按回款日期、收款单号查询
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款单管理
    #费用列表查看收款单号及实付金额
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${recbillno}
    应该要相等    3,000.00    ${amount}

收款核销1（生成并核销）-按账单-收款登记页面
    [Documentation]    新增费用到第8条就会点不到保存按钮？
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用    3000
    费用信息页面点击应收账单/Debitnote
    应收（付）账单/Debitnote-保存账单    应收账单/Debitnote
    ${debitno}    生成账单
    点击业务管理
    #生成收款单
    点击结算管理
    点击收款
    点击收款登记
    收（付）款登记-点击按账单
    收（付）款登记-按账单页面查询    ${debitno}
    进入列表页面框架
    勾选记录    xpath=//table[@id='qp_rec_debitcredit_tbl5']/tbody/tr[2]//input    #勾选第一条记录
    离开框架
    收款登记列表页面-点击生成收款单
    收款核销选择页面-勾选记录并点击收款登记
    点击生成并核销收（付）款单    生成收款单
    ${recbillno}    收款单页面获取收款单号
    关闭所有弹出框
    点击收款单管理
    收款单管理已核销列表查询    qyrec_datetype=1    qyrec_recbillno=${recbillno}    #按回款日期、收款单号查询
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款单管理
    #费用列表查看收款单号及实付金额
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${recbillno}
    应该要相等    3,000.00    ${amount}

收款核销1（审核并核销）点击收款单号-收款单管理页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用    3000
    费用信息页面勾选收入费用    ${row}
    费用信息页面点击收款核销
    ${recbillno}    详情-生成收款单
    关闭所有弹出框
    点击业务管理
    点击结算管理
    点击收款
    点击收款单管理
    收款单管理待审核页面查询    ${recbillno}
    进入收/付款单详情
    收款单页面审核并核销
    关闭所有弹出框
    收款单管理已核销列表查询    qyrec_datetype=1    qyrec_recbillno=${recbillno}    #按回款日期、收款单号查询
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款单管理
    #费用列表查看收款单号及实付金额
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${recbillno}
    应该要相等    3,000.00    ${amount}

收款核销1（审核后核销）-点击收款单号-收款单管理页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用    3000
    费用信息页面勾选收入费用    ${row}
    费用信息页面点击收款核销
    ${recbillno}    详情-生成收款单
    关闭所有弹出框
    点击业务管理
    点击结算管理
    点击收款
    点击收款单管理
    收款单管理待审核页面查询    ${recbillno}
    进入收/付款单详情
    收款单页面审核
    收款单页面核销
    关闭所有弹出框
    收款单管理已核销列表查询    qyrec_datetype=1    qyrec_recbillno=${recbillno}    #按回款日期、收款单号查询
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款单管理
    #费用列表查看收款单号及实付金额
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${recbillno}
    应该要相等    3,000.00    ${amount}

收款核销1（生成并核销）-勾选发票核销-发票管理页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用    3000
    费用信息页面勾选收入费用    ${row}
    ${Invoice}    标记开票-费用信息页面
    点击业务管理
    点击结算管理
    点击发票
    点击发票管理
    发票管理-收入列表查询    ${Invoice}
    发票管理（收入）页面费用点击核销
    收款核销选择页面-勾选记录并点击收款登记
    点击生成并核销收（付）款单    生成收款单
    ${fi_recbills_recbillno}    收款单页面获取收款单号
    关闭所有弹出框
    点击收款
    收款核销记录查询    ${fi_recbills_recbillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${fi_recbills_recbillno}
    应该要相等    3,000.00    ${amount}

收款核销1（生成并核销）-点击发票号-发票管理页面
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用    3000
    费用信息页面勾选收入费用    ${row}
    ${Invoice}    标记开票-费用信息页面
    点击业务管理
    #生成收款单
    点击结算管理
    点击发票
    点击发票管理
    发票管理-收入列表查询    ${Invoice}
    #点击发票号
    进入列表页面框架
    点击链接    css=.Linkstyle
    离开框架
    #发票详情点击收款核销
    进入特定页面框架    发票
    点击    id=bt_writeoff_rec
    离开框架
    点击生成并核销收（付）款单    收款核销
    进入特定页面框架    收款核销
    等待    1
    ${fi_recbills_recbillno}    获取页面文本内容    css=.vrws-value    #获取收款单号
    离开框架
    #${fi_recbills_recbillno}    收款单页面获取收款单号
    关闭所有弹出框
    点击收款
    收款核销记录查询    ${fi_recbills_recbillno}
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${fi_recbills_recbillno}
    应该要相等    3,000.00    ${amount}
