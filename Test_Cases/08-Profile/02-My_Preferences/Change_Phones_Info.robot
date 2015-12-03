*** Settings ***
Documentation    A test suite to change the agent's phone numbers
...
...               This test will log into MyWFG, open My Preferences menu, verify the page
...               and changes Associate's phone numbers
Metadata          Version   0.1
Resource          ../../../Resources/Resource_Login.robot
Resource          ../../../Resources/Resource_Webpage.robot
Library           O:/BusinessSupport/QA_Automation/Testing/Isabella/MyWFG/Resources/TestingLibrary.py
Library           ../../../Resources/TestingLibrary.py
Library           Selenium2Library

Suite Teardown     Close Browser

*** Variables ***

${HOME PHONE}       7701234567
${CELL PHONE}       4043456789
${VERIFY_TEXT}      phones were sucessfully changed

*** Test Cases ***

Login to MyWFG.com
    Given browser is opened to login page
    When user "${USER ID}" logs in with password "${PASSWORD}"
    Then Home Page Should Be Open
    sleep   3s

Go to Profile My Preference Page
    Hover Over "Profile"
    sleep   3s
    Click Menu Item "My Preferences"
    sleep   3s

Verify Webpage
    Find "Associate Phones" On Webpage

Click Change phones button for Cancel
    Click Button using id "showChangePhone"
    sleep   3s

Click Cancel button
    Click Button using id "cancelPhone"

Click Change phones button for Change
    Click Button using id "showChangePhone"
    sleep   3s

Change Home Phone number
    Input "${HOME PHONE}" in the "homeTelephone" Field

Change Cell Phone number
    Input "${CELL PHONE}" in the "cellTelephone" Field

Click Save Changes Button
    Click Button using id "changePhone"

Verify Phones Change
    Find "${VERIFY_TEXT}" On Webpage

Log Out of MyWFG
    Log Out of MyWFG

Close opened Browser
    Close Browser


*** Keywords ***

