*** Settings ***
Resource                  ../resources/common.robot
Suite Setup               Setup Browser
Suite Teardown            End suite
Library                   DateTime
Library                   String


*** Variables ***


*** Test Cases ***

Create NCR from a Case
    [Documentation]       This is to create NCR
    [Tags]                NCR
    Login
    Login As ISR          Regina Peters
    Select the first Case
    ClickText             Create NCR
    ${DBARand}=           Generate Random String      6                         [LOWER]
    ${FirstRand}=         Generate Random String      6                         [LOWER]
    ${LastRand}=          Generate Random String      6                         [LOWER]
    Create NCR as ISR     DBAName=${DBARand}          firstName=${FirstRand}    lastName=${LastRand}    requestedFor=Charles Kirk                             BU=FDI                    selltype=House Account
    VerifyText            Approved
    

Create NCR as an FSR
    [Documentation]       This is to create NCR
    [Tags]                NCR
    Login
    Login As FSR          Charles Kirk
    ClickText             Show menu
    ClickText             New Customer Request    Anchor=2        anchor=Live Order
    ${DBARand}=           Generate Random String      6                         [LOWER]
    ${FirstRand}=         Generate Random String      6                         [LOWER]
    ${LastRand}=          Generate Random String      6                         [LOWER]
    #ClickText             New Customer Request
    SwitchWindow          NEW
    Create NCR as FSR     DBAName=${DBARand}          firstName=${FirstRand}    lastName=${LastRand}    BU=FDI    selltype=House Account
    VerifyText            Awaiting Manager Approval

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


