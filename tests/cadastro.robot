*** Settings ***
Documentation     Online API
Library           Browser
Library           FakerLibrary
Resource          ../resources/base.resource 
Resource           ../resources/env.resource
Test Setup        Start Session
Test Teardown     Take Page Screenshot


*** Test Cases ***


Cadastrar Usuario com sucesso
    [Documentation]    Cadastra um novo usuário com sucesso.
    Criar Usuario Dinamico 
    Go To signup page
    Go to signup form  
    Notice should be    Cadastro realizado com sucesso
    

 
Cadastrar Usuario com email duplicado
    [Documentation]    Tenta cadastrar um usuário com um e-mail já existente.
    
    Go To signup page
    Go to signup form
    Criar Usuario Estatico   
    
    Go To signup page
    Go to signup form
    Criar Usuario Estatico   
    ALert should be    Este email já está sendo usado


    
Verificar Campos obrigatorios vazios no formulario de cadastro
    Campos obrigatorios vazio
    ALert should be     Nome é obrigatório    
    ALert should be     Email é obrigatório  
    ALert should be     Password é obrigatório 

Verificar Cadastro com email incorreto 
   Go To signup page
   Criar Usuario Estatico com email invalido (sem @)



