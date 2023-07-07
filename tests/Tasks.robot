*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***

Create Order
    [Documentation]    This is to create order
    [Tags]             Orders
    Login
    Home
    Login As ISR           Regina Peters
    Home
    ClickText    Minimize
    ClickText    Search...    anchor=Reyes BevLine
    

    ClickText    Show Navigation Menu
    ClickText    Accounts
    ClickText    /# 39 OCEAN PRIME ORLANDO
    ClickText    More
    ClickText    Critical Minute
    ClickText    New Task
    DropDown    6909:0    Failed Scan Task
    ClickText    Next    anchor=Select a Record Type
    ClickText    input-1547
    TypeText    *Subject    failed scan
    ClickText    *Due Date
    ClickText    8
    ClickText    input-1549
    UseTable    Choose a RowSelect All
    TypeText    *Comments    comments
    ClickCheckbox    r?Select Item 1/c1    on
    DropDown    46:6516;a    High
    ClickText    Normal
    DropDown    64:6516;a    Open
    ClickText    No order captured
    ClickCheckbox    Photo Required    on
    ClickCheckbox    Photo Required    off
    ClickText    Save
    ClickText    Tabs
    ClickText    Critical Minute
    ClickText    Links
    ClickText    Minimize
    ClickText    Next
    TypeText    Search...    \# 39 OCEAN PRIME ORLANDO    anchor=Home
    ClickText                \# 39 OCEAN PRIME ORLANDO    anchor=Account
