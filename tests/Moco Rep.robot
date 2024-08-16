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
    Login As Moco Rep           Kevin Wall
    Select the first Account
    ClickText                   Survey                      Anchor=Visit History
    ClickText                   Out of Code Surveys
    ClickText                   New Out of Code Survey
    ClickElement                xpath=(//a[@id\='flexipage_tab21__item'])
    ClickText                   New Out of Code Survey
    ClickElement                xpath\=//*[@class\='slds-input']              
    TypeText                    xpath\=//*[@class\='slds-input']      tr
    ClickElement                xpath\=(//div[@role\='option'])[1]
    TypeText                    *Product Quantity           1
    ClickText                   *Out of Code Date
    UseTable                    Sun
    ClickCell                   r3c4
    TypeText                    Additional Comments         comments
    ClickText                   Next
    ClickText                   Finish
