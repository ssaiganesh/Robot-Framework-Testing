*** Settings ***
Library  RequestsLibrary

*** Variables ***
${APP_BASE_URL}  http://thetestingworldapi.com/
${StudentID}  28


*** Test Cases ***
TC_003_Fetch_Student_Details_By_ID
    create session  FetchData  ${APP_BASE_URL}
    ${Response}=  GET On Session  FetchData  api/studentsDetails/${StudentID}
    log to console  ${Response.status_code}
    log to console  ${Response.content}

#    should be equal  ${Response.status_code}  200  # 200 (integer) != 200 (string) Error

#    ${actual_code}=  convert to string  ${Response.status_code}
#    should be equal  ${actual_code}  200

    should be equal as strings  ${Response.status_code}  200
    should be equal  ${Response.json()}[status]  false