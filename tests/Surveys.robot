*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime
Library                SeleniumLibrary

*** Test Cases ***

Menu Survey
    [Documentation]    This is test Menu Survey Functionality
    [Tags]             Surveys
    Login
    LaunchApp          Reyes Beverage Group
    ClickText          Accounts
    ClickText          Select a List View: Accounts
    ClickText          menu survey
    sleep              3s
    ClickElement       xpath=(//a[@data-refid\="recordId"])[1]
    UseTable           Account Name
    ClickText          Take Survey                 Anchor=Menu Survey
    ClickElement       xpath\=//*[@class\='slds-combobox__input slds-input_faux slds-combobox__input-value']
    ClickText          Yes
    ClickElement       xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    VerifyText         What are the cocktails? *
    TypeText           *Cocktail Item Name         cocktail 1
    ClickText          No
    PickList           Liquor Type                 Gin
    Picklist           Liquor Brand                Barton
    UploadFile         Upload Files                /home/services/suite/MicrosoftTeams-image (56).png
    ClickElement       xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    ClickElement       xpath\=//*[@class\='slds-combobox__input slds-input_faux slds-combobox__input-value']
    ClickText          Yes
    ClickElement       xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    ClickText          No                          anchor=Please select the Gin Well Liquor Brand:
    PickList           Well Brand            Barton
    #ClickElement       xpath\=//*[@class\='slds-combobox__input slds-input_faux slds-combobox__input-value']
    #ClickText          Barton
    ClickText          No                          anchor=Please select the Rum Well Liquor Brand:
    PickList           Well Brand            Concierge
    #ClickElement       xpath\=//*[@class\='slds-combobox__input slds-input_faux slds-combobox__input-value']
    #ClickText          Concierge
    ClickElement       xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    ClickText          Finish                      2

