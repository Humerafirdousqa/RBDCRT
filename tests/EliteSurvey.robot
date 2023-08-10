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

    ClickText    Surveys
    ClickText    New ELITE Survey
    DropDown    *    Large Format
    ClickText    Next
    DropDown    *    Manager Alone
    DropDown    *    Yes
    TypeText    //*[@id\='input-991']    cccc
    ClickText    Upload FilesOr drop files    anchor=Question Comments
    DropDown    *    No
    TypeText    //*[@id\='input-1004']    dddd
    DropDown    *    N/A
    DropDown    *    Yes
    ClickCheckbox    Follow-up Task needed?Follow-up task will be created.No    on
    UseTable    Choose a Row to Select
    ClickCell    r1c1
    DropDown    *    No
    DropDown    *    N/A
    DropDown    *    Yes
    DropDown    *    No
    DropDown    *    N/A
    DropDown    What steps of Consultant of Choice were followed?               Uncover Information
    DropDown    *    Yes
    DropDown    Sales Tools                        Circana
    ClickText    Next
    ClickText    Capture Signature
    ClickText    Next
    VerifyText    Score: 61
    ClickText    Finish
    
