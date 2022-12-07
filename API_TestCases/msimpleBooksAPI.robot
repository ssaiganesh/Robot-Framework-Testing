*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  OperatingSystem
Library  JSONLibrary
# Suite Setup
# Test Setup
# Test Teardown
# Suite Teardown
# Resource

*** Variables ***      # global level
${base_url}     https://simple-books-api.glitch.me

*** Test Cases ***
Status 200 and should be OK
    [Documentation]     Checks if API is working

    ${response}=  GET  ${base_url}/status
    should be equal as strings  ${response.status_code}  200
    Should Be Equal As Strings    ${response.json()}[status]    OK

Register
    [Documentation]    Registers user to use access token for authorization

    ${body}=  create dictionary  clientName=e1sai  clientEmail=e1sai@email.com.sg
    ${header}=  create dictionary  Content-Type=application/json
    ${response}=  POST  ${base_url}/api-clients  json=${body}  headers=${header}
    should be equal as strings  ${response.status_code}  201
    ${bearer_token_list}=  get value from json  ${response.json()}  $.accessToken
    ${bearer_token}=  catenate  Bearer  ${bearer_token_list[0]}
    ${bearer_token}=  convert to string  ${bearer_token}
    set global variable  ${bearer_token}


Get List of Books
    [Documentation]     Gets list of non-fiction books and checks the first book that's available

    ${response}=  GET  ${base_url}/books   params=type=non-fiction
    should be equal as strings  ${response.status_code}  200
    FOR    ${book}    IN    @{response.json()}
        IF    ${book}[available] == True
            ${bookId}=  Get Value From Json    ${book}    $.id
            END
        END
    Set Global Variable    ${bookId}
    Should Be Equal As Strings    ${book}[type]    non-fiction
    Should Be Equal As Strings    ${book}[available]    True

Get Single Book
    [Documentation]     Checks information on the book saved from previous test case

    ${book_url}=    Catenate    SEPARATOR=    ${base_url}/books/     ${book_id}[0]
    ${response}=    GET   ${book_url}
    should be equal as strings  ${response.status_code}  200
    Should Not Be Equal As Numbers    ${response.json()}[current-stock]    0

Order Book
    [Documentation]     Orders the book that was saved previously

    ${headers}  create dictionary  Authorization=${bearer_token}   Content-Type=application/json
    ${req_body}=  create dictionary  bookId=${bookId}  customerName=sai ganesh
    ${response}=  POST  ${base_url}/orders  json=${req_body}  headers=${headers}
    should be equal as strings  ${response.status_code}  201
    Should Be Equal As Strings    ${response.json()}[created]    True
    ${orderId}=     Get Value From Json    ${response.json()}    $.orderId
    Set Suite Variable    ${orderId}


Get All Book Orders
    [Documentation]     Gets all orders of the user

    ${headers}  create dictionary  Authorization=${bearer_token}
    ${response}=  GET  ${base_url}/orders   headers=${headers}
    should be equal as strings  ${response.status_code}  200


Get Single Book Order
    [Documentation]     Gets specific order of user of the non-fiction book

    ${headers}  create dictionary  Authorization=${bearer_token}
    ${order_url}=   Catenate    SEPARATOR=  ${base_url}/orders/    ${orderId}[0]
    Set Suite Variable    ${order_url}
    ${response}=  GET  ${order_url}   headers=${headers}
    should be equal as strings  ${response.status_code}  200
    Should Be Equal As Integers    ${response.json()}[bookId]    ${bookId}[0]
    should be equal as strings  ${response.json()}[customerName]  sai ganesh
    
Update Customer Name In Order
     [Documentation]        Updates customer name in order, gets the order to check if name udpated

    ${headers}  create dictionary  Authorization=${bearer_token}   Content-Type=application/json
    ${req_body}=  create dictionary  customerName=shankar
    ${response}=  PATCH  ${order_url}  json=${req_body}  headers=${headers}
    should be equal as strings  ${response.status_code}  204
    ${get_response}=  GET  ${order_url}   headers=${headers}
    Should Be Equal As Integers    ${get_response.json()}[bookId]    ${bookId}[0]
    should be equal as strings  ${get_response.json()}[customerName]  shankar

Delete Order
    [Documentation]     Deletes order and gets order to check if error is handled

    ${headers}  create dictionary  Authorization=${bearer_token}   Content-Type=application/json
    ${response}=  DELETE  ${order_url}  headers=${headers}
    should be equal as strings  ${response.status_code}  204
    ${get_response}=  GET  ${order_url}   headers=${headers}    expected_status=404
    Dictionary Should Contain Key    ${get_response.json()}    error

