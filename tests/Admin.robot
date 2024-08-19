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
Create NCR as FSR Manager
    [Documentation]       This is to create NCR
    [Tags]                NCR
    Login
    Home
    Login As FSR          Jason Wieland
    ClickText             New Customer Request        anchor=Live Order
    ${DBARand}=           Generate Random String      6                         [LOWER]
    ${FirstRand}=         Generate Random String      6                         [LOWER]
    ${LastRand}=          Generate Random String      6                         [LOWER]
    ClickText             New Customer Request        index=2
    SwitchWindow          NEW
    Create NCR as FSR     DBAName=${DBARand}          firstName=${FirstRand}    lastName=${LastRand}    BU=FDI                      selltype=House Account
    VerifyText            Approved
    sleep                 10m
    RefreshPage
    VerifyText            Submitted to DMO
