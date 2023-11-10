*** Settings ***
Resource                  ../resources/common.robot
Suite Setup               Setup Browser
Suite Teardown            End suite


*** Test Cases ***

Create Order
    [Documentation]       This is to create Task
    [Tags]                Tasks
    Login
    Home
    Login As ISR          Regina Peters
    Create Task
