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


*** Test Cases ***

Login to MyWFG.com
    Given browser is opened to login page
    When user "${USER ID}" logs in with password "${PASSWORD}"
    Then Home Page Should Be Open
    sleep   4s

Go to Profile My Preference Page
    Hover Over "Profile"
    Then Wait "3" Seconds
    Click Menu Item "My Preferences"
    sleep   4s

Verify Webpage
    And Verify A Link Named "View Disclosure" Is On The Page
    sleep   3s

Click View Disclosure
    Click link with name contained "View Disclosure"

Click Close Disclosure button
   Click element    xpath=//span[@class="ui-button-text"][contains(text(),'Close')]

#************************************************************************************
Run Opt Out
    ${passed} =     run keyword and return status    Click button named "Opt Out"
    ${button_option} =    check_opt_in_option    ${passed}
    Run Keyword If    "${button_option}" == "Enabled"    Click Cancel on Alert
    Run Keyword If    "${button_option}" == "Enabled"    Click button named "Opt Out"
    Run Keyword If    "${button_option}" == "Enabled"    sleep    2s
    Run Keyword If    "${button_option}" == "Enabled"    Click Ok on Alert
    Run Keyword If    "${button_option}" == "Enabled"    sleep    2s

Run Opt In
    Click button named "Opt In"
    sleep   2s
    Scroll Page to Location Where Y equals "450"
    Click button named "Disagree"
    Click button named "Opt In"
    Scroll Page To Location    0    450
    sleep   2s
    Click button named "Agree"
    sleep   2s


Log Out of MyWFG
    sleep    3s
    Log Out of MyWFG


*** Keywords ***

