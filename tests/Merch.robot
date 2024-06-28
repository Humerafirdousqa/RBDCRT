*** Settings ***
Library    QForce
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         DateTime
Library                         String


*** Variables ***


*** Test Cases ***
Merch App
    [Documentation]    This is to test Reyes Merch App
    [Tags]             Merch App
    Login
    Login As Merch      Ronald Starke
    Verify Home page for Merch
    Select the first Account
    Verify tabs on Account
    ClickText    Surveys
    ClickText    New ELITE Merch Survey
    DropDown    *    East
    ClickText    Next
    ComboBox    Search People...    Ronald Starke
    DropDown    *    10
    ClickText    Upload FilesOr drop files    anchor=Please select a value: 0 - 10
    TypeText    Upload FilesOr drop files    C:\\fakepath\\MicrosoftTeams-image (56).png
    DropDown    *    Yes
    ClickText    Upload FilesOr drop files    anchor=Please select a value: Yes or No
    TypeText    Upload FilesOr drop files    C:\\fakepath\\MicrosoftTeams-image (56).png
    DropDown    *    10
    ClickText    Upload FilesOr drop files    anchor=Please select a value: 0 - 10
    TypeText    Upload FilesOr drop files    C:\\fakepath\\MicrosoftTeams-image (56).png
    DropDown    *    Yes
    ClickText    Upload FilesOr drop files    anchor=Please select a value: Yes or No
    TypeText    Upload FilesOr drop files    C:\\fakepath\\MicrosoftTeams-image (56).png
    DropDown    *    Yes
    ClickText    Upload FilesOr drop files    anchor=Please select a value: Yes or No
    TypeText    Upload FilesOr drop files    C:\\fakepath\\MicrosoftTeams-image (56).png
    DropDown    *    Yes
    ClickText    Upload FilesOr drop files    anchor=Please select a value: Yes or No
    TypeText    Upload FilesOr drop files    C:\\fakepath\\MicrosoftTeams-image (56).png
    DropDown    *    Yes
    ClickText    Upload FilesOr drop files    anchor=Please select a value: Yes or No
    TypeText    Upload FilesOr drop files    C:\\fakepath\\MicrosoftTeams-image (56).png
    DropDown    *    Yes
    ClickText    Upload FilesOr drop files    anchor=Please select a value: Yes or No
    TypeText    Upload FilesOr drop files    C:\\fakepath\\MicrosoftTeams-image (56).png
    DropDown    *    Yes
    ClickText    Upload FilesOr drop files    anchor=Please select a value: Yes or No
    TypeText    Upload FilesOr drop files    C:\\fakepath\\MicrosoftTeams-image (56).png
    DropDown    *    Yes
    ClickText    Upload FilesOr drop files    anchor=Please select a value: Yes or No
    TypeText    Upload FilesOr drop files    C:\\fakepath\\MicrosoftTeams-image (56).png
    TypeText    *    comments
    ClickText    Next
    VerifyText    Thank you for successfully filling out the Elite Merch Store Survey, have a great rest of your day.
    ClickText    close
    ClickText    Yes
    Create Merch Checkout with Breakage
    Sleep                 5s
    Create Merch Checkout without Breakage
    ClickText    Merch Checkout
    UseModal    On
