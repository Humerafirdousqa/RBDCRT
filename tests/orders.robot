*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite


*** Test Cases ***

Create Order
    [Documentation]    This is to create order
    [Tags]             Orders
    Login
    Home
    Login As ISR       Regina Peters
    Home
    ClickText          Minimize
    ClickText          Search...                   anchor=Reyes BevLine
    TypeText           Search...                   39 ocean prime orlando
    ClickText          Account
    ClickText          New Order
    #ClickText          Select a date for           anchor=Clear
    Select Future Date               4 days              Delivery Date
    UseModal           On
    UseModal           Off
    ClickText          Select Origin               anchor=*
    ClickText          Outbound Phone Order        anchor=Clear
    UseTable           SortProduct Nameicon
    ClickText          Add Product
    


    UseTable    SortProduct Nameicon
    TypeText    Search by product name, item number, pkg type    coors
    ClickCell    r1c5
    #TypeText           Search by product name        coors
    ClickText          Coors Banquet 12 - 24oz Cans
    VerifyTable        r1c8    0
    TypeText           r1c8                         2
    ClickText          Apply Changes
    ClickText          Submit Order
    ClickText          Select an Option            anchor=Off Day/Off Frequency Reason
    ClickText          Account Missed Last Delivery                            anchor=close
    ClickText          Select an Option            anchor=Missed Delivery Reason
    ClickText          No Answer                   anchor=Off Day/Off Frequency Reason
    ClickText          Yes
    ClickText          Close                       partial_match=False
    ClickText          Accounts
    ClickText          MARATHON GAS
    ClickText          Open Orders
    ClickText          Expand 582011
    ClickText          Collapse 582011
    UseTable           Order NumberShow actions
    VerifyTable        r1c1                        5/29/2023
    VerifyTable        r1c2                        05/08/2023
    ClickText          Search...                   anchor=Reyes BevLine
    TypeText           Search...                   marathon
    ClickText          Account
    ClickText          New Order
    UseModal           On
    UseModal           Off
    ClickText          Minimize
    ClickText          Close                       partial_match=False
    ClickText          Search...                   anchor=Reyes BevLine
    ClickText          2440 N STATE RD 7 HOLLYWOOD, FL 33021 United States
