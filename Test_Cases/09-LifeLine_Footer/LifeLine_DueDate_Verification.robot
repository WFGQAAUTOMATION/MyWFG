*** Settings ***
Documentation    A test suite to verify MyWFG LifeLine Due date
...
...               This test will log into MyWFG and verify MyWFG LifeLine Due Date
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
${Notification_ID}        8
${Notification_TypeID}    1
${STATE}
${PROVINCE}

*** Test Cases ***

Select Agent and Login to MyWFG.com
    ${Agent_Info}=    Run Keyword If    ${Notification_ID} == 4 or ${Notification_ID} == 7 or ${Notification_ID} == 13
    ...    Database_Library.Find_LifeLine_Agent    ${Notification_ID}    ${Notification_TypeID}    ${LL_STATE}
    ...    ${HOSTNAME}    ${WFG_DATABASE}
    ...    ELSE IF    ${Notification_ID} == 5
    ...    Database_Library.Find_LifeLine_Agent    ${Notification_ID}    ${Notification_TypeID}    ${PROVINCE}
    ...    ${HOSTNAME}    ${WFG_DATABASE}
    ...    ELSE
    ...    Database_Library.Find_LifeLine_Agent    ${Notification_ID}    ${Notification_TypeID}    ${STATE}
    ...    ${HOSTNAME}    ${WFG_DATABASE}

    Browser is opened to login page
    User "${Agent_Info[0]}" logs in with password "${VALID_PASSWORD}"
    Home Page for any Agent Should Be Open
    sleep   2s
    Click element   xpath=//span[@class="ui-user-MyLifeline-notification-attachment-count"]
    sleep    2s
    Click image using img where ID is "QuestionMark-${Agent_Info[1]}"
    sleep    2s
    Click image where ID is "close"

#   ***** Get Due Date from the web page
    ${Webpage_DateDue_Str}    Get Text    xpath=//*[@id='DueDate-${Agent_Info[1]}']
    ${DateDue_Length}    Get Length    ${Webpage_DateDue_Str}

#    ***** Convert date to match with database formate
    ${Webpage_DateDue}    Remove String     ${Webpage_DateDue_Str}     (Expired)
    ${Webpage_DateDue}    Replace String    ${Webpage_DateDue}    /    -

    Should be equal    ${Agent_Info[2].strip()}    ${Webpage_DateDue.strip()}

    Run Keyword If    ${Agent_Info[2].strip()} == ${Webpage_DateDue.strip()}
    ...    log    Date Due verification Passed.
    ...    ELSE
    ...    log    Date Due verification Failed.

Log Out of MyWFG
    Log Out of MyWFG

*** Keywords ***

