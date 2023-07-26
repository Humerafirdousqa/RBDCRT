*** Settings ***
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite


*** Test Cases ***

Create Order within 7 Days
    [Documentation]             This is to create order
    [Tags]                      Orders
    Login
    Login As ISR                Regina Peters
    Create Order within 7 days


Create Future Order
    [Documentation]             This is to create Future Order
    [Tags]                      Orders
    Login
    Login As ISR                Regina Peters
    Create Future Order

Create Order from SipMarket
    [Documentation]             This is to create Order from SipMarket
    [Tags]                      Orders
    GoTo                        https://preprod.sipmarket.com/en/login/
    ClickText                   Yes, continue
    TypeText                    Email or Username           MiggyPop
    TypeSecret                  Password                    Beer1234
    ClickText                   SIGN IN                     anchor=Password
    ClickText                   LEE Distributors Charleston
    ClickText                   CODFATHER PROPER FISH AND (HJL)                         anchor=Sign In
    ClickText                   Shop Now                    anchor=Insights
    ClickText                   +                          anchor=24 - 12oz Cans, 12 Pack
    Sleep                       3s
    ClickText                   Add to Cart
    ClickText                   1
    DropDown                    Delivery Date               8/1/23
    ClickText                   Submit your order
    VerifyText                  Order Confirmation
    Login
    Login As ISR                Regina Peters
    ClickText                   Accounts
    ClickText                   CODFATHER PROPER FISH AND
    ClickText                   Show All
    ClickText                   Orders



