*** Settings ***
Documentation    A test suite to verify MyWFG LifeLine Annuity Course Expiration dates
...
...               This test will log into MyWFG and verify that MyWFG LifeLine Annuity Course
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
${DATABASE}               WFGOnline
${HOSTNAME}               CRDBCOMP03\\CRDBWFGOMOD
${Notification_ID}        12
${Notification_TypeID}    1
${STATE}

*** Test Cases ***

Connect to Database
    Connect To Database Using Custom Params    pymssql    host='${HOSTNAME}', database='${DATABASE}'

Select Agent and Login to MyWFG.com
    ${Agent_Info}    Database_Library.Find_LifeLine_Agent    ${Notification_ID}    ${Notification_TypeID}    ${STATE}
    Browser is opened to login page
    User "${Agent_Info[0]}" logs in with password "${PASSWORD}"
    Home Page for any Agent Should Be Open
    sleep   2s
    Click element   xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]
    sleep    2s
    Click image using img where ID is "QuestionMark-${Agent_Info[1]}"
    sleep    2s
    Click image where ID is "close"

    ${Webpage_DateDue}    Get Text    xpath=//*[@id='DueDate-${Agent_Info[1]}']
    Run Keyword If    ${Notification_TypeID} == 1
    ...    Should be equal    Immediately    ${Webpage_DateDue.strip()}

    Run Keyword If    ${Notification_TypeID} == 1
    ...    log    Annuity Course Red notification test Passed
    ...    ELSE IF    ${Notification_TypeID} == 2
    ...    log    Annuity Course should never be displayed in Yellow notification!
    ...    ELSE IF    ${Notification_TypeID} == 3
    ...    log    Green Notification will be tested in separate component 'Green Notification Expiration'

Log Out of MyWFG
    Log Out of MyWFG

Disconnect from SQL Server
    Disconnect From Database

*** Keywords ***

