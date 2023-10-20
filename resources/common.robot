*** Settings ***
Library                         QForce
Library                         String
Library                         DateTime

*** Variables ***
# IMPORTANT: Please read the readme.txt to understand needed variables and how to handle them!!
${BROWSER}                      chrome
${username}                     hfirdous@reyesholdings.com.uat
${automationpassword}           Beer123456!
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
    Sleep                       2s
    ClickText                   Minimize
    Sleep                       2s
    ClickText                   Show Navigation Menu
    Sleep                       2s

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
    ComboBox                    Search People...            Charles Kirk                index=2
    ComboBox                    Search People...            Charles Kirk                index=3
    ComboBox                    Search People...            Charles Kirk                index=4
    ComboBox                    Search People...            Charles Kirk                index=5
    ComboBox                    Search People...            Charles Kirk                index=6
    MultiPickList               Requested Delivery Days     Monday
    ClickText                   Move selection to Chosen
    MultiPickList               Requested Delivery Days     Thursday
    ClickText                   Move selection to Chosen
    PickList                    Visit Frequency             Twice Per Week
    MultiPickList               Visit Day(s)                Monday
    ClickText                   Move selection to Chosen    anchor=Available
    MultiPickList               Visit Day(s)                Thursday
    ClickText                   Move selection to Chosen    anchor=Available
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
    ComboBox                    Search People...            Charles Kirk                index=2
    ComboBox                    Search People...            Charles Kirk                index=3
    ComboBox                    Search People...            Charles Kirk                index=4
    ComboBox                    Search People...            Charles Kirk                index=5
    ComboBox                    Search People...            Charles Kirk                index=6
    MultiPickList               Requested Delivery Days     Monday
    ClickText                   Move selection to Chosen
    MultiPickList               Requested Delivery Days     Thursday
    ClickText                   Move selection to Chosen
    PickList                    Visit Frequency             Twice Per Week
    MultiPickList               Visit Day(s)                Monday
    ClickText                   Move selection to Chosen    anchor=Available
    MultiPickList               Visit Day(s)                Thursday
    ClickText                   Move selection to Chosen    anchor=Available
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
    ClickText                   Accounts
    ClickElement                xpath=(//a[@data-refid\="recordId"])[1]
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
    VerifyText                  Home
    VerifyText                  DSOF
    VerifyText                  Cases
    VerifyText                  My Open Pinned Products
    VerifyText                  Tasks                       Anchor=2
    VerifyText                  New Customer Requests
    VerifyText                  Newsletter
    VerifyText                  Dashboard                   Anchor=3
    VerifyText                  ELITE Dashboard
    ClickText                   Show menu
    VerifyText                  VIP Begin Day
    VerifyText                  Live Order
    VerifyText                  New Customer Request        Anchor=2
    VerifyText                  Circana Portal
    VerifyText                  Employee Center
    VerifyText                  SipMarket Registration
    VerifyText                  SipMarket Keg Box
    VerifyText                  SipMarket Forgot Password
    VerifyText                  Route Change Requests
    VerifyText                  Training Docs
    VerifyText                  Fintech Evite
    VerifyText                  User Route Update
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
    VerifyText                  Circana Portal
    VerifyText                  Training Docs
    ClickText                   Training Docs
    SwitchWindow                NEW
    SwitchWindow                3
    VerifyText                  Training Documents

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
    VerifyText                  Training Documents
Draft Beer Calculator
    [Documentation]             This is to test Profit Calculator
    [Arguments]
    TypeText                    Competitor Beer Name        beer1
    TypeText                    Price per Keg (Price to Retailer)                       23
    ClickElement                xpath\=//*[@class\='slds-combobox__input slds-input_faux']
    ClickText                   1/4 Barrel
    TypeText                    Price per Serving (Price to Consumer)                   25
    TypeText                    Serving Size in Ounces (Pour Size)                      5
    TypeText                    Velocity per Month (Number of Kegs)                     5
    ClickText                   Add a Product to Compare
    ClickCheckbox               Use Reyes Product?YesNo     on                          Anchor=2
    TypeText                    Search by product name, item number, pkg type           mill                        Anchor=2
    Sleep                       3s
    ClickText                   Miller Lite Half Barrel
    TypeText                    Price per Serving (Price to Consumer)                   110                         Anchor=2
    TypeText                    Serving Size in Ounces (Pour Size)                      5                           Anchor=2
    TypeText                    Velocity per Month (Number of Kegs)                     5                           Anchor=2
    ClickText                   Calculate
    ClickText                   Save for Later
    TypeText                    Profit Calculation Record Name                          Draft Beer profit calculation
    ClickText                   Save                        partial_match=False
    ClickText                   Draft Beer profit calculation
    VerifyText                  Profit Calculation\Draft Beer profit calculation

Packaged Beer Calculator
    [Documentation]             This is to test Profit Calculator
    [Arguments]
    TypeText                    Competitor Beer Name        beer1
    TypeText                    Case Cost (Price to Retailer)                           23
    ClickText                    Case Size
    Sleep                        3s                        
    ClickText                   6 Unit Case
    TypeText                    Price Charged Per Retail Package (Price to Consumer)                   25
    ClickText                   Retail Package Size
    ClickText                   6 Pack
    TypeText                    Cases Sold per Month                     5
    ClickText                   Add a Product to Compare
    ClickCheckbox               Use Reyes Product?YesNo     on                          Anchor=2
    TypeText                    Search by product name, item number, pkg type           mill                        Anchor=2
    Sleep                       3s
    ClickText                   Miller High Life 12 - 32oz Cans
    TypeText                    Price Charged Per Retail Package (Price to Consumer)                   110                         Anchor=2
    ClickText                   Retail Package Size                        Anchor=2
    ClickText                   6 Pack                        Anchor=2
    TypeText                    Cases Sold per Month                     5                           Anchor=2
    ClickText                   Calculate
    ClickText                   Save for Later
    TypeText                    Profit Calculation Record Name                          Packaged Beer profit calculation
    ClickText                   Save                        partial_match=False
    ClickText                   Packaged Beer profit calculation
    VerifyText                  Profit Calculation\Packaged Beer profit calculation

Select the first Account
    [Documentation]    This to click first Account in the list View
    [Arguments]
    ClickText          Accounts
    ClickElement       xpath=(//a[@data-refid\="recordId"])[1]

Create Merch Checklist
    [Documentation]    To create Merch Checklist
    [Arguments]
     ClickText          Merch Checklist             partial_match=False
    UseModal           On
    ClickText          Create/Update Checklist
    ClickText          Select a date for           anchor=*Checklist Date
    Sleep              3s
    Select Future Date          1 days             Checklist Date
    ClickElement       xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
    TypeText           Store Contact Name       store contact name
    TypeText           General Comments         comments with long text ...
    ClickText          Create Merch Checklist
    ClickElement       xpath\=//button[@class\='slds-button slds-button_brand'][normalize-space()\='Next']
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