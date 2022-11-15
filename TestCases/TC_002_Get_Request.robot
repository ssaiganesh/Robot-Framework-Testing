*** Settings ***
Library  RequestsLibrary

*** Variables ***
${BASE_URL}  http://thetestingworldapi.com/


*** Test Cases ***
TC_002_Get_Request
    create session   Get_Student_Details  ${BASE_URL}
    ${response}=    GET On Session  Get_Student_Details  api/studentsDetails
    log to console  ${response.status_code} # log to console ${response}
    log to console  ${response.content}
