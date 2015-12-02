*** Settings ***
Documentation    A test suite to set up or cancel electronic 1099-MISC
...
...               This test will log into MyWFG, open My Preferences menu, verify the page
...               and Opt_In/Opt-Out for electronic 1099-MISC
Metadata          Version   0.1
Resource          ../../../Resources/Resource_Login.robot
Resource          ../../../Resources/Resource_Webpage.robot
#Library           O:/BusinessSupport/QA_Automation/Testing/Isabella/MyWFG/Resources/TestingLibrary.py
#Resource           ../../../Resources/TestingLibrary.py
Library           Selenium2Library

#Suite Teardown     Close Browser

*** Test Cases ***
Login to MyWFG.com
    Given browser is opened to login page
    When user "${VALID USER}" logs in with password "${VALID PASSWORD}"
    sleep   5s
    Then Home Page Should Be Open

Go to Profile My Preference Page
    Hover Over "Profile"
    Select Menu Item "My Preferences"

Verify Webpage
    And Verify A Link Named "View Disclosure" Is On The Page

Click View Disclosure
    Click Link Named "View Disclosure"

Click Close button
    Click element    xpath=//span[@class="ui-button-text"][contains(text(),'Close')]

Click Opt In button to Disagree
    Click button named "Opt In"
    sleep   5s

Scroll Down
    Scroll Page to Location Where Y equals "435"

Click Disagree
    Click button named "Disagree"

Click Opt In button to Agree
    Click button named "Opt In"

Scroll Down Again
    Scroll Page to Location Where Y equals "435"
    sleep   5s

Click Agree
    Click button named "Agree"

Set Selenium slower
    sleep   5s
    
Click Opt Out button
    Click button named "Opt Out"

Click OK to Opt Out
    Click Ok on Alert

Click Cancel to stay Opted In
    Click Cancel on Alert


Log Out of MyWFG
    Log Out of MyWFG

*** Keywords ***
