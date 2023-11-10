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
    ClickText             Accounts                    Anchor=Home
    ClickElement          xpath=(//a[@data-refid\="recordId"])[1]
    ClickText             More                        Anchor=Account Scorecard
    ClickText             Critical Minute
    ClickText             New Task
    DropDown              None                        Call
    ClickText             Next                        anchor=Select a Record Type
    UseModal              on
    TypeText              *Subject                    My Task
    Select Future Date    10 days                     Due Date
    TypeText              *Comments                   comments
    UseTable              Choose a RowSelect All
    Click Element         xpath=//div[@class="slds-modal__container"]//span[@class="slds-checkbox" and ./input[@class="datatable-select-all"]]
    DropDown              Priority                    High
    DropDown              Status                      Open
    ClickCheckbox         Photo Required              on
    ClickCheckbox         Photo Required              off
    ClickText             Save
