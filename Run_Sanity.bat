ECHO
call pybot --outputdir Login_Log --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\01-Login\*.robot"
::call pybot --outputdir Logs_Verify_Home --variablefile C:\Jenkins_Files\Variable_Files\Dev_Variables.py "C:\Jenkins_Files\Test_Cases\02-Homepage\*.robot"
::call pybot --outputdir Logs_Dashboard_Results --variablefile C:\Jenkins_Files\Variable_Files\Dev_Variables.py "C:\Jenkins_Files\Test_Cases\03-Dashboard\*.robot"
::call pybot --outputdir Logs_My_Preferences --variablefile C:\Jenkins_Files\Variable_Files\Dev_Variables.py "C:\Jenkins_Files\Test_Cases\08-Profile\02-My_Preferences\*.robot"
::call pybot --outputdir Logs_Lifeline --variablefile C:\Jenkins_Files\Variable_Files\Dev_Variables.py "C:\Jenkins_Files\Test_Cases\09-LifeLine_Footer\*.robot"
