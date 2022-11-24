*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections
Resource    ./library_api.resource
# Resource      library_resouce.robot


*** Test Cases ***
Add Book into Library Database
    [Template]          Add Book into Library Database Template
    [Documentation]     This will add a book to the database
    ...                 We are Expecting a BOOK ID to be created and saved to global variable
    book_name=TestName        isbn_value=1SAIGANESHTEST12343   aisle_value=1241351      author_name=Sai Ganesh
    book_name=TestName        isbn_value=1SAIGANESHTEST23523    aisle_value=1241351      author_name=Jane Doe
    book_name=${bookName}     isbn_value=1SAIGANESHTEST5476    aisle_value=37431      author_name=John Smith


Get the Book Details which got Added
    ${get_response}=    GET     ${base_url}/Library/GetBook.php    params=ID=${book_id}        expected_status=200
    Should Be Equal As Strings    ${get_response.json()}[0][book_name]     ${book_name}
    # response in robot framework prints list of dictionaries but that's not the case in the above test case.
    # it prints a dictionary itself.
    # so need to check how response is generated.

     
Delete the Book from database
    &{delete_req}=      Create Dictionary   ID=${book_id}
    ${delete_resp}=     POST    ${base_url}/Library/DeleteBook.php      json=${delete_req}      expected_status=200
    Should Be Equal As Strings    ${delete_resp.json()}[msg]    book is successfully deleted

Duplicate Add Book Request Sent
    [Template]          Duplicate Add Book Request Sent Template
    [Documentation]     This test case will send duplicate requests for adding books
    ...                 Expecting an error message for duplicate addition
    book_name=TestName     isbn_value=1SAIGANESHTEST123435792   aisle_value=1241351      author_name=Sai Ganesh
    book_name=TestName     isbn_value=1SAIGANESHTEST23523    aisle_value=1241351      author_name=Mary Jane
