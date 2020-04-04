# import win32com.client
# from tkinter import filedialog
# from selenium.webdriver.common.keys import Keys
# from RFS.GM1_test.pylib.SCcommon import *
# class SCcompany(SCcommon):
#     ROBOT_LIBRARY_SCOPE = 'GLOBAL'
#     name = 'sccompany'
#     # sc_c1 = SCcommon()
#     # driver = sc_c1.driver()
#
#     #其余信息个人觉得更改不太好,这边只更换公司logo
#     def modify_company_infomation(self):#此关键字只限打开的对话框有相关图片才可以操作，因无法确定其他成员电脑图片存放具体位置
#         self.driver.implicitly_wait(10)
#         self.refresh_sleep()
#         self.enter_iframe("GM1ExternalFrame")
#         self.driver.find_element_by_css_selector('div#customer-edit-area span.ant-upload').click()
#         time.sleep(3)
#         shell = win32com.client.Dispatch('WScript.Shell')
#         shell.Sendkeys(r"D:\test_photo\test123.gif" + "\r\n")
#         shell.Sendkeys("{ENTER}")
#         time.sleep(3)
#         self.driver.find_element_by_css_selector("button.ant-btn-primary").click()
#         time.sleep(1)
#



# if __name__ == '__main__':
#     s2 = SCcompany()
#     s2.open_broswer()
#     s2.sc_login('sc_lzb','a111111')
#     s2.click_user_setting('设置','公司信息')
#     s2.modify_company_infomation()
#     s2.close_broswer()
#
#
