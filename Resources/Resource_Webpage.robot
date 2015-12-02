*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library
Library           TestingLibrary

*** Variables ***
${SERVER}            m-www.mywfg.com
${BROWSER}           ff
${DELAY}             0
${VALID USER}        1200W
${VALID PASSWORD}    81u3$ky
${LOGIN URL}         https://${SERVER}/Users/Account/AccessDenied?ReturnUrl=%2f
${WELCOME URL}       https://${SERVER}/
${ERROR URL}         https://${SERVER}/Users/Account/LogOn?ReturnUrl=%2F

*** Keywords ***
#*****************************************************
#*****************************************************
######   NAVIGATION  ######
#*****************************************************
#*****************************************************

Navigate to webpage
    click link  ${LinkName}

#*****************************************************

Hover Over "${hoverover}"
    mouse over       xpath=//a[(text()='${hoverover}')]

#*****************************************************

Select Menu Item "${clickelement}"
    click element    xpath=//a[(text()='${clickelement}')]

#*****************************************************

Log Out of MyWFG
    click link    xpath=//a[@href="/Wfg.MyWfgLogin/Account/LogOff"]

#*****************************************************

Wait "${seconds}" Seconds
    set selenium implicit wait  ${seconds}

#*****************************************************
#*****************************************************
######   INTERACT ELEMENTS    ######
#*****************************************************
#*****************************************************

Click Object Named "${clickelement}"
    click element    xpath=//a[(text()='${clickelement}')]

#*****************************************************

Click Button named "${buttonname}"
    click button    xpath=//button[contains(text(),'${buttonname}')]

#*****************************************************

Click Link Named "${clicklick}"
    click link    xpath=//a[(text()='${clicklick}')]

#*****************************************************

Input "${Text}" in The "${FieldName}" Field
    input text  xpath=//input[@name='${FieldName}']   ${Text}

#*****************************************************
#*****************************************************
######   FIND/VERIFY ELEMENTS      ######
#*****************************************************
#*****************************************************

Verify A Link Named "${linkname}" Is On The Page
    wait until page contains element    xpath=//a[contains(text(),'${linkname}')]

#*****************************************************

Find "${textonpage}" On Webpage
    page should contain    ${textonpage}

#*****************************************************

Find "${AgentID}" in the Results List
    element should be visible    xpath=//a[@href="javascript:showAgentReports('${AgentID}')"]

#*****************************************************

