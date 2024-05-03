*** Settings ***
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         DateTime
Library                         String


*** Variables ***


*** Test Cases ***
Bevline App
    [Documentation]             This is to Validate Bevline App
    [Tags]                      Bevline App
    Login
    Home
    Login As ISR          Regina Peters
    Verify Home page for ISR
    Create Task ISR
    Verify tab order on Account
    Draft Beer Calculator
    Packaged Beer Calculator
    Spirit Calculator
    Create Order within 7 days
    Create Future Order
    Create Order on a Case
    Select the first Case
    ClickText             Create NCR
    ${DBARand}=           Generate Random String      6                         [LOWER]
    ${FirstRand}=         Generate Random String      6                         [LOWER]
    ${LastRand}=          Generate Random String      6                         [LOWER]
    Create NCR as ISR     DBAName=${DBARand}          firstName=${FirstRand}    lastName=${LastRand}    requestedFor=Charles Kirk                             BU=FDI                    selltype=House Account
    VerifyText            Awaiting Manager Approval