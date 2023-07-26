*** Settings ***
Resource                  ../resources/common.robot
Suite Setup               Setup Browser
Suite Teardown            End suite


*** Test Cases ***

Create Order
    [Documentation]       This is to create order
    [Tags]                Orders
    Login
    Home
    Login As ISR          Regina Peters
    Home
    ClickText             Minimize
    ClickText             Show Navigation Menu
    ClickText             Accounts                    Anchor=Home
    ClickElement          xpath=(//a[@data-refid\="recordId"])[1]
    ClickText             More
    ClickText             Critical Minute
    ClickText             New Task
    DropDown              None                        Call
    ClickText             Next                        anchor=Select a Record Type
    TypeText              *Subject                    My Task
    Select Future Date    10 days                     Due Date
    UseTable              Choose a RowSelect All
    TypeText              *Comments                   comments
    ClickCheckbox         Select All                  on
    ClickElement          xpath\=//*[@class\='slds-form-element_control slds-grow']
    DropDown              46:4613;a                   High
    DropDown              64:4613;a                   Open
    DropDown              46:6516;a                   High
    ClickText             Normal
    DropDown              64:6516;a                   Open
    ClickText             No order captured
    ClickCheckbox         Photo Required              on
    ClickCheckbox         Photo Required              off
    ClickText             Save
    ClickText             Tabs
    ClickText             Critical Minute
    ClickText             Links
    ClickText             Minimize
    ClickText             Next
    TypeText              Search...                   \# 39 OCEAN PRIME ORLANDO                  anchor=Home
    ClickText             \# 39 OCEAN PRIME ORLANDO                               anchor=Account
