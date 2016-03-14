*** Settings ***
Documentation     A test suite with a single Gherkin style test.
...
...               This test is functionally identical to the example in
...               valid_login.txt file.
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Test Teardown     Close Browser
Force Tags        Dev_Sanity

*** Test Cases ***

Valid Login
    Given browser is opened to login page
    When user "${VALID_USER}" logs in with password "${VALID_PASSWORD}"
    Then Home Page Should Be Open
    Then Hover Over "Profile"
    Then Wait "3" Seconds
    And Select Menu Item "My Profile"

Valid Login - Click Menu Item
    Given browser is opened to login page
    When user "${VALID_USER}" logs in with password "${VALID_PASSWORD}"
    Then Home Page Should Be Open
    Then Hover Over "Resources"
    Then Wait "5" Seconds
    And Select Menu Item "Media Center"

Invalid Login - Bad Password
    Given Browser is opened to login page
    When User "${VALID_USER}" logs in with password "none"
    Then Login Should Have Failed

Invalid Login - Bad Username
    Given Browser is opened to login page
    When User "invalid" logs in with password "${VALID_PASSWORD}"
    Then Login Should Have Failed

*** Keywords ***
Browser is opened to login page
    Open browser to login page

User "${username}" logs in with password "${password}"
    Input username        ${username}
    Input password        ${password}
    Submit credentials

Login Should Have Failed
    Location Should Contain    ${ERROR_URL}
    Title Should Be       ${LOGIN_TITLE}

