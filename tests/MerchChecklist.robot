*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime
Library                String


*** Variables ***


*** Test Cases ***
Create MerchChecklist
    [Documentation]    This is to create MerchChecklist
    [Tags]             Merch Checklist
    Login
    Login As FSR       Charles Kirk
    Select the first Account
    ClickText          Merch Checklist             partial_match=False
    UseModal           On
    ClickText          Create/Update Checklist
    ClickText          Select a date for           anchor=*Checklist Date
    Select Future Date          4 days             Checklist Date
    ClickElement       xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    TypeText           Store Contact Name       store contact name
    TypeText           General Comments         comments with long text ...
    ClickText          Create Merch Checklist
    #ClickElement       xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    ClickText          Create New Task
    ClickText          Create/Update Task
    TypeText           Subject                 task Subject
    TypeText           Task Details                task details
    DropDown           Location                    Front Endcap
    ComboBox           Search Products...          2 Silos Citralicious Sixth Barrel
    ClickText          Save Task
    UploadFile         Upload Files                /home/services/suite/MicrosoftTeams-image (56).png
    ClickText          Continue
    ClickText          Done                        Anchor=2
    UseModal           Off
