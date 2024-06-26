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
