*** Settings ***
Resource                  ../resources/common.robot
Suite Setup               Setup Browser
Suite Teardown            End suite


*** Test Cases ***

Create Order within 7 Days
    [Documentation]       This is to create order
    [Tags]                Orders
    Login
    #Home
    Login As ISR          Regina Peters
    Create Order within 7 days
    

Create Future Order
    [Documentation]    This is to create Future Order
    [Tags]             Orders
     Login
    #Home
    Login As ISR          Regina Peters
    Create Future Order    
    


