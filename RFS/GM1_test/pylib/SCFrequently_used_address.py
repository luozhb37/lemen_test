# from RFS.GM1_test.pylib.SCcommon import *
# from RFS.GM1_test.sc_cfg import *
# import time,random,traceback
#
# class SCFrequently_used_address:
#     ROBOT_LIBRARY_SCOPE = 'GLOBAL'
#     name = 'scfrequently_used_address'
#
#     def add_address(self):#增加地址
#         self.driver.implicitly_wait(10)
#         self.sc_f1.refresh_sleep()
#         self.sc_f1.enter_iframe("GM1ExternalFrame")
#         self.driver.find_element_by_css_selector("td button:nth-child(1)").click()
#         time.sleep(3)
#         self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>div:nth"
#          "-child(1) input[type='text']").send_keys('test')
#         self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>div:nth-ch"
#          "ild(2) textarea.ant-input").send_keys("text")
#         self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>di"
#          "v:nth-child(4) input[type='text']").send_keys('test')
#         self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>div:nt"
#          "h-child(6) input[type='text']").send_keys(self.sc_f1.phoneNORandomGenerator())
#         time.sleep(1)
#         self.driver.find_element_by_css_selector("button.ant-btn-primary").click()
#         time.sleep(1)
#
#     def modify_address(self):#修改地址
#         self.driver.implicitly_wait(10)
#         self.sc_f1.refresh_sleep()
#         self.sc_f1.enter_iframe("GM1ExternalFrame")
#         self.driver.find_element_by_css_selector("tbody.ant-table-tbody>tr:nth-"
#          "child(1) td:nth-child(11) a:nth-child(1)").click()
#         ele_one = self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>div:nth"
#          "-child(1) input[type='text']")
#         ele_one.clear()
#         ele_one.send_keys('new')
#         ele_two = self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>div:nth-ch"
#          "ild(2) textarea.ant-input")
#         ele_two.clear()
#         ele_two.send_keys(self.sc_f1.now_time())
#         ele_four = self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>di"
#          "v:nth-child(4) input[type='text']")
#         ele_four.clear()
#         ele_four.send_keys('海运出口整箱')
#         time.sleep(1)
#         self.driver.find_element_by_css_selector("button.ant-btn-primary").click()
#         time.sleep(1)
#
#     def delete_address(self):#删除地址
#         self.driver.implicitly_wait(10)
#         self.sc_f1.refresh_sleep()
#         self.sc_f1.enter_iframe("GM1ExternalFrame")
#         self.driver.find_element_by_css_selector("tbody.ant-table-tbody>tr:nth-"
#           "child(1) td:nth-child(11) a:nth-child(2)").click()
#         time.sleep(3)
#         self.driver.find_element_by_css_selector("div.ant-confirm-btns button:nth-child(2)").click()
#         time.sleep(2)
#     try:
#         def set_default_address(self):#设置默认地址
#             self.driver.implicitly_wait(10)
#             self.sc_f1.refresh_sleep()
#             self.sc_f1.enter_iframe("GM1ExternalFrame")
#             self.sc_f1.move_chains_css("tbody.ant-table-tbody>tr:nth-child(1)")
#             ele_set = self.driver.find_element_by_css_selector("tbody.ant-table-tbody>tr:nth-child(1) td:nth-child(12) span")
#             if ele_set.text == '设置默认':
#                 ele_set.click()
#                 time.sleep(2)
#             else:
#                 if ele_set.text == '默认地址':
#                     self.sc_f1.move_chains_css("tbody.ant-table-tbody>tr:nth-child(2)")
#                     self.driver.find_element_by_css_selector(
#                         "tbody.ant-table-tbody>tr:nth-child(2) td:nth-child(12) span").click()
#                     time.sleep(2)
#     except:
#         print(traceback.format_exc())
#
#
#
#
# if __name__ == '__main__':
#     s3 = SCFrequently_used_address()
#     s3.sc_f1.open_broswer()
#     s3.sc_f1.sc_login('sc_lzb','a111111')
#     s3.sc_f1.click_user_setting('设置','常用地址')
#     s3.add_address()
#     s3.modify_address()
#     s3.delete_address()
#     s3.set_default_address()
#     s3.sc_f1.close_broswer()