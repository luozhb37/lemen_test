*** Settings ***
Library  GM1_test/pylib/SCcommon.py
Library  GM1_test/pylib/SCuser.py
Variables  GM1_test/tc/sc_cfg.py
Suite Setup         open_broswer
Suite Teardown    close_broswer