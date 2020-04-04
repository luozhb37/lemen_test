*** Settings ***
Library           RFS.GM1_test.pylib.SCcommon
Variables         RFS/GM1_test/sc_cfg.py


*** Test Cases ***
新增海运出口拼箱订单 - tc000030
    refresh_sleep
    click_user_setting    订单  订单列表
    Order_list_click_all
    add_order_init    订单  海运出口拼箱
    add_order_client
    add_order_service  境外服务
    order_button_ascertain  确定
    enter_handle  新增订单
    order_services  订舱,第三国转运,目的港换单
    add_order_save  保存
    add_order_save  提交
    order_through  通过
    order_New_shipping_space  新订
    order_button_ascertain  确定
    enter_mainhandle

新增海运出口整箱订单 - tc000031
    refresh_sleep
    click_user_setting    订单  订单列表
    Order_list_click_all
    add_order_init    订单  海运出口整箱
    add_order_client
    add_order_service  境外服务
    order_button_ascertain  确定
    enter_handle  新增订单
    window_scroll_bar_div_select  //div[@id='bnMainsBookingCtnList[0].ctn_0']
    ...    ant-select-dropdown-menu \ ant-select-dropdown-menu-root ant-select-dropdown-menu-vertical  0  10000
#    order_services  订舱,第三国转运,目的港换单
#    add_order_save  保存
#    add_order_save  提交
#    order_through  通过
#    order_New_shipping_space  新订
#    order_button_ascertain  确定
#    enter_mainhandle

新增铁路运输订单 - tc000032
    refresh_sleep
    click_user_setting    订单  订单列表
    Order_list_click_all
    add_order_init    订单  铁路运输
    add_order_client
    add_order_service  境外服务
    order_button_ascertain  确定
    enter_handle  新增订单
    order_services  订舱,拖柜,境外服务
    add_order_save  保存
    add_order_save  提交
    order_through  通过
    order_button_ascertain  确定
    enter_mainhandle

新增海运进口订单 - tc000033

新增空运出口订单 - tc000034

新增空运进口订单 - tc000035

新增海运出口占舱订单 - tc000035