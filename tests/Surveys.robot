*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime

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


    ClickText          1032 CINEMARK CEDAR PK 12
    ClickText          Take Survey
    UseModal    On
    
    

    ClickElement      xpath\=//*[@class\='slds-combobox__input slds-input_faux slds-combobox__input-value']
    ClickText         Yes
    ClickElement      xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
   
    
    VerifyText        What are the cocktails? *
    TypeText           *Cocktail Item Name         cocktail 1
    ClickText          Yes
    ClickText          radio-0-1066
    ClickText          input-1069
    ClickText          input-1069
    TypeText           combobox-search             coo
    ClickText          icon
    UploadFile         verify                      C:\Users\hfirdous\Downloads\MicrosoftTeams-image (56).png
    ClickText          Upload FilesOr drop files


