*** Settings ***
Documentation     A test suite to check leadership.
...
...               This test will log into MyWFG and
...               verify the Leadership.
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

Navigate to Home Office Leadership
    Then Hover Over "Home"
    Then Wait "3" Seconds
    And Select Menu Item "Home Office Executive Leadership"

Check Leadership Names
    And Find "Joe DiPaola" On Webpage
    And Find "Richard Williams" On Webpage
    And Find "Paul Mineck" On Webpage
    And Find "Susan Davies" On Webpage
    And Find "Leesa Easley" On Webpage
    And Find "John Joseph" On Webpage

Log Out and Close Browser
    Then log out of mywfg
    And close browser

*** Keywords ***
