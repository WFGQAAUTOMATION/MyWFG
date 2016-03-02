*** Settings ***
Documentation     A test suite containing tests related to invalid login.
...
...               These tests are data-driven by nature. They use a single
...               keyword, specified with Test Template setting, that is called
...               with different arguments to cover different scenarios.
...
...               This suite also demonstrates using setups and teardowns in
...               different levels.
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Suite Setup       Open Browser To Login Page
Test Template     Login With Invalid Credentials Should Fail
Test Setup        Go To Login Page
Suite Teardown    Close Browser

#This is an example of Data Driven Testing (DDD)

*** Test Cases ***               User Name        Password
Invalid Username                 invalid          ${VALID_PASSWORD}
Invalid Password                 ${VALID_USER}    invalid
Invalid Username And Password    invalid          whatever
Empty Username                   ${EMPTY}         ${VALID_PASSWORD}
Empty Password                   ${VALID_USER}    ${EMPTY}
Empty Username And Password      ${EMPTY}         ${EMPTY}

*** Keywords ***
#High level keywords will take arguments (parameters)
Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Login Should Have Failed

Login Should Have Failed
    Location Should Be    ${ERROR_URL}
    Title Should Be    ${PAGE_TITLE}
