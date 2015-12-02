*** Settings ***
Documentation     A test suite to check home office contacts page.
...
...               This test will log into MyWFG and
...               verify the Home Office Contacts page.
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Test Teardown

*** Test Cases ***
Login to MyWFG.com
    Given browser is opened to login page
    When user "${VALID USER}" logs in with password "${VALID PASSWORD}"
    Then Home Page Should Be Open
    And Verify A Link Named "Home" Is On The Page

Navigate to Home Office Contacts
    Then Hover Over "Home"
    And Select Menu Item "Home Office Contacts"

Check Info on Home Office Contacts page
    And Find "Home Office Contacts" On Webpage
    And Find "770.246.9889" On Webpage
    And Find "416.225.2121" On Webpage
    And Find "678.966.6161" On Webpage

Log Out and Close Browser
    Then log out of mywfg
    And close browser

*** Keywords ***
