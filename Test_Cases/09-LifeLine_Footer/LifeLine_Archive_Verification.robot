*** Settings ***
Documentation    A test suite to click MyWFG LifeLine Archive, verify the message and close Archive
...
...               This test will log into MyWFG, clicks MyWFG Lifeline Archive link,
...               verifies the message and closes Archive
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Library           ../../Resources/Testing_Library.py
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary
Library           String
Library           DateTime

*** Settings ***
Suite Teardown     Close Browser
#Test Teardown

*** Variables ***
${DATABASE}     WFGOnline
${HOSTNAME}     CRDBCOMP03\\CRDBWFGOMOD
${Notification_ID}     2
${Archive_Question}    ArchieveQuestionMark
${Dismiss_Index}       3
${Dismiss_Task}        Yes

#************** NOT COMPLETED !!!!! **************************************************************

*** Test Cases ***
Connect to Database
    Connect To Database Using Custom Params    pymssql    host='${HOSTNAME}', database='${DATABASE}'

Compare Life Line task to dismiss with archived (dismissed) task
#*****This query is used if we need to connect with a specific agent ID*******
#    ${Results}    query    SELECT AgentCodeNumber FROM [WFGCompass].[dbo].[agAgent] WHERE AgentID IN (${AGENT_ID});
    ${Agent_Info}    Database_Library.get_lifeline_dismiss_notification_agent    ${Notification_ID}
    Browser is opened to login page
    User "${Agent_Info[0]}" logs in with password "${PASSWORD}"
    Home Page for any Agent Should Be Open
    sleep   3s
    Click element   xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]
    sleep    2s

    ${DateDue_Str}    Get Text    xpath=//*[@id='DueDate-${Agent_Info[1]}']
    ${DateDue_Length}    Get Length    ${DateDue_Str}
    ${DateDue}    Fetch From Left    ${DateDue_Str}    (

    Run Keyword If    ${Notification_ID} != 4 and ${Notification_ID} != 5 and ${Notification_ID} != 6 and ${Notification_ID} != 7
    ...    Tasks cannot be dismissed

    Click List Box With ID "selDismissReason-${Agent_Info[1]}" and select by index "${Dismiss_Index}"
    Run Keyword If    '${Dismiss_Task}' == 'No'
    ...    Confirm No for Dismiss
    ...    ELSE IF    '${Dismiss_Task}' == 'Yes'
    ...    Process Yes for Dismiss

#**** Click Archive link *******
     click link     xpath=//a[@id='linkArchive']
     ${Archived_DateDue}    Get Text    xpath=//*[@id='ArchiveDueDate-${Agent_Info[1]}']

Click Back link and Close Archive page
    click link     xpath=//a[@id='linkBack']

Log Out of MyWFG
    Log Out of MyWFG

Disconnect from SQL Server
    Disconnect From Database


*** Keywords ***
Tasks cannot be dismissed
    log    Dismiss Reason doesn't exist for LifeLine Task " & ${Notification_ID}
    Log Out of MyWFG
    sleep    2s
    Disconnect From Database
    Close Browser


Confirm No for Dismiss
    Click image where ID is "closeDisMissNotification"
    log    Dismiss_Task is No

Process Yes for Dismiss
    Click image where ID is "yesDisMissNotification"
    sleep    1s
    Click image where ID is "close"
    log    Dismiss_Task is Yes
