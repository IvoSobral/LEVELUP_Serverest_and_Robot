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


Notice should be email sem @
    [Documentation]    Verifica a mensagem de erro de email invalido.
    [Arguments]    ${expected_message}    ${email}

    ${xpath}=    Set Variable    xpath=//small[contains(text(), '${expected_message}')]

    Wait For Elements State    ${xpath}    state=visible
    
    ${actual_message}=    Get Text    ${xpath}
    Should Contain    ${actual_message}    ${expected_message}
    Should Contain    ${actual_message}    ${email}


