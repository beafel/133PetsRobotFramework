*** Settings ***
Documentation    Consultas no site da Petz

Library  SeleniumLibrary
Library  OperatingSystem
Library  String

Test Teardown   close browser

*** Variables ***
${browser}      Chrome
${url}          https://www.petz.com.br

*** Test Cases ***
Consulta Produto com Clique na Lupa
    [Tags]    lupa
    Dado que acesso o site
    Quando escrevo "Ração" na barra de pesquisa
    E clico no botao da lupa
    Entao exibe um grid e a frase do resultado esperado

Consulta Produto Apertando Enter
    [Tags]    enter
    Dado que acesso o site
    Quando escrevo "Coleira" na barra de pesquisa
    E aperto o Enter
    Entao exibe um grid e a frase do resultado esperado

Compra Produto
    [Tags]    enter
    Dado que acesso o site
    Quando escrevo "Comedouro" na barra de pesquisa
    E aperto o Enter
    Entao exibe um grid e a frase do resultado esperad


*** Keywords ***
Dado que acesso o site
    open browser                    ${url}                                  ${browser}

Quando escrevo "${palavra_chave}" na barra de pesquisa
    Set Test Variable               ${palavra_chave}
    wait until element is enabled   name = q                                30ms
    input text                      name = q                                ${palavra_chave}

E clico no botao da lupa
    click element                   class = button-search

Entao exibe um grid e a frase do resultado esperado
    ${palavra_chave_upper}          convert to upper case                   ${palavra_chave}
    wait until element is visible   css = h1.h2Categoria.nomeCategoria
    element should contain          css = h1.h2Categoria.nomeCategoria      RESULTADOS PARA "${palavra_chave_upper}"

Fecha o browser
    close browser

E aperto o Enter
    press keys                      name = q                                ENTER