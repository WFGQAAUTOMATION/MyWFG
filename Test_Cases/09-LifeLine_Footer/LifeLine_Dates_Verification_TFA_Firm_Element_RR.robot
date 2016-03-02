*** Settings ***
Documentation    A test suite to verify MyWFG LifeLine TFA Firm Element RR Expiration dates
...              (former Annual Compliance Reminders)
...
...               This test will log into MyWFG and verify that MyWFG TFA Firm Element RR
...               notification is displayed according to expiration dates
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Library           ../../Resources/Testing_Library.py
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary
Library           String
Library           DateTime

Suite Teardown     Close Browser

*** Variables ***
<<<<<<< HEAD
${DATABASE}               WFGOnline
${HOSTNAME}               CRDBCOMP03\\CRDBWFGOMOD
=======
#${DATABASE}               WFGOnline
#${HOSTNAME}               CRDBCOMP03\\CRDBWFGOMOD
>>>>>>> master
${Notification_ID}        16
${Notification_TypeID}    1
${STATE}

*** Test Cases ***

<<<<<<< HEAD
Connect to Database
    Connect To Database Using Custom Params    pymssql    host='${HOSTNAME}', database='${DATABASE}'

Select Agent and Login to MyWFG.com
    ${Agent_Info}    Database_Library.Find_LifeLine_Agent    ${Notification_ID}    ${Notification_TypeID}    ${STATE}
    Browser is opened to login page
    User "${Agent_Info[0]}" logs in with password "${PASSWORD}"
=======
#Connect to Database
#    Connect To Database Using Custom Params    pymssql    host='${HOSTNAME}', database='${DATABASE}'

Select Agent and Login to MyWFG.com and Check LifeLine
    ${Agent_Info}    Database_Library.Find_LifeLine_Agent    ${Notification_ID}    ${Notification_TypeID}    ${STATE}
    Browser is opened to login page
    User "${Agent_Info[0]}" logs in with password "${VALID_PASSWORD}"
>>>>>>> master
    Home Page for any Agent Should Be Open
    sleep   2s
    Click element   xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]
    sleep    2s
    Click image using img where ID is "QuestionMark-${Agent_Info[1]}"
    sleep    2s
    Click image where ID is "close"
    ${Webpage_DateDue}    Get Text    xpath=//*[@id='DueDate-${Agent_Info[1]}']

#    ***** Convert date to match with database formate
    ${Webpage_DateDue}    Remove String     ${Webpage_DateDue}     (Expired)
    ${Webpage_DateDue}    Replace String    ${Webpage_DateDue}    /    -

    Should be equal    ${Agent_Info[2].strip()}    ${Webpage_DateDue.strip()}

    ${Today_Date}    Get Current Date
    ${Dates_Diff}    Subtract Date From Date    ${Agent_Info[3]}    ${Today_Date}
#   ***** Convert Dates difference from sec into min then into hours and into days.
    ${Dates_Diff}    Evaluate    ${Dates_Diff}/60/60/24
    log    Days difference is ${Dates_Diff}

    Run Keyword If    ${Notification_TypeID} == 1 and ${Dates_Diff} > 30
    ...    log    TFA Firm Element RR Red notification was displayed too early
    ...    ELSE IF    ${Notification_TypeID} == 1 and ${Dates_Diff} <= 30
    ...    log    TFA Firm Element RR Red notification test Passed

    Run Keyword If    ${Notification_TypeID} == 2 and ${Dates_Diff} <= 30
    ...    log    TFA Firm Element RR Yellow notification should be a Red notification
    ...    ELSE IF    ${Notification_TypeID} == 2 and ${Dates_Diff} > 60
    ...    log    TFA Firm Element RR Yellow notification was displayed too early
    ...    ELSE IF    ${Notification_TypeID} == 2 and ${Dates_Diff} > 30
    ...    log    TFA Firm Element RR Yellow notification test Passed

    Run Keyword If    ${Notification_TypeID} == 3
    ...    log    Green Notification will be tested in separate component 'Green Notification Expiration'

Log Out of MyWFG
    Log Out of MyWFG

<<<<<<< HEAD
Disconnect from SQL Server
    Disconnect From Database
=======
#Disconnect from SQL Server
#    Disconnect From Database
>>>>>>> master

*** Keywords ***
