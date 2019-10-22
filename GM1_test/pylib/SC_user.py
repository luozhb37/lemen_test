import time,random,traceback
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium import webdriver
from dazhanggui_test.tc.sc_cfg import *
from selenium.webdriver import ActionChains

class SC_user:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    name = 'sc_user'
    def __init__(self):
        options = webdriver.ChromeOptions()
        prefs = {
            'profile.default_content_setting_values':
                {
                    'notifications': 2
                }
        }
        options.add_experimental_option('prefs', prefs)  # 关掉浏览器左上角的通知提示
        # options.add_argument("disable-infobars")  # 关闭'chrome正受到自动测试软件的控制'提示
        options.add_argument('--ignore-certificate-errors')
        options.add_argument('--ignore-ssl-errors')
        self.driver = webdriver.Chrome(chrome_options=options)
        self.driver.maximize_window()
        self.timestamp = str(time.time())

    def open_broswer(self):
        self.driver.implicitly_wait(3)

    def close_broswer(self):
        self.driver.quit()

    def login(self):
        self.driver.get(url)
        self.driver.implicitly_wait(10)
        self.driver.switch_to.frame("loginPanel")
        self.driver.find_element_by_css_selector('#username').send_keys(username)
        self.driver.find_element_by_css_selector('#password').send_keys(password+'\n')
        time.sleep(3)
        window_ele = self.driver.find_elements_by_css_selector('div.ant-modal-body a span')#处理弹窗
        if window_ele:
            window_ele[0].click()

    def phoneNORandomGenerator(self):
        prelist = ["130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "147", "150", "151", "152",
                   "153", "155", "156", "157", "158", "159", "186", "187", "188"]
        return random.choice(prelist) + "".join(random.choice("0123456789") for i in range(8))

    def click_user_setting(self):
        # self.driver.find_element_by_css_selector('ul#rootMenu li:nth-child(1)').click()
        # time.sleep(3)
        self.driver.implicitly_wait(10)
        move = self.driver.find_element_by_xpath('//span[text()="设置"]')
        ActionChains(self.driver).move_to_element(move).perform()
        move.find_element_by_xpath("//span[text()='用户管理']").click()
        time.sleep(3)

    def add_user(self):
        try:
            self.driver.implicitly_wait(10)
            self.click_user_setting()
            self.driver.switch_to.frame('GM1ExternalFrame')
            self.driver.find_element_by_css_selector('div.ant-table-title div.custom_other_btn_right:nth-child(1)').click()
            time.sleep(1)
            self.driver.find_element_by_css_selector('input#username').send_keys(self.timestamp)
            self.driver.find_element_by_css_selector('input#pwd').send_keys(password)
            self.driver.find_element_by_css_selector('input#surName').send_keys(self.timestamp)
            self.driver.find_element_by_css_selector('input#firstName').send_keys(self.timestamp)
            self.driver.find_element_by_css_selector('input#nickName').send_keys(self.timestamp)
            self.driver.find_element_by_css_selector('span.ant-select-selection__rendered span').click()
            select_departments = self.driver.find_elements_by_css_selector('ul.ant-select-tree span:nth-child(2)')
            select_departments[0].click()
            time.sleep(2)
            self.driver.find_element_by_xpath("//input[@id='roleGroupList']/../../../..").click()#角色
            time.sleep(1)
            selects = self.driver.find_elements_by_css_selector("ul[role='listbox'] li:nth-of-type(2)")
            selects[0].click()
            self.driver.find_element_by_css_selector('input#username').click()
            time.sleep(2)
            self.driver.find_element_by_css_selector('div#personType').click()#岗位
            time.sleep(1)
            selects = self.driver.find_elements_by_css_selector("ul[role='listbox'] li:nth-of-type(2)")
            selects[1].click()
            self.driver.find_element_by_css_selector('input#username').click()
            time.sleep(2)
            self.driver.find_element_by_css_selector('input#mobile').send_keys(self.phoneNORandomGenerator())
            self.driver.find_element_by_css_selector('input#emailAddress').send_keys(f'{self.timestamp}@qq.com')
            self.driver.find_element_by_css_selector('button.ant-btn.ant-btn-primary').click()
            time.sleep(3)
            self.driver.find_element_by_css_selector('button[aria-label="Close"]').click()
            time.sleep(1)
        except:
            print(traceback.format_exc())

    def action_first_user(self):
        move = self.driver.find_element_by_css_selector("div.ant-table-title div.custom_other_btn_right:nth-child(1)")
        ActionChains(self.driver).move_to_element(move).perform()  # 移动焦点让左侧菜单栏收回
        time.sleep(3)
        move = self.driver.find_element_by_css_selector("tbody.ant-table-tbody>tr:nth-child(1)")
        ActionChains(self.driver).move_to_element(move).perform()  # 移动鼠标到第一栏方便下面定位

    def modify_user(self):
        try:
            self.driver.implicitly_wait(10)
            self.driver.refresh()#不加无法跳转
            time.sleep(3)
            self.click_user_setting()
            self.driver.switch_to.frame('GM1ExternalFrame')
            time.sleep(3)
            self.action_first_user()
            time.sleep(1)
            # menu = self.driver.find_element_by_css_selector("tr.ant-table-row.ant-table-row-level-0 td:nth-child(4)>div>div>a")
            hidden_submenu = self.driver.find_element_by_css_selector("tbody.ant-table-tbody td:nth-child(4) div a")
            ActionChains(self.driver).move_to_element(hidden_submenu).click(hidden_submenu).perform()
            time.sleep(2)
            self.driver.find_element_by_css_selector('input#pwd').send_keys(new_password)
            mobile_ele = self.driver.find_element_by_css_selector('input#mobile')
            mobile_ele.clear()
            mobile_ele.send_keys(self.phoneNORandomGenerator())
            email_ele = self.driver.find_element_by_css_selector('input#emailAddress')
            email_ele.clear()
            email_ele.send_keys(f'{self.timestamp}@qq.com')
            self.driver.find_element_by_css_selector('button.ant-btn.ant-btn-primary').click()
            time.sleep(3)
            self.driver.find_element_by_css_selector('button[aria-label="Close"]').click()
            time.sleep(2)
        except:
            print(traceback.format_exc())

    def delete_user(self):
        try:
            self.driver.implicitly_wait(10)
            self.driver.refresh()  # 不加无法跳转
            time.sleep(3)
            self.click_user_setting()
            self.driver.switch_to.frame('GM1ExternalFrame')
            self.action_first_user()
            time.sleep(1)
            menu = self.driver.find_element_by_css_selector("tbody.ant-table-tbody td input")
            # hidden_submenu = self.driver.find_element_by_css_selector("tr.ant-table-row.ant-table-row-hover.ant-table-row-level-0 td:nth-child(1)")
            ActionChains(self.driver).move_to_element(menu).click(menu).perform()
            self.driver.find_element_by_css_selector('div.ant-table-title div.custom_other_btn_right:nth-child(4)').click()
            time.sleep(2)
            self.driver.find_element_by_css_selector('div.ant-confirm-btns button:nth-child(2)').click()
            time.sleep(3)
        except:
            print(traceback.format_exc())

if __name__ == '__main__':
    s1 = SC_user()
    s1.open_broswer()
    s1.login()
    s1.add_user()
    # s1.modify_user()
    # s1.delete_user()
    s1.close_broswer()


