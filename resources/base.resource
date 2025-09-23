*** Settings ***
Library        Browser
Library        JSONLibrary
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
    New Page    ${BASE_URL}

Take Page Screenshot
    ${timestamp}    Get Time    epoch
    Take Screenshot    filename=screenshot_${timestamp}.png
