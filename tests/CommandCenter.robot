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

Command Center for ISR
    [Documentation]    This is to Validate Command Center
    [Tags]             Command Center
    Login
    Login As ISR       Regina Peters
    Verify Home page for ISR
    

Command Center for Merch
    [Documentation]    This is to Validate Command Center
    [Tags]             Command Center
    Login
    Login As Merch      Ronald Starke
    Verify Home page for Merch