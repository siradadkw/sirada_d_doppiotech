*** Settings ***
Library        SeleniumLibrary

*** Variables ***
${locator_accept_cookies}    //*[@id="rcc-confirm-button"]
${locator_loan_calculation_button}    //*[@id="LoanType"]/div/div/div[2]/div/div[1]/div/button   
${locator_occupation_subject}    //*[@id="loancalculatorpage_job"]
${locator_occupation_button}    //*[@id="loancalculatorpage_job"]/div/div/div
${locator_occupation_employee_button}    //*[@id="menu-"]/div[3]/ul/li[2]
${locator_monthlyincome_box}    //*[@id="loan-calculator"]/div/div/div[2]/div[1]/div/div/div[4]/form/div/div[1]/div[2]/div/div/div/input
${locator_result_type_button}    //*[@id="loancalculatorpage_duration"]/div/div/div
${locator_result_type_option1_button}    //*[@id="menu-"]/div[3]/ul/li[2]
${locator_loan_type_button}    //*[@id="loancalculatorpage_loantype"]/div/div/div
${locator_loan_type_cardxspeedy_button}    //*[@id="menu-"]/div[3]/ul/li[2]
${locator_creditlimit_box}    //*[@id="loan-calculator"]/div/div/div[2]/div[1]/div/div/div[4]/form/div/div[1]/div[3]/div/div/div/input
${locator_desiredlimit_subject}    //*[@id="loan-calculator"]/div/div/div[2]/div[1]/div/div/div[4]/form/div/div[1]/div[3]/div/span/span
${locator_installmentperiod_subject}    //*[@id="loan-calculator"]/div/div/div[2]/div[1]/div/div/div[4]/form/div/div[1]/div[4]/div/span
${locator_reminder_text}    //*[@id="loan-calculator"]/div/div/div[2]/div[1]/div/div/div[4]/form/div/div[1]/div[3]/span[2]


*** Keywords ***

Verify Cookie Policy Url
    ${cookie_url}    Get Element Attribute    //*[@class="CookieConsent"]//a    href
    Should Contain    ${cookie_url}    /cookies-policy

Click Accept Cookies
    Click Button    ${locator_accept_cookies}

Click Loan Calculation
    Click Button    ${locator_loan_calculation_button}

Select Occupation
    Click Element    ${locator_occupation_button}  

Choose Employee
    Click Element    ${locator_occupation_employee_button}

Select Result Type
    Click Element    ${locator_result_type_button}

Choose Result Type Option 1
    Click Element    ${locator_result_type_option1_button}

Select Loan Type
    Click Element    ${locator_loan_type_button}    

Choose CardX SPEEDY LOAN
    Click Element    ${locator_loan_type_cardxspeedy_button}

Input Monthly Income
    [Arguments]    ${MonthlyIncome} 
    Press Keys    ${locator_monthlyincome_box}    CTRL+A+BACKSPACE
    Input Text    ${locator_monthlyincome_box}    ${MonthlyIncome} 

Input Desired Credit Limit
    [Arguments]    ${CreditLimit}        
    Press Keys    ${locator_creditlimit_box}    CTRL+A+BACKSPACE
    Input Text    ${locator_creditlimit_box}    ${CreditLimit}


Reminder Text Appears Correctly
    [Arguments]    ${ReminderText}
    Element Text Should Be    ${locator_reminder_text}     ${ReminderText}  


*** Test cases ***
TC-001 Verify that the credit limit reminder text appears when select occupation, result type, loan type, input monthly income and desired credit limit that exceeds 3 times of monthly income
    Open Browser    https://www.cardx.co.th/    browser=chrome
    Maximize Browser Window
        Verify Cookie Policy Url
            Click Accept Cookies
                Click Loan Calculation
                Wait Until Element Is Visible    ${locator_occupation_subject}
                    Select Occupation
                    Choose Employee
                        Select Result Type
                        Choose Result Type Option 1
                            Select Loan Type
                            Choose CardX SPEEDY LOAN
                            Sleep    0.5
                                Scroll Element Into View    ${locator_desiredlimit_subject}
                                Sleep    0.5
                                    Input Monthly Income    25000
                                    Scroll Element Into View    ${locator_installmentperiod_subject}
                                    Sleep    0.5
                                        Input Desired Credit Limit    500000    
                                            Reminder Text Appears Correctly    วงเงินทั้งหมดจะต้องไม่เกิน 3 เท่าของรายได้ต่อเดือนและไม่เกิน 37,000 บาท
                 
    
    Sleep    5

