*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime
Library                String


*** Variables ***


*** Test Cases ***
Create Elite Survey
    [Documentation]    This is to create Elite Survey
    [Tags]             Elite Survey
    Login
    Login As FSR       Charles Kirk
    Create Elite Survey

