*** Settings ***
Documentation    Suite que testa o login do UniRide (funcionalidade e seguranca)
Resource         login_resources.robot
Test Setup       Abrir o navegador
Test Teardown    Fechar o navegador

*** Test Cases ***
CT1 - Realizar login com senha incorreta
    [Documentation]    Verifica se o sistema rejeita login de usuario existente com senha errada
    [Tags]    login_senha_incorreta
    Acessar area de login
    Fazer tentativa de login    ${EMAIL_ATIVO}    ${SENHA_INCORRETA}
    Verificar mensagem de erro no login

CT2 - Realizar login com email nao cadastrado
    [Documentation]    Verifica se o sistema rejeita login de um email que nao existe na base
    [Tags]    login_email_inexistente
    Acessar area de login
    Fazer tentativa de login    ${EMAIL_INEXISTENTE}    ${SENHA_ATIVA}
    Verificar mensagem de erro no login

CT3 - Realizar login com campos vazios
    [Documentation]    Verifica se o sistema impede o login sem preencher email e senha
    [Tags]    login_campos_vazios
    Acessar area de login
    Acionar o botao de login
    Verificar que o login foi rejeitado

CT4 - Realizar login com injecao de SQL no campo email
    [Documentation]    Verifica se o sistema rejeita 100 por cento das tentativas de injecao de SQL
    [Tags]    login_sql_injection    seguranca
    Acessar area de login
    Fazer tentativa de login    ${INJECAO_SQL}    ${INJECAO_SQL}
    Verificar que o login foi rejeitado

CT5 - Bloquear acesso apos 5 tentativas consecutivas com senha incorreta
    [Documentation]    Apos 5 erros seguidos, nem a senha correta deve permitir o acesso
    [Tags]    login_bloqueio    seguranca
    Acessar area de login
    Errar a senha varias vezes seguidas
    Fazer tentativa de login    ${EMAIL_ATIVO}    ${SENHA_ATIVA}
    Verificar que o login foi rejeitado
