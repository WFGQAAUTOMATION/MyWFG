*** Settings ***
Documentation     A test suite to verify MyWFG LifeLine IUL and Annuity Courses Yellow Notifications
...
...               The purpose of this test is to verify that MyWFG LifeLine IUL Course and Annuity Course Notifications
...               are never displayed in Yellow Life Line section
Metadata          Version   0.1
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary

*** Variables ***
${Notification1}    11
${Notification2}    12

*** Test Cases ***
Connect from Python file
    Database_Library.LifeLine_UIL_Annuity_Yellow_Notifications    ${Notification1}    ${Notification2}