*** Settings ***

Documentation    A test suite to click MyWFG LifeLine Archive, verify Dismiss Reason and close Archive
...
...               This test will log into MyWFG, click MyWFG Lifeline Archive link,
...               verify Dismiss Reason and closes Archive
Metadata          Version   0.1
Resource          ../../Resources/Resource_Login.robot
Resource          ../../Resources/Resource_Webpage.robot
Library           ../../Resources/Testing_Library.py
Library           ../../Resources/Database_Library.py
Library           Selenium2Library
Library           DatabaseLibrary
Library           String
Library           DateTime

Suite Teardown     Close Browser

*** Variables ***
${}
${}
${}
${}

*** Test Cases ***
