*** Settings ***
Library  JSONLibrary
Library  os
Library  Collections
Library  RequestsLibrary

*** Variables ***
${base_url}  https://restcountries.com

*** Test Cases ***
Get_countryInfo
    create session  mysession  ${base_url}
    ${response}=  GET On Session  mysession  /v2/alpha/SG

#    ${json_object}=  ${response.json()}
    ${country_name}=   get value from json     ${response.json()}    $.name
#    log to console  ${json_object}
    #  Single Data Validation
#    ${country_name}=  get value from json  ${json_object}  $.name
#    ${country_name_dict}=     Get From Dictionary    ${resp_json}[0]     name
    should be equal  ${country_name[0]}  Singapore  # remember to use index

    #  Single Data Validation in Array
    ${alternate_name}=  get value from json  ${response.json()}  $.altSpellings[1]
    should be equal  ${alternate_name[0]}  Singapura

#	#  Multiple Data Validation in array
	${alternate_names}=  get value from json  ${response.json()}  $.altSpellings
    should contain any  ${alternate_names[0]}  SG  Singapura  Republik Singapura  新加坡共和国
    should not contain any  ${alternate_names[0]}  ABC  XYC  ASDA