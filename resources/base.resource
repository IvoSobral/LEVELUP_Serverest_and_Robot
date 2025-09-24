*** Settings ***

Library    Browser
Library    JSONLibrary
Library    libs/api.py

Resource    env.resource
Resource    pages/LoginPage.resource
Resource    pages/ProductPage.resource

*** Keywords ***
Start Session
    New Browser    browser=chromium    headless=False
    New Page    ${BASE_URL}

Get Fixtures
    [Arguments]    ${file_name}    ${scenario}

    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8

    RETURN    ${data}[${scenario}]