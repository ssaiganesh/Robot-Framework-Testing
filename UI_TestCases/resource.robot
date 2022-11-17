*** Settings ***
Documentation  A resouce file with reusable keywords and variables
...
...            The System specific keywords created here form our own
...            domain specific language. They utilize keywords provided
...            by the imported SeleniumLibrary.
Library        SeleniumLibrary
#Library        OperatingSystem


*** Variables ***
${user_name}        rahulshettyacademy
${invalid_password}       12345678
${valid_password}     learning
${url}              https://rahulshettyacademy.com/loginpagePractise/


*** Keywords ***
open the browser with the Mortgage payment url
    Create Webdriver    Chrome  # executable_path=...
    Go To    ${url}

