*** Settings ***
Library  dazhanggui_test/pylib/SC_user.py
Variables  dazhanggui_test/tc/sc_cfg.py
Suite Setup    open_broswer
Suite Teardown    close_broswer