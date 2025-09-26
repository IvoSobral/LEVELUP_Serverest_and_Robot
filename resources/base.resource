*** Settings ***
Library    Browser
Library    JSONLibrary
Library    libs/api.py
Library    Collections
Resource    env.resource
Resource    pages/LoginPage.resource
Resource    pages/ProductPage.resource
Resource       ../resources/env.resource
Resource       ../resources/components/Alert.resource
Resource       ../resources/components/Notice.resource
Resource       ../resources/components/Header.resource
Resource       ../tests/online.robot
Resource       ../resources/cadastroKeyword.resource
Resource        ../resources/backup/pages.resource


*** Keywords ***
Start Session
    New Browser    browser=chromium    headless=False
    New Page       ${BASE_URL}

Get Fixtures
    [Arguments]    ${file_name}    ${scenario}

    ${data}    Load Json From File
    ...    ${EXECDIR}/resources/fixtures/${file_name}.json
    ...    encoding=utf-8

    RETURN    ${data}[${scenario}]


