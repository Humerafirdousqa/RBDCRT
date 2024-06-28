*** Settings ***
Library                         QForce
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         DateTime
Library                         String


*** Variables ***


*** Test Cases ***
Merch App
    [Documentation]             This is to test Reyes Merch App
    [Tags]                      Merch App
    Login
    Login As Merch              Ronald Starke
    Verify Home page for Merch
    Select the first Account
    Verify tabs on Account
    ClickText                   Surveys
    ClickText                   New ELITE Merch Survey
    DropDown                    *                           East
    ClickText                   Next
    ComboBox                    Search People...            Ronald Starke
    DropDown                    Were any RBG cases missed during service?                           10
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png     Anchor=Question 1 Image
    DropDown                    Are Displays properly rotated?                           Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png     Anchor=Question 2 Image
    DropDown                    How many RBG cases were out of rotation in the cooler?                           10
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png     Anchor=Question 3 Image
    DropDown                    Are the displays safely built? Properly tied up? Built to Standard?                           Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png     Anchor=Question 4 Image
    DropDown                    Are the shelves stocked according to RBG company standard?                           Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png     Anchor=Question 5 Image
    DropDown                    Is the back room organized, workable and condensed?                           Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png     Anchor=Question 6 Image
    DropDown                    Is the backstock rotated?                            Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png     Anchor=Question 7 Image
    DropDown                    Is the breakage stored/staged in the proper place?                           Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png     Anchor=Question 8 Image
    DropDown                    Did the Merchandiser clean up all the trash before leaving the store?                           Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png     Anchor=Question 9 Image
    DropDown                    Did the Merchandiser fill and face all Non-Alcoholic product(s)?                           Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png     Anchor=Question 10 Image
    TypeText                    Comments                           comments
    ClickText                   Next
    VerifyText                  Thank you for successfully filling out the Elite Merch Store Survey, have a great rest of your day.
    ClickText                   close
    ClickText                   Yes
    Create Merch Checkout with Breakage
    Sleep                       5s
    Create Merch Checkout without Breakage
    ClickText                   Merch Checkout
    UseModal                    On
