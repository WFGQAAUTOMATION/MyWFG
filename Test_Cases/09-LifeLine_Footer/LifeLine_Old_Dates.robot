*** Settings ***
Documentation     A test suite to find LifeLine records with old dates excluding AML records
...
...               This test will connect to database and searches MywFG LifeLine records
...               with old dates excluding AML records
Metadata          Version   0.1
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary

*** Variables ***
${LL_Exclude}    2,3,9,10      # AML Renewal - US, AML Renewal - CA, AML Course - US, AML Course - CA

*** Test Cases ***
Get LifeLine Old Dates

    ${mydata}   Database_Library.Count_Total_Notifications    ${HOSTNAME}    ${WFG_DATABASE}
    Database_Library.LifeLine_Old_Dates    ${mydata}   ${LL_Exclude}    ${HOSTNAME}    ${WFG_DATABASE}
