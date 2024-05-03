*** Settings ***
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         DateTime
Library                         String


*** Variables ***


*** Test Cases ***
Bevline
    [Documentation]             This is to Validate Bevline App
    [Tags]                      Bevline
