*** Settings ***
Library  RequestsLibrary
Library  Collections

*** Variables ***
${base_url}   https://postman-echo.com


*** Test Cases ***
BasicAuthTest
    ${auth}=  create list  postman  password
    create session  mysession   ${base_url}   auth=${auth}
    ${response}=  GET On Session  mysession  /basic-auth
    log to console  ${response.content}

    should be equal as strings  ${response.status_code}  200