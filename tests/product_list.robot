*** Settings ***
Documentation     Teste da lista de produtos no frontend

Resource    ../resources/base.resource

Suite Setup    Setup Suite Environment
Suite Teardown    Take Screenshot

*** Test Cases ***
Deve adicionar um produto a Lista de Compras
    [Tags]    products

    Request Add    ${product_data}[nome]
    Sleep    1
    Get Text    body    contains    ${product_data}[nome]

Deve limpar a lista de produtos
    [Tags]    products

    Go To    ${BASE_URL}/minhaListaDeProdutos
    Sleep    1
    Click    [data-testid="limparLista"]
    Sleep    1
    Get Text    [data-testid="shopping-cart-empty-message"]    ==    Seu carrinho está vazio