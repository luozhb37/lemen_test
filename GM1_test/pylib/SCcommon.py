from selenium import webdriver
from GM1_test.tc.sc_cfg import *
import time,random,traceback
from selenium.webdriver import ActionChains

class SCcommon:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    name = 'sccommon'

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

    def open_broswer(self):
        self.driver.implicitly_wait(3)

    def sc_login(self,username,password):#登录 账号 密码
        self.driver.get(url)
        self.driver.implicitly_wait(10)
        self.driver.switch_to.frame("loginPanel")
        self.driver.find_element_by_css_selector('#username').send_keys(username)
        self.driver.find_element_by_css_selector('#password').send_keys(password+'\n')
        time.sleep(3)
        window_ele = self.driver.find_elements_by_css_selector('div.ant-modal-body a span')#处理弹窗
        if window_ele:
            window_ele[0].click()

    def close_broswer(self):
        self.driver.quit()

    def phoneNORandomGenerator(self):
        prelist = ["130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "147", "150", "151", "152",
                   "153", "155", "156", "157", "158", "159", "186", "187", "188"]
        return random.choice(prelist) + "".join(random.choice("0123456789") for i in range(8))

    def click_user_setting(self,tab_text,info_text):
        # self.driver.find_element_by_css_selector('ul#rootMenu li:nth-child(1)').click()
        # time.sleep(3)
        self.driver.implicitly_wait(10)
        move = self.driver.find_element_by_xpath(f"//span[text()='{tab_text}']")
        ActionChains(self.driver).move_to_element(move).perform()
        move.find_element_by_xpath(f"//span[text()='{info_text}']").click()
        time.sleep(3)


if __name__ == '__main__':
    sc = SCcommon()