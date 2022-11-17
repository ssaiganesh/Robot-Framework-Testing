*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${Browser}  Chrome
# use Firefox instead of Chrome if want to use firefox and add geckodriver to scripts folder

${URL}  http://www.thetestingworld.com/testings

*** Test Cases ***
TC_001 Browser Start and Close
    open browser  ${URL}  ${Browser}
    close browser