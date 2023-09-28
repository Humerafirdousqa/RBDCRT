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
    ClickText             More                        index=2                        anchor=2
    ClickText             Critical Minute
    ClickText             New Task
    DropDown              None                        Call
    ClickText             Next                        anchor=Select a Record Type
    TypeText              *Subject                    My Task
    Select Future Date    10 days                     Due Date
    UseTable              Choose a RowSelect All
    TypeText              *Comments                   comments


    ClickCheckbox         Select All                  Anchor=1
    #ClickCheckbox         xpath\=//label[@for\='lgt-dt-header-factory-id-937']//span[@class\='slds-checkbox_faux']    on
    #ClickElement         xpath\=//*[@class\='slds-form-element_control slds-grow']
    DropDown              Priority                    High
    DropDown              Status                      Open
    ClickCheckbox         Photo Required              on
    ClickCheckbox         Photo Required              off
    ClickText             Save
