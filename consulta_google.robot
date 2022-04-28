*** Settings ***
Documentation    Testes no Buscador do Google
...  abre o navegador Chrome
...  realiza a consulta

Library  SeleniumLibrary
Library  OperatingSystem

*** Variables ***
${browser}      Chrome
${url}          https://www.google.com.br

*** Test Cases ***
Consulta Google
    [Tags]    rapido
    Acessar o Chrome na pagina <https://www.google.com.br>
    Digitar "Ovos de Páscoa" na pesquisa
    Validar se aparece no titulo da guia o resultado esperado
    Fechar o browser

*** Keywords ***
Setup chromedriver
    Set Environment Variable  webdriver.chrome.driver  C:\\Users\\bearu\\PycharmProjects\\133PetsRobotFramework\\venv\\WebDriverManager\\chrome\\100.0.4896.60\\chromedriver_win32\\chromedriver.exe

Acessar o ${browser} na pagina <${url}>
    Open Browser       ${url}           ${browser}

Digitar "${palavra_chave}" na pesquisa
    Set Test Variable  ${palavra_chave}
    input text          name = q        ${palavra_chave}
    press keys          name = q        ENTER

Validar se aparece no titulo da guia o resultado esperado
    ${titulo}           get title
    Should contain      ${titulo}       ${palavra_chave}

Fechar o browser
    close browser