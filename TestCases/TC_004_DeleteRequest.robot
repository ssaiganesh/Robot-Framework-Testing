*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_url}  http://thetestingworldapi.com

*** Test Cases ***
TC_004 Validate Delete Request
    create session  AppAccess  ${base_url}
    ${response}=  DELETE On Session  AppAccess  /api/studentsDetails/32
    should be equal as strings  ${response.status_code}  200
    should be equal  ${response.json()}[status]  false