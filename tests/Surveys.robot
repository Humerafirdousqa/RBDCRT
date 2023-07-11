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
    Home

    ClickText          Accounts
    ClickText          Select a List View: Accounts
    ClickText          menu survey
    UseTable           Account Name
    ClickCell          r1c9
    ClickText          Take Survey
    UseModal           On
    ClickElement       xpath\=//*[@class\='slds-combobox__input slds-input_faux slds-combobox__input-value']
    ClickText          Yes
    ClickElement       xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    VerifyText         What are the cocktails? *
    TypeText           *Cocktail Item Name         cocktail 1
    ClickText          No
    PickList           Liquor Type                 Gin
    Picklist           Liquor Brand                Barton
    ClickText          Upload FilesOr drop files
    Choose File        C:\fakepath\MicrosoftTeams-image (56).png

    #ClickText          Upload FilesOr drop files
    #ClickText          Upload FilesOr drop files                               C:\\Home\\suite\\MicrosoftTeams-image (56).png
    #ClickText          Open


    ClickText          Upload FilesOr drop files
    SwitchWindow       1
    ClickText          Home
    ClickText          suite
    TypeText           Upload FilesOr drop files                               C:\\fakepath\\MicrosoftTeams-image (56).png
    UseModal           Off
    #UploadFile        verify                      C:\Users\hfirdous\Downloads\MicrosoftTeams-image (56).png
    ClickElement       xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    ClickElement       xpath\=//*[@class\='slds-combobox__input slds-input_faux slds-combobox__input-value']
    ClickText          Yes
    ClickElement       xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    ClickElement       xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    ClickText          Finish                      2

