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
#${BROWSER}           ff
#${DELAY}             0
#${VALID USER}        1200W
#${VALID PASSWORD}    81u3$ky
#${LOGIN URL}         https://${SERVER}/Users/Account/AccessDenied?ReturnUrl=%2f
#${WELCOME URL}       https://${SERVER}/
#${ERROR URL}         https://${SERVER}/Users/Account/LogOn?ReturnUrl=%2F

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

#*********************************************************************

Click OK Button On Java Dialog
    Execute JavaScript    window.close()
#    driver.findelement(By.xpath("//span[@class="ui-button-text"][contains(text(),'Ok')]")).click();

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

Click Link With ID "${LinkID}"
    click link    xpath=//a[@id='${LinkID}']

#***************************************************************

Input "${Text}" in The "${FieldName}" Field
    input text  xpath=//input[@name='${FieldName}']   ${Text}

#***************************************************************

Input "${Text}" in the "${Fieldname}" Field With ID
    input text  xpath=//input[@id='${FieldName}']   ${Text}

#************************************************************************

Select Checkbox Where ID is "${cbName}"
    select checkbox     xpath=//input[@id='${cbName}']

#************************************************************************

Select Frame Where ID is "${frameID}"
    log  ${frameID}
    select frame    xpath=//iframe[@id='${frameID}']

#************************************************************************

Click List Box Named "${SelectItem}" and select "${Item}"
    Select From List     xpath=//select[@name='${SelectItem}']  ${Item}

#*************************************************************************

Click List Box With ID "${ItemID}" and select "${Item}"
    Select From List     xpath=//select[@id='${ItemID}']  ${Item}

#*************************************************************************

Click List Box With ID "${ItemID}" and select by index "${Index}"
    Select From List By Index    xpath=//select[@id='${ItemID}']  ${Index}

#*************************************************************************
Click image where ID is "${ImageID}"
    click image     xpath=//input[@id='${ImageID}']

#**************************************************************************

Click iamge named "${Image}"
    click image     xpath=//input[@name='${Image}']

#*****************************************************

Click image using img where ID is "${ImageID}"
    click image     xpath=//img[@id='${ImageID}']

#*****************************************************

Click Ok on Alert
    confirm action

#*****************************************************

Click Cancel on Alert
     Choose Cancel On Next Confirmation
     sleep      3
     confirm action

#*****************************************************
######   FIND/VERIFY ELEMENTS      ######
#*****************************************************
#*****************************************************

Verify A Link Named "${linkname}" Is On The Page
    wait until page contains element    xpath=//a[contains(text(),'${linkname}')]   30s

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

Find text on the page
    Page Should Contain Element    xpath=//
                                   .//*[@id='DueDate-10379399']

#*********************************************************************************

Find Element on the Page "${element_id}"
    Page Should Contain Element    xpath=.//*[@id='${element_id}']

#*********************************************************************************

Zoom out to "${zoomLevel}" (percentage)
	Execute javascript  document.body.style.zoom="${zoomLevel}"

#*********************************************************************************
Elements should be equal ${SQL_Text} ${Webpage_Text}
    Should be equal    ${SQL_Text}    ${Webpage_Text}

#*************************************************************************************

Verify element parameters
#//*[@type='button'][@class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"]
