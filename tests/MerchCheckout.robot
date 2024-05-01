*** Settings ***
Resource                  ../resources/common.robot
Suite Setup               Setup Browser
Suite Teardown            End suite
Library                   DateTime
Library                   String


*** Variables ***


*** Test Cases ***
Create MerchCheckout with and without Breakage
    [Documentation]       This is to create Merch Checkout
    [Tags]                Merch Checkout
    Login
    Login As Merch        Ronald Starke
    Select the first Account
    Create Merch Checkout with Breakage
    Sleep                 5s
    Create Merch Checkout without Breakage
