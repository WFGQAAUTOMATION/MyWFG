<<<<<<< HEAD
ECHO
call pybot --outputdir Gherkin_Login_Results.html "C:\Jenkins_Files\Test_Cases\01-Login\*.robot"
call pybot --outputdir Verify_Exec_Leadership_Results.html "C:\Jenkins_Files\Test_Cases\02-Homepage\*.robot"
::call pybot --outputdir Verify_Exec_Leadership_Results.html "C:\Jenkins_Files\Test_Cases\09-LifeLine_Footer\LifeLine_Dates_Verification_New_IAR_Training_Course.robot"
::call pybot --outputdir Valid_Login_Results.html "C:\Jenkins_Files\Test_Cases\01-Login\MyWFG_Valid_Login.robot"
=======
ECHO
::call pybot --outputdir Gherkin_Login_Results.html --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\01-Login\*.robot"
::call pybot --outputdir Verify_Exec_Leadership_Results.html --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\02-Homepage\*.robot"
::call pybot --outputdir Dashboard_Results.html --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\GitHub_Files\MyWFG_Model\Test_Cases\03-Dashboard\*.robot"
::call pybot --outputdir My_Preferences_Results.html --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\08-Profile\02-My_Preferences\*.robot"
call pybot --outputdir Lifeline_Results.html --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\09-LifeLine_Footer\*.robot"
>>>>>>> master
