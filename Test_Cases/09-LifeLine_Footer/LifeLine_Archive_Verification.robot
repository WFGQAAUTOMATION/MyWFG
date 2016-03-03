*** Settings ***
Documentation    A test suite to view dismissed notifications and verify Dismiss Dates in Archive
...
...               This test will log into MyWFG, clicks MyWFG Lifeline Archive link,
...               verifies dismissed notifications and Dismiss Dates, and closes Archive
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Library           ../../Resources/Testing_Library.py
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary
Library           String
Library           DateTime

Suite Teardown    Close Browser

*** Variables ***
#${DATABASE}     WFGOnline
#${HOSTNAME}     CRDBCOMP03\\CRDBWFGOMOD
${Notification_ID}    4
${Dismiss_Index}      1
${Dismiss_Task}       Yes

*** Test Cases ***
#Connect to Database
#    Connect To Database Using Custom Params    pymssql    host='${HOSTNAME}', database='${WFG_DATABASE}'

Select Agent, Login to MyWFG.com, Check Dismiss Notifications
    ${Agent_Info}    Database_Library.Get_lifeline_dismiss_notification_agent    ${Notification_ID}
    Browser is opened to login page
    User "${Agent_Info[0]}" logs in with password "${VALID_PASSWORD}"
    Home Page for any Agent Should Be Open
    sleep   3s
    Click element   xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]
    sleep    2s
#    Click List Box With ID "selDismissReason-${Agent_Info[1]}" and select by index "${Dismiss_Index}"

#    Run Keyword If    ${Notification_ID} != 4 and ${Notification_ID} != 5 and ${Notification_ID} != 6 and ${Notification_ID} != 7
    Run Keyword If    ${Notification_ID} not in [4, 5, 6, 7]
    ...    log    Dismiss Reason doesn't exist for LifeLine Task " & Parameter("NotificationID")
#    Run Keyword If    ${Notification_ID}== 4 and ${Notification_ID} == 5 and ${Notification_ID} == 6 and ${Notification_ID} == 7 and '${Dismiss_Task}' == 'No'
    Run Keyword If    ${Notification_ID} in [4, 5, 6, 7] and '${Dismiss_Task}' == 'No'
    ...    Confirm No for Dismiss for htmlID - ${Agent_Info[1]} and Dismiss Index - ${Dismiss_Index}
    ...    ELSE IF    '${Dismiss_Task}' == 'Yes'
    ...    Confirm Yes for Dismiss for htmlID - ${Agent_Info[1]} and Dismiss Index - ${Dismiss_Index}
    ...    ELSE
    ...    log    I am in ELSE section for some reason

    #************Click Archive link and open archive page****************
    click link     xpath=//a[@id='linkArchive']
    sleep    2s
    #*************Click Back link and Close Archive page******************
    click link     xpath=//a[@id='linkBack']
    sleep    2s
    # **************Check if the Due Date of the archived notification is correct*****

    #************Check if the Date when notification was archived  is correct. -->
    #-->Eliminate "Dismissed..." verbiage from the Dismiss Date statemet**************

    #************Check if the correct Dismiss reason was passed to Archive*************


Log Out of MyWFG
    sleep    1s
    Log Out of MyWFG

#Disconnect from SQL Server
#    Disconnect From Database


*** Keywords ***
Confirm No for Dismiss for htmlID - ${htmlID} and Dismiss Index - ${Index}
    Click List Box With ID "selDismissReason-${htmlID}" and select by index "${Index}"
    sleep    2s
    Click image where ID is "closeDisMissNotification"
    log    Dismiss_Task is No

Confirm Yes for Dismiss for htmlID - ${htmlID} and Dismiss Index - ${Index}
    Click List Box With ID "selDismissReason-${htmlID}" and select by index "${Index}"
    sleep    2s
    Click image where ID is "yesDisMissNotification"
    sleep    1s
    Click image where ID is "close"
    log    Dismiss_Task is Yes