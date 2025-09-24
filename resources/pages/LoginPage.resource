*** Settings ***
Documentation    Ações e elementos da página de login

Library    Browser

*** Keywords ***
Submit Login Form
    [Arguments]    ${user}
    Fill Text    input[name="email"]    ${user}[email]
    Fill Text    input[name="password"]    ${user}[password]
    Click    button[type="submit"]

User Should Be Logged In
    Wait For Elements State    css=h1 >> text=Serverest Store    visible    5

Request Add
    [Arguments]    ${Product_name}

    ${element}    Set Variable
    ...    //h5[text()="${Product_name}"]/..//button[@data-testid="adicionarNaLista"]

    Wait For Elements State    ${element}    visible    5

    Click    ${element}