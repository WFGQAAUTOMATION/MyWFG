*** Settings ***
Documentation     A test suite with Gherkin style tests.
...
...               This test will log into MyWFG and
...               verify the Homepage.
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Test Teardown

*** Test Cases ***
Login to MyWFG.com
    Given browser is opened to login page
    When user "${VALID_USER}" logs in with password "${VALID_PASSWORD}"
    Then Home Page Should Be Open

Navigate to HomePage
    And Verify A Link Named "Home" Is On The Page
    Then Select Menu Item "Home"
    And Element Header "My WFG Business" Should Be Present

Log Out and Close Browser
    Then log out of mywfg
    And close browser

*** Keywords ***