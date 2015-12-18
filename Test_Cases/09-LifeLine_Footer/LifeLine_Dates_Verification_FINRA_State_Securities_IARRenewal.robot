*** Settings ***
Documentation    A test suite to verify MyWFG LifeLine FINRA, State Securities, and/or IAR Renewal Expiration dates
...
...               This test will log into MyWFG and verify that MyWFG LifeLine FINRA, State Securities and/or
...               IAR Renewal notifications are displayed according to expiration dates
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Library           ../../Resources/Testing_Library.py
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary
Library           String

Suite Teardown     Close Browser

*** Variables ***
${DATABASE}               WFGOnline
${HOSTNAME}               CRDBCOMP03\\CRDBWFGOMOD
#${AGENT_ID}               1032171
${Notification_ID}        13
${Notification_TypeID}    2
${STATE}                  TX

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
#    Elements should be equal "${Agent_Info[7]}"
Log Out of MyWFG
    Log Out of MyWFG

Disconnect from SQL Server
    Disconnect From Database

*** Keywords ***

