*** Settings ***
Documentation    Ações e elementos da página de produtos

Library    Browser

*** Keywords ***
Product should be resgistered
    [Arguments]    ${task_name}

    Wait For Elements State    css=h5 >> text=${task_name}
    ...    visible    5


