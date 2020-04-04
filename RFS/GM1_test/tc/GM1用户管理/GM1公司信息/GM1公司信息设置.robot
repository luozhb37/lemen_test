*** Settings ***
Library           RFS.GM1_test.pylib.SCcommon
Variables         RFS/GM1_test/sc_cfg.py


*** Test Cases ***
添加用户 - tc000010
    refresh_sleep
    click_user_setting    设置  公司信息
    enter_iframe    GM1ExternalFrame
    modify_company_infomation