*** Settings ***
Documentation     Teste da lista de produtos no frontend

Resource    ../resources/base.resource

Suite Setup    Setup Data Once
Test Setup    Start Session And Login
Test Teardown    Take Screenshot

*** Keywords ***
Setup Data Once
    ${token}=    Setup Admin And Get Token
    Delete User By Email From Fixtures    common
    Create User From Fixtures    common
    Delete Product By Name From Fixtures    produto_mouse    ${token}
    Create Product From Fixtures    produto_mouse    ${token}
    
    Set Suite Variable    ${product_data}    ${EMPTY}
    ${product_data}=    Get Fixtures    products    produto_mouse
    Set Suite Variable    ${product_data}

Start Session And Login
    Start Session
    ${user}=    Get Fixtures    users    common
    Submit Login Form    ${user}
    User Should Be Logged In

*** Test Cases ***
Deve adicionar um produto a Lista de Compras
    [Tags]    products

    Request Add    ${product_data}[nome]
    Get Text    body    contains    ${product_data}[nome]

Deve limpar a lista de produtos
    [Tags]    products

    Request Add    ${product_data}[nome]
    Go To    ${BASE_URL}minhaListaDeProdutos
    Click    [data-testid="limparLista"]
    Get Text    [data-testid="shopping-cart-empty-message"]    ==    Seu carrinho está vazio