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

    ${json_object}=  To Json  ${response.content}
#    log to console  ${json_object}
    #  Single Data Validation
    ${country_name}=  get value from json  ${json_object}  $.name
    should be equal  ${country_name[0]}  Singapore  # remember to use index

    #  Single Data Validation in Array
    ${alternate_name}=  get value from json  ${json_object}  $.altSpellings[1]
    should be equal  ${alternate_name[0]}  Singapura

	#  Multiple Data Validation in array
	${alternate_names}=  get value from json  ${json_object}  $.altSpellings
    should contain any  ${alternate_names[0]}  SG  Singapura  Republik Singapura  新加坡共和国
    should not contain any  ${alternate_names[0]}  ABC  XYC  ASDA