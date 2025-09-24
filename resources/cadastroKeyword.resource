*** Settings ***
Documentation   Elemntos e ações da pagina de cadastro
Library        Browser
Library        DateTime
Resource       ../resources/env.resource
Resource       ../resources/base.resource





*** Keywords ***


Criar Usuario Dinamico 
    [Documentation]    
    ...   ${eh_admin}
    ${timestamp}=    Get Current Date        result_format=%Y%m%d_%H%M%S
    ${nome_aleatorio}=    Generate Random String    length=8    chars=[LETTERS]
    ${nome_aleatorio}=    Convert To Lower Case    ${nome_aleatorio}

    
    ${nome_completo}=    Set Variable    Usuario_${nome_aleatorio}_${timestamp}
    ${email}=    Set Variable    ${nome_aleatorio}@qa.com
    ${senha}=    Set Variable    Senha${timestamp}


    Go To signup page  
    Go to signup form
    Wait For Elements State    css=h2    state=visible    timeout=5000ms
    Get Text    css=h2    equal    Cadastro


    Fill Text    css=input[name="nome"]    ${nome_completo}
    Fill Text    css=input[name=email]    ${email}
    Fill Text    css=input[name=password]    ${senha}

    Click    css=.btn.btn-primary >> text=Cadastrar

    Wait For Elements State    css=div.alert.alert-primary a.alert-link    state=visible    timeout=5000ms
    Get Text    css=div.alert.alert-primary a.alert-link    equal    Cadastro realizado com sucesso
    
    ${usuario_criado}=    Create Dictionary
    ...    nome=${nome_completo}
    ...    email=${email}
    ...    password=${senha}
    RETURN    ${usuario_criado}






Criar Usuario Estatico
    [Documentation]   

    ${nomeEstatico}=    Set Variable    fulano
    ${emailEstatico}=            Set Variable    fulano123@qa.com
    ${senha}=            Set Variable    teste123
    
   
    Go To signup page  
    Go to signup form
    Wait For Elements State    css=h2    state=visible    timeout=5000ms
    Get Text    css=h2    equal    Cadastro


    Fill Text    css=input[name=nome]    ${nomeEstatico}
    Fill Text    css=input[name=email]    ${emailEstatico}
    Fill Text    css=input[name=password]    ${senha}
    
    Click    css=button[type=submit] >> text=Cadastrar

    ${user}=    Create Dictionary
    ...    name=${nomeEstatico}
    ...    email=${emailEstatico}
    ...    password=${senha}
    RETURN    ${user}

 
Criar Usuario Estatico com email invalido (sem @)
    [Documentation]   

    ${nomeEstatico}=    Set Variable    fulano
    ${emailinvalido}=            Set Variable    fulano123qa.com
    ${senha}=            Set Variable    teste123
    
   
    Go To signup page  
    Go to signup form
    Wait For Elements State    css=h2    state=visible    timeout=5000ms
    Get Text    css=h2    equal    Cadastro


    Fill Text    css=input[name=nome]    ${nomeEstatico}
    Fill Text    css=input[name=email]    ${emailinvalido}
    Fill Text    css=input[name=password]    ${senha}
   
    Click    css=button[type=submit] >> text=Cadastrar
     Sleep  1

    ${user}=    Create Dictionary
    ...    name=${nomeEstatico}
    ...    email=${emailinvalido}
    ...    password=${senha}
    RETURN    ${user}
    ${ok}=    Evaluate JavaScript    ${emailinvalido}    element => element.checkValidity()
    Should Not Be True    ${ok}
    Notice should be email sem @    Inclua um "@" no endereço de email.    ${emailinvalido}
    

Criar Usuario Estatico com email invalido (sem .)
    [Documentation]   

    ${nomeEstatico}=    Set Variable    fulano
    ${emailinvalido}=            Set Variable    fulano123@qacom
    ${senha}=            Set Variable    teste123
    
   
    Go To signup page  
    Go to signup form
    Wait For Elements State    css=h2    state=visible    timeout=5000ms
    Get Text    css=h2    equal    Cadastro


    Fill Text    css=input[name=nome]    ${nomeEstatico}
    Fill Text    css=input[name=email]    ${emailinvalido}
    Fill Text    css=input[name=password]    ${senha}
    
    Click    css=button[type=submit] >> text=Cadastrar
    
    
    ${user}=    Create Dictionary
    ...    name=${nomeEstatico}
    ...    email=${emailinvalido}
    ...    password=${senha}
    RETURN    ${user}


Campos obrigatorios vazio  
    ${user}=  Create Dictionary
    ...  name=${EMPTY}
    ...  email=${EMPTY}
    ...  password=${EMPTY}
    
    Go To signup page
    Go to signup form
    Wait For Elements State  css=h2  state=visible  timeout=5000ms
    Get Text  css=h2  equal  Cadastro

    Fill Text  css=input[name=nome]  ${user.name}
    Fill Text  css=input[name=email]  ${user.email}
    Fill Text  css=input[name=password]  ${user.password}

    Click    css=button[type=submit] >> text=Cadastrar
    



  
  