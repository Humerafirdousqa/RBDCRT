*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime
Library                SeleniumLibrary

*** Test Cases ***

Draft Beer Calculator
    [Documentation]    This is to test Draft Profit Calculator Functionality
    [Tags]             Profit Calculator
    Login
    Login As FSR       Charles Kirk
    Select the first Account
    ClickText          Profit Calculator
    Draft Beer Calculator

Packaged Beer Calculator
    [Documentation]    This is to test Packaged Beer Profit Calculator Functionality
    [Tags]             Profit Calculator
    Login
    Login As FSR       Charles Kirk
    Select the first Account
    ClickText          Profit Calculator
    ClickText          Packaged Calculator
    Packaged Beer Calculator

Spirit Calculator
    [Documentation]    This is to test Spirit Calculator
    [Tags]             Profit Calculator
    Login
    Login As FSR       Charles Kirk
    Select the first Account
    ClickText          Profit Calculator
    Spirit Calculator