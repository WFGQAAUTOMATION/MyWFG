*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          ../../Resources/Resource_Login.robot
<<<<<<< HEAD
=======
Test Teardown     Close Browser
>>>>>>> fa1654788efdb8b0f80ac0c7f2fd41c3ebf3bf9e

*** Test Cases ***
Valid Login
    Open Browser To Login Page
    input username  ${VALID USER}
    input password  ${VALID PASSWORD}
    Submit Credentials
    Home Page Should Be Open
<<<<<<< HEAD
    [Teardown]    Close Browser
=======
>>>>>>> fa1654788efdb8b0f80ac0c7f2fd41c3ebf3bf9e
