*** Settings ***
Documentation  Essa suite testa a visualizacao e filtros de caronas na tela inicial do Uniride
Resource  telaInicial_resources.robot
Test Setup  Abrir o navegador
Test Teardown  Fechar o navegador

*** Test Cases ***
CT1- Visualizar grupo criado por outra conta na aba inicial
    [Documentation]  Esse teste verifica se o usuario consegue visualizar um card de carona criado por outro usuario na tela inicial
    [Tags]  visualizar_grupo_outra_conta
    Acessar area de login
    Digitar no campo usuario o passageiro ativo
    Digitar no campo senha a senha padrao
    Acionar o botao de login
    Verificar sessao
    Verificar presenca de grupo criado por outra conta na aba inicial

CT2- Filtrar grupos de carona exclusivamente por solicitacao
    [Documentation]  Esse teste busca verificar se o filtro de caronas exibe exclusivamente grupos do tipo solicitacao
    [Tags]  filtrar_por_solicitacao
    Acessar area de login
    Digitar no campo usuario o passageiro ativo
    Digitar no campo senha a senha padrao
    Acionar o botao de login
    Verificar sessao
    Selecionar filtro de grupos por somente solicitacao
    Verificar que apenas solicitacoes sao exibidas na lista
