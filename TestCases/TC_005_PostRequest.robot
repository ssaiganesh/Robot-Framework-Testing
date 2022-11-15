*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_url}  https://reqres.in/

*** Test Cases ***
TC_005 Create new resource
    create session  AddData  ${base_url}
#    &{body}=  create dictionary  first_name=Testing  middle_name=A  last_name=World  date_of_birth=11/11/1911
    &{body}=  create dictionary  email=eve.holt@reqres.in  password=pistol
    ${body}  evaluate  json.dumps(${body})  json
    &{header}=  create dictionary  Content-Type=application/json

    ${response}=  POST On Session  AddData  api/register  data=${body}  headers=${header}
    should be equal as strings  ${response.status_code}  200
