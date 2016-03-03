*** Settings ***
Documentation     A test suite to check MyWFG Site.
...
...               This test will log into MyWFG and
...               verify the Dashboard Home.
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot

*** Test Cases ***
Login to MyWFG.com
    Given browser is opened to login page
    When user "${VALID_USER}" logs in with password "${VALID_PASSWORD}"
    Then Home Page Should Be Open

Go to Dashboard Page
    And Verify A Link Named "Home" Is On The Page
    Then Select Menu Item "Dashboard"

Verify Dashboard Page is Opened
    And Element Header "Business Profile" Should Be Present

Log Out and Close Browser
    Then log out of mywfg
    And close browser

*** Keywords ***