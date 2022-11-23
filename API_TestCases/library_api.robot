*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_url}  https://rahulshettyacademy.com
${book_id}   # entry should be created here when declaring global variable in testcase
${bookName}    RobotFramework

*** Test Cases ***
Add Book into Library Database
    [Template]          Add Book into Library Database Template
    [Documentation]     This will add a book to the database
    ...                 We are Expecting a BOOK ID to be created and saved to global variable
    book_name=TestName     isbn_value=1SAIGANESHTEST123435792   aisle_value=1241351      author_name=Sai Ganesh
    book_name=TestName     isbn_value=1SAIGANESHTEST23523    aisle_value=1241351      author_name=Mary Jane
    book_name=${bookName}     isbn_value=1SAIGANESHTEST5476    aisle_value=37431      author_name=Peter Parker

Get the Book Details which got Added
    ${get_response}=    GET     ${base_url}/Library/GetBook.php     params=ID=${book_id}        expected_status=200
    Should Be Equal As Strings    ${get_response.json()}[0][book_name]     ${book_name}
    # response in robot framework prints list of dictionaries but that's not the case in the above test case.
    # it prints a dictionary itself.
    # so need to check how response is generated.

     
Delete the Book from database
    &{delete_req}=      Create Dictionary   ID=${book_id}
    ${delete_resp}=     POST    ${base_url}/Library/DeleteBook.php      json=${delete_req}      expected_status=200
    Should Be Equal As Strings    ${delete_resp.json()}[msg]    book is successfully deleted

Duplicate Request Sent
    [Template]  Duplicate Request Sent Template
    book_name=TestName     isbn_value=1SAIGANESHTEST123435792   aisle_value=1241351      author_name=Sai Ganesh
    book_name=TestName     isbn_value=1SAIGANESHTEST23523    aisle_value=1241351      author_name=Mary Jane


*** Keywords ***
Add Book into Library Database Template
    [Arguments]     ${book_name}        ${isbn_value}       ${aisle_value}      ${author_name}
    &{req_body}=    Create Dictionary    name=${book_name}    isbn=${isbn_value}      aisle=${aisle_value}   author=${author_name}
    ${response}=  POST      ${base_url}/Library/Addbook.php    json=${req_body}    expected_status=200
    log         ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    ID
    ${book_id}=     Get From Dictionary    ${response.json()}    ID
    Set Global Variable    ${book_id}
    Log    ${book_id}
    Should Be Equal As Strings    successfully added    ${response.json()}[Msg]
    Status Should Be    200         ${response}

Duplicate Request Sent Template
    [Arguments]     ${book_name}        ${isbn_value}       ${aisle_value}      ${author_name}
    &{req_body}=    Create Dictionary    name=${book_name}    isbn=${isbn_value}      aisle=${aisle_value}   author=${author_name}
    ${response}=  POST      ${base_url}/Library/Addbook.php    json=${req_body}    expected_status=200
    Dictionary Should Contain Key    ${response.json()}    ID
    Should Be Equal As Strings    The Book with the entered Isbn and Aisle already Exists!!    ${response.json()}[Msg]


