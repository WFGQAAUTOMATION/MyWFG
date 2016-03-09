*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library
Library           Testing_Library.py

*** Variables ***
#${SERVER}            m-www.mywfg.com
${BROWSER}           gc
${DELAY}             0
#${VALID USER}        1708W
#${VALID PASSWORD}    81u3$ky
#${LOGIN_URL}         https://${SERVER}/Users/Account/AccessDenied?ReturnUrl=%2f
#${LOGIN URL}         https://${SERVER}
#${WELCOME_URL}       https://${SERVER}/
#${ERROR_URL}         https://${SERVER}/Users/Account/LogOn?ReturnUrl=%2F
${linkname}          REPORTS
#${PREF_USER_ID}           3330T

*** Keywords ***

Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    ${BROWSER}  None  http://161.179.241.85:4444/wd/hub
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

#*****************************************************

Login Page Should Be Open
    Title Should Be    ${LOGIN_TITLE}

#*****************************************************

Go To Login Page
    Go To    ${LOGIN_URL}
    Login Page Should Be Open

#*****************************************************

Input Username
    [Arguments]    ${username}
    Input Text    username-email    ${username}

#*****************************************************

Input Password
    [Arguments]    ${password}
    Input Text    password    ${password}

#*****************************************************

Submit Credentials
    Click Button    Log In

#*****************************************************

Home Page Should Be Open
    sleep    3
    Location Should Contain    ${WELCOME_URL}
    title should be     ${PAGE_TITLE}

#*****************************************************
# This keyword includes new agents
Home Page for any Agent Should Be Open
    sleep    3
    Location Should Contain    ${WELCOME_URL}
    Page Should Contain     MyWFG

#*****************************************************

Browser is opened to login page
    Open browser to login page

#*****************************************************

User "${username}" logs in with password "${password}"
    Input username    ${username}
    Input password    ${password}
    Submit credentials

#*****************************************************

Login Should Have Failed
    Location Should Be    ${ERROR_URL}
    Title Should Be    ${PAGE_TITLE}

#*****************************************************

Navigate To "${linkname}"
    click link    ${linkname}

#*****************************************************

User is on "${pagename}"
    get element attribute    ${pagename}

#*****************************************************

Element Header "${elementname}" Should Be Present
    element should be visible    //h1[contains(text(),'${elementname}')]
