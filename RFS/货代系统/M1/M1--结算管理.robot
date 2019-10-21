*** Settings ***
Suite Setup       登录    # Run keywords | 系统参数设置-应付对账核销模式 | AND | 往来单位初始化
Suite Teardown    close all browsers
Test Setup        回到首页
Resource          ../../Resources/M1基础操作/M1--引用.txt

*** Test Cases ***
新增费用
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增收入费用
    进入详情框架
    ${content}    获取页面文本内容    xpath=//tr[@elementname='fee_amount_rec']/td[2]/font
    离开框架
    应该要相等    ${content}    USD:1,000.00
    新增支出费用
    进入详情框架
    ${content}    获取页面文本内容    xpath=//tr[@elementname='fee_amount_pay']/td[2]/font
    离开框架
    应该要相等    ${content}    USD:1,000.00
    关闭费用信息页面

删除费用
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增收入费用
    新增支出费用
    删除收入费用
    进入详情框架
    ${content}    获取页面文本内容    xpath=//tr[@elementname='fee_amount_rec']/td[2]/font
    离开框架
    应该要相等    ${content}    总计:0.00
    删除支出费用
    进入详情框架
    ${content}    获取页面文本内容    xpath=//tr[@elementname='fee_amount_pay']/td[2]/font
    离开框架
    应该要相等    ${content}    总计:0.00
    关闭费用信息页面

收入费用审核/取消审核
    #审核收入费用
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增收入费用
    审核收入费用
    关闭费用信息页面
    #查询应收款已审核列表中有记录
    应收款审核页面验证收入费用已审核    ${businessNo}
    #取消审核
    点击业务管理
    点击业务台帐
    点击海运出口
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    取消审核收入费用
    关闭费用信息页面
    #查询应收款待审核列表中有该记录
    应收款审核页面验证收入费用未审核    ${businessNo}

支出费用审核/取消审核
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增支出费用
    审核支出费用
    关闭费用信息页面
    #查询应付款已审核列表中有该记录
    应付款审核页面验证支出费用已审核    ${businessNo}
    #取消审核
    点击业务管理
    点击业务台帐
    点击海运出口
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    取消审核支出费用
    关闭费用信息页面
    #查询应付款待审核列表中有该记录
    应付款审核页面验证支出费用未审核    ${businessNo}

收入费用确认/取消确认
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增收入费用
    确认收入费用
    关闭费用信息页面
    验证收入费用已确认    ${businessNo}
    点击业务管理
    点击业务台帐
    点击海运出口
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    取消确认收入费用
    关闭费用信息页面
    验证收入费用未确认    ${businessNo}

应付费用对账/取消对账
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增支出费用
    关闭费用信息页面
    #对账
    点击结算管理
    点击付款核销
    点击应付费用对账
    应付费用对账列表查询    ${businessNo}
    查询列表勾选第一条记录
    应付对账    ${businessNo}
    #对账后已对账列表有记录
    进入列表页面框架
    ${page}    获取页面文本内容    xpath=//table[@id='qp_paycheck1_tbl3']/tbody/tr/td/span[2]
    离开框架
    应该包含    ${page}    共1条
    ${Reconciliation}    费用列表获取对账单号    ${businessNo}
    应该要相等    ${Reconciliation}    ${businessNo}
    #取消对账
    点击结算管理
    点击付款核销
    点击应付费用对账
    应付费用对账列表查询    ${businessNo}
    查询列表勾选第一条记录
    点击取消对账
    #获取未对账的条数
    进入列表页面框架
    ${page}    获取页面文本内容    xpath=//table[@id='qp_paycheck2_tbl3']/tbody/tr/td/span[2]
    离开框架
    应该包含    ${page}    共1条

新增发票(关联业务)--明细开票
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增收入费用
    关闭费用信息页面
    点击发票管理
    点击货代发票
    点击新增发票(关联业务)
    新增发票(关联业务)列表查询    ${businessNo}
    进入一个框架后-全选记录
    未开票列表点击下一步
    关联业务-点击明细开发票
    ${invoiceno1}    保存发票    ${businessNo}
    点击发票查询
    货代发票查询    ${invoiceno1}
    ${pages}    获取单个列表记录数
    应该包含    ${pages}    共1条

新增发票(关联业务)--汇总开票
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增收入费用
    关闭费用信息页面
    点击发票管理
    点击货代发票
    点击新增发票(关联业务)
    新增发票(关联业务)列表查询    ${businessNo}
    进入一个框架后-全选记录
    未开票列表点击下一步
    关联业务-点击汇总开发票
    ${invoiceno1}    保存发票    ${businessNo}
    点击发票查询
    货代发票查询    ${invoiceno1}
    ${page}    获取单个列表记录数
    应该包含    ${page}    共1条

新增发票(费用明细)--明细开票
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增收入费用
    关闭费用信息页面
    点击发票管理
    点击货代发票
    点击新增发票(费用明细)
    新增发票(费用明细)列表查询    ${businessNo}
    进入一个框架后-全选记录
    费用明细-点击明细开发票
    ${invoiceno1}    保存发票    ${businessNo}
    点击发票查询
    货代发票查询    ${invoiceno1}
    ${page}    获取单个列表记录数
    应该包含    ${page}    共1条

新增发票(费用明细)--汇总开票
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增收入费用
    关闭费用信息页面
    点击发票管理
    点击货代发票
    点击新增发票(费用明细)
    新增发票(费用明细)列表查询    ${businessNo}
    进入一个框架后-全选记录
    费用明细-点击汇总开发票
    ${invoiceno1}    保存发票    ${businessNo}
    点击发票查询
    货代发票查询    ${invoiceno1}
    ${page}    获取单个列表记录数
    应该包含    ${page}    共1条

标记开票
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增收入费用
    关闭费用信息页面
    点击发票管理
    点击货代发票
    点击标记开票
    标记开票列表查询    ${businessNo}
    进入一个框架后-全选记录
    未开票列表点击下一步
    ${invoiceno1}    标记开票    ${businessNo}
    点击发票查询
    货代发票查询    ${invoiceno1}
    ${page}    获取单个列表记录数
    应该包含    ${page}    共1条

应付发票登记
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增支出费用
    关闭费用信息页面
    点击发票管理
    点击应付发票
    点击应付发票登记
    应付发票登记列表查询    ${businessNo}
    进入一个框架后-全选记录
    应付发票登记列表点击选择
    #对账单号、发票号就是业务编号
    对账并发票登记    ${businessNo}
    #验证发票号
    点击应付发票查询
    应付发票查询    ${businessNo}
    ${page}    获取单个列表记录数
    应该包含    ${page}    共1条
    #验证对账单号相等
    ${Reconciliation}    费用列表获取对账单号    ${businessNo}
    应该要相等    ${Reconciliation}    ${businessNo}

收款--发票核销--费用明细/反核销费用明细
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增收入费用
    关闭费用信息页面
    点击发票管理
    点击货代发票
    点击新增发票(关联业务)
    新增发票(关联业务)列表查询    ${businessNo}
    进入一个框架后-全选记录
    未开票列表点击下一步
    关联业务-点击明细开发票
    ${invoiceno1}    保存发票    ${businessNo}
    点击结算管理
    点击收款核销
    点击收款单制作(费用明细)
    收款单制作(费用明细)--选择费用进入生成收款单页面    ${businessNo}
    ${recNo}    生成收款单
    log    ${recNo}
    点击收款单查询
    ${pages}    收款单查询验证    ${recNo}
    应该包含    ${pages}    共1条
    收款--反核销费用明细(所有)    ${businessNo}
    点击收款单查询
    ${pages1}    收款单反核销验证    ${recNo}
    应该要相等    ${pages1}    RMB:0.00

付款--对账核销--费用明细/反核销费用明细
    ${businessNo}    新增海运出口业务台帐
    列表查询业务编号    ${businessNo}
    进入一个框架后-全选记录
    在列表点击费用
    新增支出费用
    关闭费用信息页面
    点击结算管理
    点击付款核销
    点击应付费用对账
    应付费用对账--选择费用进入对账页面    ${businessNo}
    应付对账    ${businessNo}
    点击付款申请(费用明细)
    付款申请(费用明细)--选择费用进入生成付款单页面    ${businessNo}
    ${payNo}    生成付款单
    点击付款单查询
    ${pages}    付款单查询验证    ${payNo}
    应该包含    ${pages}    共1条
    付款--反核销费用明细(所有)    ${businessNo}
    点击付款单查询
    ${pages1}    付款单查询验证    ${payNo}
    应该包含    ${pages1}    共0条
