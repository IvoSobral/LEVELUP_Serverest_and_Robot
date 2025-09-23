*** Settings ***
Library           Browser
Documentation    Componente de Notice

*** Keywords ***
Notice should be 
    [Arguments]   ${expected_text}
     ${element}  Set Variable    css=.alert-link
     Wait For Elements State    ${element}    
     ...        state=visible   
     ...        timeout=5000ms
     Get Text    ${element}   equal    ${expected_text}