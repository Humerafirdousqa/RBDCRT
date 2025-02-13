*** Settings ***
Library    QWeb
Resource                        ../resources/common.robot
Suite Setup                     Setup Browser
Suite Teardown                  End suite
Library                         DateTime
Library                         String


*** Variables ***


*** Test Cases ***
Reyes Beverages App
    [Documentation]             This is to Validate Reyes Beverages App
    [Tags]                      Reyes Beverages App
    Login
    Login As FSR                Zachary Wilkins
    Verify Home page for FSR
    #ClickText             Show menu    Anchor=2
    ClickText             New Customer Request    Anchor=2        anchor=Live Order
    ${DBARand}=           Generate Random String      6                         [LOWER]
    ${FirstRand}=         Generate Random String      6                         [LOWER]
    ${LastRand}=          Generate Random String      6                         [LOWER]
    #ClickText             New Customer Request
    SwitchWindow          NEW
    Create NCR as FSR     DBAName=${DBARand}          firstName=${FirstRand}    lastName=${LastRand}    BU=CRD    selltype=House Account
    VerifyText            Awaiting Manager Approval
    Create Elite Survey
    Create Data Driven Survey
    Create Non-Alc Cooler Lead Survey

    ClickText    New Non-Alc Cooler Lead Survey
    TypeText    /html[1]/body[1]/div[4]/div[1]/section[1]/div[1]/div[2]/div[2]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[1]/one-record-home-flexipage2[1]/forcegenerated-adg-rollup_component___force-generated__flexipage_-record-page___-r-b-d_-retail_-account_-record_-page_-desktop___-account___-v-i-e-w___-l-m-t___1739388641000[1]/forcegenerated-flexipage_rbd_retail_account_record_page_desktop_account__view_js___lmt___1739388641000[1]/record_flexipage-desktop-record-page-decorator[1]/div[1]/records-record-layout-event-broker[1]/slot[1]/slot[1]/flexipage-record-home-single-col-template-desktop2[1]/div[1]/div[2]/div[1]/slot[1]/flexipage-component2[3]/slot[1]/flexipage-tabset2[1]/div[1]/lightning-tabset[1]/div[1]/slot[1]/slot[1]/flexipage-tab2[4]/slot[1]/flexipage-component2[1]/slot[1]/flexipage-tabset2[1]/div[1]/lightning-tabset[1]/div[1]/slot[1]/slot[1]/flexipage-tab2[4]/slot[1]/flexipage-component2[1]/slot[1]/flexipage-aura-wrapper[1]/div[1]/section[1]/div[1]/div[1]/section[1]/flowruntime-flow[1]/flowruntime-lwc-body[1]/div[1]/flowruntime-list-container[1]/div[1]/flowruntime-base-section[1]/div[1]/flowruntime-screen-field[3]/flowruntime-lwc-field[1]/div[1]/c-survey-answers[1]/div[1]/p[2]/lightning-textarea[1]/div[1]/textarea[1]    dEcision maker text
    ClickText    Select an Option    anchor=Primary POC
    ClickText    Checkstand    anchor=Skip to Navigation
    ClickText    Select an Option    anchor=Comments:
    ClickText    IDW G-10: 3 shelf medium cooler    anchor=Skip to Navigation
    TypeText    /html[1]/body[1]/div[4]/div[1]/section[1]/div[1]/div[2]/div[2]/div[1]/div[1]/div[1]/div[1]/div[4]/div[1]/div[1]/one-record-home-flexipage2[1]/forcegenerated-adg-rollup_component___force-generated__flexipage_-record-page___-r-b-d_-retail_-account_-record_-page_-desktop___-account___-v-i-e-w___-l-m-t___1739388641000[1]/forcegenerated-flexipage_rbd_retail_account_record_page_desktop_account__view_js___lmt___1739388641000[1]/record_flexipage-desktop-record-page-decorator[1]/div[1]/records-record-layout-event-broker[1]/slot[1]/slot[1]/flexipage-record-home-single-col-template-desktop2[1]/div[1]/div[2]/div[1]/slot[1]/flexipage-component2[3]/slot[1]/flexipage-tabset2[1]/div[1]/lightning-tabset[1]/div[1]/slot[1]/slot[1]/flexipage-tab2[4]/slot[1]/flexipage-component2[1]/slot[1]/flexipage-tabset2[1]/div[1]/lightning-tabset[1]/div[1]/slot[1]/slot[1]/flexipage-tab2[4]/slot[1]/flexipage-component2[1]/slot[1]/flexipage-aura-wrapper[1]/div[1]/section[1]/div[1]/div[1]/section[1]/flowruntime-flow[1]/flowruntime-lwc-body[1]/div[1]/flowruntime-list-container[1]/div[1]/flowruntime-base-section[1]/div[1]/flowruntime-screen-field[3]/flowruntime-lwc-field[1]/div[1]/c-survey-answers[1]/div[1]/p[7]/lightning-textarea[1]/div[1]/textarea[1]    comments here
    ClickText    Finish Survey
    ClickText    Finish
    Create Merch Checklist
    ClickText                   More                        Anchor=2
    ClickText                   Profit Calculator
    Draft Beer Calculator
    Packaged Beer Calculator
    Spirit Calculator
    Create Failed Scan
    Create Task FSR
    View and Download Invoice
