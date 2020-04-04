*** Settings ***
Library  RFS.GM1_test.pylib.SCcommon
Variables  RFS/GM1_test/sc_cfg.py
Suite Setup         Run Keywords   Open Broswer  AND   sc_login  ${sc_username}  ${sc_password}
Suite Teardown      Close Broswer
