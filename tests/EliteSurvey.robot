*** Settings ***
Resource               ../resources/common.robot
Suite Setup            Setup Browser
Suite Teardown         End suite
Library                DateTime
Library                String


*** Variables ***


*** Test Cases ***
Create Elite Survey
    [Documentation]    This is to create Elite Survey
    [Tags]             Elite Survey
    Login
    Login As FSR       Charles Kirk
    ClickText          Accounts
    ClickElement       xpath=(//a[@data-refid\="recordId"])[1]

    ClickText          Surveys
    ClickText          New ELITE Survey
    DropDown           *                           Large Format
    ClickText          Next
    DropDown           Survey Completed by         Manager Alone
    DropDown           *Is the RBG Display Support of Feature consistent with local objectives?    Yes
    TypeText           Question Comments           cccc                        anchor=Support of Feature Picture
    ClickText          Upload Files                anchor=Support of Feature Picture
    UploadFile         Upload Files                /home/services/suite/MicrosoftTeams-image (56).png
    DropDown           *Is the overall display of cases on the sales floor at standard as defined by the business?                           No
    TypeText           Question Comments      dddd                        anchor=Is the overall display of cases on the sales floor at standard as defined by the business?
    ClickText          Upload Files                anchor=Display Cases Picture
    UploadFile         Upload Files                /home/services/suite/MicrosoftTeams-image (56).png
    DropDown           *Are planner items merchandised and executed?                           N/A
    DropDown           *Are legal consumer offers equal to or greater than competition?                           Yes
    ClickCheckbox      Follow-up Task needed?             on              anchor=Legal Offers Picture
    UseTable           Choose a Row to Select
    ClickCell          r1c1
    DropDown           *Do displays have legal POS equal to greater than competition?                           No
    DropDown           *Is the cooler set by schematic with correct pricing and packages?                           N/A
    DropDown           *Is the RBG Product Quality Policy being followed?                           Yes
    DropDown           *Is the back room clean and organized?                           No
    DropDown           *Does RBG have any controllable Out of Stocks?                           N/A
    DropDown           What steps of Consultant of Choice were followed?       Uncover Information
    DropDown           *Were any existing sales tools used to secure features or distribution during sales?                           Yes
    DropDown           Sales Tools                 Circana
    ClickText          Next
    ClickText          Capture Signature
    ClickText          Next
    VerifyText         Score: 61
    ClickText          Finish

