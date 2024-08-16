*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime
Library                SeleniumLibrary

*** Test Cases ***

Menu Survey
    [Documentation]    This is test Menu Survey Functionality
    [Tags]             Surveys
    Login
    LaunchApp          Reyes Beverage Group
    Create a Menu Survey