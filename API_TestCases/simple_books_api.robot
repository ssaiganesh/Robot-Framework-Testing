*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  OperatingSystem
Library  JSONLibrary

*** Variables ***
${base_url}     https://simple-books-api.glitch.me




*** Test Cases ***
Status 200 and should be OK
    create session  checkstatus  ${base_url}
    ${response}=  GET On Session  checkstatus  /status
    should be equal as strings  ${response.status_code}  200

Register
    create session  register  ${base_url}
    ${body}=  create dictionary  clientName=sdfkjlffudkfffsdfsd  clientEmail=sdfklfffjhdkfsdffsdv@email.com.sg
    ${body}  evaluate  json.dumps(${body})  json
    ${header}=  create dictionary  Content-Type=application/json
    ${response}=  POST On Session  register  /api-clients  data=${body}  headers=${header}
    should be equal as strings  ${response.status_code}  201
#    log to console  Response Content is ${response.content}
#    log to console  Response JSON is ${response.json()}
#    log to console  accessToken is ${response.json()}
    ${bearer_token_list}=  get value from json  ${response.json()}  $.accessToken
#    log to console  Beaerer Token List is ${bearer_token_list}
    ${bearer_token}=  catenate  Bearer  ${bearer_token_list[0]}
#    log to console  Bearer Token is ${bearer_token}
    set global variable  ${bearer_token}


Order Book
    create session  orderbook  ${base_url}
    
    log to console  Bearer Token is ${bearer_token}
    # Note that since set as global variable- able to access bearer_token in this testcase

    ${bearer_token_string}=  convert to string  ${bearer_token}
    ${headers}  create dictionary  Authorization=${bearer_token_string}   Content-Type=application/json
    ${body}=  create dictionary  bookId=5  customerName="sai ganesh"
    ${body}=  evaluate  json.dumps(${body})  json
    ${response}=  post on session  orderbook  /orders  data=${body}  headers=${headers}
    should be equal as strings  ${response.status_code}  201
