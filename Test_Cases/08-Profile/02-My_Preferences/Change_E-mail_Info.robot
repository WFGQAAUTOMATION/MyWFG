*** Settings ***
Documentation    A test suite to set up or change the agent's email information
...
...               This test will log into MyWFG, open My Preferences menu, verify the page
...               and changes agents's personal email address
Metadata          Version   0.1
Resource          ../../../Resources/Resource_Login.robot
Resource          ../../../Resources/Resource_Webpage.robot
Library           ../../../Resources/Testing_Library.py
Library           Selenium2Library

Suite Teardown     Close Browser

*** Variables ***

${NEW EMAIL}        my.email@yahoo.com
${VERIFY_TEXT}      E-mail Address was sucessfully changed

*** Test Cases ***

Login to MyWFG.com
    Given browser is opened to login page
    When user "${USER ID}" logs in with password "${PASSWORD}"
    Then Home Page Should Be Open
    sleep   3s

Go to Profile My Preference Page
    Hover Over "Profile"
    Then Wait "3" Seconds
    Verify A Link Named "My Preferences" Is On The Page
    Click Menu Item "My Preferences"
    sleep   3s

Verify Webpage
    Find "Personal Email" On Webpage

Click Change Email button for Cancel
    Click Button using id "showChangeEmail"
    sleep   3s

Scroll Down
    Scroll Page to Location Where Y equals "300"

Click Cancel button
    Click Button using id "cancelEmailChange"

Click Change Email button for Change
    Click Button using id "showChangeEmail"
    sleep   3s

Change Email address
    Input "${NEW EMAIL}" in the "newEmail" Field

Click Save Changes Button
    Click Button using id "emailChange"

Verify Email Change
    Find "${VERIFY_TEXT}" On Webpage

Log Out of MyWFG
    sleep    3s
    Log Out of MyWFG

Close opened Browser
    Close Browser



*** Keywords ***

