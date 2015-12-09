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
Library           String

Suite Teardown     Close Browser

*** Variables ***
${DATABASE}             WFGOnline
${HOSTNAME}             CRDBCOMP03\\CRDBWFGOMOD
#${AGENT_ID}            1114916    # 9763N
${AGENT_ID}             732469
${Notification_ID}      12
${STATE}

*** Test Cases ***

Connect to Database
     Connect To Database Using Custom Params    pymssql    host='${HOSTNAME}', database='${DATABASE}'

Select Agent and Login to MyWFG.com
    ${Results}    query    SELECT AgentCodeNumber FROM [WFGCompass].[dbo].[agAgent] WHERE AgentID IN (${AGENT_ID});
    Given browser is opened to login page
    When user "${Results[0][0]}" logs in with password "${PASSWORD}"
    Then Home Page Should Be Open
    sleep   3s

Click LifeLine image
    Click element   xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]

Get Life Line task Information
    ${html_ID}    Database_Library.Get_LifeLine_Explanation_Info    ${AGENT_ID}    ${Notification_ID}    ${STATE}
    #********* Click Question image next to Life Line task   ***********
    Click image using img where ID is "QuestionMark-${html_ID}"
    sleep    5

Compare Life Line Explanation Messages
    #***********  Retrive Explanation description from database  **********
    ${SQL_Text}    query    SELECT Explanation FROM [WFGOnline].[dbo].[wfgLU_Notification] WHERE NotificationID = ${Notification_ID};

    #  Replace &#8217 ASCI character to " ' "
    ${SQL_Text[0][0]}=    Replace String    ${SQL_Text[0][0]}    &#8217    '

    #  Remove </br> from Explanation String
    ${SQL_Text[0][0]}=    Remove String    ${SQL_Text[0][0]}    </br>

    # **********  Get Explanation description from Web page  ***************
    ${Webpage_Text}    Get Text    xpath=//p[@id='messsageLabel']

    # Replace ’ character with ' in order to compare explanations
    ${Webpage_Text}=    Replace String    ${Webpage_Text}    ’    '

    #  Remove <br> from Explanation String
    ${Webpage_Text}=    Remove String    ${Webpage_Text}    <br>

    #**********    Verify the text of explanantion  *****************
    Should be equal    ${SQL_Text[0][0]}    ${Webpage_Text}

Close Explanation message
    Click image where ID is "close"

Log Out of MyWFG
    Log Out of MyWFG

Disconnect from SQL Server
    Disconnect From Database

*** Keywords ***

