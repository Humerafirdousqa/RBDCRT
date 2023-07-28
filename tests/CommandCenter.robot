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
    VerifyText         Home
    VerifyText         DSOF
    VerifyText         Cases
    VerifyText         My Open Pinned Products
    VerifyText         Tasks                       Anchor=2
    VerifyText         New Customer Requests
    VerifyText         Newsletter
    VerifyText         Dashboard                   Anchor=3
    VerifyText         ELITE Dashboard
    ClickText          Show menu
    VerifyText         VIP Begin Day
    VerifyText         Live Order
    VerifyText         New Customer Request        Anchor=2
    VerifyText         Circana Portal
    VerifyText         Employee Center
    VerifyText         SipMarket Registration
    VerifyText         SipMarket Keg Box
    VerifyText         SipMarket Forgot Password
    VerifyText         Route Change Requests
    VerifyText         Training Docs
    VerifyText         Fintech Evite
    VerifyText         User Route Update
    VerifyText         Fintech                     Anchor=2

Command Center for ISR
    [Documentation]    This is to Validate Command Center
    [Tags]             Command Center
    Login
    Login As FSR       Regina Peters
    ClickText          Show Navigation Menu
    ClickText          Home
    ClickElement       xpath\=//button[@class\='slds-button slds-button_icon-border slds-button_last']
    VerifyText         Kronos
    VerifyText         Web VIP
    VerifyText         Maps - Accounts Near Me
    VerifyText         Live Order
    VerifyText         New Customer Request
    VerifyText         Cisco
    VerifyText         Route Change Requests
    VerifyText         SipMarket Registration
    ClickElement       xpath\=//button[@class\='slds-button slds-button_icon-border slds-button_last']
    VerifyText         Wall Board East
    VerifyText         Wall Board West
    VerifyText         Wall Board NA
    VerifyText         Web Board
    VerifyText         Sharepoint
    VerifyText         Employee Center
    VerifyText         Circana Portal
    VerifyText         Training Docs
    

Command Center for Merch
    [Documentation]    This is to Validate Command Center
    [Tags]             Command Center
    Login
    Login As Merch      Ronald Starke
    VerifyText         Live Order
    VerifyText         Employee Center
    VerifyText         Training Docs
    VerifyText         Fintech
    VerifyText         All Newsletters