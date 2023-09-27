*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime
Library                String


*** Variables ***


*** Test Cases ***
Create FailedScan
    [Documentation]    This is to create Failed Scan
    [Tags]             Failed Scan
    Login
    Login As FSR       Charles Kirk
    ClickText          Products
    ClickText          2 Silos Citralicious Sixth Barrel
    ClickText          New Failed Scan
    UseModal           On
    ClickElement       xpath\=//*[@class\='slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right']
    TypeText           Account                     39 Ocean Prime
    ComboBox           Search Accounts...          \# 39 OCEAN PRIME ORLANDO
    DropDown           *                           Vendor Information Incorrect or Pricing Issue
    TypeText           *                           comments
    ClickText          Next
    UploadFile         Upload Files                /home/services/suite/MicrosoftTeams-image (56).png
    ClickText          Next
    ClickText          Finish
    UseModal           Off
    ClickText          New Failed Scan
    UseModal           On
    ClickElement       xpath\=//*[@class\='slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right']
    TypeText           Account                     39 Ocean Prime
    ComboBox           Search Accounts...          \# 39 OCEAN PRIME ORLANDO
    ClickElement       xpath\=//*[@class\='slds-select']
    #PickList          Failed Scan Reason          Item Not Scanning / Not Found / Not on File
    DropDown           *                           Item Not Scanning / Not Found / Not on File
    ClickText          Next
    DropDown           Is this item in the schematic?                          YES
    ClickText          Next
    #UploadFile         Upload Files                /home/services/suite/MicrosoftTeams-image (56).png
    #ClickText          Next
    ClickText          Finish
    UseModal           Off
