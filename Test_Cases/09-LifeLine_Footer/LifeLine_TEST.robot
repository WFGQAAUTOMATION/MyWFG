*** Settings ***
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Library           ../../Resources/Testing_Library.py
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary
Library           String

Suite Setup       Connect to SQL Server and Open Browser
Test Setup        Go To Login Page
Test Template     Select Agent, Login to MyWFG.com, verify the LifeLine Link
Suite Teardown    Close Browser and Disconnect from SQL Server

*** Variables ***
${DATABASE}               WFGOnline
${HOSTNAME}               CRDBCOMP03\\CRDBWFGOMOD
#${Notification_ID}        3
#${Notification_TypeID}    2
${STATE}

*** Test Cases ***                      NotificationID
#US E&O/TFA Balance Due                      1
#AML Renewal - US                            2
AML Renewal - CA                            3
#License Renewal - US                        4
#License Renewal - CA                        5
#Appointment Renewal                         6
#Affiliation Renewal                         7
#TFG New Rep Training Course                 8
#AML Course - US                             9
AML Course - CA                             10
#IUL Course                                  11
#Annuity Course                              12
#Long Term Care Renewal                      13
#TFG New IAR Training Course                 14
#2015 TFA Firm Element Supervisor            15
#2015 TFA Firm Element RR                    16
#2015 TFA AML                                17
#2015 TFA Firm Element General Sec           18
#2015 TFA Firm Element IAR                   19
#2015 TFA ACM                                20
FINRA,State Securities,IAR Renewal          21
#Canada Agency Agreement                     22
#Mutual Fund License Renewal                 23
#TFA Annual Regulatory Questionaire          24
#IRS 8233 Form                               25
#FINRA Regulatory Education Course           26
#CA E&O Balance Due                          27

*** Keywords ***
Connect to SQL Server and Open Browser
     Connect To Database Using Custom Params    pymssql    host='${HOSTNAME}', database='${DATABASE}'
     Open Browser To Login Page

Select Agent, Login to MyWFG.com, verify the LifeLine Link
    [Arguments]    ${Notification_ID}
#    ${Agent_Info}    Database_Library_DEV.Find_LifeLine_Agent    ${Notification_ID}    ${Notification_TypeID}    ${STATE}
#    User "${Agent_Info[0]}" logs in with password "${PASSWORD}"
    ${Agent_CodeNo}    Database_Library_DEV.Get_LifeLine_Explanation_Agent_ID    ${Notification_ID}
    User "${Agent_CodeNo}" logs in with password "${PASSWORD}"
#    Home Page for any Agent Should Be Open   ***** Temporarely commented for DEV testing
    sleep    3s
    Click element    xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]
    sleep    5s
    ${WindowTitle}=    Get Title
    sleep    5s
#    Click element    xpath=//a[@id='Notice-${Agent_Info[1]}']
    ${html_ID}    Database_Library_DEV.Get_LifeLine_Link_html_Id    ${Agent_CodeNo}    ${Notification_ID}    ${STATE}
    Click Link With ID "Notice-${html_ID}"
    sleep    5s

#    ${URL}    query    SELECT NavigationURL FROM [WFGOnline].[dbo].[wfgLU_Notification] WHERE NotificationID IN (${Notification_ID});
#    Select Window    url=http://www.mywfg.com/map/
    Select Window    url=http://m-www.mywfg.com/PaymentEngine
#    Run keyword if    ${Notification_ID} == 1 or ${Notification_ID} == 21
#    ...    Select Window    url=http://m-www.mywfg.com/PaymentEngine
#    ...    ELSE IF    ${Notification_ID} == 3 or ${Notification_ID }== 10
#    ...    Select Window    url=http://wfgei.com
#    ...    ELSE IF    ${Notification_ID} == 4 or ${Notification_ID} == 5 or ${Notification_ID} == 23 or ${Notification_ID} == 26
#    ...    log    No links URL provided for NotificationID ${Notification_ID}
#    ...    log    Days difference is ${Dates_Diff}
#    ...    ELSE IF    ${Notification_ID} == 24
#    ...    Select Window    url=http://www.mywfg.com/informs
#    ...    ELSE IF     ${Notification_ID} == 25
#    ...    Select Window    url=http://www.mywfg.com/map
    sleep    10s
    close window
    sleep    10s
    Select Window    Title=${WindowTitle}
    sleep    5s
    Log Out of MyWFG

Close Browser and Disconnect from SQL Server
    Close Browser
    Disconnect From Database












