# from RFS.GM1_test.pylib.SCcommon import *
# from RFS.GM1_test.sc_cfg import *
# import time,random,traceback
# from selenium.webdriver import ActionChains
# from RFS.GM1_test.pylib.DriverUtil import DriverUtil
#
#
# class SCuser:
#     ROBOT_LIBRARY_SCOPE = 'GLOBAL'
#     name = 'scuser'
#     timestamp = str(time.time())
#     # driver = DriverUtil.get_driver()
#     # sc_u1 = SCcommon()
#     # driver = sc_u1.driver()
#
#     def add_user(self):#增加用户
#         try:
#             self.driver.implicitly_wait(10)
#             self.sc_u1.refresh_sleep()
#             self.sc_u1.click_user_setting('设置','用户管理')
#             self.sc_u1.enter_iframe("GM1ExternalFrame")
#             self.driver.find_element_by_css_selector('div.ant-table-title div.custom_other_btn_right:nth-child(1)>button').click()
#             time.sleep(1)
#             self.driver.find_element_by_css_selector('input#username').send_keys(self.timestamp)
#             self.driver.find_element_by_css_selector('input#pwd').send_keys(sc_password)
#             self.driver.find_element_by_css_selector('input#surName').send_keys(self.timestamp)
#             self.driver.find_element_by_css_selector('input#firstName').send_keys(self.timestamp)
#             self.driver.find_element_by_css_selector('input#nickName').send_keys(self.timestamp)
#             self.driver.find_element_by_css_selector('span.ant-select-selection__rendered span').click()
#             select_departments = self.driver.find_elements_by_css_selector('ul.ant-select-tree span:nth-child(2)')
#             select_departments[0].click()
#             time.sleep(2)
#             self.driver.find_element_by_xpath("//input[@id='roleGroupList']/../../../..").click()#角色
#             time.sleep(1)
#             selects = self.driver.find_elements_by_css_selector("ul[role='listbox'] li:nth-of-type(2)")
#             selects[0].click()
#             self.driver.find_element_by_css_selector('input#username').click()
#             time.sleep(2)
#             self.driver.find_element_by_css_selector('div#personType').click()#岗位
#             time.sleep(1)
#             selects = self.driver.find_elements_by_css_selector("ul[role='listbox'] li:nth-of-type(2)")
#             selects[1].click()
#             self.driver.find_element_by_css_selector('input#username').click()
#             time.sleep(2)
#             self.driver.find_element_by_css_selector('input#mobile').send_keys(self.sc_u1.phoneNORandomGenerator())
#             self.driver.find_element_by_css_selector('input#emailAddress').send_keys(f'{self.timestamp}@qq.com')
#             self.driver.find_element_by_css_selector('button.ant-btn.ant-btn-primary').click()
#             time.sleep(3)
#             self.driver.find_element_by_css_selector('button[aria-label="Close"]').click()
#             time.sleep(1)
#         except:
#             print(traceback.format_exc())
#
#     def action_first_user(self):#用户栏焦点
#         self.sc_u1.move_chains_css("div.ant-table-title div.custom_other_btn_right:nth-child(1)")  # 移动焦点让左侧菜单栏收回
#         time.sleep(3)
#         self.sc_u1.move_chains_css("tbody.ant-table-tbody>tr:nth-child(1)")  # 移动鼠标到第一栏方便下面定位
#
#     def modify_user(self):#修改用户
#         try:
#             self.driver.implicitly_wait(10)
#             self.sc_u1.refresh_sleep()
#             self.sc_u1.click_user_setting('设置','用户管理')
#             self.sc_u1.enter_iframe("GM1ExternalFrame")
#             time.sleep(3)
#             self.action_first_user()
#             time.sleep(1)
#             # menu = self.driver.find_element_by_css_selector("tr.ant-table-row.ant-table-row-level-0 td:nth-child(4)>div>div>a")
#             hidden_submenu = self.driver.find_element_by_css_selector("tbody.ant-table-tbody td:nth-child(4) div a")
#             ActionChains(self.driver).move_to_element(hidden_submenu).click(hidden_submenu).perform()
#             time.sleep(2)
#             self.driver.find_element_by_css_selector('input#pwd').send_keys(sc_new_password)
#             mobile_ele = self.driver.find_element_by_css_selector('input#mobile')
#             mobile_ele.clear()
#             mobile_ele.send_keys(self.sc_u1.phoneNORandomGenerator())
#             email_ele = self.driver.find_element_by_css_selector('input#emailAddress')
#             email_ele.clear()
#             email_ele.send_keys(f'{self.timestamp}@qq.com')
#             self.driver.find_element_by_css_selector('button.ant-btn.ant-btn-primary').click()
#             time.sleep(3)
#             self.driver.find_element_by_css_selector('button[aria-label="Close"]').click()
#             time.sleep(2)
#         except:
#             print(traceback.format_exc())
#
#     def delete_user(self):#删除用户
#         try:
#             self.driver.implicitly_wait(10)
#             self.sc_u1.refresh_sleep()
#             self.sc_u1.click_user_setting('设置','用户管理')
#             self.sc_u1.enter_iframe("GM1ExternalFrame")
#             self.action_first_user()
#             time.sleep(1)
#             menu = self.driver.find_element_by_css_selector("tbody.ant-table-tbody td input")
#             # hidden_submenu = self.driver.find_element_by_css_selector("tr.ant-table-row.ant-table-row-hover.ant-table-row-level-0 td:nth-child(1)")
#             ActionChains(self.driver).move_to_element(menu).click(menu).perform()
#             self.driver.find_element_by_css_selector('div.ant-table-title div.custom_other_btn_right:nth-child(4)').click()
#             time.sleep(2)
#             self.driver.find_element_by_css_selector('div.ant-confirm-btns button:nth-child(2)').click()
#             time.sleep(3)
#         except:
#             print(traceback.format_exc())
#
# if __name__ == '__main__':
#     s1 = SCuser()
#     s1.sc_u1.open_broswer()
#     s1.sc_u1.sc_login('sc_lzb','a111111')
#     s1.add_user()
#     s1.modify_user()
#     s1.delete_user()
#     s1.sc_u1.close_broswer()
#
#
#
#
