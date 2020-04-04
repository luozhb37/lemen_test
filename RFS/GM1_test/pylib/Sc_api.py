import requests
from RFS.GM1_test.pylib.SCcommon import *
class Sc_api(SCcommon):
    name = 'scapi'

    # def get_login(self):
    #     login_url = 'https://vip.800jit.com/fmsmembership/rest/publicGetDomain?'
    #     headers = {
    #         'User-Agent':'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36'
    #     }
    #     payload = {
    #             'username':'sc_lzb'
    #     }
    #     reps = requests.get(login_url,params=payload,headers=headers)
    #     return reps.cookies


c1 = Sc_api()
print(c1.get_add_user_info())