*** Settings ***
Documentation     A test suite to check MyWFG Site.
...
...               This test will log into MyWFG and
...               verify the Associate Search.
Metadata          Version   0.1
Resource          ../../../Resources/Resource_Login.robot
Resource          ../../../Resources/Resource_Webpage.robot
#Library          ../../../Resources/TestingLibrary.py
Test Teardown

*** Test Cases ***
Login to MyWFG.com
    Given browser is opened to login page
    When user "1708W" logs in with password "${VALID PASSWORD}"
    Then Home Page Should Be Open

Go to Associate Search Page
    And Verify A Link Named "Home" Is On The Page
    Then Hover Over "Dashboard"
    Then Select Menu Item "Associate Search"

Verify Associate Search Page is Opened
    And Element Header "Associate Search" Should Be Present

Enter Name and Search
	Then Select "Base" from dropdown
    And Input "Irvine" in The "searchFieldCity" Field
#    Then Click Button named "Search"
#    And Wait "20" Seconds
#    And Find "Temple City" in the Results List
#
#Log Out and Close Browser
#    Then log out of mywfg
#    And close browser

*** Keywords ***