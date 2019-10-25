*** Settings ***
Library  pylib.SCcommon
Library  pylib.SCuser
Variables  sc_cfg.py
Suite Setup  pylib.SCcommon.sc_login  sc_lzb  a111111

*** Test Cases ***
添加用户 - tc000001
    add_user

修改用户 - tc000002
    modify_user

删除用户 - tc000003
    delete_user

