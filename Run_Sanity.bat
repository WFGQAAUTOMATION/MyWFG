ECHO
::set Pathname="C:\Jenkins_Files"
::cd /d %Pathname%
call pybot --outputdir Login_Log --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\01-Login\*.robot"
::call pybot --outputdir Verify_Home_Log --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\02-Homepage\*.robot"
::call pybot --outputdir Dashboard_Results_Log --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\03-Dashboard\*.robot"
::call pybot --outputdir My_Preferences_Log --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\08-Profile\02-My_Preferences\*.robot"
::call pybot --outputdir Lifeline_Log --variablefile C:\Jenkins_Files\Variable_Files\Model_Variables.py "C:\Jenkins_Files\Test_Cases\09-LifeLine_Footer\*.robot"
