*** Settings ***
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
    ${Invoice}    标记开票-费用信息页面
    点击业务管理
    #生成收款单
    点击结算管理
    ${Payment receipt number}    ${Cost}    按发票--核销    ${Invoice}
    反核销--核销记录    ${Payment receipt number}
    离开框架
    点击收款单管理
    收款单管理已核销列表查询    qyrec_datetype=1    qyrec_recbillno=${Payment receipt number}    #按回款日期、收款单号查询
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
    ${Invoice}    标记开票-费用信息页面
    点击业务管理
    #生成收款单
    点击结算管理
    ${Payment receipt number}    ${Cost}    按发票--核销    ${Invoice}
    反核销--收款单管理    ${Payment receipt number}
    离开框架
    点击收款单管理
    收款单管理已核销列表查询    qyrec_datetype=1    qyrec_recbillno=${Payment receipt number}    #按回款日期、收款单号查询
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
    反核销--费用反核销    ${Payment receipt number}
    离开框架
    点击收款单管理
    收款单管理已核销列表查询    qyrec_datetype=1    qyrec_recbillno=${Payment receipt number}    #按回款日期、收款单号查询
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
    ${fapiao}    付款--对账并开票    ${BUSINESSNO-SUIT-SEAEXPORT}
    点击付款
    点击付款申请
    ${paycode}    ${paynum}    付款(生成并核销)--按发票    ${fapiao}
    付款反核销--核销记录(发票)    ${paynum}
    点击付款单管理
    付款单管理已核销列表查询    ${paynum}
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
    ${fapiao}    付款--对账并开票    ${BUSINESSNO-SUIT-SEAEXPORT}
    点击付款
    点击付款申请
    ${paycode}    ${paynum}    付款(生成并核销)--按发票    ${fapiao}
    付款反核销--付款单管理（发票）    ${paynum}
    付款单管理已核销列表查询    ${paynum}
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
    ${fapiao}    付款--对账并开票    ${BUSINESSNO-SUIT-SEAEXPORT}
    点击付款
    点击付款申请
    ${paycode}    ${paynum}    付款(生成并核销)--按发票    ${fapiao}
    付款反核销--付款单管理（发票）    ${paynum}
    付款单管理已核销列表查询    ${paynum}
    ${page}    获取列表记录数
    应该包含    ${page}    共0条
    点击付款单管理
    #费用列表查看收款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${row}
    应该要相等    ${fee_paybillno}    ${EMPTY}
    应该要相等    0.00    ${amount}

对冲(反核销)--核销记录
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${recrow}    新增收入费用-选定费用    2000
    费用页面滚动竖滚条
    ${payrow}    新增支出费用-选定费用    2000
    ${fapiao}    对冲费用(对账并汇总开票)
    点击业务管理
    点击结算管理
    点击对冲
    点击对冲申请
    ${duichong}    ${money}    ${rec}    ${code}    对冲(核销)--按发票    ${fapiao}
    对冲反核销(核销记录)    ${duichong}
    点击对冲单管理
    对冲单管理已核销列表查询    ${duichong}
    ${page}    获取列表记录数
    应该包含    ${page}    共0条
    点击结算管理
    #费用列表查看收款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${payrow}
    ${rec_paybillno}    ${amount1}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${recrow}
    应该要相等    ${fee_paybillno}    ${EMPTY}
    应该要相等    ${rec_paybillno}    ${EMPTY}
    应该要相等    0.00    ${amount}
    应该要相等    0.00    ${amount1}

对冲(已核销)--对冲单管理
    点击业务管理
    点击业务台帐
    海运出口列表查询业务编号    ${BUSINESSNO-SUIT-SEAEXPORT}
    进入台帐详情    ${BUSINESSNO-SUIT-SEAEXPORT}
    从台帐详情进入费用页面
    ${recrow}    新增收入费用-选定费用    2000
    费用页面滚动竖滚条
    ${payrow}    新增支出费用-选定费用    2000
    ${fapiao}    对冲费用(对账并汇总开票)
    点击业务管理
    点击结算管理
    点击对冲
    点击对冲申请
    ${duichong}    ${money}    ${rec}    ${code}    对冲(核销)--按发票    ${fapiao}
    点击对冲单管理
    对冲(反核销)--对冲单管理    ${duichong}
    对冲单管理已核销列表查询    ${duichong}
    ${page}    获取列表记录数
    应该包含    ${page}    共0条
    点击结算管理
    #费用列表查看收款单号及实付金额
    ${fee_paybillno}    ${amount}    费用列表获取付款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${payrow}
    ${rec_paybillno}    ${amount1}    费用列表获取收款单号-选定费用    ${BUSINESSNO-SUIT-SEAEXPORT}    ${recrow}
    应该要相等    ${fee_paybillno}    ${EMPTY}
    应该要相等    ${rec_paybillno}    ${EMPTY}
    应该要相等    0.00    ${amount}
    应该要相等    0.00    ${amount1}
