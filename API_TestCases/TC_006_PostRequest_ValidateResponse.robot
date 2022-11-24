*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_url}  https://reqres.in/

*** Test Cases ***
TC_006 Create new user
    create session  CreateUser  ${base_url}
    ${body}=  create dictionary  name=morpheus  job=leader
    Dictionary Should Contain Key    ${body}    name
    Log    ${body}[name]
    ${name_variable}=    Get From Dictionary    ${body}    name
    ${body}  evaluate  json.dumps(${body})  json
    ${header}=  create dictionary  Content-Type=application/json

    ${response}=  POST On Session  CreateUser  api/users  data=${body}  headers=${header}
    should be equal as strings  ${response.status_code}  201

#How to pass the data for this element?


#"language": [
#    "sample string 1",
#    "sample string 2"
#  ],

#Figured out with
#* Variables *
#@{Language} =  English  Hindi
#
#
#and my test case looked like:
#
#* Test Cases *
#${body} =  create dictionary  language=@{Language}  yearexp=3  lastused=2008  st_id=23
