*** Settings ***
Documentation     A test suite to find LifeLine records with old dates excluding AML records
...               This test will connect to database and searches MywFG LifeLine records
...               with old dates excluding AML records
Metadata          Version   0.1
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary

*** Variables ***
${LL_2}      2      # AML Renewal - US
${LL_3}      3      # AML Renewal - CA
${LL_9}      9      # AML Course - US
${LL_10}    10      # AML Course - CA


*** Test Cases ***
Connect from Python file
    ${mydata}   Database_Library.Count_Total_Notifications
    Database_Library.LifeLine_Old_Dates    ${mydata}   ${LL_2}    ${LL_3}    ${LL_9}    ${LL_10}
