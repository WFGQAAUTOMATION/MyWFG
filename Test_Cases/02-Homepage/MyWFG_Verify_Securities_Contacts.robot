*** Settings ***
Documentation     A test suite to check Securities Home Office Contacts page.
...
...               This test will log into MyWFG and
...               verify the Securities Home Office Contacts page.
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot

*** Test Cases ***
Login to MyWFG.com
    Given browser is opened to login page
    When user "${VALID USER}" logs in with password "${VALID PASSWORD}"
    Then Home Page Should Be Open
    And Verify A Link Named "Home" Is On The Page

Navigate to Securities Home Office Contacts
    Then Hover Over "Home"
    Then Wait "3" Seconds
    Then Select Menu Item "Securities Home Office Contacts"

Find Text On Webpage
    And Find "WFG Securities of Canada" On Webpage
    And Find "416.225.2121" On Webpage
    And Find "TFG Managers" On Webpage

Log Out
    Then log out of mywfg
    And close browser

*** Keywords ***