*** Settings ***
Documentation     A test suite to find MyWFG LifeLine archived records with old dates excluding AML records
...               The purpose of this test is to find LifeLine archived records with old dates excluding AML records
...               and  create excel report
Metadata          Version   0.1
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary

*** Variables ***
${LL_2}      2      # AML Renewal - US
${LL_3}      3      # AML Renewal - CA
${LL_9}      9      # AML Course - US
${LL_10}    10      # AML Course - CA
${LL_Archived}    2,3,9,10

*** Test Cases ***
Connect from Python file
    ${mydata}   Database_Library.Count_Total_Notifications
    Database_Library.LifeLine_Old_Dates_Archived    ${mydata}   ${LL_2}    ${LL_3}    ${LL_9}    ${LL_10}
#   Doesn't work when pass a string of notifications rather than separate variables
#   Database_Library.LifeLine_Old_Dates_Archived    ${mydata}   ${LL_Archived}

