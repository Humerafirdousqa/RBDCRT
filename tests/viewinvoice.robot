*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime
Library                String


*** Variables ***


*** Test Cases ***
View Invoice
    [Documentation]    This is to create MerchChecklist
    [Tags]             Merch Checklist
    Login
    Login As FSR       Charles Kirk
    View and Download Invoice
    
