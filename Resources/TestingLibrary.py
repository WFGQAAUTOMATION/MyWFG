from robot.libraries.BuiltIn import BuiltIn


def is_checked(self, driver, item):
    checked = driver.execute_script(("return document.getElementById('%s').checked") % item)
    return checked

def check_opt_in_button(buttonoption):
    result = "Nothing"
    if buttonoption == "Opt-In":
        print buttonoption
        result = buttonoption
        return result
    elif buttonoption == "Opt-Out":
        print buttonoption
        result = buttonoption
        return result

def title_should_start_with(expected):
    seleniumlib = BuiltIn().get_library_instance('SeleniumLibrary')
    title = seleniumlib.get_title()
    if not title.startswith(expected):
        raise AssertionError("Title '%s' did not start with '%s'"
                             % (title, expected))

def print_hello_world(yourname,myname):

    print "I want to make sure that I use my function"
    print "Hello", myname
    print
    a = 10
    b = 10
    icount = 0
    bcount = 0

    if a==b:
        print "a = b and my number is %s " % (a+b)
    else:
        print "a <> b and my number is %s " % (a+b)

    print
    while icount < a:
        print "My numbers in While loop are", icount,  "and ", bcount

        icount += 1
        bcount = icount + 5

    print
    print "My name is", yourname
    print

    for i in range(7):
        print "My number is",i

    print
    myword = "Learning Python!"
    newword = ""
    for letter in myword:
        if letter != " ":
            newword = newword + letter
        else:
            newword = newword + " MY "
    print newword

print_hello_world("Tim Coffey", "Isabella Fayner")