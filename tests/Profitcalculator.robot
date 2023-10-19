*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime
Library                SeleniumLibrary

*** Test Cases ***

Menu Survey
    [Documentation]    This is test Profit Calculator Functionality
    [Tags]             Profit Calculator
    Login
    Login As FSR       Charles Kirk
    ClickText          Accounts
    ClickElement       xpath=(//a[@data-refid\="recordId"])[1]
    ClickText          Profit Calculator
    TypeText           Competitor Beer Name       beer1
    TypeText           Price per Keg (Price to Retailer)                      23
    ClickText          Example: 1/2 Barrel         anchor=*Keg Size
    ClickText          1/2 Barrel                  anchor=*Price per Keg (Price to Retailer)
    TypeText           Price per Serving (Price to Consumer)                      25
    TypeText           Serving Size in Ounces (Pour Size)                 5
    TypeText           Velocity per Month (Number of Kegs)                  5
    ClickText          Add a Product to Compare
    ClickCheckbox      Use Reyes Product?YesNo     on    Anchor=2
    TypeText           Search by product name, item number, pkg type           mill    Anchor=2
    ClickText          Miller Lite Half Barrel
    TypeText           Price per Serving (Price to Consumer)                      110                        Anchor=2
    TypeText           Serving Size in Ounces (Pour Size)                 5                        Anchor=2
    TypeText           Velocity per Month (Number of Kegs)                  5                     Anchor=2
    ClickText          Add a Product to Compare
    ClickCheckbox      Use Reyes Product?YesNo     on                        Anchor=3
    TypeText           Search by product name, item number, pkg type           mill               Anchor=3
    ClickText          Miller Lite Quarter Barrel Slim
    TypeText           Price per Serving (Price to Consumer)                      80               Anchor=3
    TypeText           Serving Size in Ounces (Pour Size)                 5                        Anchor=3
    TypeText           Velocity per Month (Number of Kegs)                  5                     Anchor=3
    ClickText          Calculate
    ClickText          Save for Later
    TypeText           Profit Calculation Record Name                         Draft Beer profit calculation
    ClickText          Save                        partial_match=False
