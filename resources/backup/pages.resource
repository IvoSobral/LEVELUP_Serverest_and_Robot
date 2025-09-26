*** Settings ***
Library           Browser
Documentation    Componente de Alertas
Resource    ../../resources/base.resource
Resource    ../../resources/env.resource


*** Keywords ***


Go To signup page    
    Go to     ${BASE_URL}/login
    Wait For Elements State    css=h1    state=visible    timeout=5000ms
    Get Text     css=h1    equal    Login


    
Go to signup form 
    Click       css=.btn.btn-link
    Get Text     css=h2    equal     Cadastro 
    
