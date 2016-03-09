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

*** Test Cases ***

Login to MyWFG.com
    Given browser is opened to login page
    When user "${PREF_USER_ID}" logs in with password "${VALID_PASSWORD}"
    Then Home Page Should Be Open

Go to Profile My Preference Page
    Hover Over "Profile"
    Wait "5" Seconds
    Click Menu Item "My Preferences"

Verify Webpage
    Verify A Link Named "View Disclosure" Is On The Page

Click View Disclosure
    Click link with name contained "View Disclosure"

Click Close Disclosure button
	Wait "2" Seconds
    Click element    xpath=//span[@class="ui-button-text"][contains(text(),'Close')]

#************************************************************************************
Check if Opted In
	Wait "2" Seconds
    Find "You have not Opted-In" On Webpage

Click Opt In button to Disagree
	Wait "5" Seconds
    Click button named "Opt In"
    sleep   3s

Scroll Down
    Scroll Page to Location Where Y equals "450"

Click Disagree
    Click button named "Disagree"

Click Opt In button to Agree
	Wait "5" Seconds
    Click button named "Opt In"

Scroll Down Again
     Scroll Page To Location    0    450
     sleep   3s

Click Agree
    Click button named "Agree"

Set Selenium slower
    sleep   3s

Click Opt Out button for Cancel
    sleep    3s
    Click button named "Opt Out"

Click Cancel to stay Opted In
    Click Cancel on Alert

Click Opt Out button for OK
    sleep    3s
    Click button named "Opt Out"

Confirm Opt Out
    sleep    3
    Click Ok on Alert

Log Out of MyWFG
    Log Out of MyWFG



*** Keywords ***

