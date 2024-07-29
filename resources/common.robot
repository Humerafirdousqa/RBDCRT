*** Settings ***
Library                         QForce
Library                         String
Library                         DateTime

*** Variables ***
# IMPORTANT: Please read the readme.txt to understand needed variables and how to handle them!!
${BROWSER}                      chrome
${username}                     hfirdous@reyesholdings.com.uat
${automationpassword}           Beer12345678!
${login_url}                    https://e360--uat.sandbox.my.salesforce.com/            # Salesforce instance. NOTE: Should be overwritten in CRT variables
${home_url}                     ${login_url}/lightning/page/home


*** Keywords ***
Setup Browser
    # Setting search order is not really needed here, but given as an example
    # if you need to use multiple libraries containing keywords with duplicate names
    Set Library Search Order    QForce                      QWeb
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}                    #\ue000
    SetConfig                   DefaultTimeout              20s                         #sometimes salesforce is slow
    Evaluate                    random.seed()               random                      # initialize random generator


End suite
    Close All Browsers


Login
    [Documentation]             Login to Salesforce instance
    GoTo                        ${login_url}
    TypeText                    Username                    ${username}                 delay=1
    TypeText                    Password                    ${automationpassword}
    ClickText                   Log In

    # We'll check if variable ${secret} is given. If yes, fill the MFA dialog.
    # If not, MFA is not expected.
    # ${secret} is ${None} unless specifically given.
    ${MFA_needed}=              Run Keyword And Return Status                           Should Not Be Equal         ${None}                     ${secret}
    Run Keyword If              ${MFA_needed}               Fill MFA


Login As ISR
    [Documentation]             Login As different persona. User needs to be logged into Salesforce with Admin rights
    ...                         before calling this keyword to change persona.
    ...                         Example:
    ...                         LoginAs                     Chatter Expert
    [Arguments]                 ${persona}
    ClickText                   Setup
    ClickText                   Setup for current app
    SwitchWindow                NEW
    TypeText                    Search Setup                ${persona}                  delay=2
    ClickText                   User                        anchor=${persona}           delay=5                     # wait for list to populate, then click
    VerifyText                  Freeze                      timeout=45                  # this is slow, needs longer timeout
    ClickText                   Login                       anchor=Freeze               delay=1
    Sleep                       5s
    ClickText                   Minimize
    Sleep                       5s

Login As FSR
    [Documentation]             Login As different persona. User needs to be logged into Salesforce with Admin rights
    ...                         before calling this keyword to change persona.
    ...                         Example:
    ...                         LoginAs                     Chatter Expert
    [Arguments]                 ${persona}
    ClickText                   Setup
    ClickText                   Setup for current app
    SwitchWindow                NEW
    TypeText                    Search Setup                ${persona}                  delay=2
    ClickText                   User                        anchor=${persona}           delay=5                     # wait for list to populate, then click
    VerifyText                  Freeze                      timeout=45                  # this is slow, needs longer timeout
    ClickText                   Login                       anchor=Freeze               delay=1
    Sleep                       2s

Login As Moco Rep
    [Documentation]             Login As different persona. User needs to be logged into Salesforce with Admin rights
    ...                         before calling this keyword to change persona.
    ...                         Example:
    ...                         LoginAs                     Chatter Expert
    [Arguments]                 ${persona}
    ClickText                   Setup
    ClickText                   Setup for current app
    SwitchWindow                NEW
    TypeText                    Search Setup                ${persona}                  delay=2
    ClickText                   User                        anchor=${persona}           delay=5                     # wait for list to populate, then click
    VerifyText                  Freeze                      timeout=45                  # this is slow, needs longer timeout
    ClickText                   Login                       anchor=Freeze               delay=1
    Sleep                       2s

Login As Merch
    [Documentation]             Login As different persona. User needs to be logged into Salesforce with Admin rights
    ...                         before calling this keyword to change persona.
    ...                         Example:
    ...                         LoginAs                     Chatter Expert
    [Arguments]                 ${persona}
    ClickText                   Setup
    ClickText                   Setup for current app
    SwitchWindow                NEW
    TypeText                    Search Setup                ${persona}                  delay=2
    ClickText                   User                        anchor=${persona}           delay=5                     # wait for list to populate, then click
    VerifyText                  Freeze                      timeout=45                  # this is slow, needs longer timeout
    ClickText                   Login                       anchor=Freeze               delay=1
    Sleep                       2s



Fill MFA
    ${mfa_code}=                GetOTP                      ${username}                 ${secret}                   ${login_url}
    TypeSecret                  Verification Code           ${mfa_code}
    ClickText                   Verify


Home
    [Documentation]             Navigate to homepage, login if needed
    GoTo                        ${home_url}
    ${login_status} =           IsText                      To access this page, you have to log in to Salesforce.                              2
    Run Keyword If              ${login_status}             Login
    ClickText                   Home
    VerifyTitle                 Home | Salesforce


    # Example of custom keyword with robot fw syntax
VerifyStage
    [Documentation]             Verifies that stage given in ${text} is at ${selected} state; either selected (true) or not selected (false)
    [Arguments]                 ${text}                     ${selected}=true
    VerifyElement               //a[@title\="${text}" and @aria-checked\="${selected}"]


NoData
    VerifyNoText                ${data}                     timeout=3                   delay=2


DeleteAccounts
    [Documentation]             RunBlock to remove all data until it doesn't exist anymore
    ClickText                   ${data}
    ClickText                   Delete
    VerifyText                  Are you sure you want to delete this account?
    ClickText                   Delete                      2
    VerifyText                  Undo
    VerifyNoText                Undo
    ClickText                   Accounts                    partial_match=False


DeleteLeads
    [Documentation]             RunBlock to remove all data until it doesn't exist anymore
    ClickText                   ${data}
    ClickText                   Delete
    VerifyText                  Are you sure you want to delete this lead?
    ClickText                   Delete                      2
    VerifyText                  Undo
    VerifyNoText                Undo
    ClickText                   Leads                       partial_match=False

Open Specific case
    [Documentation]             This keyword navigates to "Cases" and opens specific case.
    [Arguments]                 ${CasetoOpen}

    ClickText                   Cases
    ClickText                   ${CasetoOpen}

Create NCR as ISR
    [Documentation]
    [Arguments]                 ${DBAName}                  ${firstName}                ${lastName}                 ${requestedFor}             ${BU}          ${selltype}
    #ClickText                  Create NCR
    UseModal                    On
    TypeText                    *D.B.A. Name                ${DBAName}                  timeout=5s                  partial_match=False
    TypeText                    First Name                  fname
    TypeText                    Last Name                   ${lastName}
    ComboBox                    Search People...            ${requestedFor}
    DropDown                    *                           ${BU}
    DropDown                    *                           ${selltype}                 anchor=Sell Type
    ClickText                   Next
    VerifyText                  Create NCR
    ClickText                   Create                      3
    UseModal                    Off
    ClickText                   Edit License #1
    TypeText                    License #1                  56465
    TypeText                    Licensee Name               kn72534
    Select Future Date          4 days                      License Expiration Date
    PickList                    License Type                Beer & Wine
    TypeText                    Store Number                str46
    TypeText                    Tax ID/Seller Permit        tx757657
    PickList                    License Status              Active
    ComboBox                    Search Address              245 Orlando Avenue
    TypeText                    Email                       hfir@gmail.com
    TypeText                    Phone                       5556665555
    PickList                    Premise                     On Premise
    PickList                    Chain/Independent           Independent
    TypeText                    Chain                       Independent
    ClickText                   Show All Results for
    UseModal                    On
    UseTable                    Sort Chain Name
    ClickText                   Independent
    PickList                    Class                       Concessionaire
    PickList                    Sub Class                   Entertainment Venue
    PickList                    Civilian/Military           Civilian
    PickList                    Beer Industy Volume         Top 50/20%
    PickList                    Ethnic - Patron             African American
    PickList                    Lifestyle                   Gay
    PickList                    Occupation Code             Blue Collar
    PickList                    Patron Age Code             General Pop
    PickList                    Residence                   Local
    ComboBox                    Search People...            Charles Kirk
    #ComboBox                   Search People...            Charles Kirk                index=2
    #ComboBox                   Search People...            Charles Kirk                index=3
    #ComboBox                   Search People...            Charles Kirk                index=4
    #ComboBox                   Search People...            Charles Kirk                index=5
    #ComboBox                   Search People...            Charles Kirk                index=6
    MultiPickList               Requested Delivery Days     Monday
    ClickText                   Move selection to Chosen
    MultiPickList               Requested Delivery Days     Thursday
    ClickText                   Move selection to Chosen
    #PickList                   Visit Frequency             Twice Per Week
    #MultiPickList              Visit Day(s)                Monday
    #ClickText                  Move selection to Chosen    anchor=Available
    #MultiPickList              Visit Day(s)                Thursday
    #ClickText                  Move selection to Chosen    anchor=Available
    PickList                    Delivery Open Time #1       6:00
    PickList                    Delivery Close Time #1      9:00
    PickList                    Package Type                Draft & Pkg
    PickList                    Draft Status                Exclusive Reyes Draft Account
    PickList                    Displayable                 Displayable
    ClickText                   POS Materials
    PickList                    POS Materials               <50 Case Display
    PickList                    Seasonal Open Month         January
    PickList                    Seasonal Close Month        June
    TypeText                    Special Instructions - Short                            ssss
    TypeText                    Special Instructions - Long                             llllll
    PickList                    Company                     Florida Distributors        patial_match=False
    PickList                    Warehouse                   Orlando
    PickList                    PDA Print UPC Barcode       To not print barcodes on the PDA pick tickets
    PickList                    UPC Print                   No UPC
    PickList                    Barcoded Invoice            Bottle UPC Barcode Sorting Sub by Item
    PickList                    Terms                       Certified Check/Money Order
    ClickCheckbox               Print UCS Code Labels       on
    ClickCheckbox               Print Separate Empty Invoice                            on
    TypeText                    Comments for MDM Team       comments
    ClickText                   Save
    Submit NCR


Create NCR as FSR
    [Documentation]
    [Arguments]                 ${DBAName}                  ${firstName}                ${lastName}                 ${BU}                       ${selltype}
    UseModal                    On
    TypeText                    *D.B.A. Name                ${DBAName}                  timeout=5s                  partial_match=False
    TypeText                    First Name                  ${firstName}
    TypeText                    Last Name                   ${lastName}
    DropDown                    *                           ${BU}
    DropDown                    *                           ${selltype}                 anchor=Sell Type
    ClickText                   Next
    VerifyText                  Create Prospective Customer
    Sleep                       1s
    ClickText                   Create                      3
    ClickText                   Edit Licensee Name
    TypeText                    Licensee Name               kn72534
    UseModal                    Off
    TypeText                    License #1                  56465
    Select Future Date          4 days                      License Expiration Date
    PickList                    License Type                Beer & Wine
    TypeText                    Store Number                str46
    TypeText                    Tax ID/Seller Permit        tx757657
    PickList                    License Status              Active
    ComboBox                    Search Address              245 Orlando Avenue
    TypeText                    Email                       hfir@gmail.com
    TypeText                    Phone                       5556665555
    PickList                    Premise                     On Premise
    PickList                    Chain/Independent           Independent
    TypeText                    Chain                       Independent
    #ClickText                  Show more Results for "independent"
    #ClickText                  Search Chains...
    ClickText                   Show more results for "Independent"
    UseModal                    On
    ClickText                   INDEPENDENT                 anchor=Sort Chain Name
    UseModal                    Off
    #UseModal                   On
    #UseTable                   Sort Chain Name
    #ClickText                  Independent
    PickList                    Class                       Concessionaire
    PickList                    Sub Class                   Entertainment Venue
    PickList                    Civilian/Military           Civilian
    PickList                    Beer Industy Volume         Top 50/20%
    PickList                    Ethnic - Patron             African American
    PickList                    Lifestyle                   Gay
    PickList                    Occupation Code             Blue Collar
    PickList                    Patron Age Code             General Pop
    PickList                    Residence                   Local
    ComboBox                    Search People...            Charles Kirk
    ComboBox                    Search People...            Charles Kirk                index=2
    ComboBox                    Search People...            Charles Kirk                index=3
    ComboBox                    Search People...            Charles Kirk                index=4
    ComboBox                    Search People...            Charles Kirk                index=5
    ComboBox                    Search People...            Charles Kirk                index=6
    MultiPickList               Requested Delivery Days     Monday
    ClickText                   Move selection to Chosen
    MultiPickList               Requested Delivery Days     Thursday
    ClickText                   Move selection to Chosen
    #PickList                   Visit Frequency             Twice Per Week
    #MultiPickList              Visit Day(s)                Monday
    #ClickText                  Move selection to Chosen    anchor=Available
    #MultiPickList              Visit Day(s)                Thursday
    #ClickText                  Move selection to Chosen    anchor=Available
    PickList                    Delivery Open Time #1       6:00
    PickList                    Delivery Close Time #1      9:00
    PickList                    Package Type                Draft & Pkg
    PickList                    Draft Status                Exclusive Reyes Draft Account
    PickList                    Displayable                 Displayable
    ClickText                   POS Materials
    PickList                    POS Materials               <50 Case Display
    PickList                    Seasonal Open Month         January
    PickList                    Seasonal Close Month        June
    TypeText                    Special Instructions - Short                            ssss
    TypeText                    Special Instructions - Long                             llllll
    PickList                    Company                     Florida Distributors        patial_match=False
    PickList                    Warehouse                   Orlando
    PickList                    PDA Print UPC Barcode       To not print barcodes on the PDA pick tickets
    PickList                    UPC Print                   No UPC
    PickList                    Barcoded Invoice            Bottle UPC Barcode Sorting Sub by Item
    PickList                    Terms                       Certified Check/Money Order
    ClickCheckbox               Print UCS Code Labels       on
    ClickCheckbox               Print Separate Empty Invoice                            on
    TypeText                    Comments for MDM Team       comments
    ClickText                   Save
    Submit NCR



Submit NCR
    [Documentation]             This code snippet is to submit NCR
    [Arguments]
    ClickText                   Submit New Customer Request
    UseModal                    On
    ClickText                   Submit
    ClickText                   Submit                      3
    ClickText                   Next
    UseModal                    Off
Select Future Date
    [Documentation]             This is to select a future Date
    [Arguments]                 ${DaystoAdd}                ${Fieldtoupdate}
    ${CurrentDate}=             Get Current Date
    ${Date}=                    Add Time To Date            ${CurrentDate}              ${DaystoAdd}                result_format=%m/%d/%Y
    TypeText                    ${Fieldtoupdate}            ${Date}

ClickNext
    [Documentation]             This is to click Next
    ClickText                   Next                        Anchor=Menu Survey


Create Order within 7 days
    [Documentation]             This is to create order within 7 Days
    [Arguments]
    ClickText                   Show Navigation Menu
    ClickText                   Accounts                    Partialmatch=false
    Select the first Account
    ClickText                   New Order
    Select Future Date          4 days                      Delivery Date
    UseModal                    On
    UseModal                    Off
    ClickText                   Select Origin               anchor=*
    ClickText                   Outbound Phone Order        anchor=Clear
    UseTable                    SortProduct Nameicon
    #ClickText                  Add Product
    #UseTable                   SortProduct Nameicon
    #TypeText                   Search by product name, item number, pkg type           Coors Banquet
    #ClickText                  Coors Banquet
    ClickElement                xpath\=//*[@class\='slds-input qtyInput']
    #ClickCell                  r1c8                        0
    TypeText                    xpath\=//*[@class\='slds-input qtyInput']               2
    sleep                       3s
    ClickText                   Apply Changes
    Sleep                       3s
    ClickText                   Submit Order
    ClickText                   Select an Option            anchor=Off Day/Off Frequency Reason
    ClickText                   Account Missed Last Delivery
    ClickText                   Select an Option            anchor=Missed Delivery Reason
    ClickText                   No Answer                   anchor=Off Day/Off Frequency Reason
    ClickText                   Yes
    VerifyText                  Posted to VIP


Create Future Order
    [Documentation]             This is to create order within 7 Days
    [Arguments]
    ClickText                   Accounts
    ClickElement                xpath=(//a[@data-refid\="recordId"])[1]
    ClickText                   New Order
    Select Future Date          10 days                     Delivery Date
    UseModal                    On
    UseModal                    Off
    ClickText                   Select Origin               anchor=*
    ClickText                   Outbound Phone Order        anchor=Clear
    UseTable                    SortProduct Nameicon
    #ClickText                  Add Product
    #UseTable                   SortProduct Nameicon
    #TypeText                   Search by product name, item number, pkg type           Coors Banquet
    #ClickText                  Coors Banquet
    ClickElement                xpath\=//*[@class\='slds-input qtyInput']
    TypeText                    xpath\=//*[@class\='slds-input qtyInput']               2
    sleep                       3s
    ClickText                   Apply Changes
    Sleep                       3s
    ClickText                   Submit Order
    ClickText                   Select an Option            anchor=Off Day/Off Frequency Reason
    ClickText                   Account Missed Last Delivery
    ClickText                   Select an Option            anchor=Missed Delivery Reason
    ClickText                   No Answer                   anchor=Off Day/Off Frequency Reason
    ClickText                   Yes
    VerifyText                  Pending - Future Order


Verify Home page for FSR
    [Documentation]             This is to verify command center for FSR
    [Arguments]
    #Sleep                      5s
    #ClickText                  More                        Anchor=2
    VerifyText                  Home
    #VerifyText                 Spirits Business Objective
    VerifyText                  Elite Dashboard
    VerifyText                  DSOF
    VerifyText                  Cases                       Anchor=DSOF
    VerifyText                  My Open Pinned Products
    VerifyText                  Tasks                       Anchor=2
    VerifyText                  New Customer Requests       Anchor=2
    VerifyText                  Newsletter
    VerifyText                  Dashboard                   Anchor=Newsletter
    VerifyText                  Task Reporting
    ClickText                   Show menu
    VerifyText                  VIP Begin Day
    VerifyText                  Live Order
    VerifyText                  New Customer Request        Anchor=2
    #VerifyText                 Circana Portal
    VerifyText                  Employee Center
    VerifyText                  SipMarket Registration
    VerifyText                  SipMarket Keg Box
    VerifyText                  SipMarket Forgot Password
    VerifyText                  Route Change Requests
    VerifyText                  Training Docs
    VerifyText                  Fintech Evite
    #VerifyText                 User Route Update
    VerifyText                  Fintech                     Anchor=2


Verify Home page for ISR
    [Documentation]             This is to verify command center for FSR
    [Arguments]
    ClickText                   Show Navigation Menu
    ClickText                   Home
    ClickElement                xpath\=//button[@class\='slds-button slds-button_icon-border slds-button_last']
    VerifyText                  Kronos
    VerifyText                  Web VIP
    VerifyText                  Maps - Accounts Near Me
    VerifyText                  Live Order
    VerifyText                  New Customer Request
    VerifyText                  Cisco
    VerifyText                  Route Change Requests
    VerifyText                  SipMarket Registration
    VerifyText                  Wall Board East
    VerifyText                  Wall Board West
    VerifyText                  Wall Board NA
    VerifyText                  Web Board
    VerifyText                  Sharepoint
    VerifyText                  Employee Center
    #VerifyText                 Circana Portal
    VerifyText                  Fintech Evite
    VerifyText                  Training Docs
    ClickText                   Training Docs
    SwitchWindow                NEW
    SwitchWindow                3
    VerifyText                  Training Files
    SwitchWindow                2


Verify Home page for Merch
    [Documentation]             This is to verify command center for Merch
    [Arguments]
    VerifyText                  Live Order
    VerifyText                  Employee Center
    VerifyText                  Training Docs
    VerifyText                  Fintech
    VerifyText                  All Newsletters
    ClickText                   Training Docs
    SwitchWindow                NEW
    SwitchWindow                3
    VerifyText                  Training Files
    SwitchWindow                2
Draft Beer Calculator
    [Documentation]             This is to test Profit Calculator
    [Arguments]
    ClickText                   Profit Calculator
    TypeText                    Competitor Draft Name       beer1
    TypeText                    Price per Keg (Price to Retailer)                       23
    ClickElement                xpath\=//*[@class\='slds-combobox__input slds-input_faux fix-slds-input_faux']
    ClickText                   1/4 Barrel
    TypeText                    Price per Serving (Price to Consumer)                   25
    TypeText                    Serving Size in Ounces (Pour Size)                      5
    TypeText                    Velocity per Month (Number of Kegs)                     5
    ClickText                   Add a Product to Compare
    ClickCheckbox               Use Reyes Product?YesNo     on                          Anchor=2
    TypeText                    Search by product name, item number, pkg type           mill                        Anchor=2
    Sleep                       3s
    ClickElement                xpath\=//*[@class\='slds-listbox__option-text slds-listbox__option-text_entity slds-cell-wrap']
    TypeText                    Price per Serving (Price to Consumer)                   110                         Anchor=2
    TypeText                    Serving Size in Ounces (Pour Size)                      5                           Anchor=2
    TypeText                    Velocity per Month (Number of Kegs)                     5.3                         Anchor=2
    Sleep                       5s
    ClickText                   Calculate
    ClickText                   Save for Later
    TypeText                    Profit Calculation Record Name                          Draft Beer profit calculation
    ClickText                   Save                        partial_match=False
    Sleep                       3s
    ClickText                   Draft Beer profit calculation
    VerifyText                  Profit Calculation\Draft Beer profit calculation

Packaged Beer Calculator
    [Documentation]             This is to test Profit Calculator
    [Arguments]
    Select the first Account
    ClickText                   More                        Anchor=2
    ClickText                   Profit Calculator
    ClickText                   Packaged Calculator
    TypeText                    Competitor Packaged Name    beer1
    TypeText                    Case Cost (Price to Retailer)                           23
    ClickText                   Case Size
    Sleep                       3s
    ClickText                   6 Unit Case
    TypeText                    Price Charged Per Retail Package (Price to Consumer)    25
    ClickText                   Retail Package Size
    ClickText                   6 Pack
    TypeText                    Cases Sold per Month        5
    ClickText                   Add a Product to Compare
    ClickCheckbox               Use Reyes Product?YesNo     on                          Anchor=2
    TypeText                    Search by product name, item number, pkg type           mill                        Anchor=2
    Sleep                       3s
    ClickElement                xpath\=//*[@class\='slds-listbox__option-text slds-listbox__option-text_entity slds-cell-wrap']
    TypeText                    Price Charged Per Retail Package (Price to Consumer)    110                         Anchor=2
    ClickText                   Retail Package Size         Anchor=2
    ClickText                   6 Pack                      Anchor=2
    TypeText                    Cases Sold per Month        5                           Anchor=2
    Sleep                       5s
    ClickText                   Calculate
    Sleep                       5s
    ClickText                   Save for Later
    TypeText                    Profit Calculation Record Name                          Packaged Beer profit calculation
    ClickText                   Save                        partial_match=False
    Sleep                       3s
    ClickText                   Packaged Beer profit calculation
    VerifyText                  Profit Calculation\Packaged Beer profit calculation


Spirit Calculator
    [Documentation]             This is to test Profit Calculator
    [Arguments]
    Select the first Account
    #ClickText                  More                        Anchor=2
    ClickText                   Profit Calculator
    ClickText                   Spirit Calculator
    TypeText                    Competitor Spirit Name      Spirit1
    TypeText                    Case Cost (Price to Retailer)                           23
    ClickElement                xpath\=//*[@class\='slds-combobox__input slds-input_faux fix-slds-input_faux']
    Sleep                       3s
    ClickText                   1000ML
    ClickElement                xpath\=//*[@class\='slds-combobox__input slds-input_faux fix-slds-input_faux']
    ClickText                   12 Pack
    TypeText                    Price per Serving (Price to Consumer)                   25
    TypeText                    Pour Size (Serving Size in Ounces)                      3.5
    TypeText                    Cases Sold per Month        3
    ClickText                   Add a Product to Compare
    ClickCheckbox               Use Reyes Product?YesNo     on                          Anchor=2
    TypeText                    Search by product name, item number, pkg type           New                         Anchor=2
    Sleep                       3s
    ClickElement                xpath\=//*[@class\='slds-listbox__option-text slds-listbox__option-text_entity slds-cell-wrap']
    Sleep                       5s
    TypeText                    Price per Serving (Price to Consumer)                   50                          Anchor=2
    TypeText                    Pour Size (Serving Size in Ounces)                      1.5                         Anchor=2
    TypeText                    Cases Sold per Month        6                           Anchor=2
    Sleep                       5s
    ClickText                   Calculate
    Sleep                       5s
    ClickText                   Save for Later
    TypeText                    Profit Calculation Record Name                          Packaged Beer profit calculation
    ClickText                   Save                        partial_match=False
    Sleep                       3s
    ClickText                   Packaged Beer profit calculation
    VerifyText                  Profit Calculation\Packaged Beer profit calculation

Select the first Account
    [Documentation]             This to click first Account in the list View
    [Arguments]
    ClickText                   Accounts                    Partial_match=False
    sleep                       3s
    ClickElement                xpath=(//a[@data-refid\="recordId"])[1]

Select the first Case
    [Documentation]             This to click first Case in the list View
    [Arguments]
    ClickText                   Show Navigation Menu
    Sleep                       3s
    ClickText                   Cases
    ClickText                   Select a List View: Cases
    ClickText                   General ISR Case Queue
    ClickElement                xpath=(//a[@data-refid\="recordId"])[1]


Create Merch Checklist
    [Documentation]             To create Merch Checklist
    [Arguments]
    ClickText                   Merch Checklist             partial_match=False
    UseModal                    On
    ClickText                   Create/Update Checklist
    #ClickText                  Select a date for           anchor=*Checklist Date
    #Sleep                      3s
    Select Future Date          5 days                      Checklist Date
    Sleep                       3s
    ClickElement                xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    TypeText                    Store Contact Name          store contact name
    TypeText                    General Comments            comments with long text ...
    ClickText                   Create Merch Checklist
    ClickElement                xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    ClickText                   Create New Task
    ClickText                   Create/Update Task
    TypeText                    Subject                     task Subject
    TypeText                    Task Details                task details
    DropDown                    Location                    Front Endcap
    ComboBox                    Search Products...          2 SILOS CITRALICIOUS K 1/6BBL
    ClickText                   Save Task
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png
    ClickText                   Continue
    ClickText                   Done                        Anchor=2
    UseModal                    Off

Create Merch Checkout with Breakage
    [Documentation]             To create a Merch Checkout with Breakage
    [Arguments]
    ClickText                   Merch Checkout              partial_match=False
    UseModal                    On
    ClickText                   Create/View Checkout
    DropDown                    *                           Yes
    Select Future Date          0 days                      Checkout Date
    TypeText                    Store Contact Name          store contact name
    ClickCheckbox               Breakage in Store           on
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Back Room Photos (required)
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Cooler Photos (required)
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Non Alcoholic Shelf Photos (required)
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=RTD Photos (required)
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Display Photos (optional)
    ClickText                   Update/Close Checkout

Create Merch Checkout without Breakage
    [Documentation]             To create a Merch Checkout without Breakage
    [Arguments]
    ClickText                   Merch Checkout              partial_match=False
    UseModal                    On
    ClickText                   Create/View Checkout
    DropDown                    *                           Yes
    Select Future Date          0 days                      Checkout Date
    TypeText                    Store Contact Name          store contact name
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Back Room Photos (required)
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Cooler Photos (required)
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Non Alcoholic Shelf Photos (required)
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=RTD Photos (required)
    ClickText                   Update/Close Checkout

Create New Elite Merch Survey
    [Documentation]             To create New Elite Merch Survey
    [Arguments]
    ClickText                   Surveys
    ClickText                   New ELITE Merch Survey
    DropDown                    *                           East
    ClickText                   Next
    ComboBox                    Search People...            Ronald Starke
    DropDown                    Were any RBG cases missed during service?               10
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Question 1 Image
    DropDown                    Are Displays properly rotated?                          Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Question 2 Image
    DropDown                    How many RBG cases were out of rotation in the cooler?                              10
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Question 3 Image
    DropDown                    Are the displays safely built? Properly tied up? Built to Standard?                 Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Question 4 Image
    DropDown                    Are the shelves stocked according to RBG company standard?                          Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Question 5 Image
    DropDown                    Is the back room organized, workable and condensed?     Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Question 6 Image
    DropDown                    Is the backstock rotated?                               Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Question 7 Image
    DropDown                    Is the breakage stored/staged in the proper place?      Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Question 8 Image
    DropDown                    Did the Merchandiser clean up all the trash before leaving the store?               Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Question 9 Image
    DropDown                    Did the Merchandiser fill and face all Non-Alcoholic product(s)?                    Yes
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png      Anchor=Question 10 Image
    TypeText                    Comments                    comments
    ClickText                   Next
    VerifyText                  Thank you for successfully filling out the Elite Merch Store Survey, have a great rest of your day.
    ClickText                   close
    ClickText                   Yes

Create Data Driven Survey
    [Documentation]             Create data driven survey
    [Arguments]
    ClickText                   Data Driven Wins Surveys    anchor=Menu Surveys
    ClickText                   New Data Driven Wins Survey
    TypeText                    input-1432                  opportunity seen at the account
    TypeText                    input-1433                  circana fact based data presented
    TypeText                    input-1434                  result
    ClickText                   Upload FilesOr drop files
    TypeText                    Upload FilesOr drop files                               C:\\fakepath\\MicrosoftTeams-image (56).png
    ClickText                   Finish Survey
    ClickText                   Close


Create Elite Survey
    [Documentation]             Create Elite Survey
    [Arguments]
    Select the first Account
    ClickText                   Surveys
    ClickText                   New ELITE Survey
    DropDown                    *                           Large Format
    ClickText                   Next
    DropDown                    Survey Completed by         Manager Alone
    DropDown                    *Is the RBG Display Support of Feature consistent with local objectives?            Yes
    TypeText                    Question Comments           cccc                        anchor=Support of Feature Picture
    ClickText                   Upload Files                anchor=Support of Feature Picture
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png
    DropDown                    *Is the overall display of cases on the sales floor at standard as defined by the business?                     No
    TypeText                    Question Comments           dddd                        anchor=Is the overall display of cases on the sales floor at standard as defined by the business?
    ClickText                   Upload Files                anchor=Display Cases Picture
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png
    DropDown                    *Are planner items merchandised and executed?           Yes
    TypeText                    Question Comments           eeee                        anchor=Are planner items merchandised and executed?
    ClickText                   Upload Files                anchor=Planner Items Image
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png
    DropDown                    *Are all beyond beer non alc products executed as defined by the business?          Yes
    DropDown                    *Do displays have legal consumer offers and legal POS equal to, or greater than competition?                    Yes
    DropDown                    *Is the cooler set by schematic with correct pricing and packages?                  Yes
    DropDown                    *Is the RBG Product Quality Policy being followed?      Yes
    DropDown                    *Is the back room clean and organized?*                 Yes
    DropDown                    *Does RBG have any controllable Out of Stocks?          Yes
    DropDown                    Is E360 updated with current buyer contact/email info?                              Yes
    ComboBox                    Were the Consultant 2.0 steps to a Sales Call followed?                             Prepare to make the call.
    ClickText                   Move selection to Selected
    DropDown                    *Were any existing sales tools used to secure features or distribution during sales?                            Yes
    ComboBox                    Sales Tools                 Elite Performance Sales Dashboard
    ClickText                   Move selection to Selected                              anchor=Available
    ClickText                   Next                        anchor=Previous
    ClickText                   Capture Signature
    ClickText                   Next
    VerifyText                  Score:
    ClickText                   Finish

Create Failed Scan
    [Documentation]             Create Failed Scan
    [Arguments]
    ClickText                   Products
    ClickElement                xpath=(//a[@data-refid\="recordId"])[1]
    ClickText                   New Failed Scan
    UseModal                    On
    ClickElement                xpath\=//*[@class\='slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right']
    TypeText                    Account                     39 Ocean Prime
    ComboBox                    Search Accounts...          \# 39 OCEAN PRIME ORLANDO
    DropDown                    *                           Vendor Information Incorrect or Pricing Issue
    TypeText                    *                           comments
    ClickText                   Next
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png
    ClickText                   Next
    ClickText                   Finish
    UseModal                    Off
    ClickText                   New Failed Scan
    UseModal                    On
    ClickElement                xpath\=//*[@class\='slds-combobox__form-element slds-input-has-icon slds-input-has-icon_right']
    TypeText                    Account                     39 Ocean Prime
    ComboBox                    Search Accounts...          \# 39 OCEAN PRIME ORLANDO
    ClickElement                xpath\=//*[@class\='slds-select']
    #PickList                   Failed Scan Reason          Item Not Scanning / Not Found / Not on File
    DropDown                    *                           Item Not Scanning / Not Found / Not on File
    ClickText                   Next
    DropDown                    Is this item in the schematic?                          YES
    ClickText                   Next
    #UploadFile                 Upload Files                /home/services/suite/MicrosoftTeams-image (56).png
    #ClickText                  Next
    ClickText                   Finish
    UseModal                    Off

Create a Menu Survey
    [Documentation]             Create a Menu Survey
    [Arguments]
    ClickText                   Accounts
    ClickText                   Select a List View: Accounts
    ClickText                   menu survey
    sleep                       3s
    ClickElement                xpath=(//a[@data-refid\="recordId"])[1]
    UseTable                    Account Name
    ClickText                   Take Survey                 Anchor=Menu Survey
    ClickElement                xpath\=//*[@class\='slds-combobox__input slds-input_faux fix-slds-input_faux slds-combobox__input-value']
    ClickText                   Yes
    ClickElement                xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    VerifyText                  What are the cocktails? *
    TypeText                    *Cocktail Item Name         cocktail 1
    ClickText                   No
    PickList                    Liquor Type                 Gin
    Picklist                    Liquor Brand                Barton
    UploadFile                  Upload Files                /home/services/suite/MicrosoftTeams-image (56).png
    ClickElement                xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    ClickElement                xpath\=//*[@class\='slds-combobox__input slds-input_faux fix-slds-input_faux slds-combobox__input-value']
    ClickText                   Yes
    ClickElement                xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    ClickText                   No                          anchor=Please select the Gin Well Liquor Brand:
    PickList                    Well Brand                  Barton
    ClickText                   No                          anchor=Please select the Rum Well Liquor Brand:
    PickList                    Well Brand                  Concierge
    #ClickElement               xpath\=//*[@class\='slds-combobox__input slds-input_faux slds-combobox__input-value']
    #ClickText                  Concierge
    ClickElement                xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    ClickText                   Finish                      2

Create Order on a Case
    [Documentation]             Create Order on a Case
    [Arguments]
    #ClickText                  Minimize
    Select the first Case
    ClickText                   New Order
    ClickText                   Select a date for           anchor=Clear
    ClickText                   13
    ClickText                   Select Origin               anchor=*
    ClickText                   Email To Order              anchor=Clear
    ClickText                   Order Products
    UseTable                    SortProduct Nameicon
    #ClickCell                  r1c8
    #TypeText                   01t6g000003eRXaAAM          22
    #TypeText                   01t6g000003eQdLAAU          3
    ClickElement                xpath\=//*[@class\='slds-input qtyInput']
    TypeText                    xpath\=//*[@class\='slds-input qtyInput']               2
    ClickText                   Apply Changes
    #ClickText                  Account Details
    #ClickText                  Tasks
    #ClickText                  Notes                       anchor=Tasks
    #ClickText                  New                         anchor=(12)
    #TypeText                   *Title                      test notes
    #TypeText                   //*[@id\='modal-content-id-10-1403']/lightning-input-rich-text[1]/div[1]/div[1]/div[1]/div[2]/div[1]            testing
    #ClickText                  Save
    #ClickText                  Cases                       anchor=Tasks
    #ClickText                  Order Products
    ClickText                   Submit Order
    ClickText                   Select an Option            anchor=Off Day/Off Frequency Reason
    ClickText                   RBD Out of Stock            anchor=close
    ClickText                   Yes
    #ClickText                  Cigar City Jai Alai 24 - 12oz Cans, 6 Pack 24 - 12oz Cans, 6 Pack
    ClickText                   Order Summary


Create Task FSR
    [Documentation]             This is to create Task
    [Arguments]
    Select the first Account
    ClickText                   New Task
    DropDown                    None                        Call
    ClickText                   Next                        anchor=Select a Record Type
    UseModal                    on
    TypeText                    *Subject                    My Task
    Select Future Date          10 days                     Due Date
    TypeText                    *Comments                   comments
    UseTable                    Choose a RowSelect All
    Click Element               xpath=//div[@class="slds-modal__container"]//span[@class="slds-checkbox" and ./input[@class="datatable-select-all"]]
    DropDown                    Priority                    High
    DropDown                    Status                      Open
    ClickCheckbox               Photo Required              on
    ClickCheckbox               Photo Required              off
    ClickText                   Save
Create Task ISR
    [Documentation]             This is to create Task
    [Arguments]
    ClickText                   Show Navigation Menu
    ClickText                   Accounts
    Select the first Account
    ClickText                   More                        Anchor=2
    ClickText                   Critical Minute
    ClickText                   New Task
    DropDown                    None                        Call
    ClickText                   Next                        anchor=Select a Record Type
    UseModal                    on
    TypeText                    *Subject                    My Task
    Select Future Date          10 days                     Due Date
    TypeText                    *Comments                   comments
    UseTable                    Choose a RowSelect All
    Click Element               xpath=//div[@class="slds-modal__container"]//span[@class="slds-checkbox" and ./input[@class="datatable-select-all"]]
    DropDown                    Priority                    High
    DropDown                    Status                      Open
    ClickCheckbox               Photo Required              on
    ClickCheckbox               Photo Required              off
    ClickText                   Save

Verify tab order on Account
    [Documentation]             This is to verify tab order on Account for ISR
    [Arguments]
    VerifyText                  Activity
    VerifyText                  Open Orders                 partial_match=False
    VerifyText                  Invoices                    partial_match=False
    VerifyText                  Critical Minute
    VerifyText                  Profit Calculator
    VerifyText                  Chatter
    VerifyText                  Allocations
    ClickText                   More
    VerifyText                  Visit History
    VerifyText                  Order History
    VerifyText                  Account Scorecard
    VerifyText                  Circana/NIQ
    VerifyText                  FSR/OMNI Visit Day
    VerifyText                  Text Transcripts
    VerifyText                  Market Trends
    VerifyText                  Sales Trends
    VerifyText                  Nearby Accounts

Verify tabs on Account
    [Documentation]             This is to verify tabs on Account for Merch
    [Arguments]
    VerifyText                  Merch Tasks
    VerifyText                  Account Scorecard
    VerifyText                  Details
    VerifyText                  Nearby Accounts
    VerifyText                  Visit History
    VerifyText                  Surveys
    VerifyText                  Alerts
    VerifyText                  Orders and Invoices
    VerifyText                  Chatter                     Anchor=2
    VerifyText                  Contacts                    Anchor=2
    VerifyText                  Pinned Products
    VerifyText                  Cases                       Anchor=2

View and Download Invoice
    [Documentation]             This is view and Download Invoice
    [Arguments]
    ClickText                   Accounts
    ClickElement                xpath=(//a[@data-refid\="recordId"])[1]
    ClickText                   More                        Anchor=2
    ClickText                   Orders and Invoices
    ClickText                   View Invoice
    UseTable                    Invoice #
    ClickCell                   r1c3
    ClickCell                   r5c3
    ClickText                   Adobe PDF
    ClickText                   Download
    CloseWindow
    SwitchWindow                NEW