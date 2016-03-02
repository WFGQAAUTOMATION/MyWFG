*** Settings ***
Documentation    A test suite to verify MyWFG LifeLine Expired date
...
...               This test will log into MyWFG and verify that MyWFG LifeLine Expired date is shown correctly
...
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
#${DATABASE}               WFGOnline
#${HOSTNAME}               CRDBCOMP03\\CRDBWFGOMOD
${Notification_ID}        27
${Notification_TypeID}    1
#${STATE}

*** Test Cases ***

#Connect to Database
#    Connect To Database Using Custom Params    pymssql    host='${HOSTNAME}', database='${DATABASE}'

Select Agent and Login to MyWFG.com
    ${Agent_Info}    Database_Library.Find_LifeLine_Agent    ${Notification_ID}    ${Notification_TypeID}    ${LL_STATE}
    Browser is opened to login page
    User "${Agent_Info[0]}" logs in with password "${VALID_PASSWORD}"
    Home Page for any Agent Should Be Open
    sleep   2s
    Click element   xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]
    sleep    2s
    Click image using img where ID is "QuestionMark-${Agent_Info[1]}"
    sleep    2s
    Click image where ID is "close"

    ${Webpage_DateDue_Str}    Get Text    xpath=//*[@id='DueDate-${Agent_Info[1]}']
    ${DateDue_Length}    Get Length    ${Webpage_DateDue_Str}

    ${Expired_Date}    Fetch From Right    ${Webpage_DateDue_Str}    (
    ${Today_Date}    Get Current Date

    ${Dates_Diff}    Run Keyword If    ${Notification_ID} not in [11, 12]
    ...    Subtract Date From Date    ${Agent_Info[3]}    ${Today_Date}

#   ***** Convert Dates difference from sec into min then into hours and into days.
    ${Dates_Diff}    Run Keyword If    ${Notification_ID} not in [11, 12]
    ...    Evaluate    ${Dates_Diff}/60/60/24

#   IUL Course and Annuity Course don't display the date, display "Immediately" instead
#   License Renewal LifeLine notifications always "Expired" in Red
    Run Keyword If    ${Notification_TypeID} == 2
    ...    log    Expired Date Verification is not applicable for NotificationID = 2
    ...    ELSE IF    ${Notification_ID} in [11, 12] and '${Webpage_DateDue_Str.strip()}' == 'Immediately'
    ...    log    Expired Date Due verification Passed for IUL or Annuity Courses
    ...    ELSE IF    ${Notification_ID} in [4, 5] and '${Expired_Date}' == 'Expired)'
    ...    log    Expired Date Due verification Passed for License Renewal
    ...    ELSE IF    ${Notification_ID} in [2,3,6,7,9,10,13,23,25] and ${Dates_Diff} <= 0 and ${DateDue_Length} > 12
    ...    log    1 Expired Date Due verification Passed for AMLR or AMLC or LTCR or IRS 8233 or App/Aff Renewal
    ...    ELSE IF    ${Notification_ID} in [2,3,6,7,9,10,13,23,25] and ${Dates_Diff} > 0 and ${DateDue_Length} < 12
    ...    log    2 Expired Date Due verification Passed for AMLR or AMLC or LTCR or IRS 8233 or App/Aff Renewal
    ...    ELSE IF     ${Notification_TypeID} == 1
    ...    log    Expired Date Due verification Passed
    ...    ELSE
    ...    log    Didn't identify any option

Log Out of MyWFG
    Log Out of MyWFG

#Disconnect from SQL Server
#    Disconnect From Database

*** Keywords ***
