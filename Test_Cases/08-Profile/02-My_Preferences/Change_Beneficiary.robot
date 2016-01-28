*** Settings ***
Documentation    A test suite to set up or change the agent's designated beneficiary
...
...               This test will log into MyWFG, open My Preferences menu, verify the page
...               and sets up or changes agents's designated beneficiary
Metadata          Version   0.1
Resource          ../../../Resources/Resource_Login.robot
Resource          ../../../Resources/Resource_Webpage.robot
Library           ../../../Resources/Testing_Library.py
Library           Selenium2Library

Suite Teardown     Close Browser

*** Variables ***

${FIRST NAME}        Ella
${LAST NAME}         NGUEN
${PHONE}             7701234567
${RELATIONSHIP}      Wife
${ADDRESS 1}         1234 Clearbrooke Way
${ADDRESS 2}         APT. A5
${COUNTRY}           US
${STATE}             GA
${CITY}              DULUTH
${ZIP}               30097
${VERIFY_TEXT}       beneficiary information was sucessfully changed

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
    Scroll Page to Location Where Y equals "800"

Verify Webpage
    Find "Designated Beneficiary" On Webpage

Click Change Recognition Settings button for Cancel
    Click Button using id "showChangeBeneficiary"
    sleep   3s

Scroll Down more
    Scroll Page to Location Where Y equals "1200"

Click Cancel button
    Click Button using id "cancelBeneficiary"

Scroll Up
    Scroll Page to Location Where Y equals "800"

Click Change Beneficiary button for Change
    Click Button using id "showChangeBeneficiary"
    sleep   3s

Change Beneficiary First Name
    Input "${FIRST NAME}" in the "BenFirstName" Field

Change Beneficiary Last Name
    Input "${LAST NAME}" in the "BenLastName" Field

Change Beneficiary Phone
    Input "${PHONE}" in The "BenPhone" Field

Change Benenficiary Relationship
    Input "${RELATIONSHIP}" in The "BenRelationship" Field

Scroll Down again
    Scroll Page to Location Where Y equals "1200"

Change Beneficiary Address 1
    Input "${ADDRESS 1}" in the "BenHomeLine1" Field

Change Beneficiary Address 2
    Input "${ADDRESS 2}" in the "BenHomeLine2" Field

Change Beneficiary Country
     Click List Box Named "BenHomeCountry" and select "${COUNTRY}"
     sleep  2s
Change Beneficiary State
     Click List Box Named "BenHomeState" and select "${STATE}"
     sleep  2s
Change Beneficiary City
    Input "${CITY}" in The "BenHomeCity" Field

Change Beneficiary Zip Code
    Input "${ZIP}" in The "BenHomeZip" Field

Click Save Changes Button
    Click Button using id "changeBeneficiary"

Verify Beneficiary Change
    Find "${VERIFY_TEXT}" On Webpage

#****************************************************************************************************
Log Out of MyWFG
    Log Out of MyWFG

Close opened Browser
    Close Browser


*** Keywords ***

