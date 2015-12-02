*** Settings ***
Documentation    A test suite to add or change the Spouse Info
...
...               This test will log into MyWFG, open My Preferences menu, verify the page
...               and adds or changes the Spouse Info
Metadata          Version   0.1
Resource          ../../../Resources/Resource_Login.robot
Resource          ../../../Resources/Resource_Webpage.robot
Library           O:/BusinessSupport/QA_Automation/Testing/Isabella/MyWFG/Resources/TestingLibrary.py
Library           ../../../Resources/TestingLibrary.py
Library           Selenium2Library

Suite Teardown     Close Browser

*** Variables ***

${SPOUSE AGENT NO}
${SPOUSE FIRST NAME}        LIHN
${SPOUSE COMMON NAME}       LYNNA
${SPOUSE LAST NAME}         NGHUYEN
${VERIFY TEXT}              spouse information was sucessfully changed

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

Scroll Down
    Scroll Page to Location Where Y equals "1000"

Verify Webpage
    Find "Spouse Info" On Webpage

Click Change Spouse Info button for Cancel
    Click Button using id "showChangeSpouse"
    sleep   3s

Click Cancel button
    Click Button using id "cancelSpouse"

Click Change Spouse Info button for Change
    Click Button using id "showChangeSpouse"
    sleep   3s

Change Spouse First name
    Input "${SPOUSE FIRST NAME}" in the "SpouseFirstName" Field

Change Spouse Common name
    Input "${SPOUSE COMMON NAME}" in the "SpouseCommonName" Field

Change Spouse Last name
    Input "${SPOUSE LAST NAME}" in the "SpouseLastName" Field

Click Save Changes Button
    Click Button using id "changeSpouse"

Verify Recognition Settings
    Find "${VERIFY TEXT}" On Webpage

Log Out of MyWFG
    Log Out of MyWFG

Close opened Browser
    Close Browser


*** Keywords ***
