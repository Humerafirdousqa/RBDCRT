*** Settings ***
Library                         QWeb
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         DateTime
Library                         String


*** Variables ***


*** Test Cases ***
Reyes Beverages App
    [Documentation]             This is to Validate Reyes Beverages App
    [Tags]                      Reyes Beverages App
    Login
    Login As Moco Rep           Genaro Mina
    Select the first Account
    ClickText                   Survey                      Anchor=Visit History
    ClickText                   New Out of Code Survey
    ClickElement                xpath\=//*[@class\='slds-input']
    TypeText                    * Search for a Product      tr
    ClickElement                xpath=(//a[@data-refid\="recordId"])[1]

    
    TypeText                    *Product Quantity           1
    ClickText                   *Out of Code Date
    UseTable                    Sun
    ClickCell                   r3c4
    ClickText                   Add Product
    TypeText                    combobox-search             tr
    ClickText                   icon                        anchor=* Search for a Product
    TypeText                    *Product Quantity           1
    ClickText                   *Pickup Date                anchor=* Search for a Product
    ClickCell                   r3c7
    ClickText                   *Out of Code Date           anchor=* Search for a Product
    ClickCell                   r5c5
    TypeText                    Additional Comments         comments
    ClickText                   Next
    ClickText                   Finish
