*** Settings ***
Documentation    A test suite to verify MyWFG LifeLine Explanation image
...
...               This test will log into MyWFG, clicks LifeLine task Explanation image and
...               verifies the message for one chosen Life Line ID
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
#${DATABASE}                 WFGOnline
#${HOSTNAME}                 CRDBCOMP03\\CRDBWFGOMOD
${Notification_ID}          19
#${STATE}

*** Test Cases ***

#Connect to Database
#    Connect To Database Using Custom Params    pymssql    host='${HOSTNAME}', database='${DATABASE}'

Select Agent, Login to MyWFG.com, click LifeLine image and get LifeLine task Information

    ${Agent_CodeNo}    Database_Library.Get_LifeLine_Explanation_Agent_ID    ${Notification_ID}
    Given browser is opened to login page
    When user "${Agent_CodeNo}" logs in with password "${VALID_PASSWORD}"
    Then Home Page for any Agent Should Be Open
    sleep   3s
    Click element   xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]
    ${html_ID}    Database_Library.Get_LifeLine_Explanation_Info    ${Agent_CodeNo}    ${Notification_ID}    ${LL_STATE}
    #********* Click Question image next to Life Line task   ***********
    Click image using img where ID is "QuestionMark-${html_ID}"
    sleep    2

Compare Life Line Explanation Messages
    # ***********  Retrive Explanation description from database  *****************
    ${SQL_Text}    query    SELECT Explanation FROM [WFGOnline].[dbo].[wfgLU_Notification] WHERE NotificationID = ${Notification_ID};
    # ***********  Replace &#8217 ASCI character to " ' " *************************
    ${SQL_Text[0][0]}=    Replace String    ${SQL_Text[0][0]}    &#8217    '
    # ***********  Remove </br> from Explanation String ***************************
    ${SQL_Text[0][0]}=    Remove String    ${SQL_Text[0][0]}    </br>
    # ***********  Get Explanation description from Web page  *********************
   ${Webpage_Text}    Get Text    xpath=//p[@id='messsageLabel']
    # ***********  Replace ’ character with ' in order to compare explanations ****
    ${Webpage_Text}=    Replace String    ${Webpage_Text}    ’    '
    # ***********  Remove <br> from Explanation String  ***************************
    ${Webpage_Text}=    Remove String    ${Webpage_Text}    <br>
    # ***********  Verify the text of explanantion  *******************************
    Should be equal    ${SQL_Text[0][0]}    ${Webpage_Text}

Close Explanation message
    Click image where ID is "close"

Log Out of MyWFG
    Log Out of MyWFG

#Disconnect from SQL Server
#    Disconnect From Database

*** Keywords ***

