#*** Settings ***
#Documentation    A test suite to click MyWFG LifeLine Question image and verify the message
#...
#...               This test will log into MyWFG, clicks MyWFG Lifeline question image and
#...               verifies the message
#Metadata          Version   0.1
#Resource          ../../Resources/Resource_Login.robot
#Resource          ../../Resources/Resource_Webpage.robot
#Library           ../../Resources/Testing_Library.py
#Library           Selenium2Library
#Library           DatabaseLibrary
#
#Suite Teardown     Close Browser
#
#*** Variables ***
##${DATABASE}     WFGOnline
##${HOSTNAME}     CRDBCOMP03\\CRDBWFGOMOD
#
#*** Test Cases ***
#
#Connect to Database
#     Connect To Database Using Custom Params    pymssql    host='${HOSTNAME}', database='${WFG_DATABASE}'
#
#Select Agent and Login to MyWFG.com
#    ${AgentID}     query    SELECT Top 1 AgentID FROM [WFGOnline].[dbo].[WFGLLNotifications] WHERE NotificationID <> 3;
#    ${AgentCodeNo}    query    SELECT AgentCodeNumber FROM [WFGCompass].[dbo].[agAgent] WHERE AgentID = $ ${AgentID[0][0]};
#    Given browser is opened to login page
#    When user "${AgentCodeNo[0][0]}" logs in with password "${VALID_PASSWORD}"
#    Then Home Page Should Be Open
#    sleep   3s
#
#Click Question Image
#     click image     xpath=//img[@id='MyLifelineIcon']
#
#Close Question Image
#     click link     xpath=(//a[contains(text(),'Close')])[2]
#
#Check LifeLine
#    Click element   xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]
#    #[contains(text(),'Ok')]
#
#Click Question Image again
#     click image     xpath=//img[@id='MyLifelineIcon']
#
#Close Question Image again
#     click link     xpath=(//a[contains(text(),'Close')])[2]
#
#
#Log Out of MyWFG
#    Log Out of MyWFG
#
#Disconnect from SQL Server
#    Disconnect From Database
#
#
#*** Keywords ***
#
#
#
#
