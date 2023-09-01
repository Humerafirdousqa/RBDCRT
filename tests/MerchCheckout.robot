*** Settings ***
Resource                  ../resources/common.robot
Suite Setup               Setup Browser
Suite Teardown            End suite
Library                   DateTime
Library                   String


*** Variables ***


*** Test Cases ***
Create MerchCheckout with Breakage
    [Documentation]       This is to create Merch Checkout
    [Tags]                Merch Checkout
    Login
    Login As Merch        Ronald Starke
    ClickText             Accounts
    ClickElement          xpath=(//a[@data-refid\="recordId"])[1]
    ClickText             Merch Checkout              partial_match=False
    UseModal              On
    ClickText             Create/View Checkout
    DropDown              *                           Yes
    Select Future Date    0 days                      Checkout Date
    TypeText              Store Contact Name          store contact name
    ClickCheckbox         Breakage in Store           on
    UploadFile            Upload Files                /home/services/suite/MicrosoftTeams-image (56).png    Anchor=1
    UploadFile            Upload Files                /home/services/suite/MicrosoftTeams-image (56).png    Anchor=2
    UploadFile            Upload Files                /home/services/suite/MicrosoftTeams-image (56).png    Anchor=3
    ClickText             Update/Close Checkout


Create MerchCheckout without Breakage
    [Documentation]       This is to create Merch Checkout
    [Tags]                Merch Checkout
    Login
    Login As Merch        Ronald Starke
    ClickText             Accounts
    ClickElement          xpath=(//a[@data-refid\="recordId"])[1]
    ClickText             Merch Checkout              partial_match=False
    UseModal              On
    ClickText             Create/View Checkout
    DropDown              *                           Yes
    Select Future Date    0 days                      Checkout Date
    TypeText              Store Contact Name          store contact name
    UploadFile            Upload Files                /home/services/suite/MicrosoftTeams-image (56).png    Anchor=1
    UploadFile            Upload Files                /home/services/suite/MicrosoftTeams-image (56).png    Anchor=2
    UploadFile            Upload Files                /home/services/suite/MicrosoftTeams-image (56).png    Anchor=3
    ClickText             Update/Close Checkout