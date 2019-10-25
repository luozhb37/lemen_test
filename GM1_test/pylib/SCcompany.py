import tkinter as tk
from tkinter import filedialog
from GM1_test.pylib.SCcommon import *
class SCcompany(SCcommon):
    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    name = 'sccompany'

    def modify_company_infomation(self):
        time.sleep(3)
        ele_mobile = self.driver.find_element_by_id('mobile')
        ele_mobile.clear()
        ele_mobile.send_keys(self.phoneNORandomGenerator())
        self.driver.find_element_by_xpath('//div[text()="Upload Logo"]').click()
        root = tk.Tk()    #打开选择文件夹对话框
        root.withdraw()

        Folderpath = filedialog.askdirectory()  # 获得选择好的文件夹
        Filepath = filedialog.askopenfilename()  # 获得选择好的文件

        print('Folderpath:', Folderpath)
        print('Filepath:', Filepath)





if __name__ == '__main__':
    s2 = SCcompany()
    s2.open_broswer()
    s2.sc_login('sc_lzb','a111111')
    s2.click_user_setting('设置','公司信息')
    s2.modify_company_infomation()


