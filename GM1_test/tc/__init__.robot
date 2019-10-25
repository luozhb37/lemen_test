*** Settings ***
Library  pylib.SCcommon
Library  pylib.SCuser
Variables  sc_cfg.py
Suite Setup         pylib.SCcommon.Open Broswer
Suite Teardown    pylib.SCcommon.Close Broswer