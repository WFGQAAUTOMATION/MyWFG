*** Settings ***
Documentation    A test suite to verify that MyWFG LifeLine records are not duplictated
...               This test will connect to database and verify that MywFG LifeLine
...               records are not duplicated
Metadata          Version   0.1
#Resource          ../../Resources/Resource_Login.robot
#Resource          ../../Resources/Resource_Webpage.robot
#Library           ../../Resources/Testing_Library.py
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary
#Library           ExcelLibrary

*** Variables ***
${DATABASE}       WFGOnline
${HOSTNAME}       CRDBCOMP03\\CRDBWFGOMOD
${AGENT_ID}
${Current_DIR}    O:/BusinessSupport/QA_Automation/Testing/Isabella/MyWFG/Test_Cases/09-LifeLine_Footer
${Testing_DIR}    C:/PERSONAL/SELENIUM/TESTING_FOLDER

*** Test Cases ***
Connect from Python file
    ${mydata}   Database_Library.count_total_notifications
    Database_Library.LifeLine_Records_Duplications    ${mydata}
