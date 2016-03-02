*** Settings ***
Documentation     A test suite to change the associate contact
...
...               This test will log into MyWFG, open My Preferences menu, verify the page
...               and changes Associate Contact information
Metadata          Version   0.1
Resource          ../../../Resources/Resource_Login.robot
Resource          ../../../Resources/Resource_Webpage.robot
Library           ../../../Resources/Testing_Library.py
Library           Selenium2Library

Suite Teardown     Close Browser

*** Variables ***
${ADDRESS}         1234 Main Street
${CITY}            Duluth
${STATE}           GA
${ZIP}             30309
${VERIFY_TEXT}     Thank you for submitting your home address change

*** Test Cases ***

Login to MyWFG.com
    Given browser is opened to login page
    When user "${PREF_USER_ID}" logs in with password "${VALID_PASSWORD}"
    Then Home Page Should Be Open
    sleep   3s

Go to Profile My Preference Page
    Hover Over "Profile"
    Wait "3" Seconds
    Click Menu Item "My Preferences"
    sleep   3s

Verify Webpage
    Find "Associate Contact:" On Webpage

Click Change Associate Contact button for Cancel
    Click Button using id "showChangeContact"
    sleep   3s

Scroll Down
    Scroll Page to Location Where Y equals "400"

Click Cancel button
    Click Button using id "cancelContact"

Scroll Up
    Scroll Page to Location Where Y equals "100"

Click Change Associate Contact button for Change
    Click Button using id "showChangeContact"
    sleep   3s

Change Contact Associate Contact Address
    Input "${ADDRESS}" in the "Address" Field

Change Associate Contact City
    Input "${CITY}" in The "city" Field

Change Associate Contact State
     Click List Box Named "states" and select "${STATE}"
     sleep  2s

Change Associate Contact Zip Code
    Input "${ZIP}" in The "zipCode" Field

Click Save Changes Button
    Click Button using id "changeContact"

Verify Associate Contact Change
    Find "${VERIFY_TEXT}" On Webpage

Log Out of MyWFG
    Log Out of MyWFG

Close opened Browser
    Close Browser


*** Keywords ***

