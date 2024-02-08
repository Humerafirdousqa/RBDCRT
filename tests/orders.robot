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
    Create Order on a Case


