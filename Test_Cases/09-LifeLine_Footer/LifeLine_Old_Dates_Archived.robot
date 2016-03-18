*** Settings ***
Documentation     A test suite to find MyWFG LifeLine archived records with old dates excluding AML records
...
...               The purpose of this test is to find LifeLine archived records with old dates
...               excluding AML records and  create excel report
...
Metadata          Version   0.1
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary

*** Variables ***
${LL_Archived}    2,3,9,10      # AML Renewal - US, AML Renewal - CA, AML Course - US, AML Course - CA

*** Test Cases ***
Get LifeLine Archived Dates
    ${mydata}   Database_Library.Count_Total_Notifications    ${HOSTNAME}    ${WFG_DATABASE}
    Database_Library.LifeLine_Old_Dates_Archived    ${mydata}    ${LL_Archived}    ${HOSTNAME}    ${WFG_DATABASE}

