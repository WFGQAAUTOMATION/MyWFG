*** Settings ***
Documentation    A test suite to click MyWFG LifeLine Archive, verify the message and close Archive
...
...               This test will log into MyWFG, clicks MyWFG Lifeline Archive link,
...               verifies the message and closes Archive
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Library           ../../Resources/Testing_Library.py
Library           Selenium2Library
Library           DatabaseLibrary

Suite Teardown     Close Browser

*** Variables ***
#${DATABASE}     WFGOnline
#${HOSTNAME}     CRDBCOMP03\\CRDBWFGOMOD
#${AGENT_ID}     982036
#${Archive_Question}    ArchieveQuestionMark

*** Test Cases ***
Connect to Database
    Connect To Database Using Custom Params    pymssql    host='${HOSTNAME}', database='${WFG_DATABASE}'

Select Agent and Login to MyWFG.com
    ${AgentID}     query    SELECT Top 1 AgentID FROM [WFGOnline].[dbo].[WFGLLNotifications] WHERE NotificationID <> 3;
    ${AgentCodeNo}    query    SELECT AgentCodeNumber FROM [WFGCompass].[dbo].[agAgent] WHERE AgentID = $ ${AgentID[0][0]};
    Given browser is opened to login page
    When user "${AgentCodeNo[0][0]}" logs in with password "${VALID_PASSWORD}"
    Then Home Page for any Agent Should Be Open
    sleep   3s

Click LifeLine button
    Click element   xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]
    sleep    2s

Click Archive Question Image
    Click image    xpath=//img[@alt='explanation']

Close Question Image
    Click image    xpath= //input[@id='close']

Click Archive Question Image using id
    Click image using img where ID is "${Archive_Question}"

Close Question Image Again
     click image    xpath= //input[@id='close']

Click Archive link
     click link     xpath=//a[@id='linkArchive']

Click Back link and Close Archive page
    click link     xpath=//a[@id='linkBack']

Log Out of MyWFG
    sleep    2s
    Log Out of MyWFG

Disconnect from SQL Server
    Disconnect From Database


*** Keywords ***




