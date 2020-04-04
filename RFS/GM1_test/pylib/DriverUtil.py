from selenium import webdriver
class DriverUtil:
    @classmethod
    def get_driver(cls):
        cls.driver = webdriver.Chrome()
        return cls.driver
