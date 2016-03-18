*** Settings ***
Documentation    A test suite to click MyWFG LifeLine Archive, verify Dismiss Reason and close Archive
...
...               This test will log into MyWFG, click MyWFG Lifeline Archive link,
...               verify Dismiss Reason and closes Archive
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
#${DATABASE}     WFGOnline
#${HOSTNAME}     CRDBCOMP03\\CRDBWFGOMOD
${Notification_ID}    4
${Dismiss_Index}      3
${Dismiss_Task}       Yes

*** Test Cases ***

Select Agent, Login to MyWFG.com, Check Dismiss Notifications
    ${Agent_Info}    Database_Library.Get_lifeline_dismiss_notification_agent    ${Notification_ID}   ${HOSTNAME}
    ...    ${WFG_DATABASE}
    Browser is opened to login page
    User "${Agent_Info[0]}" logs in with password "${VALID_PASSWORD}"
    Home Page for any Agent Should Be Open
    sleep   3s
    Click element   xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]
    sleep    2s
    Click List Box With ID "selDismissReason-${Agent_Info[1]}" and select by index "${Dismiss_Index}"

    Run Keyword If    ${Notification_ID} != 4 and ${Notification_ID} != 5 and ${Notification_ID} != 6 and ${Notification_ID} != 7
    ...    log    Dismiss Reason doesn't exist for LifeLine Task " & Parameter("NotificationID")

    Run Keyword If    '${Dismiss_Task}' == 'No'
    ...    Confirm No for Dismiss
    ...    ELSE IF    '${Dismiss_Task}' == 'Yes'
    ...    Confirm Yes for Dismiss

Click Archive link
     click link     xpath=//a[@id='linkArchive']

Click Back link and Close Archive page
    click link     xpath=//a[@id='linkBack']

Log Out of MyWFG
    sleep    1s
    Log Out of MyWFG

*** Keywords ***
Confirm No for Dismiss
    Click image where ID is "closeDisMissNotification"
    log    Dismiss_Task is No

Confirm Yes for Dismiss
    Click image where ID is "yesDisMissNotification"
    sleep    1s
    Click image where ID is "close"
    log    Dismiss_Task is Yes