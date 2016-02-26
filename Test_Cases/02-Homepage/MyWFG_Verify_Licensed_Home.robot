*** Settings ***
Documentation     A test suite to check Licensed Home page.
...
...               This test will log into MyWFG and
...               verify the Licensed Home page.
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot

*** Test Cases ***
Login to MyWFG.com
    Given browser is opened to login page
    When user "${VALID USER}" logs in with password "${VALID PASSWORD}"
    Then Home Page Should Be Open
    And Verify A Link Named "Home" Is On The Page

Navigate to Licensed Home
    Then Hover Over "Home"
    Then Wait "6" Seconds
    Then Select Menu Item "Licensed Home"

Find Text On Webpage
    And Find "AppVantage" On Webpage
    And Find "iGO" On Webpage
    And Find "Become Appointed with a Company" On Webpage

Log Out
    Then log out of mywfg
    And close browser

*** Keywords ***
