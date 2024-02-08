*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime
Library                String


*** Variables ***


*** Test Cases ***
Command Center for FSR
    [Documentation]    This is to Validate Command Center
    [Tags]             Command Center
    Login
    Login As FSR       Charles Kirk
    Verify Home page for FSR
    Create Elite Survey
    Create Merch Checklist
    ClickText                   More                        Anchor=2
    ClickText                   Profit Calculator
    Draft Beer Calculator
    Packaged Beer Calculator
    Spirit Calculator
    Create Task


