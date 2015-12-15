*** Settings ***
Documentation     A test suite to verify MyWFG LifeLine All Dates in database
...               The purpose of this test is to find LifeLine records which located
...               in the wrong notification sections or not archived on time
Metadata          Version   0.1
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary

# N O T    C O M P L E T E D !!!
*** Variables ***

*** Test Cases ***
Connect from Python file
    ${mydata}   Database_Library.Count_Total_Notifications
    Database_Library.LifeLine_Old_Dates    ${mydata}