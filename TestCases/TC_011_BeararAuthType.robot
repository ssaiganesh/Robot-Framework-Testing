*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  OperatingSystem

*** Variables ***
${base_url}  https://certtransaction.elementexpress.com
${bearerToken}  "Bearer E4F284BFADA11D01A52508ED7B92FFD7EE0905659F5DED06A4B73FC7739B48A287648801"

*** Test Cases ***
BearerAuthTest
    create session  mysession  ${base_url}

    ${headers}  create dictionary  Authorization=${bearerToken}  Content-Type=text/xml

    ${req_body}=  get file  C:/SeleniumPractice/xmldata/PostData.txt  # get file from Operating System library for text file should be empty

    ${response}=  POST On Session  myession     /   data=${req_body}   headers=${headers}

