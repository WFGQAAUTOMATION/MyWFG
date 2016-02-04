*** Settings ***
Library           Selenium2Library

*** Test Cases ***
#Manipulate Multiple Windows
#    [Tags]    MultiWindow
#    Open Browser    http://robotframework.org    gc
#    Maximize Browser Window
#    ${Window1Title}=    Get Title
#    Wait Until Element Is Visible    css=div.button.orange    10s
#    Click Element    css=div.button.orange
#    Wait Until Element Is Visible    link=Builtin
#    Click Element    link=Builtin
##        This is a new Window
#    Sleep    3s
#    Select Window    Title=Robot Framework documentation
#    Wait Until Element Is Visible    //button[@value='BuiltIn']
#    Click Element    //button[@value='BuiltIn']
#    Sleep    3s
#    Select Window    Title=Builtin
#    Sleep    3s
#    Close Window
##    Comment    Go back to the first window
#    Sleep    3s
#    Select Window    Title=${Window1Title}
#    Page Should Contain Element    link=Builtin
#    sleep    3s
#    Close Window
##    Close Browser

Manipulate Multiple Windows
    [Tags]    MultiWindow
    Open Browser    http://robotframework.org    gc
    Maximize Browser Window
    ${Window1Title}=    Get Title
    Wait Until Element Is Visible    css=div.button.green    10s
    Click Element    css=div.button.green
    Wait Until Element Is Visible    link=User Guide
    Click Element    link=User Guide
#        This is a new Window
    Sleep    3s
    Select Window    Title=Robot Framework documentation
    Wait Until Element Is Visible    //button[@value='DateTime']
    Click Element    //button[@value='DateTime']
    Sleep    3s
    Select Window    Title=DateTime
    Sleep    3s
    Close Window
#    Comment    Go back to the first window
    Sleep    3s
    Select Window    Title=${Window1Title}
    Page Should Contain Element    link=User Guide
    sleep    3s
    Close Window
#    Close Browser
