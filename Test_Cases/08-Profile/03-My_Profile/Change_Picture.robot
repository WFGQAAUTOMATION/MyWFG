*** Settings ***
Documentation    A test suite to upload or change the photo on Profile page
...
...               This test will log into MyWFG, open Profile menu and
...               upload or change profile photo
Metadata          Version   0.1
Resource          ../../../Resources/Resource_Login.robot
Resource          ../../../Resources/Resource_Webpage.robot
Library           ../../../Resources/TestingLibrary.py
Library           Selenium2Library


Suite Teardown     Close Browser

*** Test Cases ***

Login to MyWFG.com
    Given browser is opened to login page
    When user "${USER ID}" logs in with password "${PASSWORD}"
    Then Home Page Should Be Open
    sleep   4s

Go to Profile My Profile Page
    Hover Over "Profile"
    sleep   2s
    Click Menu Item "My Profile"
    sleep   2s

Verify Webpage
    sleep   2s
    Find "My Profile" On Webpage

Click Delete Photo button for Cancel
    Click Object Named "Delete Photo"

Confirm Cancel to keep the picture
    Click Cancel on Alert

Click Delete Photo button
    click element   //a[@id='agentimage-delete']

Confirm Delete to delete the picture
    sleep    2s
    Click Ok on Alert

Click Upload Photo button for OK
    sleep   2s
    Click button named "Upload Photo"

Click OK button
    sleep   2s
    Click element   xpath=//span[@class="ui-button-text"][contains(text(),'Ok')]

Click Upload Photo button for Cancel
    sleep   2s
    Click Button named "Upload Photo"

Select Frame for Cancel
    select frame where id is "agentImageUploaderContainer"

Click Cancel button
    click button named "Cancel"

Click Upload Photo button
    sleep   2s
    Click Button named "Upload Photo"

Select Frame for Continue
    select frame where id is "agentImageUploaderContainer"

Click Agree checkbox
    select checkbox where id is "chkAgree"

Click Continue button
    click button named "Continue"

Click Browse button
    Click image where ID is "Image"
    sleep    10   # when sleeps choose the file from File Uploader and close it

Click Upload button
    Click button named "Upload"

Click Continue and confirm upload
    Click button named "Continue"

Close Uploader
    Click image where ID is "dialogClose"

Log Out of MyWFG
    sleep   1s
    Log Out of MyWFG


*** Keywords ***


