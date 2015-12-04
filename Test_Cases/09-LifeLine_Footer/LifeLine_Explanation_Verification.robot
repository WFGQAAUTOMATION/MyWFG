*** Settings ***
Documentation    A test suite to click MyWFG LifeLine Question image and verify the message
...
...               This test will log into MyWFG, clicks MyWFG Lifeline question image and
...               verifies the message
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Library           ../../Resources/Testing_Library.py
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary

#Suite Teardown     Close Browser

*** Variables ***
${DATABASE}             WFGOnline
${HOSTNAME}             CRDBCOMP03\\CRDBWFGOMOD
${AGENT_ID}             1114916    # 9763N
${Notification_ID}      4
${STATE}                DC

*** Test Cases ***

Connect to Database
     Connect To Database Using Custom Params    pymssql    host='${HOSTNAME}', database='${DATABASE}'

Select Agent and Login to MyWFG.com
    ${Results}    query    SELECT AgentCodeNumber FROM [WFGCompass].[dbo].[agAgent] WHERE AgentID IN (${AGENT_ID});
    Given browser is opened to login page
    When user "${Results[0][0]}" logs in with password "${PASSWORD}"
    Then Home Page Should Be Open
    sleep   3s

Check LifeLine
    Click element   xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]

Get Life Line task Information
    ${mydata}    Database_Library.Get_LifeLine_Explanation_Info    ${AGENT_ID}    ${Notification_ID}    ${STATE}
    #********* Click Question image next to Life Line task and verify the text of explanantion  ***********
    click image    xpath=//img[@id='QuestionMark-${mydata}']

#Log Out of MyWFG
#    Log Out of MyWFG

Disconnect from SQL Server
    Disconnect From Database


*** Keywords ***

