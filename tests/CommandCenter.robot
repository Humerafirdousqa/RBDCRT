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
    Verify Command Center for FSR

Command Center for ISR
    [Documentation]    This is to Validate Command Center
    [Tags]             Command Center
    Login
    Login As FSR       Regina Peters
    Verify Command Center for ISR
    

Command Center for Merch
    [Documentation]    This is to Validate Command Center
    [Tags]             Command Center
    Login
    Login As Merch      Ronald Starke
    Verify Command Center for Merch