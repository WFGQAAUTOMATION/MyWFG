*** Settings ***
Documentation     A test suite to verify MyWFG LifeLine PCode Descriptions
...
...               The purpose of this test is to find LifeLine records with PCode numer in Description field
...               and  create error report
Metadata          Version   0.1
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary

*** Variables ***
${Notification_ID}    6
${P_Codes}      'PO','PA','PB','PC','PD','PI','PM','PZ'
${PComp_Name}    'PAC','PAN','PAR','PAU','PAY','PIL','PIM','PIN','PIO'


*** Test Cases ***
Connect from Python file

    Database_Library.LifeLine_PCodes    ${Notification_ID}    ${P_Codes}    ${PComp_Name}    ${HOSTNAME}    ${WFG_DATABASE}


