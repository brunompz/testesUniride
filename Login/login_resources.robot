*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BROWSER}                chrome
${URL}                    http://localhost/Uniride/home/index.html
${BOTAO_TELA_LOGIN}       xpath://a[contains(text(), 'LOGIN')]
${CAMPO_EMAIL}            email
${CAMPO_SENHA}            senha
${BOTAO_LOGIN}            id:enviar
${LOGIN_SUCESSO}          id:boasVindas
${ICONE_ERRO}             css:.swal2-icon.swal2-error.swal2-icon-show
${BOTAO_FECHAR_ALERTA}    css:.swal2-confirm

${EMAIL_ATIVO}            luana.mendes1@pucpr.edu.br
${SENHA_ATIVA}            1234
${SENHA_INCORRETA}        senhaErrada999
${EMAIL_INEXISTENTE}      naoexiste.teste@pucpr.edu.br
${INJECAO_SQL}            ' OR '1'='1
${TENTATIVAS_MAXIMAS}     5

*** Keywords ***
Abrir o navegador
    Open Browser    ${URL}    ${BROWSER}
    Set Screenshot Directory    ${CURDIR}/Outputs/${TEST NAME}
    Maximize Browser Window

Fechar o navegador
    Capture Page Screenshot
    Close Browser

Acessar area de login
    Wait Until Page Contains Element    ${BOTAO_TELA_LOGIN}    timeout=10s
    Click Element    ${BOTAO_TELA_LOGIN}
    Wait Until Page Contains Element    ${CAMPO_EMAIL}    timeout=10s

Digitar no campo email
    [Arguments]    ${valor}
    Clear Element Text    ${CAMPO_EMAIL}
    Input Text    ${CAMPO_EMAIL}    ${valor}

Digitar no campo senha
    [Arguments]    ${valor}
    Clear Element Text    ${CAMPO_SENHA}
    Input Text    ${CAMPO_SENHA}    ${valor}

Acionar o botao de login
    Click Element    ${BOTAO_LOGIN}

Fazer tentativa de login
    [Arguments]    ${email}    ${senha}
    Digitar no campo email    ${email}
    Digitar no campo senha    ${senha}
    Acionar o botao de login

Fechar alerta se estiver aberto
    Run Keyword And Ignore Error    Click Element    ${BOTAO_FECHAR_ALERTA}

Verificar login realizado com sucesso
    Wait Until Page Contains Element    ${LOGIN_SUCESSO}    timeout=10s

Verificar mensagem de erro no login
    Wait Until Element Is Visible    ${ICONE_ERRO}    timeout=5s
    Page Should Not Contain Element    ${LOGIN_SUCESSO}
    Capture Page Screenshot

Verificar que o login foi rejeitado
    ${alerta}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${ICONE_ERRO}    timeout=3s
    Log    Alerta de erro exibido: ${alerta}
    Page Should Not Contain Element    ${LOGIN_SUCESSO}
    Capture Page Screenshot

Errar a senha varias vezes seguidas
    FOR    ${i}    IN RANGE    ${TENTATIVAS_MAXIMAS}
        Log    Tentativa incorreta ${i+1} de ${TENTATIVAS_MAXIMAS}
        Fazer tentativa de login    ${EMAIL_ATIVO}    ${SENHA_INCORRETA}
        Wait Until Element Is Visible    ${ICONE_ERRO}    timeout=5s
        Fechar alerta se estiver aberto
    END
