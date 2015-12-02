*** Settings ***
Documentation     A test suite containing tests related to teams in search.
...
...               These tests go through all the team levels and see if results are returened
Metadata          Version   0.1
Resource          ../../../Resources/Resource_Login.robot
Resource          ../../../Resources/Resource_Webpage.robot
Library           ../../../Resources/TestingLibrary.py
#Suite Setup       Log Into MyWFG.com
#Test Template     Select The Team and Click Search
#Test Setup        Go To Login Page
#Suite Teardown    Close Browser

#This is an example of Data Driven Testing (DDD)

*** Test Cases ***               #User Name        Password
Test1
    #find_element_by_name('Butter').isSelected()
    ${color} =  set variable  Red
    log to console  ${color}
    Run Keyword If  '${color}' == 'Red'  log to console  \nexecuted with single condition
    #Run Keyword If  '${color}' == 'Red' or '${color}' == 'Blue' or '${color}' == 'Pink'  log to console  \nexecuted  with multiple or


Test2
    ${color} =  set variable  Blue
    ${Size} =  set variable  Small
    ${Simple} =  set variable  Simple
    ${Design} =  set variable  Complex
    log to console  ${color}
    log to console  ${Size}
    log to console  ${Simple}
    log to console  ${Design}
    Run Keyword If  '${color}' == 'Blue' and '${Size}' == 'Small' and '${Design}' != '${Simple}'  log to console  \nexecuted with multiple and

Test3
    ${color} =  set variable  Blue
    ${Size} =  set variable  XL
    ${Design} =  set variable  Complex
    log to console  ${color}
    log to console  ${Size}
    log to console  ${Design}
    Run Keyword Unless  '${color}' == 'Black' or '${Size}' == 'Small' or '${Design}' == 'Simple'  log to console  \nexecuted with unless and multiple or


#Invalid Username                 invalid          ${VALID PASSWORD}
#Invalid Password                 ${VALID USER}    invalid
#Invalid Username And Password    invalid          whatever
#Empty Username                   ${EMPTY}         ${VALID PASSWORD}
#Empty Password                   ${VALID USER}    ${EMPTY}
#Empty Username And Password      ${EMPTY}         ${EMPTY}

*** Keywords ***
#High level keywords will take arguments (parameters)
Select The Team and Click Search


Log Into MyWFG.com
    Open Browser To Login Page
    user "1708W" logs in with password "${VALID PASSWORD}"