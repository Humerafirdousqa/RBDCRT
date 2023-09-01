*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime
Library                String


*** Variables ***


*** Test Cases ***
View Invoice
    [Documentation]    This is to create MerchChecklist
    [Tags]             Merch Checklist
    Login
    Login As FSR       Charles Kirk
    ClickText          Accounts
    ClickElement       xpath=(//a[@data-refid\="recordId"])[1]

    ClickText    Tabs
    ClickText    Orders and Invoices
    ClickText    View Invoice
    UseTable    Invoice #
    

    ClickCell    r1c3
    ClickCell    r5c3
    ClickText    Adobe PDF
    ClickText    Download
    CloseWindow
    SwitchWindow    NEW
