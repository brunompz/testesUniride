*** Settings ***
Library    SeleniumLibrary
Library    DateTime

*** Variables ***
${BROWSER}                    chrome
${URL}                        http://localhost/Uniride/home/index.html

# Navegacao
${BOTAO_TELA_LOGIN}           xpath://a[contains(text(), 'LOGIN')]
${BOTAO_PERFIL}               xpath://a[contains(@href, 'perfil.html')]
${BOTAO_TORNAR_MOTORISTA}     xpath://a[contains(text(), 'Se tornar motorista')]

# Login
${CAMPO_EMAIL}                email
${CAMPO_SENHA}                senha
${BOTAO_LOGIN}                id:enviar

# Tornar motorista
${CAMPO_CPF}                  cpf
${CAMPO_VENCIMENTO}           dataVencimento
${CAMPO_REGISTRO}             numeroRegistro
${BOTAO_CADASTRAR}            id:enviar
${ICONE_SUCESSO}              css:.swal2-icon.swal2-success.swal2-icon-show
${ICONE_ERRO}                 css:.swal2-icon.swal2-error.swal2-icon-show
${ERRO_CPF}                   id:erroCpf
${ERRO_VENCIMENTO}            id:erroDataVencimento
${ERRO_REGISTRO}              id:erroNumeroRegistro

# Dados de teste (usuario ja cadastrado que AINDA NAO e motorista)
${EMAIL_LOGIN}                usuario.teste@pucpr.edu.br
${SENHA_LOGIN}                1234

# CPF de teste com digitos verificadores corretos
${CPF_VALIDO}                 52998224725
${CPF_CURTO}                  123456
${CPF_DV_INVALIDO}            52998224726
${REGISTRO_VALIDO}            12345678900

${MSG_CPF_VAZIO}              *Informe o CPF.
${MSG_VENCIMENTO_VAZIO}       *Informe a data de vencimento.
${MSG_REGISTRO_VAZIO}         *Informe o número de registro.
${MSG_CNH_VENCIDA}            *A habilitação/documento informado está vencido.

*** Keywords ***
Abrir o navegador
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    ${prefs}=      Create Dictionary
    ...    credentials_enable_service=${False}
    ...    profile.password_manager_enabled=${False}
    ...    profile.password_manager_leak_detection=${False}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Call Method    ${options}    add_argument    --disable-save-password-bubble
    Call Method    ${options}    add_argument    --disable-notifications
    Open Browser    ${URL}    ${BROWSER}    options=${options}
    Set Screenshot Directory    ${CURDIR}/Outputs/${TEST NAME}
    Maximize Browser Window

Fechar o navegador
    Close Browser

Realizar login
    Wait Until Page Contains Element    ${BOTAO_TELA_LOGIN}    timeout=10s
    Click Element    ${BOTAO_TELA_LOGIN}
    Wait Until Page Contains Element    ${CAMPO_EMAIL}    timeout=10s
    Input Text    ${CAMPO_EMAIL}    ${EMAIL_LOGIN}
    Input Text    ${CAMPO_SENHA}    ${SENHA_LOGIN}
    Click Element    ${BOTAO_LOGIN}

Acessar area de tornar motorista
    Wait Until Page Contains Element    ${BOTAO_PERFIL}    timeout=10s
    Click Element    ${BOTAO_PERFIL}
    Wait Until Element Is Visible    ${BOTAO_TORNAR_MOTORISTA}    timeout=10s
    Click Element    ${BOTAO_TORNAR_MOTORISTA}
    Wait Until Element Is Visible    ${CAMPO_CPF}    timeout=10s

Preencher data de vencimento
    [Arguments]    ${data}
    Execute Javascript    document.getElementById('${CAMPO_VENCIMENTO}').value = '${data}'

Preencher formulario de motorista
    [Arguments]    ${cpf}    ${vencimento}    ${registro}
    Input Text    ${CAMPO_CPF}    ${cpf}
    Preencher data de vencimento    ${vencimento}
    Input Text    ${CAMPO_REGISTRO}    ${registro}

Calcular data de vencimento futura
    ${data}=    Get Current Date    increment=365 days    result_format=%Y-%m-%d
    RETURN    ${data}

Calcular data de vencimento vencida
    ${data}=    Get Current Date    increment=-1 days    result_format=%Y-%m-%d
    RETURN    ${data}

Acionar o botao de cadastrar
    Click Element    ${BOTAO_CADASTRAR}

Verificar cadastro de motorista realizado com sucesso
    Wait Until Element Is Visible    ${ICONE_SUCESSO}    timeout=10s
    Capture Page Screenshot

Verificar mensagens de campos obrigatorios
    Wait Until Element Is Visible    ${ERRO_CPF}    timeout=5s
    Element Text Should Be    ${ERRO_CPF}    ${MSG_CPF_VAZIO}
    Element Text Should Be    ${ERRO_VENCIMENTO}    ${MSG_VENCIMENTO_VAZIO}
    Element Text Should Be    ${ERRO_REGISTRO}    ${MSG_REGISTRO_VAZIO}
    Element Should Not Be Visible    ${ICONE_SUCESSO}
    Capture Page Screenshot

Verificar erro de CPF invalido
    Wait Until Element Is Visible    ${ICONE_ERRO}    timeout=10s
    Element Should Not Be Visible    ${ICONE_SUCESSO}
    Capture Page Screenshot

Verificar erro de CNH vencida
    Wait Until Element Is Visible    ${ERRO_VENCIMENTO}    timeout=5s
    Element Text Should Be    ${ERRO_VENCIMENTO}    ${MSG_CNH_VENCIDA}
    Element Should Not Be Visible    ${ICONE_SUCESSO}
    Capture Page Screenshot
