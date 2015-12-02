from robot.libraries.BuiltIn import BuiltIn


def check_opt_in_option(passed):
    print passed
    if passed is True:
        opt_in_result = "Enabled"
        print "My button option is - ", opt_in_result
        return opt_in_result
    elif passed is False:
        opt_in_result = "Disabled"
        print "My button option is - ", opt_in_result
        return opt_in_result
    else:
        print "This is Else option"
        opt_in_result = "My button option is Else"
    print "Printing on Python side - ", opt_in_result
    return opt_in_result


def check_opt_in_button(button_option):
    print button_option
    if button_option == "Opt_Out":
        opt_in_result = button_option
        print "My button option should be Opt-Out -", button_option
        return opt_in_result
    elif button_option == "Opt_In":
        print button_option
        opt_in_result = "My button option should be Opt-In - ", button_option
        return opt_in_result
    else:
        print "This is Else option"
        opt_in_result = "My button option should be Else - ", button_option
    print "Printing on Python side - ", button_option
    return opt_in_result


def check_1099_misc_button(button_id, button_style):
    if button_id == "showChangeIsElectronic1099OptIn" and button_style == "display: inline":
        button_name = "Opt In"
        return button_name
    elif button_id == "showChangeIsElectronic1099OptIn" and button_style == "display: none":
        button_name = "None"
        return button_name
    elif button_id == "showChangeIsElectronic1099OptOut" and button_style == "display: inline":
        button_name = "Opt Out"
        return button_name
    elif button_id == "showChangeIsElectronic1099OptOut" and button_style == "display: none":
        button_name = "None"
        return button_name


def title_should_start_with(expected):
    selenium_lib = BuiltIn().get_library_instance('SeleniumLibrary')
    title = selenium_lib.get_title()
    if not title.startswith(expected):
        raise AssertionError("Title '%s' did not start with '%s'"
                             % (title, expected))


def temperature_calculations(convert_from, convert_to, temp_value):
    result = 0
    if convert_from == "F":
        result = (int(temp_value) - 32) * 5 / 9

    elif convert_from == "C":
        result = 1.8 * int(temp_value) + 32

    print "This is calculator"
    print "Convert ", temp_value, " from ", convert_from, "to ", convert_to
    print "This is my result ", result

    return result


def print_hello_world(your_name, my_name):
    if your_name == "Jane":
        print "This is If ", your_name
    elif your_name == "Rita":
        print "This is Else If ", your_name
    else:
        print "This is Else part again"

    print "I want to make sure that I use my function"
    print "Hello", my_name
    print
    a = 10
    b = 10
    i_count = 0
    b_count = 0

    if a == b:
        print "a = b and my number is %s " % (a + b)
    else:
        print "a <> b and my number is %s " % (a + b)

    print
    while i_count < a:
        print "My numbers in While loop are", i_count, "and ", b_count

        i_count += 1
        b_count = i_count + 5

    print
    print "My name is", your_name
    print

    for i in range(7):
        print "My number is", i

    print
    my_word = "Learning Python!"
    new_word = ""
    for letter in my_word:
        if letter != " ":
            new_word += letter
        else:
            new_word += " MY "
    print new_word
