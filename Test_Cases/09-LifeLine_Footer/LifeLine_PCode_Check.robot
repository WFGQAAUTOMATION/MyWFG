*** Settings ***
Documentation     A test suite to verify MyWFG LifeLine PCode Descriptions
...               The purpose of this test is to find LifeLine records with PCode numer in Description field
...               and  create error report
Metadata          Version   0.1
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary

*** Variables ***
${P_Code1}          P0
${P_Code2}          PA
${P_Code3}          PB
${P_Code4}          PC
${P_Code5}          PD
${P_Code6}          PI
${P_Code7}          PM
${P_Code8}          PZ
${P_CompName}      'PAC','PAN','PAR','PAU','PAY','PIL','PIM','PIN','PIO'
${NotID}    6

*** Test Cases ***
Connect from Python file
    Database_Library.LifeLine_PCodes    ${NotID}    ${P_Code1}    ${P_Code2}    ${P_Code3}    ${P_Code4}    ${P_Code5}    ${P_Code6}    ${P_Code7}    ${P_Code8}   ${P_Compname}

