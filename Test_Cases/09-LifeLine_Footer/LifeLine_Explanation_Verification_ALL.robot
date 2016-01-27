*** Settings ***
Documentation    A test suite to verify MyWFG LifeLine Explanation image
...
...               This test will log into MyWFG, clicks LifeLine task Explanation image and
...               verifies the message of all Life Line IDs
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Library           ../../Resources/Testing_Library.py
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary
Library           String

Suite Setup       Connect to SQL Server and Open Browser
Test Setup        Go To Login Page
Test Template     Select Agent, Login to MyWFG.com, click LifeLine image and get LifeLine task Information
#Test Teardown     Log Out of MyWFG
Suite Teardown    Close Browser and Disconnect from SQL Server

*** Variables ***
${DATABASE}                 WFGOnline
${HOSTNAME}                 CRDBCOMP03\\CRDBWFGOMOD
${STATE}

*** Test Cases ***                      NotificationID
US E&O/TFA Balance Due                      1
AML Renewal - US                            2
AML Renewal - CA                            3
License Renewal - US                        4
License Renewal - CA                        5
Appointment Renewal                         6
Affiliation Renewal                         7
TFG New Rep Training Course                 8
AML Course - US                             9
AML Course - CA                             10
IUL Course                                  11
Annuity Course                              12
Long Term Care Renewal                      13
TFG New IAR Training Course                 14
2015 TFA Firm Element Supervisor            15
2015 TFA Firm Element RR                    16
2015 TFA AML                                17
2015 TFA Firm Element General Sec           18
2015 TFA Firm Element IAR                   19
2015 TFA ACM                                20
FINRA,State Securities,IAR Renewal          21
Canada Agency Agreement                     22
Mutual Fund License Renewal                 23
TFA Annual Regulatory Questionaire          24
IRS 8233 Form                               25
FINRA Regulatory Education Course           26
CA E&O Balance Due                          27

*** Keywords ***
Connect to SQL Server and Open Browser
    Connect To Database Using Custom Params    pymssql    host='CRDBCOMP03\\CRDBWFGOMOD', database='WFGOnline'
#    Connect To Database Using Custom Params    pymssql    host='${HOSTNAME}', database='${DATABASE}'
    Open Browser To Login Page

Select Agent, Login to MyWFG.com, click LifeLine image and get LifeLine task Information
    [Arguments]    ${Notification_ID}
    ${Agent_CodeNo}    Database_Library.Get_LifeLine_Explanation_Agent_ID    ${Notification_ID}
    User "${Agent_CodeNo}" logs in with password "${PASSWORD}"
    Then Home Page for any Agent Should Be Open
    sleep    2s
    Click element   xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]
    ${html_ID}    Database_Library.Get_LifeLine_Explanation_Info    ${Agent_CodeNo}    ${Notification_ID}    ${STATE}
    #********* Click Question image next to Life Line task   ***********
    Click image using img where ID is "QuestionMark-${html_ID}"
    Compare Life Line Explanation Messages    ${Notification_ID}
    sleep    2s
    Click image where ID is "close"
    Log Out of MyWFG
    sleep    2s

Compare Life Line Explanation Messages
    [Arguments]    ${Notification_ID}
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
    Run Keyword And Continue On Failure    Should be equal    ${SQL_Text[0][0]}    ${Webpage_Text}

Close Browser and Disconnect from SQL Server
    Close Browser
    Disconnect From Database


