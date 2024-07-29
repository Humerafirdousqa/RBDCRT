*** Settings ***
Library    QWeb
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         DateTime
Library                         String


*** Variables ***


*** Test Cases ***
Reyes Beverages App
    [Documentation]             This is to Validate Reyes Beverages App
    [Tags]                      Reyes Beverages App
    Login
    Login As FSR                Charles Kirk
    Verify Home page for FSR
    #ClickText             Show menu    Anchor=2
    ClickText             New Customer Request    Anchor=2        anchor=Live Order
    ${DBARand}=           Generate Random String      6                         [LOWER]
    ${FirstRand}=         Generate Random String      6                         [LOWER]
    ${LastRand}=          Generate Random String      6                         [LOWER]
    #ClickText             New Customer Request
    SwitchWindow          NEW
    Create NCR as FSR     DBAName=${DBARand}          firstName=${FirstRand}    lastName=${LastRand}    BU=FDI    selltype=House Account
    VerifyText            Awaiting Manager Approval
    Create Elite Survey
    Create Data Driven Survey
    Create Merch Checklist
    ClickText                   More                        Anchor=2
    ClickText                   Profit Calculator
    Draft Beer Calculator
    Packaged Beer Calculator
    Spirit Calculator
    Create Failed Scan
    Create Task FSR
    View and Download Invoice
