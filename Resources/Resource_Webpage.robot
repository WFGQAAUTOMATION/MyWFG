*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library
Library           Testing_Library.py

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

Click Menu Item "${menuitem}"
    Click Link    //a[contains(text(),'${menuitem}')]

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

Scroll Page to Location
    [Arguments]    ${x_location}    ${y_location}
    Execute JavaScript    window.scrollTo(${x_location},${y_location})

#*********************************************************************

Scroll Page to Location Where Y equals "${y_location}"
    Execute JavaScript    window.scrollTo(0,${y_location})

#********************************************************************

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

Click Button using style "${buttonstyle}"
    click button    xpath=//button[@style='${buttonstyle}']

#*****************************************************

Click Button using id "${buttonid}"
    click button    xpath=//button[@id='${buttonid}']

#*****************************************************

Click Link Named "${clicklick}"
    click link    xpath=//a[(text()='${clicklick}')]

#*****************************************************

Click Link With Name Contained "${clicklink}"
    click link    xpath=//a[contains(text(),'${clicklink}')]

#***************************************************************

Input "${Text}" in The "${FieldName}" Field
    input text  xpath=//input[@name='${FieldName}']   ${Text}

#***************************************************************

Input "${Text}" in the "${Fieldname}" Field With ID
    input text  xpath=//input[@id='${FieldName}']   ${Text}

#************************************************************************

Select Frame Where ID is "${frameID}"
    log  ${frameID}
    select frame    xpath=//iframe[@id='${frameID}']

#************************************************************************

Select Checkbox Where ID is "${cbName}"
    select checkbox     xpath=//input[@id='${cbName}']

#************************************************************************

Click List Box Named "${SelectItem}" and select "${Item}"
    Select From List     xpath=//select[@name='${SelectItem}']  ${Item}

#*************************************************************************

Click List Box With ID "${ItemID}" and select "${Item}"
    Select From List     xpath=//select[@id='${ItemID}']  ${Item}

#*************************************************************************

Click image where ID is "${ImageID}"
    click image     xpath=//input[@id='${ImageID}']

#**************************************************************************

Click iamge named "${Image}"
    click image     xpath=//input[@name='${Image}']

#*****************************************************

Click image using img where ID is "${ImageID}"
    click image     xpath=//img[@id='${ImageID}']

#**************************************************************************

Select "${team}" from dropdown
    click button    xpath=//td[2]/button
#    Wait Until Element Is Visible   xpath=//*[@id='generationField']    timeout=15
#    ${clickthis} =      Set Variable        ${team}
#    Run Keyword If    "${clickthis}" == "Base"
     select from list by value  xpath=//*[@id='generationField']/option[text()='Base']  ${team}

#    If ${team} == "Base"
#        Click //input[@id='ui-multiselect-generationField-option-0']
#    Elif ${team} == "Super Base"
#        Click //input[@id='ui-multiselect-generationField-option-1']
#    Elif ${team} == "Super Team"
#        Click //input[@id='ui-multiselect-generationField-option-2']
#    Elif ${team} == "Securities"
#        Click //input[@id='ui-multiselect-generationField-option-3']
#    Elif ${team} == "WFG Terminated"
#        Click //input[@id='ui-multiselect-generationField-option-4']
#    Else:
#        Click //input[@id='ui-multiselect-generationField-option-5']

#**************************************************************************
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

Verify Title on the page "${titlename}"
    Title Should Be     ${titlename}

#*****************************************************

Click Ok on Alert
    confirm action

#*****************************************************

Click Cancel on Alert
     Choose Cancel On Next Confirmation
     sleep      3
     confirm action

#*********************************************************************************

Verify element parameters

#//*[@type='button'][@class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"]