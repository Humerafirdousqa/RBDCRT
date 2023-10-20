*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime
Library                String


*** Variables ***


*** Test Cases ***
Create FailedScan
    [Documentation]    This is to create Failed Scan
    [Tags]             Failed Scan
    Login
    Login As FSR       Charles Kirk
    Create Failed Scan
