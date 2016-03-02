*** Settings ***
Documentation    A test suite to change the Recognition Settings
...
...               This test will log into MyWFG, open My Preferences menu, verify the page
...               and sets up or changes Recognition Settings
Metadata          Version   0.1
Resource          ../../../Resources/Resource_Login.robot
Resource          ../../../Resources/Resource_Webpage.robot
Library           ../../../Resources/Testing_Library.py
Library           Selenium2Library

Suite Teardown     Close Browser

*** Variables ***

${RECOGNITION NAME}       Ella & Daniel
${VERIFY_TEXT}

*** Test Cases ***
Login to MyWFG.com
    Given browser is opened to login page
    When user "${PREF_USER_ID}" logs in with password "${VALID_PASSWORD}"
    Then Home Page Should Be Open
    Verify A Link Named "Profile" Is On The Page

Go to Profile My Preference Page
    Hover Over "Profile"
    Then Wait "3" Seconds
    Verify A Link Named "My Preferences" Is On The Page
    Click Menu Item "My Preferences"
    sleep   3s

Scroll Down
    Scroll Page to Location Where Y equals "400"

Verify Webpage
    Find "Recognition Settings" On Webpage

Click Change Recognition Settings for Cancel
    Click Button using id "showChangeRecognition"
    sleep   3s

Click Cancel button
    Click Button using id "cancelRecognition"

Click Change Recognition Settings button for Change
    Click Button using id "showChangeRecognition"
    sleep   3s

Change Recognition Settings number
    Input "${RECOGNITION NAME}" in the "recognitionName" Field

Click Save Changes Button
    Click Button using id "changeRecognition"

#Verify Recognition Settings
#    Find "${VERIFY_TEXT}" On Webpage

Log Out of MyWFG
    Log Out of MyWFG

Close opened Browser
    Close Browser



*** Keywords ***
