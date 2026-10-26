*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${Browser}              Google Chrome
${URL}                  http://localhost/Uniride/home/index.html
${LOGIN_SUCESSO}        id:boasVindas
${CAMPO_USUARIO}        email
${CAMPO_SENHA}          senha
${USUARIO_PASSAGEIRO}   passageiro.teste@pucpr.edu.br
${SENHA_PADRAO}         1234
${BOTAO_LOGIN}          id:enviar
${BOTAO_TELA_LOGIN}     xpath://a[contains(text(), 'LOGIN')]

${RADIO_TODOS}          xpath://input[@name='filtroTipo' and @value='todos']
${RADIO_SOLICITACAO}    xpath://input[@name='filtroTipo' and @value='passageiro']
${RADIO_OFERTA}         xpath://input[@name='filtroTipo' and @value='motorista']
${LABEL_SOLICITACAO}    xpath://label[contains(., 'Somente Solicitação')]

${CONTAINER_LISTA}      id:lista
${CARD_CLICAVEL}        css=.card-viagem.card-clicavel
${HINT_SELECIONAR}      xpath://span[contains(text(), 'Clique para selecionar esta carona')]
${TEXTO_SOLICITACAO}    Solicitação
${TEXTO_OFERTA}         Oferta

*** Keywords ***
Abrir o navegador
    Open Browser  ${URL}  ${Browser}
    Set Screenshot Directory    ${CURDIR}/Outputs/${TEST NAME}
    Maximize Browser Window

Fechar o navegador
    Close Browser

Acessar area de login
    Wait Until Page Contains Element  ${BOTAO_TELA_LOGIN}  timeout=10s
    Click Element  ${BOTAO_TELA_LOGIN}

Digitar no campo usuario o passageiro ativo
    Wait Until Page Contains Element  ${CAMPO_USUARIO}  timeout=10s
    Input Text  ${CAMPO_USUARIO}  ${USUARIO_PASSAGEIRO}

Digitar no campo senha a senha padrao
    Input Text  ${CAMPO_SENHA}  ${SENHA_PADRAO}

Acionar o botao de login
    Click Element  ${BOTAO_LOGIN}

Verificar sessao
    Wait Until Page Contains Element  ${LOGIN_SUCESSO}  timeout=10s

Verificar presenca de grupo criado por outra conta na aba inicial
    Wait Until Element Is Visible    ${CONTAINER_LISTA}    timeout=10s
    Wait Until Element Is Visible    ${CARD_CLICAVEL}      timeout=10s
    Element Should Be Visible        ${HINT_SELECIONAR}
    Capture Page Screenshot

Selecionar filtro de grupos por somente solicitacao
    Wait Until Element Is Visible    ${LABEL_SOLICITACAO}    timeout=10s
    Click Element                    ${LABEL_SOLICITACAO}
    Sleep    1s

Verificar que apenas solicitacoes sao exibidas na lista
    Wait Until Element Is Visible    ${CONTAINER_LISTA}      timeout=10s
    Element Should Contain           ${CONTAINER_LISTA}      ${TEXTO_SOLICITACAO}
    Element Should Not Contain       ${CONTAINER_LISTA}      ${TEXTO_OFERTA}
    Capture Page Screenshot
