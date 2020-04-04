*** Settings ***
Library           RFS.GM1_test.pylib.SCcommon
Variables         RFS/GM1_test/sc_cfg.py

*** Test Cases ***
添加用户 - tc000001
    refresh_sleep
    click_user_setting    设置    用户管理
    enter_iframe    GM1ExternalFrame
    add_user
    ${user_name}=    get_username
    ${username_list}=    check_username    ${user_name}
    Should Be True    $user_name in $username_list


修改用户 - tc000002
    refresh_sleep
    click_user_setting    设置    用户管理
    enter_iframe    GM1ExternalFrame
    action_first_user
    modify_user

删除用户 - tc000003
    refresh_sleep
    click_user_setting    设置    用户管理
    enter_iframe    GM1ExternalFrame
    action_first_user
    ${first_user_name}=    get_first_username
    delete_user
    ${username_list}=    check_username    ${first_user_name}
    should be true    $username_list == []
