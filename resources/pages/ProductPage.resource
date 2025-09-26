*** Settings ***
Documentation    Ações e elementos da página de produtos

Library    Browser

Resource    ../base.resource

*** Keywords ***
Product should be resgistered
    [Arguments]    ${task_name}

    Wait For Elements State    css=h5 >> text=${task_name}
    ...    visible    5

Setup Suite Environment
    ${token}=    Setup Admin And Get Token
    Delete User By Email From Fixtures    common
    Create User From Fixtures    common
    Delete Product By Name From Fixtures    produto_mouse    ${token}
    Create Product From Fixtures    produto_mouse    ${token}

    Start Session
    ${user}=    Get Fixtures    users    common
    Submit Login Form    ${user}
    User Should Be Logged In Products

    ${product_data}=    Get Fixtures    products    produto_mouse
    Set Suite Variable    ${product_data}
