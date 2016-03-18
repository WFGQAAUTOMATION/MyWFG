*** Settings ***
Documentation     A test suite to change the associate profile
...
...               This test will log into MyWFG, open My Profile menu, verify the page
...               and updates Associate Profile information
Metadata          Version   0.1
Resource          ../../../Resources/Resource_Login.robot
Resource          ../../../Resources/Resource_Webpage.robot
Library           ../../../Resources/Testing_Library.py
Library           Selenium2Library

Suite Teardown     Close Browser

*** Variables ***

${BUS_PHILOSOPHY}     NEW GENERATRION
${PREV_CAREER}        DANTIST
${LANGUAGE}           RUSSIAN
${WORK_TIME}          Full-Time
${OPEN_TO_MAP}        Yes
${DISPLAY_BUS_STAT}   Yes
${BUSINESS_STYLE}     Canada
#${WORK_TIME}          Part-Time
#${OPEN_TO_MAP}        No
#${DISPLAY_BUS_STAT}   No
#${BUSINESS_STYLE}     Legacy
${VERIFY_TEXT}        Your Profile was Successfully changed

*** Test Cases ***

Login to MyWFG.com
    Given browser is opened to login page
    When user "${USER ID}" logs in with password "${PASSWORD}"
    Then Home Page Should Be Open
    sleep   3s

Go to Profile My Profile Page
    Hover Over "Profile"
    sleep   3s
    Click Menu Item "My Profile"
    Wait Until Element Is Visible    xpath=.//*[@id='showChangeProfile']    20s
    sleep   3s

Verify Webpage
    sleep   3s
    Find "My Profile" On Webpage

Scroll Down
    Scroll Page to Location Where Y equals "800"

Click Change Associate Contact button for Cancel
    Click Button using id "showChangeProfile"
    sleep   3s

Scroll Down Again
    Scroll Page to Location Where Y equals "1200"

Click Cancel button
    Click Button using id "cancelChangeProfile"

Click Change Associate Contact button for Change
    Click Button using id "showChangeProfile"
    sleep   3s

Change Business Philosophy
    Input "${BUS_PHILOSOPHY}" in the "newPhilosophy" Field With ID

Change Previous Career
    Input "${PREV_CAREER}" in the "newCareer" Field With ID

Change Languages Spoken
    Input "${LANGUAGE}" in The "newLanguage" Field With ID

Change Work Time
     Click List Box With ID "newStatus" and select "${WORK_TIME}"
     sleep  2s

Change Open To Map
     Click List Box With ID "newMap" and select "${OPEN_TO_MAP}"
     sleep  2s

Change Display Business Statistic
     Click List Box With ID "newStat" and select "${DISPLAY_BUS_STAT}"
     sleep  2s

Change Business Style
     Click List Box With ID "newStyle" and select "${BUSINESS_STYLE}"

Click Save Changes Button
    Click Button using id "changeProfile"

Verify Associate Contact Change
    Find "${VERIFY_TEXT}" On Webpage

Log Out of MyWFG
    sleep   2s
    Log Out of MyWFG

*** Keywords ***
