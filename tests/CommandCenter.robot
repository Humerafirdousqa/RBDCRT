*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime
Library                String


*** Variables ***


*** Test Cases ***
Command Center for FSR
    [Documentation]    This is to create MerchChecklist
    [Tags]             Merch Checklist
    Login
    Login As FSR       Charles Kirk
    VerifyText         Home
    VerifyText         DSOF
    VerifyText         Cases
    VerifyText         My Open Pinned Products
    VerifyText         Tasks
    VerifyText         New Customer Requests
    VerifyText         Newsletter
    VerifyText         Dashboard
    VerifyText         ELITE Dashboard
    ClickText          Show menu
    VerifyText         VIP Begin Day
    VerifyText         Live Order
    VerifyText         New Customer Request
    VerifyText         Circana Portal
    VerifyText         Employee Center
    VerifyText         SipMarket Registration
    VerifyText         SipMarket Keg Box
    VerifyText         SipMarket Forgot Password
    VerifyText         Route Change Requests
    VerifyText         Training Docs
    VerifyText         Fintech Evite
    VerifyText         User Route Update
    VerifyText         Fintech