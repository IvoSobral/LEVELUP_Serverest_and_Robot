*** Settings ***
Documentation    Criação de produtos

Resource    ../resources/base.resource

*** Test Cases ***
Fazer cadastro como administrador
    Start Session
    Go To    ${BASE_URL}

    Wait For Elements State    css=h1    visible    5s
    Get Text    css=h1    equal    Login
    
    # clica em cadastra-se
    Click    //*[@id="root"]/div/div/form/small/a

    Type Text    id=nome    teste123
    Type Text   id=email    teste123@gmail.com
    Type Text   id=password    senha123
    
    #clica em registrar como admin
    Click    //*[@id="root"]/div/div/form/div[4]/div/label
    
    #clica em Cadastrar
    Click    //*[@id="root"]/div/div/form/div[5]/button

Login no site e criação de um produto
    Start Session
    Go To    ${BASE_URL}/login

    Wait For Elements State    css=h1    visible    5s
    Get Text    css=h1    equal    Login

    Click    id=email
    Type Text    id=email    teste123@gmail.com
    Press Keys   id=email    Tab

    Click    id=password
    Type Text    id=password    senha123
    Press Keys   id=password    Tab

    Wait For Elements State    css=button[type="submit"]    visible    5s
    Click    css=button[type="submit"]
    
    # clica na opção de cadastrar produtos
    Click    //*[@id="root"]/div/div/p[2]/div[4]/div/div/a
    
    Type Text    id=nome    Teclado
    Type Text    id=price    200
    Type Text    id=description    Teclado mecanico
    Type Text    id=quantity    10

    # clica em criar o produto
    Click    //*[@id="root"]/div/div/div/form/div[6]/div/button
