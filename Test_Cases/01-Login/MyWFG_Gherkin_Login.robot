*** Settings ***
Documentation     A test suite with a single Gherkin style test.
...
...               This test is functionally identical to the example in
...               valid_login.txt file.
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Test Teardown     Close Browser

*** Test Cases ***
Valid Login
    Given browser is opened to login page
    When user "${VALID USER}" logs in with password "${VALID PASSWORD}"
    Then Home Page Should Be Open
    Then Hover Over "Profile"
    And Select Menu Item "My Profile"

Select Frame
    click button named "Upload Photo"
#    select frame where id is "agentImageUploaderContainer"
#    select checkbox where id is "chkAgree"
    click button named "Cancel"

Valid Login - Click Menu Item
    Given browser is opened to login page
    When user "${VALID USER}" logs in with password "${VALID PASSWORD}"
    Then Home Page Should Be Open
    Then Hover Over "Resources"
    And Select Menu Item "Media Center"

Invalid Login - Bad Password
    Given Browser is opened to login page
    When User "${VALID USER}" logs in with password "none"
    Then Login Should Have Failed

Invalid Login - Bad Username
    Given Browser is opened to login page
    When User "invalid" logs in with password "${VALID PASSWORD}"
    Then Login Should Have Failed

*** Keywords ***
Browser is opened to login page
    Open browser to login page

User "${username}" logs in with password "${password}"
    Input username        ${username}
    Input password        ${password}
    Submit credentials

Login Should Have Failed
    Location Should Be    ${ERROR URL}
    Title Should Be       MyWFG - Log In
