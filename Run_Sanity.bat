ECHO
::call pybot --outputdir Gherkin_Login_Results --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\01-Login\*.robot"
::call pybot --outputdir Verify_Exec_Leadership_Results --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\02-Homepage\*.robot"
call pybot --outputdir Dashboard_Results --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\03-Dashboard\*.robot"
::call pybot --outputdir My_Preferences_Results.html --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\08-Profile\02-My_Preferences\*.robot"
::call pybot --outputdir Lifeline_Results.html --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\09-LifeLine_Footer\*.robot"
