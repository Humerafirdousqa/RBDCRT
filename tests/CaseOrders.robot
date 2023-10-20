*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***

Create Order on a Case
    [Documentation]    This is to create order from a case
    [Tags]             Orders
    Login
    Home
    Login As ISR           Regina Peters
    sleep                  5s
    Create Order on a Case

