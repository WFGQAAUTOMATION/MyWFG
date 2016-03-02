*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../../Resources/Resource_Login.robot
Test Teardown     Close Browser

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    input username  ${VALID_USER}
    input password  ${VALID_PASSWORD}
    Submit Credentials
    Home Page Should Be Open

<<<<<<< HEAD
    [Teardown]    Close Browser

=======
>>>>>>> master
