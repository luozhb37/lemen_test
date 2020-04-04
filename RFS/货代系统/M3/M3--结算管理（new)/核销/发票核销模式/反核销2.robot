*** Settings ***
Suite Setup       Run keywords    系统参数设置-发票核销模式
...               AND    登录
...               AND    新增海运出口业务
Suite Teardown    close all browsers
Test Setup        Reload Page
Resource          ../../../../../Resources/M3基础操作/M3--引用.txt

*** Test Cases ***
收款核销2(反核销)--核销记录
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用    1000
    费用信息页面勾选收入费用    ${row}
    费用信息页面点击开票
    ${invoiceno}    费用信息页面-明细开票
    点击业务管理
    #生成收款单
    点击结算管理
    点击收款
    点击按发票-收（付）款登记
    查询-收（付）款登记-按发票    ${invoiceno}
    全选记录-列表页面
    点击生成收款单-收款登记列表页面
    生成并核销收（付）款单    生成收款单
    ${recbillno}    收款单页面获取收款单号
    关闭所有弹出框
    点击核销记录
    查询-收（付）核销记录列表    ${recbillno}
    全选记录-列表页面
    点击反核销-核销记录列表
    点击收款单管理
    查询-收款单管理（已核销）    ${recbillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共0条
    点击收款单管理
    #费用列表查看收款单号及实付金额
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${EMPTY}
    应该要相等    0.00    ${amount}

收款核销2(反核销)--已核销-收款单管理
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用    1000
    费用信息页面勾选收入费用    ${row}
    费用信息页面点击开票
    ${invoiceno}    费用信息页面-明细开票
    点击业务管理
    #生成收款单
    点击结算管理
    点击收款
    点击按发票-收（付）款登记
    查询-收（付）款登记-按发票    ${invoiceno}
    全选记录-列表页面
    点击生成收款单-收款登记列表页面
    生成并核销收（付）款单    生成收款单
    ${recbillno}    收款单页面获取收款单号
    关闭所有弹出框
    点击收款单管理
    查询-收款单管理（已核销）    ${recbillno}
    全选记录-列表页面
    点击反核销-收款单管理已核销列表
    查询-收款单管理（已核销）    ${recbillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共0条
    点击收款单管理
    #费用列表查看收款单号及实付金额
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${EMPTY}
    应该要相等    0.00    ${amount}

收款核销2(反核销)--费用反核销
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增收入费用-选定费用    1000
    费用信息页面勾选收入费用    ${row}
    ${Invoice}    标记开票-费用信息页面
    点击业务管理
    #生成收款单
    点击结算管理
    ${Payment receipt number}    ${Cost}    按发票--核销    ${Invoice}
    点击费用反核销
    查询-费用反核销列表    ${Payment receipt number}
    全选记录-列表页面
    点击反核销-费用反核销列表
    点击收款单管理
    查询-收款单管理（已核销）    ${Payment receipt number}
    ${page}    获取列表记录数
    应该包含    ${page}    共0条
    点击收款单管理
    #费用列表查看收款单号及实付金额
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${EMPTY}
    应该要相等    0.00    ${amount}

付款反核销--核销记录
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增支出费用-选定费用    2000
    点击对账-费用信息页面
    选择收入（支出）费用-生成对账单（费用信息入口）    pay
    ${check_no}    生成对账单
    点击业务管理
    点击结算管理
    点击发票
    查询-新增发票（按对账单）    ${check_no}    ${BUSINESSNO-SUIT-SEAEXPORT}
    全选记录-列表页面
    点击开票-新增发票
    ${write_invoiceno}    按对账单-应付登记发票
    点击付款
    点击付款申请
    点击按发票-收（付）款登记
    查询-收（付）款登记-按发票    ${write_invoiceno}
    全选记录-列表页面
    点击生成付款单-付款申请列表（按发票）
    生成并核销收（付）款单    生成付款单
    ${qypay_paybillno}    获取付款单号-生成付款单详情
    关闭所有弹出框
    点击核销记录
    查询-付款核销记录    ${qypay_paybillno}
    全选记录-列表页面
    点击反核销--核销记录
    点击付款单管理
    查询-付款单管理（已核销）    ${qypay_paybillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共0条
    点击付款单管理
    #费用列表查看收款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_paybillno}    ${EMPTY}
    应该要相等    0.00    ${amount}

付款反核销--付款单管理（发票）
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增支出费用-选定费用    2000
    点击对账-费用信息页面
    选择收入（支出）费用-生成对账单（费用信息入口）    pay
    ${check_no}    生成对账单
    点击业务管理
    点击结算管理
    点击发票
    查询-新增发票（按对账单）    ${check_no}    ${BUSINESSNO-SUIT-SEAEXPORT}
    全选记录-列表页面
    点击开票-新增发票
    ${write_invoiceno}    按对账单-应付登记发票
    点击付款
    点击付款申请
    点击按发票-收（付）款登记
    查询-收（付）款登记-按发票    ${write_invoiceno}
    全选记录-列表页面
    点击生成付款单-付款申请列表（按发票）
    生成并核销收（付）款单    生成付款单
    ${qypay_paybillno}    获取付款单号-生成付款单详情
    关闭所有弹出框
    点击付款单管理
    查询-付款单管理（已核销）    ${qypay_paybillno}
    全选记录-列表页面
    点击反核销--付款单管理（已核销列表）
    查询-付款单管理（已核销）    ${qypay_paybillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共0条
    点击付款单管理
    #费用列表查看收款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_paybillno}    ${EMPTY}
    应该要相等    0.00    ${amount}

付款反核销--费用反核销（发票）
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增支出费用-选定费用    2000
    点击对账-费用信息页面
    选择收入（支出）费用-生成对账单（费用信息入口）    pay
    ${check_no}    生成对账单
    点击业务管理
    点击结算管理
    点击发票
    查询-新增发票（按对账单）    ${check_no}    ${BUSINESSNO-SUIT-SEAEXPORT}
    全选记录-列表页面
    点击开票-新增发票
    ${write_invoiceno}    按对账单-应付登记发票
    点击付款
    点击付款申请
    点击按发票-收（付）款登记
    查询-收（付）款登记-按发票    ${write_invoiceno}
    全选记录-列表页面
    点击生成付款单-付款申请列表（按发票）
    生成并核销收（付）款单    生成付款单
    ${qypay_paybillno}    获取付款单号-生成付款单详情
    关闭所有弹出框
    点击费用反核销
    查询-费用反核销列表    ${qypay_paybillno}
    全选记录-列表页面
    点击反核销-费用反核销列表
    点击付款单管理
    查询-付款单管理（已核销）    ${qypay_paybillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共0条
    点击付款单管理
    #费用列表查看收款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_paybillno}    ${EMPTY}
    应该要相等    0.00    ${amount}

对冲反核销--对冲单管理
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${recrow}    新增收入费用-选定费用    2000
    费用页面滚动竖滚条
    ${payrow}    新增支出费用-选定费用    2000
    点击对账-费用信息页面
    选择对冲费用-生成对账单（费用信息入口）
    ${check_no_rec}    生成对账单
    点击业务管理
    点击结算管理
    点击发票
    点击新增发票
    查询-新增发票（按对账单）    ${check_no_rec}    ${BUSINESSNO-SUIT-SEAEXPORT}
    全选记录-列表页面
    ${invoiceno}    汇总开票-按对账单
    点击对冲
    点击对冲申请
    查询-对冲申请（按发票）    ${invoiceno}
    全选记录-列表页面
    点击核销-对冲申请（按发票、对账单、账单）
    点击对冲申请-（核销-页面选择）
    ${duibillno}    ${duicong_billamount}    ${recbillno}    对冲核销--按发票、对账单、账单（收入>=支出）
    点击对冲单管理
    查询-对冲单管理（默认是已核销）    ${duibillno}
    全选记录-列表页面
    点击反核销-对冲单管理（已核销）列表
    查询-对冲单管理（默认是已核销）    ${duibillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共0条
    点击结算管理
    #费用列表查看收款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${payrow}
    点击业务管理
    ${rec_paybillno}    ${amount1}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${recrow}
    应该要相等    ${fee_paybillno}    ${EMPTY}
    应该要相等    ${rec_paybillno}    ${EMPTY}
    应该要相等    0.00    ${amount}
    应该要相等    0.00    ${amount1}

对冲反核销--核销记录
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${recrow}    新增收入费用-选定费用    2000
    费用页面滚动竖滚条
    ${payrow}    新增支出费用-选定费用    2000
    点击对账-费用信息页面
    选择对冲费用-生成对账单（费用信息入口）
    ${check_no_rec}    生成对账单
    点击业务管理
    点击结算管理
    点击发票
    点击新增发票
    查询-新增发票（按对账单）    ${check_no_rec}    ${BUSINESSNO-SUIT-SEAEXPORT}
    全选记录-列表页面
    ${invoiceno}    汇总开票-按对账单
    点击对冲
    点击对冲申请
    查询-对冲申请（按发票）    ${invoiceno}
    全选记录-列表页面
    点击核销-对冲申请（按发票、对账单、账单）
    点击对冲申请-（核销-页面选择）
    ${duibillno}    ${duicong_billamount}    ${recbillno}    对冲核销--按发票、对账单、账单（收入>=支出）
    点击核销记录
    查询-核销记录列表    ${duibillno}
    全选记录-列表页面
    点击反核销-对冲核销记录
    点击对冲单管理
    查询-对冲单管理（默认是已核销）    ${duibillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共0条
    点击结算管理
    #费用列表查看收款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${payrow}
    点击业务管理
    ${rec_paybillno}    ${amount1}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${recrow}
    应该要相等    ${fee_paybillno}    ${EMPTY}
    应该要相等    ${rec_paybillno}    ${EMPTY}
    应该要相等    0.00    ${amount}
    应该要相等    0.00    ${amount1}
