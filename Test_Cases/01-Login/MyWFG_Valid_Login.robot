*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../../Resources/Resource_Login.robot
*** Test Cases ***
Valid Login
    Open Browser To Login Page
    input username  ${VALID USER}
    input password  ${VALID PASSWORD}
    Submit Credentials
    Welcome Page Should Be Open
    [Teardown]    Close Browser