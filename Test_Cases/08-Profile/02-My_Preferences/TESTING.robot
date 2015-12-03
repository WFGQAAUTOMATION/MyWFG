*** Settings ***
Documentation    A practice suite to test new stuff
...
Metadata          Version   0.1
Resource          ../../../Resources/Resource_Login.robot
Resource          ../../../Resources/Resource_Webpage.robot
Library           Selenium2Library
Library           BuiltIn

Test Teardown

*** Test Cases ***

Library Testing
    Testing_Library.Print Hello World    Rita    Jane

Testing functions 1
    ${button}=    check_opt_in_button     Opt_In
    log     "My button " ${button}

Testing functions 2
    ${button}    check_opt_in_button     Opt_Out
    log     "My button " ${button}

Temperature Calculations 1
    temperature_calculations    F    C    32

Temperature Calculations 2
    temperature_calculations    F    C    -40

Temperature Calculations 3
    temperature_calculations    C    F    0

Temperature Calculations 4
    temperature_calculations    C    F    -40

Verify Temperature F to C Conversion
    ${result} =     Convert temperature F To C    32
     Should Be Equal     ${result}   ${0}
     log     'My temperature is ' ${result}

Verify Temperature C to F Conversion
    ${result} =     Convert temperature C To F    0
    Should Be Equal     ${result}   ${32}
    log     'My temperature is ' ${result}

Verify Temperature C to F
    ${result} =     Convert temperature C To F    -40
    Should Be Equal     ${result}       ${-40}
    log     "My temperature is " ${result}

Verify Temperature F to C
    ${result} =     Convert temperature F To C    -40
    Should Be Equal     ${result}       ${-40}
    log     "My temperature is " ${result}

Call custom keyword and get result
    ${results} =     mykeyword    125
    log  ${results}

Return Numeric Value
    ${ret} =    Return Numeric Value    125
    log    ${ret}

Return String Value
    ${ret} =    Return String Value    "125"
    log    ${ret}

*** Keywords ***

mykeyword
    [Arguments]     ${input}
    ${string}=      set variable        the string is "${input}"
    [return]    ${string}

Convert temperature C To F
    [Arguments]     ${ctemp}
    ${ctemp} =      Convert To Number     ${ctemp}
    ${ftemp} =      Evaluate    1.8 * ${ctemp} + 32
    [return]    ${ftemp}

Convert temperature F To C
    [Arguments]   ${ftemp}
    ${ftemp} =    Convert To Number   ${ftemp}
    ${ctemp} =    Evaluate    (${ftemp} - 32) * 5 / 9
    [return]  ${ctemp}

Return Numeric Value
    [Arguments]  ${MyNo}
    ${MyNo} =      Convert To Number   ${MyNo}
    ${MyNewNo} =   Evaluate    ${MyNo} + ${MyNo}
    Return From Keyword     ${MyNewNo}

Return String Value
    [Arguments]   ${arg}
    ${arg} =      Convert To String   ${arg}
    ${mystr} =    Evaluate      ${arg}
    Return From Keyword    "My string is " + ${mystr}



