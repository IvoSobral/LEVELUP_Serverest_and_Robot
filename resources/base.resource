*** Settings ***

Library     Browser
Library     Collections
Resource    env.resource

*** Keywords ***
Start Session
    New Browser    browser=chromium    headless=False
    New Page       ${BASE_URL}

Take Screenshot
    ${timestamp}       Get Time    epoch
    Take Screenshot    screenshot_${timestamp}