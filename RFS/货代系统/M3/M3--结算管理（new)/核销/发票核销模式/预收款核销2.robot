*** Settings ***
Resource          ../../../../../Resources/M3基础操作/M3--引用.txt

*** Test Cases ***
预收款核销2(生成并核销)--明细
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
    ${Payment receipt number}    预收款登记
    ${Cost}    预收款核销(明细)    ${Payment receipt number}    ${Invoice}
    点击收款单管理
    收款单管理已核销列表查询    qyrec_datetype=1    qyrec_recbillno=${Payment receipt number}    #按回款日期、收款单号查询
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款单管理
    #费用列表查看收款单号及实付金额
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${Payment receipt number}
    应该要相等    1,000.00    ${amount}

预收款核销2(生成并核销)--异币
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${row}    新增费用--USD    USD
    费用信息页面勾选收入费用    ${row}
    ${Invoice}    标记开票-费用信息页面
    点击业务管理
    #生成收款单
    点击结算管理
    ${Payment receipt number}    预收款登记
    ${Cost}    预收款核销(异币)    ${Payment receipt number}    ${Invoice}
    点击收款单管理
    收款单管理已核销列表查询    qyrec_datetype=1    qyrec_recbillno=${Payment receipt number}    #按回款日期、收款单号查询
    ${page}    获取列表记录数
    应该包含    ${page}    共1条
    点击收款单管理
    #费用列表查看收款单号及实付金额
    ${fee_recbillno}    ${amount}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_recbillno}    ${Payment receipt number}
    应该要相等    142.86    ${amount}
