*** Settings ***
Documentation  To Validate the Login form
Library  SeleniumLibrary
Library  Collections
Library    String
Test Setup    open the browser with the Mortgage payment url
#Test Teardown       Sleep    20
Resource    resource.robot
Test Template       Validate Unsuccessful Login

*** Variables ***
${Error_Message_Login}      css:.alert-danger
${Shop_Page_Load}      class:nav-link   # can also use css:.nav-link

*** Test Cases ***      username        password
Invalid username        dsahed          learning
Invalid password        rahulshetty     ploudfg
special characters      %#$#%@           learning

*** Keywords ***
Validate Unsuccessful Login
    [Arguments]             ${username}     ${password}
    fill the login form     ${username}    ${password}
    Wait Until Element Is Visible    ${Error_Message_Login}
    verify error message is correct

Validate Cards display in the Shopping Page
    fill the login form     ${user_name}    ${valid_password}
    Wait Until Element Is Visible    ${Shop_Page_Load}
    Verify Card Titles in the Shop Page
    Select the Card     Blackberry

Validate Sucessful Login
    Fill the Login Form and Click the User Option

Validate Child Window Functionality
    Select the link of Child Window
    Switch to Child Window And Verify the user is Switched to Child Window
    Grab the Email id in the Child Window
    Switch to Parent window and enter the Email



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
    @{elements}=  Get WebElements    css:.card-title
    @{actualList}=  Create List

    FOR    ${element}    IN    @{elements}  # if @{elements} above and ${elements} here then error
        Log  ${element.text}
#        Should Contain Any    @{expectedList}  ${element.text} # does not work
        Append To List    ${actualList}     ${element.text}   # @ is not used here as it denotes as creating something new
        # So when creating new list , use @. When use list after use $.
    END

    Lists Should Be Equal    ${expectedList}    ${actualList}


Select the Card
    [Arguments]     ${card_name}
    @{elements}=        Get WebElements    css:.card-title
    ${index}=       Set Variable    1
    FOR    ${element}    IN    @{elements}
        Exit For Loop If    '${card_name}' == '${element.text}'
        ${index}=   Evaluate     ${index} + 1
    END
    Click Button    xpath:(//*[@class='card-footer'])[${index}]/button


Fill the Login Form and Click the User Option
    Input Text    id:username    ${user_name}
    Input Password    id:password    ${valid_password}
    Click Element       css:input[value='user']
    Wait Until Element Is Visible    css:.modal-body   # wait until entire popup is visible
    Click Button    id:okayBtn   # in video he repeated this line 2 times, because it didn;t work for him once
    Select From List By Value    css:select.form-control    teach    # can also use select from list by index for dropdown
    Select Checkbox    terms
    Checkbox Should Be Selected    terms


Select the link of Child Window
    Click Element    css:.blinkingText
    Sleep    5


Switch to Child Window And Verify the user is Switched to Child Window
    Switch Window   NEW
    Element Text Should Be    css:h1    DOCUMENTS REQUEST

Grab the Email id in the Child Window
    ${text}=    Get Text    css:.red
    @{words}=    Split String    ${text}     at
    ${text_split}=      Get From List    ${words}    1
    Log    ${text_split}
    @{words_2}=    Split String    ${text_split}     # leaving last argument splits at white space
    ${email}=     Get From List    ${words2}    0
    Set Global Variable    ${email}

Switch to Parent window and enter the Email
    Switch Window   MAIN
    Title Should Be    LoginPage Practise | Rahul Shetty Academy
    Input Text    id:username    ${email}





