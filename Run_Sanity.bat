ECHO
call pybot --outputdir Gherkin_Login_Results.html "C:\Jenkins_Files\Test_Cases\01-Login\*.robot"
call pybot --outputdir Verify_Exec_Leadership_Results.html "C:\Jenkins_Files\Test_Cases\02-Homepage\*.robot"
::call pybot --outputdir Verify_Exec_Leadership_Results.html "C:\Jenkins_Files\Test_Cases\09-LifeLine_Footer\LifeLine_Dates_Verification_New_IAR_Training_Course.robot"
::call pybot --outputdir Valid_Login_Results.html "C:\Jenkins_Files\Test_Cases\01-Login\MyWFG_Valid_Login.robot"
