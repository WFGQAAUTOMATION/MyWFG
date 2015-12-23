*** Settings ***
Documentation    A test suite to set up or cancel electronic 1099-MISC
...
...               This test will log into MyWFG, open My Preferences menu, verify the page
...               and Opt_In/Opt-Out for electronic 1099-MISC
Metadata          Version   0.1
Resource          ../../../Resources/Resource_Login.robot
Resource          ../../../Resources/Resource_Webpage.robot
Library           ../../../Resources/Testing_Library.py
Library           Selenium2Library

Suite Teardown     Close Browser

*** Variables ***
${button_option}    Isabella

*** Test Cases ***

Login to MyWFG.com
    Given browser is opened to login page
    When user "${USER ID}" logs in with password "${PASSWORD}"
    Then Home Page Should Be Open
    sleep   3s

Go to Profile My Preference Page
    Hover Over "Profile"
    Click Menu Item "My Preferences"
    sleep  5s

Verify Webpage
    And Verify A Link Named "View Disclosure" Is On The Page
    sleep   2s

Click View Disclosure
    Click link with name contained "View Disclosure"

Click Close Disclosure button
   Click element    xpath=//span[@class="ui-button-text"][contains(text(),'Close')]

#************************************************************************************
Run Opt In
    ${passed} =     run keyword and return status    Click button named "Opt In"
#    ${button_option} =    check_opt_in_option    ${passed}

    Run Keyword If    "${button_option}" == "Isabella"
    ...    sleep    1s
    ...    ELSE IF    "${button_option}" == "Disabled"
    ...    sleep    2s
    ...    ELSE IF    "${button_option}" == "Enabled"
    ...    Click button named "Opt In"
    ...    ELSE
    ...    sleep    3s
    Run Keyword If    "${button_option}" == "Enabled"
    ...    sleep   1s
    Run Keyword If    "${button_option}" == "Enabled"
    ...    Scroll Page to Location Where Y equals "450"
    Run Keyword If    "${button_option}" == "Enabled"
    ...    Click button named "Disagree"
    ...    ELSE IF    "${button_option}" == "Disabled"
    ...    sleep    2s
    Run Keyword If    "${button_option}" == "Enabled"
    ...    Click button named "Opt In"
    Run Keyword If    "${button_option}" == "Enabled"
    ...    Scroll Page To Location    0    450
    Run Keyword If    "${button_option}" == "Enabled"
    ...    sleep   2s
    Run Keyword If    "${button_option}" == "Enabled"
    ...    Click button named "Agree"
    ...    ELSE IF    "${button_option}" == "Disabled"
    ...    sleep    2s
    Run Keyword If    "${button_option}" == "Enabled"
    ...    sleep   2s

Run Opt Out
    Click button named "Opt Out"
    sleep    3s
    Click Cancel on Alert
    sleep    3s
    Click button named "Opt Out"
    sleep    3s
    Click Ok on Alert

Log Out of MyWFG
    sleep    3s
    Log Out of MyWFG


*** Keywords ***
My Custom Keyword
    sleep   1s    AND    sleep    1s
    sleep   1s