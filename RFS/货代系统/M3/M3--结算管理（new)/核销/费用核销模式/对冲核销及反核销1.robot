*** Settings ***
Suite Setup       Run keywords    系统参数设置-费用核销模式
...               AND    自定义初始化
Suite Teardown    close all browsers
Test Setup        Reload Page
Resource          ../../../../../Resources/M3基础操作/M3--引用.txt

*** Test Cases ***
对冲核销1-按费用明细（收入>支出）
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${recrow}    新增收入费用-选定费用    3000
    ${payrow}    新增支出费用-选定费用    1000
    关闭所有弹出框
    点击业务管理
    点击结算管理
    点击对冲
    点击对冲申请
    查询-对冲申请（按费用明细）    businessno=${BUSINESSNO-SUIT-SEAEXPORT}
    全选记录-列表页面
    点击选择-对冲申请列表（按费用明细）
    点击对冲核销-对冲申请列表（按费用明细）
    ${duibillno}    ${duicong_billamount}    ${recbillno}    对冲核销--按费用明细（收入>=支出）
    点击对冲单管理
    查询-对冲单管理（默认是已核销）    ${duibillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款
    点击收款单管理
    查询-收款单管理（已核销）    ${recbillno}
    ${rec_billamount}    获取对冲金额-收款单管理已核销列表
    应该要相等    ${rec_billamount}    ${duicong_billamount}
    点击结算管理
    #费用列表查看收款单号及实付金额
    ${rec_paybillno}    ${amount_rec}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${recrow}
    ${fee_paybillno}    ${amount_pay}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${payrow}
    应该要相等    ${rec_paybillno}    ${duibillno}
    应该要相等    ${fee_paybillno}    ${duibillno}
    应该要相等    3,000.00    ${amount_rec}
    应该要相等    1,000.00    ${amount_pay}

对冲核销1--按发票（收入=支出）
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${recrow}    新增收入费用-选定费用    2000
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
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款
    点击收款单管理
    查询-收款单管理（已核销）    ${recbillno}
    ${reccode}    获取对冲金额-收款单管理已核销列表
    应该要相等    ${reccode}    ${duicong_billamount}
    点击结算管理
    #费用列表查看收款单号及实付金额
    ${rec_paybillno}    ${amount_rec}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${recrow}
    ${fee_paybillno}    ${amount_pay}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${payrow}
    应该要相等    ${rec_paybillno}    ${duibillno}
    应该要相等    ${fee_paybillno}    ${duibillno}
    应该要相等    2,000.00    ${amount_rec}
    应该要相等    2,000.00    ${amount_pay}

对冲核销1--按对账单（收入>支出）
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${recrow}    新增收入费用-选定费用    3000
    ${payrow}    新增支出费用-选定费用    1000
    点击对账-费用信息页面
    选择对冲费用-生成对账单（费用信息入口）
    ${check_no_rec}    生成对账单
    点击业务管理
    点击结算管理
    点击对冲
    点击对冲申请
    查询-对冲申请（按对账单）    ${check_no_rec}
    全选记录-列表页面
    点击核销-对冲申请（按发票、对账单、账单）
    全选记录-进入详情框架
    点击对冲申请-（核销-页面选择）
    ${duibillno}    ${duicong_billamount}    ${recbillno}    对冲核销--按发票、对账单、账单（收入>=支出）
    点击对冲单管理
    查询-对冲单管理（默认是已核销）    ${duibillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款
    点击收款单管理
    查询-收款单管理（已核销）    ${recbillno}
    ${reccode}    获取对冲金额-收款单管理已核销列表
    应该要相等    ${reccode}    ${duicong_billamount}
    点击结算管理
    #费用列表查看收款单号及实付金额
    ${rec_paybillno}    ${amount_rec}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${recrow}
    ${fee_paybillno}    ${amount_pay}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${payrow}
    应该要相等    ${rec_paybillno}    ${duibillno}
    应该要相等    ${fee_paybillno}    ${duibillno}
    应该要相等    3,000.00    ${amount_rec}
    应该要相等    1,000.00    ${amount_pay}

对冲核销1--按账单（收入>支出）
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${recrow}    新增收入费用-选定费用    3000
    ${payrow}    新增支出费用-选定费用    1000
    点击应收账单/Debitnote-费用信息
    选择对冲费用-保存账单
    ${check_no_rec}    保存账单-新增账单
    点击业务管理
    点击结算管理
    点击对冲
    点击对冲申请
    查询-对冲申请（按账单）    ${check_no_rec}
    全选记录-列表页面
    点击核销-对冲申请（按发票、对账单、账单）
    全选记录-进入详情框架
    点击对冲申请-（核销-页面选择）
    ${duibillno}    ${duicong_billamount}    ${recbillno}    对冲核销--按发票、对账单、账单（收入>=支出）
    点击对冲单管理
    查询-对冲单管理（默认是已核销）    ${duibillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款
    点击收款单管理
    查询-收款单管理（已核销）    ${recbillno}
    ${reccode}    获取对冲金额-收款单管理已核销列表
    应该要相等    ${reccode}    ${duicong_billamount}
    点击结算管理
    #费用列表查看收款单号及实付金额
    ${rec_paybillno}    ${amount_rec}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${recrow}
    ${fee_paybillno}    ${amount_pay}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${payrow}
    应该要相等    ${rec_paybillno}    ${duibillno}
    应该要相等    ${fee_paybillno}    ${duibillno}
    应该要相等    3,000.00    ${amount_rec}
    应该要相等    1,000.00    ${amount_pay}

对冲核销1--按对账单（收入<支出）
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${recrow}    新增收入费用-选定费用    1000
    ${payrow}    新增支出费用-选定费用    3000
    点击对账-费用信息页面
    选择对冲费用-生成对账单（费用信息入口）
    ${check_no_rec}    生成对账单
    点击业务管理
    点击结算管理
    点击对冲
    点击对冲申请
    查询-对冲申请（按对账单）    ${check_no_rec}
    全选记录-列表页面
    点击核销-对冲申请（按发票、对账单、账单）
    全选记录-进入详情框架
    点击对冲申请-（核销-页面选择）
    ${duibillno}    ${duicong_billamount}    ${paybillno}    对冲核销--按发票、对账单、账单（收入<支出）
    点击对冲单管理
    查询-对冲单管理（默认是已核销）    ${duibillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击付款
    点击付款单管理
    查询-付款单管理（已核销）    ${paybillno}
    ${reccode}    获取对冲金额-付款单管理已核销列表
    应该要相等    ${reccode}    ${duicong_billamount}
    点击结算管理
    #费用列表查看收款单号及实付金额
    ${rec_paybillno}    ${amount_rec}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${recrow}
    ${fee_paybillno}    ${amount_pay}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${payrow}
    应该要相等    ${rec_paybillno}    ${duibillno}
    应该要相等    ${fee_paybillno}    ${duibillno}
    应该要相等    1,000.00    ${amount_rec}
    应该要相等    3,000.00    ${amount_pay}

对冲核销1--对冲单管理
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${recrow}    新增收入费用-选定费用    2000
    ${payrow}    新增支出费用-选定费用    2000
    点击对账-费用信息页面
    选择对冲费用-生成对账单（费用信息入口）
    ${check_no_rec}    生成对账单
    点击业务管理
    点击结算管理
    点击对冲
    点击对冲申请
    查询-对冲申请（按对账单）    ${check_no_rec}
    全选记录-列表页面
    点击核销-对冲申请（按发票、对账单、账单）
    全选记录-进入详情框架
    点击对冲申请-（核销-页面选择）
    ${duibillno}    ${duicong_billamount}    ${recbillno}    对冲申请--按对账单（收入>=支出）    生成对冲单
    点击对冲单管理
    #待审核的详情点击审核
    查询-对冲单管理（默认是已核销）    ${duibillno}    i=1
    点击收/付款单号-对冲单管理    ${recbillno}
    审核-对冲单管理
    #待核销的详情点击核销
    查询-对冲单管理（默认是已核销）    ${duibillno}    i=2
    点击收/付款单号-对冲单管理    ${recbillno}
    核销--对冲单管理（待核销）
    #查询已核销
    查询-对冲单管理（默认是已核销）    ${duibillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款
    点击收款单管理
    查询-收款单管理（已核销）    ${recbillno}
    ${reccode}    获取对冲金额-收款单管理已核销列表
    应该要相等    ${reccode}    ${duicong_billamount}
    点击结算管理
    #费用列表查看收款单号及实付金额
    ${rec_paybillno}    ${amount_rec}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${recrow}
    ${fee_paybillno}    ${amount_pay}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${payrow}
    应该要相等    ${rec_paybillno}    ${duibillno}
    应该要相等    ${fee_paybillno}    ${duibillno}
    应该要相等    2,000.00    ${amount_rec}
    应该要相等    2,000.00    ${amount_pay}

对冲审核并核销1--对冲单管理
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${recrow}    新增收入费用-选定费用    2000
    ${payrow}    新增支出费用-选定费用    2000
    关闭所有弹出框
    点击业务管理
    点击结算管理
    点击对冲
    点击对冲申请
    查询-对冲申请（按费用明细）    businessno=${BUSINESSNO-SUIT-SEAEXPORT}
    全选记录-列表页面
    点击选择-对冲申请列表（按费用明细）
    点击对冲核销-对冲申请列表（按费用明细）
    ${duibillno}    ${duicong_billamount}    ${recbillno}    对冲申请--按对账单（收入>=支出）    对冲核销
    点击对冲单管理
    #待审核的详情点击审核
    查询-对冲单管理（默认是已核销）    ${duibillno}    i=1
    点击收/付款单号-对冲单管理    ${recbillno}
    审核并核销-对冲单管理（待审核）
    #查询已核销
    查询-对冲单管理（默认是已核销）    ${duibillno}
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款
    点击收款单管理
    查询-收款单管理（已核销）    ${recbillno}
    ${reccode}    获取对冲金额-收款单管理已核销列表
    应该要相等    ${reccode}    ${duicong_billamount}
    点击结算管理
    #费用列表查看收款单号及实付金额
    ${rec_paybillno}    ${amount_rec}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${recrow}
    ${fee_paybillno}    ${amount_pay}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${payrow}
    应该要相等    ${rec_paybillno}    ${duibillno}
    应该要相等    ${fee_paybillno}    ${duibillno}
    应该要相等    2,000.00    ${amount_rec}
    应该要相等    2,000.00    ${amount_pay}

对冲反核销1--核销记录
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${recrow}    新增收入费用-选定费用    2000
    ${payrow}    新增支出费用-选定费用    2000
    点击对账-费用信息页面
    选择对冲费用-生成对账单（费用信息入口）
    ${check_no_rec}    生成对账单
    点击业务管理
    点击结算管理
    点击对冲
    点击对冲申请
    查询-对冲申请（按对账单）    ${check_no_rec}
    全选记录-列表页面
    点击核销-对冲申请（按发票、对账单、账单）
    全选记录-进入详情框架
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
    ${rec_paybillno}    ${amount1}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${recrow}
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${payrow}
    应该要相等    ${fee_paybillno}    ${EMPTY}
    应该要相等    ${rec_paybillno}    ${EMPTY}
    应该要相等    0.00    ${amount}
    应该要相等    0.00    ${amount1}

对冲反核销--对冲单管理1
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${recrow}    新增收入费用-选定费用    2000
    ${payrow}    新增支出费用-选定费用    2000
    点击对账-费用信息页面
    选择对冲费用-生成对账单（费用信息入口）
    ${check_no_rec}    生成对账单
    点击业务管理
    点击结算管理
    点击对冲
    点击对冲申请
    查询-对冲申请（按对账单）    ${check_no_rec}
    全选记录-列表页面
    点击核销-对冲申请（按发票、对账单、账单）
    全选记录-进入详情框架
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
    ${rec_paybillno}    ${amount1}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${recrow}
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${payrow}
    应该要相等    ${fee_paybillno}    ${EMPTY}
    应该要相等    ${rec_paybillno}    ${EMPTY}
    应该要相等    0.00    ${amount}
    应该要相等    0.00    ${amount1}
