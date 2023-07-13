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
    Home
    ClickText             Minimize
    ClickText             Show Navigation Menu
    ClickText             Accounts
    ClickElement          xpath=(//a[@data-refid\="recordId"])[1]
    #ClickText            \# 39 OCEAN PRIME ORLANDO                               partial_match=False
    #ClickText            Search...                   anchor=Reyes BevLine
    #TypeText             Search...                   39 ocean prime orlando
    #ClickText            Account                     39 ocean prime orlando
    ClickText             New Order
    #ClickText            Select a date for           anchor=Clear
    Select Future Date    4 days                      Delivery Date
    UseModal              On
    UseModal              Off
    ClickText             Select Origin               anchor=*
    ClickText             Outbound Phone Order        anchor=Clear
    UseTable              SortProduct Nameicon
    ClickText             Add Product
    UseTable              SortProduct Nameicon
    TypeText              Search by product name, item number, pkg type           Coors Banquet
    #ClickCell            r1c5
    #TypeText             Search by product name      Coors Banquet 12 - 24oz Cans
    ClickText             Coors Banquet
    #VerifyTable          r1c8                        0
    TypeText              r1c8                        2
    ClickText             Apply Changes
    Sleep                 2s
    ClickText             Submit Order
    ClickText             Select an Option            anchor=Off Day/Off Frequency Reason
    ClickText             Account Missed Last Delivery
    ClickText             Select an Option            anchor=Missed Delivery Reason
    ClickText             No Answer                   anchor=Off Day/Off Frequency Reason
    ClickText             Yes
    VerifyText            Posted to VIP
