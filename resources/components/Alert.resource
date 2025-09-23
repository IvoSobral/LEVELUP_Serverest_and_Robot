*** Settings ***
Library           Browser
Documentation    Componente de Alertas

*** Keywords ***


ALert should be   
  [arguments]    ${expected_text} 
   Wait For Elements State    css=.alert.alert-secondary.alert-dismissible >> text=${expected_text}   
    ...        visible    5000ms  
    ...    



