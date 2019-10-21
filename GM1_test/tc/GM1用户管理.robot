*** Settings ***
Library  dazhanggui_test/pylib/SC_user.py
Variables  dazhanggui_test/tc/sc_cfg.py
Suite Setup  login

*** Test Cases ***
添加用户 - tc000001
    add_user

修改用户 - tc000002
    modify_user

删除用户 - tc000003
    delete_user

