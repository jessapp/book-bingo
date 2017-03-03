from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
import unittest


class SeleniumTests(unittest.TestCase):
# setup and teardown

    def setUp(self):
        self.browser = webdriver.Firefox()

    def tearDown(self):
        self.browser.quit()

    def test_LogIn(self):
        """Test login process"""
        
        self.browser.get('http://localhost:5000')
        assert self.browser.title == 'Book Bingo'

        btn = self.browser.find_element_by_id('login-btn')
        btn.click()

        wait = WebDriverWait(self.browser, 10)
        wait.until(EC.presence_of_element_located((By.ID, "email")))

        email = self.browser.find_element_by_id('email')
        email.send_keys('fake@email.com')

        password = self.browser.find_element_by_id('password')
        password.send_keys("secretpassword")

        submit_btn = self.browser.find_element_by_id('submit-login')
        submit_btn.click()

        wait.until(EC.presence_of_element_located((By.ID, "new-board-btn")))

        assert str("Welcome, Jess!") in self.browser.page_source

    def test_NewUser(self):
        """Test new user registration"""

        self.browser.get('http://localhost:5000')
        assert self.browser.title == 'Book Bingo'

        btn = self.browser.find_element_by_id('register-btn')
        btn.click()

        wait = WebDriverWait(self.browser, 10)
        wait.until(EC.presence_of_element_located((By.ID, "f-name")))

        f_name = self.browser.find_element_by_id('f-name')
        f_name.send_keys('John')

        l_name = self.browser.find_element_by_id('l-name')
        l_name.send_keys('Doe')

        email = self.browser.find_element_by_id('email')
        email.send_keys('johndoe@gmail.com')

        password = self.browser.find_element_by_id('password')
        password.send_keys('12345')

        register_btn = self.browser.find_element_by_id('register-submit')
        register_btn.click()

        wait.until(EC.presence_of_element_located((By.ID, "new-board-btn")))

        assert str("Welcome, John!") in self.browser.page_source


if __name__ == "__main__":
    unittest.main()