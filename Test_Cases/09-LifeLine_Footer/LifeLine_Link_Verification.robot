*** Settings ***
Documentation    A test suite to verify MyWFG LifeLine Links for each Lire Line task
...
...               This test will log into MyWFG, clicks MyWFG Lifeline and
...               verifies each  MyWFG LifeLine Link separately
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Library           ../../Resources/Testing_Library.py
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary
Library           String
Library           DateTime

*** Settings ***
Suite Teardown     Close Browser

*** Variables ***
#${DATABASE}               WFGOnline
#${HOSTNAME}               CRDBCOMP03\\CRDBWFGOMOD
${Notification_ID}        9
${Notification_TypeID}    1
${STATE}


*** Test Cases ***

Select Agent, Login to MyWFG.com, verify the LifeLine Link
    ${Agent_Info}    Database_Library.Find_LifeLine_Agent    ${Notification_ID}    ${Notification_TypeID}    ${STATE}
    ...    ${HOSTNAME}    ${WFG_DATABASE}
    Browser is opened to login page
    User "${Agent_Info[0]}" logs in with password "${VALID_PASSWORD}"
    Home Page for any Agent Should Be Open
    sleep    3s
    Click element    xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]
    sleep    2s
    Click element    xpath=//a[@id='Notice-${Agent_Info[1]}']
    sleep    3s

Log Out of MyWFG
    Log Out of MyWFG

*** Keywords ***