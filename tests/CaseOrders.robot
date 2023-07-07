*** Settings ***
Resource                      ../resources/common.robot
Suite Setup                   Setup Browser
Suite Teardown                End suite


*** Test Cases ***

Create Order
    [Documentation]    This is to create order from a case
    [Tags]             Orders
    Login
    Home
    Login As ISR           Regina Peters
    #ClickText    Show Navigation Menu
    #ClickText    Search...    anchor=Reyes BevLine
    ClickText    Minimize
    ClickText    Show Navigation Menu
    ClickText    Cases
    ClickText    00092147
    ClickText    New Order
    ClickText    Select a date for    anchor=Clear
    ClickText    13
    ClickText    Select Origin    anchor=*
    ClickText    Email To Order    anchor=Clear
    ClickText    Order Products
    UseTable    SortProduct Nameicon
    ClickCell    r1c8
    TypeText    01t6g000003eRXaAAM    22
    TypeText    01t6g000003eQdLAAU    3
    ClickText    Apply Changes
    ClickText    Account Details
    ClickText    Tasks
    ClickText    Notes    anchor=Tasks
    ClickText    New    anchor=(12)
    TypeText    *Title    test notes
    TypeText    //*[@id\='modal-content-id-10-1403']/lightning-input-rich-text[1]/div[1]/div[1]/div[1]/div[2]/div[1]    testing
    ClickText    Save
    ClickText    Cases    anchor=Tasks
    ClickText    Order Products
    ClickText    Submit Order
    ClickText    Select an Option    anchor=Off Day/Off Frequency Reason
    ClickText    RBD Out of Stock    anchor=close
    ClickText    Yes
    ClickText    Cigar City Jai Alai 24 - 12oz Cans, 6 Pack 24 - 12oz Cans, 6 Pack
    ClickText    Order Summary

