*** Settings ***
Documentation     Online

Resource    ../resources/base.resource

*** Test Cases ***
Serverest deve estar online

    Start Session
    Get Title    equal    Front - ServeRest