*** Settings ***
Documentation    Consultas no site da Petz

Library  SeleniumLibrary
#Library  FlexSeleniumLibrary
Library  OperatingSystem
Library  String

##Test Setup      open browser
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
    [Tags]    rapido
    Dado que acesso o site
    E concordo com a Plicitica de Privacidade
    Quando escrevo "Comedouro retrátil" na barra de pesquisa
    E aperto o Enter
    Entao exibe um grid e a frase do resultado esperado
    Quando seleciono "Comedouro Bowl Retrátil Azul Oikos"
    Entao exibe a pagina do produto com o preco de "R$ 29,99"
    Quando mudo a quantidade do produto para "2"
    E clico no botao Adicionar no Carrinho
    Entao exibe a pagina do carrinho com o titulo da aba

*** Keywords ***
Dado que acesso o site
    open browser                    ${url}                                      ${browser}

E concordo com a Plicitica de Privacidade
    click button                    id = aceiteLgpd

Quando escrevo "${palavra_chave}" na barra de pesquisa
    Set Test Variable               ${palavra_chave}
    wait until element is enabled   name = q                                    30000ms
    input text                      name = q                                    ${palavra_chave}

E clico no botao da lupa
    click element                   class = button-search

Entao exibe um grid e a frase do resultado esperado
    ${palavra_chave_upper}          convert to upper case                       ${palavra_chave}
    wait until element is visible   css = h1.h2Categoria.nomeCategoria
    element should contain          css = h1.h2Categoria.nomeCategoria          RESULTADOS PARA "${palavra_chave_upper}"

E aperto o Enter
    press keys                      name = q                                    ENTER

Quando seleciono "${produto}"
    Set Test Variable               ${produto}
    wait until element is enabled   xpath = //a[@data-nomeproduto="${produto}"]
    click element                   xpath = //a[@data-nomeproduto="${produto}"]

Entao exibe a pagina do produto com o preco de "${preco}"
    wait until element is visible   css = div.product-title
    element should contain          css = div.product-title                     ${produto}
    element should contain          class = current-price-left                  ${preco}

Quando mudo a quantidade do produto para "2"
    click button                    xpath = //button[@onclick="changeQuantity('plus')"]

E clico no botao Adicionar no Carrinho
    click button                    id = adicionarAoCarrinho

Entao exibe a pagina do carrinho com o titulo da aba
    ${titulo}                       get title
#    Should contain                  ${titulo}

#Entao exibe a pagina do carrinho com o total de "${preco_total}"
#    wait until element is visible   class = tx-blue.money                       30000
#    element should contain          xpath = //div[@id="cart-item-166046"]       ${produto}
#    element should contain          class = tx-blue.money                       ${preco_total}

Fecha o browser
    close browser