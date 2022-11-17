*** Settings ***
Documentation  To Validate the Login form
Library  SeleniumLibrary
Library  Collections
Test Setup    open the browser with the Mortgage payment url
Resource    resource.robot

*** Variables ***
${Error_Message_Login}      css:.alert_danger
${Shop_Page_Load}      class:nav-link   # can also use css:.nav-link

*** Test Cases ***
Validate Unuccessful Login
    fill the login form     ${user_name}    ${invalid_password}
    Wait Until Element Is Visible    ${Error_Message_Login}
    verify error message is correct

Validate Cards display in the Shopping Page
    fill the login form     ${user_name}    ${valid_password}
    Wait Until Element Is Visible    ${Shop_Page_Load}
    Verify Card Titles in the Shop Page
    Select the Card     Blackberry


*** Keywords ***
fill the login form
    [Arguments]     ${username}     ${password}
    Input Text    id:username    ${username}
    Input Password    id:password    ${password}   # password will not be logged into the log file
    Click Button    signInBtn  # by default considers id for locator even for text and password above

verify error message is correct
#    ${result}=  Get Text    ${Error_Message_Login}
#    Should Be Equal As Strings    ${result}    Incorrect username/password.
    # Above 2 lines can be shortened to this 1 line:
    Element Text Should Be    ${Error_Message_Login}    Incorrect username/password.

Verify Card Titles in the Shop Page
    @{expectedList}=  Create List     iphone X    Samsung Note 8      Nokia Edge      Blackberry
    ${elements}=  Get WebElements    css:.card-title
    @{actualList}=  Create List

    FOR    ${element}    IN    @{elements}
        Log  ${element.text}
#        Should Contain Any    @{expectedList}  ${element.text} # does not work
        Append To List    ${actualList}     ${element.text}   # @ is not used here as it denotes as creating something new
        # So when creating new list , use @. When use list after use $.
    END

    Lists Should Be Equal    ${expectedList}    ${actualList}


Select the Card
    [Arguments]     ${card_name}
    ${elements}=        Get WebElements    css:.card-title
    ${index}=       Set Variable    1
    FOR    ${element}    IN    @{elements}
        Exit For Loop If    '${card_name}' == '${element.text}'
        ${index}=   Evaluate     ${index} + 1
    END
    Click Button    xpath:(//*[@class='card-footer'])[${index}]/button
