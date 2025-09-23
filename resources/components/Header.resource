*** Settings ***
Library           Browser
Documentation    Componente de Header
Library         String

*** Keywords ***

User should be logged in
    [Arguments]   ${name}
    @{split_name}=    Split String    ${name}   
    ${element}  Set Variable    css=header .right small
    Wait For Elements State    ${element}    state=visible   timeout=5000ms
     Get Text    ${element}   equal    Olá, ${split_name}[0]