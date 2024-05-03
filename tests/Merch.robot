*** Settings ***
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         DateTime
Library                         String


*** Variables ***


*** Test Cases ***
Merch App
    [Documentation]    This is to test Reyes Merch App
    [Tags]             Merch App
    Login
    Login As Merch      Ronald Starke
    Verify Home page for Merch
    Select the first Account
    Verify tabs on Account
    Create Merch Checkout with Breakage
    Sleep                 5s
    Create Merch Checkout without Breakage