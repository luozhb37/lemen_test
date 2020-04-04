from selenium import webdriver
from selenium.webdriver.support.wait import WebDriverWait
from RFS.GM1_test.sc_cfg import *
import time,random,traceback,math
import win32com.client
import win32api,win32con
from selenium.webdriver import ActionChains
from selenium.webdriver.common.keys import Keys
import requests,json,hashlib
from selenium.webdriver.support.select import Select
from RFS.GM1_test.pylib.DriverUtil import DriverUtil
from selenium.webdriver.common.keys import Keys

class SCcommon:
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    name = 'sccommon'
    timestamp = str(math.floor(time.time()))[5:]
    now_timestamp  = lambda:int(round(time.time() * 1000))
    dzg_timestamp = now_timestamp()
    # driver = DriverUtil.get_driver()

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
        self.options=options
        self.driver = webdriver.Chrome(chrome_options=self.options)
        # self.driver = DriverUtil.get_driver()

    #公用关键字
    def open_broswer(self):
        '''
        打开浏览器
        '''
        self.driver.maximize_window()
        self.driver.implicitly_wait(10)


    def sc_login(self,username,password):
        '''
        登录 账号 密码
        '''
        self.driver.get(gm1_sc_url)
        self.enter_iframe('loginPanel')
        self.driver.find_element_by_css_selector('#username').send_keys(username)
        self.driver.find_element_by_css_selector('#password').send_keys(password+'\n')
        time.sleep(4)
        self.Explicit_waiting("//span[text()='我知道了']/..")
        window_ele = self.driver.find_elements_by_xpath("//span[text()='我知道了']/..")#处理弹窗
        if window_ele:
            window_ele[0].click()

    def get_sc_cookies(self):
        '''
            用于获取浏览器登录后存的cookies值
        '''
        cookies_list = self.driver.get_cookies()
        cookies_new = []
        for cookie_one in cookies_list:
            cookie_name = cookie_one['name']
            cookie_value = cookie_one['value']
            cookie = cookie_name + '=' + cookie_value + ';'
            cookies_new.append(cookie)
        cookies_new = ''.join(cookies_new)
        cookies = cookies_new.rsplit(';',1)[0]
        return cookies

    def get_add_user_info(self):
        '''
        用于获取用户列表接口的相关信息
        '''
        user_list_url = 'https://gm1-scysa.100jit.com/fms-rest/rest/account/getAccountList?'

        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36',
            'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8',
            'Cookie':self.get_sc_cookies()
        }
        payload = {
            "pageSize":15,
            "page":1
                    }
        requests.urllib3.disable_warnings()
        reps = requests.post(user_list_url,data=payload,headers=headers,verify=False)
        reps = reps.json()
        # reps = json.dumps(reps,indent=3,sort_keys=True,ensure_ascii=False)
        return reps

    def get_add_user_info_one(self):
        '''
        用于获取增加用户后，对应邮箱中的统一会员激活链接
        '''
        info_one = self.get_add_user_info()['data']['list'][0]
        userid = info_one['userId']
        email = info_one['emailAddress']
        sign = '__activate_val_'+f'{userid}'+'gm1'+f'{self.dzg_timestamp}'+f'{email}'
        m = hashlib.md5()
        m.update(sign.encode("utf8"))
        str_md5 = m.hexdigest()
        email_url = 'http://dzg.800jit.com/dzg-membership-front/#/Activation?'+f'timestamp={self.dzg_timestamp}'+'&'+f'userId={userid}'+'&appCode=gm1'\
        +'&'+f'sign={str_md5}'
        return email_url

    def activate_Unified_member_into_phone(self,button_text,username,password):
        '''统一会员激活 进入带的手机号 暂不写  验证码卡住问题'''
        member_login_url = self.get_add_user_info_one()
        self.driver.get(member_login_url)
        type_text = self.driver.find_element_by_css_selector('label.ant-form-item-required').text
        if type_text == '手机号':
            type_text_one = self.driver.find_element_by_css_selector('span.activation-warning-info').text
            if type_text_one == '已是大掌柜会员，请输入会员密码进行确认并绑定':
                self.driver.find_element_by_id('password').send_keys(password)
                self.driver.find_element_by_xpath(f"//span[text()='{' '.join(button_text)}']/..").click()
            else:
                if type_text_one == '，请完成以下验证以确认为你本人操作，并完善会员账号信息':
                    pass


    def activate_Unified_member_select(self):
        '''统一会员激活选择已有掌柜通   暂不写  验证码卡住问题'''
        member_login_url = self.get_add_user_info_one()
        self.driver.get(member_login_url)

    def close_broswer(self):
        '''
        关闭浏览器
        '''
        self.driver.quit()


    def autonumber(self,num,user_prefix):
        '''
        循环新增用户
        '''
        for auto_num in range(0, int(num)+1):
            self.firstname = user_prefix
            self.secondname = 'auto_'+str(auto_num)
            self.input_username = self.firstname+self.secondname
            self.refresh_sleep()
            self.click_user_setting('设置', '用户管理')
            self.add_user(self.firstname,self.secondname)

    def auto_modify(self,num):
        '''
        循环修改用户
        '''
        for auto_num in range(38, int(num) + 1):
            self.secondname = 'jt_auto_' + str(auto_num)
            self.refresh_sleep()
            self.click_user_setting('设置', '用户管理')
            self.driver.find_element_by_css_selector('input#name').send_keys(self.secondname)
            time.sleep(1)
            self.driver.find_element_by_css_selector('button#MainPage-old-adSearch').click()
            time.sleep(2)
            element_one = f"//a[text()='{self.secondname}']"
            self.Explicit_waiting(element_one)
            self.ele_not_click_xpath(element_one)
            time.sleep(2)
            element_one = "//div[@id='routes']//div[@class='ant-select-selection__rendered']/div"
            self.Explicit_waiting(element_one)
            self.doubile_click_xpath(element_one)
            self.actions_sendkeys_xpath("//div[@id='routes']//div[@class='ant-select-selection__rendered']//input",'全部')
            # self.driver.find_element_by_xpath(element_one).send_keys('全部')
            time.sleep(2)
            self.driver.find_element_by_css_selector('input#username').click()  # 点击用户名处理焦点
            self.driver.find_element_by_css_selector("span.ant-select-search__field__placeholder").click()
            time.sleep(1)
            self.driver.find_element_by_xpath("//span[@class='ant-select-tree-node-content-wrapper ant-select-tree-node-content-wrapper-close']").click()
            time.sleep(2)
            self.driver.find_element_by_css_selector('input#username').click()
            # 点击用户名处理焦点
            # self.Explicit_waiting("//div[@id='personType']//span[@class='ant-select-selection__choice__remove']")
            # self.ele_not_click_xpath("//div[@id='personType']//span[@class='ant-select-selection__choice__remove']")
            # time.sleep(2)
            ele = "//div[@id='roleGroupList']/div/div"
            self.Explicit_waiting(ele)
            # self.doubile_click_xpath(ele)
            self.driver.find_element_by_xpath(ele).click()
            time.sleep(2)
            for i in range(4):
                self.actions_sendkeys_xpath(ele,Keys.BACKSPACE)
            self.actions_sendkeys_xpath(ele,'全权限')
            # 点击角色
            # self.driver.find_element_by_xpath("//div[@id='roleGroupList']").send_keys("全权限")
            # self.driver.find_element_by_xpath("//li[@class='ant-select-dropdown-menu-item ant-select-dropdown-menu-item-active']").click()
            time.sleep(1)
            self.driver.find_element_by_css_selector('input#username').click()  # 点击用户名处理焦点
            time.sleep(2)
            ele = "//div[@id='personType']/div/div"
            self.Explicit_waiting(ele)
            self.ele_not_click_xpath(ele)
            time.sleep(1)
            for i in range(4):
                self.actions_sendkeys_xpath(ele,Keys.BACKSPACE)  # 岗位
            time.sleep(2)
            self.driver.find_element_by_xpath("//li[text()='客服']").click()
            time.sleep(1)
            self.driver.find_element_by_xpath("//li[text()='单证']").click()
            time.sleep(1)
            self.driver.find_element_by_xpath("//li[text()='操作']").click()
            time.sleep(1)
            self.driver.find_element_by_xpath("//li[text()='商务']").click()
            time.sleep(1)
            self.driver.find_element_by_xpath("//li[text()='销售']").click()
            time.sleep(1)
            self.driver.find_element_by_xpath("//li[text()='报关']").click()
            time.sleep(1)
            self.driver.find_element_by_xpath("//li[text()='报检']").click()
            time.sleep(1)
            self.driver.find_element_by_xpath("//li[text()='财务']").click()
            time.sleep(1)
            self.driver.find_element_by_css_selector('input#username').click()  # 点击用户名处理焦点
            time.sleep(1)
            self.driver.find_element_by_css_selector('button.ant-btn.ant-btn-primary').click()
            time.sleep(3)
            self.driver.find_element_by_css_selector('button[aria-label="Close"]').click()
            time.sleep(2)

    def phoneNORandomGenerator(self):
        '''
        随机生成手机号
        '''
        prelist = ["130", "131", "132", "133", "134", "135", "136", "137", "138", "139", "147", "150", "151", "152",
                   "153", "155", "156", "157", "158", "159", "186", "187", "188"]
        return random.choice(prelist) + "".join(random.choice("0123456789") for i in range(8))

    def click_user_setting(self,tab_text,info_text):
        '''
        登陆后点击相关菜单操作
        '''
        move_ele = f"//span[text()='{tab_text}']"
        self.Explicit_waiting(move_ele)
        move = self.move_chains_xpath(move_ele)
        move.find_element_by_xpath(f"//span[text()='{info_text}']").click()
        time.sleep(3)

    def now_time(self):
        '''
        生成年月日
        '''
        return time.strftime("%Y-%m-%d", time.localtime())

    def enter_iframe(self,iframe):
        '''
        切换iframe
        '''
        self.driver.switch_to.frame(iframe)

    def refresh_sleep(self):
        '''
        刷新以及等待，不加刷新无法跳转
        '''
        self.driver.refresh()
        time.sleep(3)

    def move_chains_css(self,move_ele):
        '''
        鼠标悬浮css
        '''
        move = self.driver.find_element_by_css_selector(move_ele)
        ActionChains(self.driver).move_to_element(move).perform()
        return move

    def move_chains_xpath(self,move_ele):
        '''
        鼠标悬浮xpath
        '''
        move = self.driver.find_element_by_xpath(move_ele)
        ActionChains(self.driver).move_to_element(move).perform()
        return move

    def enter_handle(self,handle_name):
        '''
        切换窗口,输入窗口title值
        '''
        self.mainwindow = self.driver.current_window_handle#保存跳转前的窗口
        handles = self.driver.window_handles
        for handle in handles:
            self.driver.switch_to.window(handle)
            if handle_name in self.driver.title:
                break
        time.sleep(3)
        return self.mainwindow

    def enter_mainhandle(self):
        '''
        切回上个方法调用前的窗口
        '''
        self.driver.switch_to.window(self.mainwindow)
        time.sleep(3)

    def ele_not_click_css(self,element_one):
        '''
        元素无法点击的处理
        '''
        hidden_submenu = self.driver.find_element_by_css_selector(element_one)
        ActionChains(self.driver).move_to_element(hidden_submenu).click(hidden_submenu).perform()

    def ele_not_click_xpath(self,element_one):
        '''
        元素无法点击的处理
        '''
        hidden_submenu = self.driver.find_element_by_xpath(element_one)
        ActionChains(self.driver).move_to_element(hidden_submenu).click(hidden_submenu).perform()

    def doubile_click_xpath(self,click_ele):
        '''
        鼠标双击操作    xpath文本框定位
        '''
        double_click = self.driver.find_element_by_xpath(click_ele)
        ActionChains(self.driver).double_click(double_click).perform()

    def doubile_click_css(self,click_ele):
        '''
        鼠标双击操作    xpath文本框定位
        '''
        double_click = self.driver.find_element_by_css_selector(click_ele)
        ActionChains(self.driver).double_click(double_click).perform()

    def actions_sendkeys_xpath(self,click_ele,ele_text):
        '''
        鼠标悬浮操作    输入文本值  xpath文本框定位 文本框为隐藏，直接使用send_keys方法无效
        '''
        self.driver.find_element_by_xpath(click_ele)
        ActionChains(self.driver).send_keys(ele_text).perform()

    def DropDownList_xpath(self,select_ele,list_ele,ele_text,label=None):
        '''此方法应用于不可输入的下拉框  可输入的也可用，但有可能展示不全
        订单/业务部分下拉框  第一个参数为下拉框元素定位本身  eg: //div[@id='bnPersonTypeRelaList-service-personal-list-container']
        第二个为下拉框列表中某个元素定位值,注意用的为xpath文本值，最后需加上文本值对应的html标签名   <li>文本值</li> 若为span等不可操作的标签，则需加上/..
        eg: //div[@id='bnPersonTypeRelaList-service-personal-list-container']//li
        eg: //div[@id='bnPersonTypeRelaList-service-personal-list-container']//span
        第三个为下拉框某元素定位值对应文本值  eg: 20GP
        第四个对应为第二个需后加的参数，只有为不可操作标签，如span，才需填写任意值  eg:biaoqian
        '''
        self.driver.find_element_by_xpath(select_ele).click()
        time.sleep(3)
        droplist_element = f"{list_ele}[text()='{ele_text}']"
        if label:
            droplist_element += '/..'
        move = self.move_chains_xpath(droplist_element)
        move.click()

    def DropDownList_xpath_input(self,select_ele_click,select_ele_input,ele_text,list_ele,label=None):
        '''此方法应用于可输入的下拉框
        订单/业务部分下拉框  第一个参数为下拉框元素定位本身  eg: //div[@id='bnPersonTypeRelaList-service-personal-list-container']
        第二个为下拉框列表中某个元素文本值 eg: 20GP
        第三个为下拉框列表中某个元素定位值,注意用的为xpath文本值，最后需加上文本值对应的html标签名   <li>文本值</li> 若为span等不可操作的标签，则需加上/..
        eg: //div[@id='bnPersonTypeRelaList-service-personal-list-container']//li
        eg: //div[@id='bnPersonTypeRelaList-service-personal-list-container']//span
        第四个对应为第二个需后加的参数，只有为不可操作标签，如span，才需填写任意值  eg:biaoqian
        '''
        self.Explicit_waiting(select_ele_click)
        self.doubile_click_xpath(select_ele_click)
        self.actions_sendkeys_xpath(select_ele_input,ele_text)
        time.sleep(2)
        droplist_element = f"{list_ele}[text()='{ele_text}']"
        if label:
            droplist_element += '/..'
        move = self.move_chains_xpath(droplist_element)
        move.click()

    def window_scroll_bar_div(self,ele,num,scrollTop):
        '''
        用于滚动条是针对某个div
        内嵌/弹出框窗口滚动条 滑到底部  先定位到内嵌窗口元素的classname语句  需判断元素在列表中第几位  像素偏移量 底部则为10000 顶部则为0 或者自定义
        eg: BaseTable__body  2  10000
        目前已测试 订单列表适用
        '''
        num = int(num)
        js = f"var q=document.getElementsByClassName('{ele}')[{num}].scrollTop = {scrollTop}"
        self.driver.execute_script(js)
        time.sleep(3)

    def window_scroll_bar_div_select(self,select_ele,ele,num,scrollTop):
        '''
        用于滚动条是针对某个div  下拉框内滚动条
        内嵌/弹出框窗口滚动条 滑到底部  先定位到内嵌窗口元素的classname语句  需判断元素在列表中第几位  像素偏移量 底部则为10000 顶部则为0 或者自定义
        eg: 下拉框本身定位元素（xpath写法）  BaseTable__body  2  10000
        目前已测试 订单列表适用
        '''
        self.driver.find_element_by_xpath(f"{select_ele}").click()
        num = int(num)
        js = f"var q=document.getElementsByClassName('{ele}')[{num}].scrollTop = {scrollTop}"
        self.driver.execute_script(js)
        time.sleep(3)

    def window_scroll_bar_body(self,scrollTop):
        '''
        针对整个body
        滑到底部  像素偏移量 底部则为10000 顶部则为0 或者自定义
        '''
        js = f"var q=document.body.scrollTop={scrollTop}"
        self.driver.execute_script(js)
        time.sleep(3)

    def Page_scroll_bar(self,scrollTop):
        '''
        用于滚动条是针对整个html  eg: 业务/订单详情页
        网页滚动条  #将页面滚动条拖到底部  像素偏移量 底部则为10000 顶部则为0 或者自定义
        '''
        js = f"var q=document.documentElement.scrollTop={scrollTop}"
        self.driver.execute_script(js)

    def Drop_down_box_slide(self,select_ele=None):#暂不使用 暂不使用
        '''
        下拉框无滚动条操作
        '''
        for i in range(1, 1000):
            sc.move_chains_xpath(select_ele)
            win32api.mouse_event(win32con.MOUSEEVENTF_WHEEL, 0, 0, -1)

    def Explicit_waiting(self,element):
        '''
        显式等待
        '''
        WebDriverWait(self.driver, 10, 1).until(lambda x: x.find_element_by_xpath(element))

    def Explicit_waiting_css(self,element):
        '''
        显式等待
        '''
        WebDriverWait(self.driver, 10, 1).until(lambda x: x.find_element_by_css_selector(element))

    #用户管理关键字
    def add_user(self,firstname,secondname):
        '''
        增加用户  新增完走统一会员激活逻辑，因验证码卡住问题，暂无脚本可用
        '''
        try:
            self.driver.find_element_by_css_selector('div.ant-table-title div.custom_other_btn_right:nth-child(1)>button').click()
            time.sleep(1)
            self.driver.find_element_by_css_selector('input#surName').send_keys(firstname)
            self.driver.find_element_by_css_selector('input#firstName').send_keys(secondname)
            self.driver.find_element_by_css_selector('input#nickName').click()#昵称
            self.driver.find_element_by_css_selector('span.ant-select-selection__rendered span').click()#编制部门点击
            select_departments = self.driver.find_elements_by_css_selector('ul.ant-select-tree span:nth-child(2)')
            select_departments[0].click()#选择第一个部门
            # self.driver.find_element_by_css_selector('#businessTypes div.ant-select-selection__rendered>div').click()#点击数据权限
            # time.sleep(1)
            # self.driver.find_element_by_css_selector('ul.ant-select-dropdown-menu>li:nth-child(1)').click()#选择第一个数据权限
            # time.sleep(2)
            self.driver.find_element_by_css_selector('input#surName').click()  # 点击员工姓处理焦点
            time.sleep(1)
            self.driver.find_element_by_xpath("//div[@id='roleGroupList']").click()#点击角色
            # self.driver.find_element_by_xpath("//input[@id='roleGroupList']").send_keys(Keys.ENTER)
            time.sleep(1)
            # self.driver.find_element_by_css_selector('div.ant-select-dropdown-placement-topLeft li:nth-child(2)').click()#角色
            # self.doubile_click_css('div.ant-select-dropdown-placement-topLeft li:nth-child(2)')
            self.driver.find_element_by_css_selector(
                'ul.ant-select-dropdown-menu.ant-select-dropdown-menu-root.ant-select-dropdown-menu-vertical li:nth-child(1)').click()  # 角色
            time.sleep(1)
            self.driver.find_element_by_css_selector(
                'ul.ant-select-dropdown-menu.ant-select-dropdown-menu-root.ant-select-dropdown-menu-vertical li:nth-child(3)').click()  # 角色
            time.sleep(1)
            self.driver.find_element_by_css_selector(
                'ul.ant-select-dropdown-menu.ant-select-dropdown-menu-root.ant-select-dropdown-menu-vertical li:nth-child(4)').click()  # 角色
            self.driver.find_element_by_css_selector('input#surName').click()  # 点击员工姓处理焦点
            time.sleep(2)
            self.driver.find_element_by_css_selector('div#personType').click()#岗位
            time.sleep(2)
            self.driver.find_element_by_xpath("//li[text()='销售助理']").click()
            time.sleep(1)
            self.driver.find_element_by_xpath("//li[text()='协同']").click()
            time.sleep(1)
            self.driver.find_element_by_xpath("//li[text()='客服']").click()
            time.sleep(1)
            self.driver.find_element_by_xpath("//li[text()='订舱']").click()
            time.sleep(1)
            self.driver.find_element_by_css_selector('input#surName').click()  # 点击员工姓处理焦点
            time.sleep(2)
            self.driver.find_element_by_css_selector('input#mobile').send_keys(self.phoneNORandomGenerator())
            self.driver.find_element_by_css_selector('input#emailAddress').send_keys(f'{self.timestamp}@qq.com')
            self.driver.find_element_by_css_selector('button.ant-btn.ant-btn-primary').click()
            time.sleep(3)
            self.driver.find_element_by_css_selector('button[aria-label="Close"]').click()
            time.sleep(1)

        except:
            print(traceback.format_exc())

        return firstname + secondname

    def action_first_user(self):
        '''
        用户栏焦点
        移动焦点让左侧菜单栏收回
        移动鼠标到第一栏方便下面定位
        '''
        self.move_chains_css("div.ant-table-title div.custom_other_btn_right:nth-child(1)")  # 移动焦点让左侧菜单栏收回
        time.sleep(3)
        self.move_chains_css("tbody.ant-table-tbody>tr:nth-child(1)")  # 移动鼠标到第一栏方便下面定位

    def modify_user(self):
        '''
        修改用户
        '''
        try:
            self.ele_not_click_css("tbody.ant-table-tbody td:nth-child(4) div a")
            time.sleep(2)
            self.driver.find_element_by_css_selector('input#pwd').send_keys(sc_new_password)
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
        '''
        删除用户
        '''
        try:
            menu = self.driver.find_element_by_css_selector("div.ant-table-fixed-right tbody tr:nth-child(1) div>a:nth-of-type(2)")
            ActionChains(self.driver).move_to_element(menu).click(menu).perform()
            time.sleep(2)
            self.driver.find_element_by_css_selector('div.ant-confirm-btns button:nth-child(2)').click()
            time.sleep(3)
        except:
            print(traceback.format_exc())

    def stop_user(self):
        '''
        停用用户
        '''
        try:
            menu = self.driver.find_element_by_css_selector("tbody.ant-table-tbody td input")
            ActionChains(self.driver).move_to_element(menu).click(menu).perform()
            self.driver.find_element_by_css_selector('div.ant-table-title div.custom_other_btn_right:nth-child(4)').click()
            time.sleep(2)
            self.driver.find_element_by_css_selector('div.ant-confirm-btns button:nth-child(2)').click()
            time.sleep(3)
        except:
            print(traceback.format_exc())

    def get_username(self):
        '''
        获取用户名
        '''
        return self.timestamp

    def check_username(self,first_username):
        '''
        校验用户增加/删除，新增后列表第一位为新增的用户，输入的用户名通过get_first_username获取
        '''
        self.driver.find_element_by_css_selector('input#name').send_keys(first_username)
        time.sleep(3)
        self.driver.find_element_by_css_selector('button#MainPage-old-adSearch').click()
        time.sleep(3)
        username_eles = self.driver.find_elements_by_css_selector('div.ant-table-content>div:nth-child(2) tbody td:nth-child(4)')
        username_list = [one_name.text for one_name in username_eles if one_name]
        return username_list

    def get_first_username(self):
        '''
        获取第一位用户名
        '''
        first_username = self.driver.find_element_by_css_selector('div.ant-table-content>div:nth-child(2) tbody td:nth-child(3)').text
        return first_username

    def authorization(self):
        '''其他操作 运价权限管理 若当前账号无相关权限 则点击会空白 '''
        auth__ists = self.driver.find_elements_by_css_selector("div.ant-table-fixed-right a.ant-dropdown-trigger")
        self.move_chains_css(auth__ists[0])
        self.driver.find_element_by_xpath("//ul[@class='ant-dropdown-menu ant-dropdown-menu-vertical ant-dropdown-menu-light ant-dropdown-menu-root']\
        //li[@class='ant-dropdown-menu-item']/a[text()='权限管理']").click()
        time.sleep(3)
        self.driver.find_element_by_xpath("//div[text()='运价权限配置']")
        time.sleep(2)
        selects = self.driver.find_elements_by_xpath("//div[@class='fui-dialog-cnt clearfix']//a[text()='全选']")
        for ele_one in selects:
            ele_one.click()
            time.sleep(1)
        #此处角色分配可不添加滑动操作，元素定位可以达到效果
        auth_text = self.driver.find_elements_by_xpath("//div[@class='clearfix']/div[1]//div[@class='rolegroup-list-box']//li")
        auth_text = [one_text.text for one_text in auth_text if one_text]
        if auth_text:#判断角色分配是否存在内容，存在即依次点击添加
            auth_click = self.driver.find_elements_by_xpath("//div[@class='clearfix']/div[1]//div[@class='rolegroup-list-box']//li/a")
            for click_one in auth_click:
                click_one.click()
                time.sleep(1)
        self.driver.find_element_by_xpath("//span[text()='保存设置']").click()
        time.sleep(2)
        self.driver.find_element_by_css_selector("button.ant-modal-close").click()

    def Password_initialization(self):
        passwords = self.driver.find_elements_by_css_selector("div.ant-table-fixed-right div.ant-col-24 a:nth-child(1)")
        passwords[0].click()
        time.sleep(2)
        self.driver.find_element_by_css_selector('div.ant-confirm-btns button:nth-child(2)').click()

    #地址管理关键字
    def add_address(self):
        '''
        增加地址
        '''
        self.driver.find_element_by_css_selector("td button:nth-child(1)").click()
        time.sleep(3)
        self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>div:nth"
         "-child(1) input[type='text']").send_keys('test')
        self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>div:nth-ch"
         "ild(2) textarea.ant-input").send_keys("text")
        self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>di"
         "v:nth-child(4) input[type='text']").send_keys('test')
        self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>div:nt"
         "h-child(6) input[type='text']").send_keys(self.phoneNORandomGenerator())
        time.sleep(1)
        self.driver.find_element_by_css_selector("button.ant-btn-primary").click()
        time.sleep(1)

    def modify_address(self):
        '''
        修改地址
        '''
        self.driver.find_element_by_css_selector("tbody.ant-table-tbody>tr:nth-"
         "child(1) td:nth-child(11) a:nth-child(1)").click()
        ele_one = self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>div:nth"
         "-child(1) input[type='text']")
        ele_one.clear()
        ele_one.send_keys('new')
        ele_two = self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>div:nth-ch"
         "ild(2) textarea.ant-input")
        ele_two.clear()
        ele_two.send_keys(self.now_time())
        ele_four = self.driver.find_element_by_css_selector(".ant-modal-body>div:nth-child(1)>di"
         "v:nth-child(4) input[type='text']")
        ele_four.clear()
        ele_four.send_keys('海运出口整箱')
        time.sleep(1)
        self.driver.find_element_by_css_selector("button.ant-btn-primary").click()
        time.sleep(1)

    def delete_address(self):
        '''
        删除地址
        '''
        self.driver.find_element_by_css_selector("tbody.ant-table-tbody>tr:nth-"
          "child(1) td:nth-child(11) a:nth-child(2)").click()
        time.sleep(3)
        self.driver.find_element_by_css_selector("div.ant-confirm-btns button:nth-child(2)").click()
        time.sleep(2)


    def set_default_address(self):
        '''
        设置默认地址
        '''
        try:
            self.move_chains_css("tbody.ant-table-tbody>tr:nth-child(1)")
            ele_set = self.driver.find_element_by_css_selector("tbody.ant-table-tbody>tr:nth-child(1) td:nth-child(12) span")
            if ele_set.text == '设置默认':
                ele_set.click()
                time.sleep(2)
            else:
                if ele_set.text == '默认地址':
                    self.move_chains_css("tbody.ant-table-tbody>tr:nth-child(2)")
                    self.driver.find_element_by_css_selector(
                        "tbody.ant-table-tbody>tr:nth-child(2) td:nth-child(12) span").click()
                    time.sleep(2)
        except:
            print(traceback.format_exc())


    #公司信息设置关键字
    def modify_company_infomation(self):
        '''公司信息设置关键字
        此关键字只限打开的对话框有相关图片才可以操作，因无法确定其他成员电脑图片存放具体位置,可将相关文件以此路径保存
        D:\test_photo\test123.gif
        '''
        self.driver.find_element_by_css_selector('div#customer-edit-area span.ant-upload').click()
        time.sleep(3)
        shell = win32com.client.Dispatch('WScript.Shell')
        shell.Sendkeys(r"D:\test_photo\test123.gif" + "\r\n")
        shell.Sendkeys("{ENTER}")
        time.sleep(3)
        self.driver.find_element_by_css_selector("button.ant-btn-primary").click()
        time.sleep(1)

    #组织结构关键字
    def add_combination(self,com_name,ele_text,com_username,button_text,sub_text):
        '''添加顶级部门  对应 部门名称 部门类型文本 部门经理姓名 查询/重置  上级部门文本'''
        self.Explicit_waiting('//td//input[@name="deptName"]')
        self.driver.find_element_by_css_selector("td input[name='deptName']").send_keys(f'{com_name}')#部门名称
        time.sleep(2)
        self.driver.find_element_by_css_selector('td select').click()
        time.sleep(1)
        self.actions_sendkeys_xpath(f"//select[@name='groupType']/option[text()='{ele_text}']",Keys.ENTER)#部门类型
        # self.driver.find_element_by_xpath(f"//select[@name='groupType']/option[text()='{ele_text}']").send_keys(Keys.ENTER)#部门类型
        time.sleep(2)
        self.driver.find_element_by_xpath("//input[@toname='user.trueName']").click()
        time.sleep(2)
        self.driver.find_element_by_css_selector("input[name='username']").send_keys(com_username)#部门经理姓名
        self.driver.find_element_by_xpath(f"//span/button[text()='{button_text}']").click()#查询/重置
        time.sleep(2)
        self.driver.find_element_by_css_selector("td[field='trueName'] a").click()#部门经理点击
        self.Explicit_waiting("//input[@toname='dept.deptName']")
        self.driver.find_element_by_xpath("//input[@toname='dept.deptName']").click()#上级部门
        sub_ele = f"//ul[@id='dept_lookup_tree']//span[text()='{sub_text}']"#上级部门文本
        self.Explicit_waiting(sub_ele)
        self.driver.find_element_by_xpath(sub_ele).click()
        self.driver.find_element_by_css_selector("div button").click()

    def modify_combination(self,com_name,new_com_name,ele_text,com_username,button_text,sub_text):
        '''修改部门信息  左侧部门名称 新部门名称 部门类型文本 查询/重置 上级部门文本'''
        self.driver.find_element_by_xpath(f"//ul[@id='stgl_jg_bmgl_leftTree']//span[text()='{com_name}']").click()
        time.sleep(1)
        self.Explicit_waiting('//td//input[@name="deptName"]')
        self.driver.find_element_by_css_selector("td input[name='deptName']").clear()  # 部门名称
        time.sleep(1)
        self.driver.find_element_by_css_selector("td input[name='deptName']").send_keys(f'{new_com_name}')  # 部门名称
        time.sleep(2)
        self.driver.find_element_by_css_selector('td select').click()
        time.sleep(1)
        self.actions_sendkeys_xpath(f"//select[@name='groupType']/option[text()='{ele_text}']",Keys.DOWN)#部门类型 焦点在于所给元素文本 键盘选项框下移
        self.actions_sendkeys_xpath(f"//select[@name='groupType']/option[text()='{ele_text}']",Keys.ENTER)#焦点在于所给元素文本 键盘选项框确定
        time.sleep(2)
        self.driver.find_element_by_xpath("//input[@toname='user.trueName']").click()
        time.sleep(2)
        self.driver.find_element_by_css_selector("input[name='username']").send_keys(com_username)  # 部门经理姓名
        self.driver.find_element_by_xpath(f"//span/button[text()='{button_text}']").click()  # 查询/重置
        time.sleep(2)
        self.driver.find_element_by_css_selector("td[field='trueName'] a").click()  # 部门经理点击
        self.Explicit_waiting("//input[@toname='dept.deptName']")
        self.driver.find_element_by_xpath("//input[@toname='dept.deptName']").click()  # 上级部门
        sub_ele = f"//ul[@id='dept_lookup_tree']//span[text()='{sub_text}']"  # 上级部门文本
        self.Explicit_waiting(sub_ele)
        self.driver.find_element_by_xpath(sub_ele).click()
        self.driver.find_element_by_css_selector("div button").click()

    def delete_combination(self,com_name,button_text):
        '''删除部门信息  左侧部门名称  确定/取消'''
        self.driver.find_element_by_xpath(f"//ul[@id='stgl_jg_bmgl_leftTree']//span[text()='{com_name}']").click()#左侧部门
        time.sleep(1)
        self.driver.find_element_by_css_selector("a#dela").click()#删除当前部门
        self.driver.find_element_by_xpath(f"//div[@class='messager-button']//span[text()='{button_text}']").click()

    def add_child_combination(self,com_name):
        '''添加下级部门 进入后可使用add_combination进行增加'''
        self.driver.find_element_by_xpath(f"//ul[@id='stgl_jg_bmgl_leftTree']//span[text()='{com_name}']").click()  #左侧部门
        time.sleep(1)
        self.driver.find_element_by_css_selector("a#addNextNote").click()#点击

    #角色管理关键字
    def add_role(self,name,permissionName,describe=None):
        '''新增角色  输入角色名  描述可省略'''
        self.driver.find_element_by_css_selector("button.ant-btn").click()
        self.driver.find_element_by_id('rolegrpName').send_keys(name)#角色名称
        if describe:
            self.driver.find_element_by_id('rolegrpDescription').send_keys(describe)#角色描述
        self.driver.find_element_by_id('nextBtn').click()#点击下一步
        time.sleep(1)
        self.driver.find_element_by_xpath("//div[@class='role_list ant-transfer']/div[1]//input[@class='ant-input ant-transfer-list-search']")\
        .send_keys(permissionName)
        time.sleep(1)
        checkroles = self.driver.find_elements_by_xpath("//div[@class='role_list ant-transfer']/div[1]//input[@class='ant-checkbox-input']")
        checkroles[0].click()
        checkroles[1].click()
        self.driver.find_element_by_css_selector("div.ant-transfer-operation button:nth-child(2)").click()
        self.driver.find_element_by_xpath("//div[@id='app']/following-sibling::div[5]//span[text()='保 存']").click()
        time.sleep(2)

    def role_Permissions(self):
         '''角色管理  权限设置  勾选页面'''
         role_lists = self.driver.find_elements_by_xpath(
             "//div[@class='role_list ant-transfer']/div[1]//div[@class='List']//li")  # 权限列表勾选页面
         if role_lists:
             for role_one in role_lists:
                 role_one.click()
                 time.sleep(1)
             self.driver.find_element_by_css_selector("div.ant-transfer-operation>button:nth-child(2)").click()
             time.sleep(1)
         self.driver.find_element_by_id('saveBtn').click()
         time.sleep(1)

    def role_other(self,other,role_name,role_desc=None):
        '''填写其他操作文本 如删除/复制/编辑    填写角色名称，角色描述可选填
           若选择为编辑，编辑后下一步页面与权限设置页面一样 , 可在此方法后接着调用role_Permissions关键字方法'''
        others = self.driver.find_elements_by_css_selector("a.ant-dropdown-link.ant-dropdown-trigger")
        self.move_chains_css(others[0])
        if other == '删除':
            Other_Operations = self.driver.find_elements_by_xpath("//div[@class='ant-dropdown ant-dropdown-placement-bottomLeft']//li")
            Other_Operations[0].click()
            time.sleep(1)
            self.driver.find_element_by_css_selector("//button[@class='ant-btn ant-btn-primary ant-btn-lg']").click()
        elif other == '复制':
            Other_Operations = self.driver.find_elements_by_xpath("//div[@class='ant-dropdown ant-dropdown-placement-bottomLeft']//li")
            Other_Operations[1].click()
            self.driver.find_element_by_id("rolegrpName").send_keys(role_name)
            if role_desc:
                self.driver.find_element_by_id("rolegrpDescription").send_keys(role_desc)
            self.driver.find_element_by_id('copySaveBtn').click()
        elif other == '编辑':
            Other_Operations = self.driver.find_elements_by_xpath("//div[@class='ant-dropdown ant-dropdown-placement-bottomLeft']//li")
            Other_Operations[2].click()
            self.driver.find_element_by_id("rolegrpName").clear()
            self.driver.find_element_by_id("rolegrpName").send_keys(role_name)
            if role_desc:
                self.driver.find_element_by_id("rolegrpDescription").clear()
                self.driver.find_element_by_id("rolegrpDescription").send_keys(role_desc)
            self.driver.find_element_by_id('nextBtn').click()#点击下一步
            time.sleep(2)

    #订单/业务模块关键字
    def Order_list_click_all(self):
        '''
        订单列表点击全部
        '''
        self.driver.find_element_by_css_selector('div#dzg-adsearch div.dzg-ad-search-'
                                                 'status-list-buttons div:nth-child(1) button').click()
        time.sleep(2)

    def add_order_init(self,Add_type_text,ToS_text):
        '''
        新增订单-初始化-填写：新增类型、业务类型
        '''
        self.move_chains_css('div#business-center-list button:nth-child(1)')#点击新增
        self.driver.find_element_by_xpath(f"//ul[contains(@class,'ant-dropdown-menu')]//span[text()='{Add_type_text}']/..").click()#新增类型
        time.sleep(2)
        self.driver.find_element_by_css_selector('div#businesstype div').click()#点击业务类型
        time.sleep(2)
        self.driver.find_element_by_xpath(f"//li[text()='{ToS_text}']").click()#填写'海运出口拼箱',选择业务类型
        time.sleep(2)

    def add_order_client(self):
        '''
        委托单位
        '''
        self.driver.find_element_by_css_selector('div#customername').click()#点击委托单位
        time.sleep(1)
        self.driver.find_element_by_css_selector('div#customername+div li').click()#选择委托单位
        time.sleep(2)

    def add_order_service(self,Service_type_text):
        '''
        服务类型
        '''
        self.driver.find_element_by_css_selector('div#serviceRuleTypeCode').click()#点击服务类型
        time.sleep(2)
        self.driver.find_element_by_xpath(f"//div[@id='serviceRuleTypeCode']/following-sibling::div//li[text()='{Service_type_text}']").click()#选择服务类型
        time.sleep(2)

    def add_order_simple_operations(self,simple_text):
        '''
        订单勾选简单操作模式
        '''
        self.ele_not_click_xpath(f"//span[text()='{simple_text}']/..")#勾选简单操作模式
        time.sleep(1)

    def order_button_ascertain(self,ascertain_text):
        '''
        订单确定,输入确定文本值
        '''
        self.driver.find_element_by_xpath(f"//span[text()='{' '.join(ascertain_text)}']/..").click()
        time.sleep(5)

    def add_order_save(self,save_text):
        '''
        订单保存/提交
        输入保存或者提交文本值
        '''
        self.driver.find_element_by_xpath(f"//div[@class='dzg-business-actions']//span[text()='{' '.join(save_text)}']/..").click()
        time.sleep(3)

    def order_services(self,service_text):
        '''
        填写服务项名称：若希望点击多个服务项，则输入服务项名称，以英文逗号分隔；单个则单个服务项名称即可
        eg: 订舱,第三国转运,目的港换单
        '''
        service_text = service_text.split(',')
        for service_one_text in service_text:
            service_one_ele = self.driver.find_element_by_xpath(f"//div[@class='ant-checkbox-group']//span[text()='{service_one_text}']/..//input")
            service_one_ele_status = service_one_ele.is_selected()#勾选框状态
            if service_one_ele_status == False:
                service_one_ele.click()
                time.sleep(1)
        time.sleep(2)

    def order_through(self,ToS_text):
        '''
        订单通过审核,填写通过等文本
        '''
        if len(ToS_text) == 2:
            self.driver.find_element_by_xpath(f"//div[@class='dzg-business-actions']//span[text()='{' '.join(ToS_text)}']/..").click()#通过
        else:
            self.driver.find_element_by_xpath(f"//div[@class='dzg-business-actions']//span[text()='{ToS_text}']/..").click()#通过
        time.sleep(3)

    def order_New_shipping_space(self,Button_text):
        '''
        使用现舱/新订
        输入现舱/新订文本值
        '''
        self.ele_not_click_xpath(f"//span[text()='{Button_text}']/..")# 填写使用现舱/新订
        time.sleep(3)

    def order_players(self,player_type_name):
        '''
        订单参与人,填写参与人岗位类型名称，参与人姓名;若希望添加多个参与人，则按照前面格式依次排列，以英文逗号,英文分号分隔；单个则单个类型，名称即可,分号不可省略
        eg:  多个： 操作,lzb;订舱,lzb1;     单个：  销售,lzb3;
        '''
        try:
            player_type_name = player_type_name.split(';')
            for one in player_type_name:
                if one == '':
                    continue
                temp = one.split(',')
                one_type = temp[0].strip()
                one_name = temp[1].strip()
                select_ele = f"//div[@id='bnPersonTypeRelaList-service-personal-list-container']\
                        //span[text()='{one_type}']/../following-sibling::div/div"
                list_ele = "//div[@class='ant-select-dropdown ant-select-dropdown--single ant-select-dropdown-placement-bottomLeft']"\
                        "//li"
                self.DropDownList_xpath_input(select_ele,select_ele,one_name,list_ele)
                time.sleep(2)
        except:
            print(traceback.format_exc())

    def order_add_players(self,player_type_name,button_text):
        '''
        添加列表没有的参与人
        eg:  多个： 操作,lzb;订舱,lzb1;     单个：  销售,lzb3;
        需注意，这边点击与输入值都是要actions方法完成，且点击后div class属性会变，所以需要重新定位
        '''
        try:
            player_type_name = player_type_name.split(';')
            for one in player_type_name:
                if one == '':
                    continue
                temp = one.split(',')
                one_type = temp[0].strip()
                one_name = temp[1].strip()
                self.driver.find_element_by_id('service-personal-new-person-content').click()#新增
                time.sleep(1)
                select_ele_first = "//div[@class='ant-popover-inner-content']"\
                                                                    "//div[@class='ant-select ant-select-enabled']"#第一个下拉框 岗位
                select_ele_second_click = "//div[@class='ant-popover-inner-content']" \
                                                                "//div[@class='ant-select ant-select-enabled ant-select-allow-clear']"
                list_ele = "//div[@class='ant-select-dropdown ant-select-dropdown--single ant-select-dropdown-placement-bottomLeft']"\
                               "//li"
                select_ele_second_input = '//div[@class="ant-select ant-select-open ant-select-focused ant-select-enabled ant-select-allow-clear"]'
                self.DropDownList_xpath(select_ele_first, list_ele, one_type)
                self.Explicit_waiting(select_ele_second_click)
                self.DropDownList_xpath_input(select_ele_second_click,select_ele_second_input,one_name,list_ele)
                time.sleep(2)
                self.order_add_players_button(button_text)
                time.sleep(2)
        except:
            print(traceback.format_exc())

    def order_add_players_button(self,button_text):
        '''
        保存/取消文本值
        '''
        move = self.move_chains_xpath(f"//button[@class='ant-btn ant-btn-primary ant-btn-sm']//span[text()='{' '.join(button_text)}']/..")
        move.click()
        time.sleep(2)

    def Full_container_for_export_by_sea(self,text_ele,num):
        '''
        海运出口整箱必填字段 箱型 箱量  eg:   20GT  2
        '''
        select_ele = "//div[@id='bnMainsBookingCtnList[0].ctn_0']"
        list_ele = "//div[@class='ant-select-dropdown ant-select-dropdown--single ant-select-dropdown-placement-bottomLeft']"\
                        "//li"
        self.DropDownList_xpath(select_ele,list_ele,text_ele)
        time.sleep(2)
        self.move_chains_xpath('//div[@id="bnMainsBookingCtnList[0].ctnCount"]//input').send_keys(num)
        time.sleep(2)


if __name__ == '__main__':
    sc = SCcommon()
    sc.open_broswer()
    sc.sc_login(sc_username, sc_password)
    print(sc.get_sc_cookies())
    sc.refresh_sleep()
    sc.click_user_setting('设置','组织结构')
    sc.enter_iframe('GM1ExternalFrame')
    # sc.add_combination("部门名称","部门",'李千','查询','测试一级部门')
    sc.modify_combination("部门名称1","部门名称2","组",'李千','查询','AAA')
    # print(type(sc.get_sc_cookies()))
    # sc.autonumber(0,'test666')
    # sc.add_user('test','66')
    # print(sc.get_add_user_info())
    # print(sc.get_add_user_info_one())
    # sc.enter_iframe('GM1ExternalFrame')
    # sc.auto_modify(100)
    # sc.Order_list_click_all()
    # sc.add_order_init('订单','海运出口整箱')
    # sc.add_order_client()
    # sc.add_order_service('境外服务')
    # sc.order_button_ascertain('确定')
    # sc.enter_handle('新增订单')
    # sc.Page_scroll_bar_bottom()
    # sc.order_services('订舱,第三国转运,目的港换单')
    # sc.order_players('操作,系统管理员;客服,系统管理员;')
    # sc.order_add_players('操作,系统管理员;单证,程月娇;','确定')
    # sc.Full_container_for_export_by_sea('20GT',"2")
    # sc.add_order_save('保存')
    # sc.add_order_save('提交')
    # sc.order_through('通过')
    # sc.order_New_shipping_space('新订')
    # sc.order_button_ascertain('确定')
    # sc.enter_mainhandle()
    # sc.window_scroll_bar_div_select("//div[@id='bnMainsBookingCtnList[0].ctn_0']","ant-select-dropdown-menu  ant-select-dropdown-menu-root ant-select-dropdown-menu-vertical",'0','10000')
    # sc.close_broswer()
