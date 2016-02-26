*** Settings ***
Documentation     A test suite to check Vision and Mission page.
...
...               This test will log into MyWFG and
...               verify the Vision and Mission page.
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot

*** Test Cases ***
Login to MyWFG.com
    Given browser is opened to login page
    When user "${VALID USER}" logs in with password "${VALID PASSWORD}"
    Then Home Page Should Be Open
    And Verify A Link Named "Home" Is On The Page

Navigate to Vision and Mission
    Then Hover Over "Home"
    Then Wait "3" Seconds
    Then click link     xpath=//a[contains(@href, '/vision-and-mission')]
#    Then Select Menu Item "WFG Vision and Mission"

Find Text On Webpage
    And Find "WFG Vision" On Webpage
    And Find "WFG Mission" On Webpage

Log Out
    Then Log Out of MyWFG
    And Close Browser

*** Keywords ***