*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_url}  https://rahulshettyacademy.com
${book_id}   # entry should be created here when declaring global variable in testcase
${book_name}    RobotFramework

*** Test Cases ***
Add Book into Library Database

    &{req_body}=    Create Dictionary    name=${book_name}    isbn=98453      aisle=2342423   author=SaiGanesh
    ${response}=  POST      ${base_url}/Library/Addbook.php    json=${req_body}    expected_status=200
    log         ${response.json()}
    Dictionary Should Contain Key    ${response.json()}    ID
    ${book_id}=     Get From Dictionary    ${response.json()}    ID
    Set Global Variable    ${book_id}
    Log    ${book_id}
    Should Be Equal As Strings    successfully added    ${response.json()}[Msg]
    Status Should Be    ${response}         200

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



    
