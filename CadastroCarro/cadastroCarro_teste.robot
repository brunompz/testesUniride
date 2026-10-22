*** Settings ***
Documentation  Essa suite testa o cadastro de carro do Uniride
Resource  cadastroCarro_resources.robot
Test Setup  Abrir o navegador
Test Teardown  Fechar o navegador

*** Test Cases ***
CT1- Realizar cadastro de carro com valores validos
    [Documentation]  Esse teste busca verificar se o sistema permite o cadastro de valores validos
    [Tags]  caampos_validos
    Acessar area de login
    Digitar no campo usuario o usuario ativo
    Digitar no campo senha a senha do usuario ativo
    Acionar o botao de login
    Verificar sessao
    Acessar area de perfil
    Acionar botao de adicionar novo veiculo na secao Carros Cadastrados
    Preencher campos do cadastro de carro placa= IVY98F2, marca= Renault, modelo= Uno, ano= 2010, cor= Azul, renavam= 123456789, capacidade=5 e categoria= SUV
    Acionar botao de cadastrar veiculo
    Verificar mensagem do cadastro de carro

CT2- Realizar cadastro de carro com campo de capacidade de passageiro -1
    [Documentation]  Esse teste busca verificar se o sistema o campo capacidade de passageiro com valor negativo -1
    [Tags]  passageiro_negativo
    Acessar area de login
    Digitar no campo usuario o usuario ativo
    Digitar no campo senha a senha do usuario ativo
    Acionar o botao de login
    Verificar sessao
    Acessar area de perfil
    Acionar botao de adicionar novo veiculo na secao Carros Cadastrados
    Preencher campos do cadastro de carro placa= IVY98F2, marca= Renault, modelo= Uno, ano= 2010, cor= Azul, renavam= 123456789 e categoria= SUV
    Preencher campo capacidade de passageiros -1
    Acionar botao de cadastrar veiculo
    Verificar que o cadastro foi rejeitado

CT3- Realizar cadastro de carro com campo de capacidade de passageiro 100
    [Documentation]  Esse teste busca verificar se o sistema valida um limite máximo para valores acima de 7 no campo de capacidade de passageiro
    [Tags]  passageiro_limite
    Acessar area de login
    Digitar no campo usuario o usuario ativo
    Digitar no campo senha a senha do usuario ativo
    Acionar o botao de login
    Verificar sessao
    Acessar area de perfil
    Acionar botao de adicionar novo veiculo na secao Carros Cadastrados
    Preencher campos do cadastro de carro placa= IVY98F2, marca= Renault, modelo= Uno, ano= 2010, cor= Azul, renavam= 123456789 e categoria= SUV
    Preencher campo capacidade de passageiros 100
    Acionar botao de cadastrar veiculo
    Verificar que o cadastro foi rejeitado

CT4- Realizar cadastro de carro com campo de RENAVAM invalido
    [Documentation]  Esse teste busca verificar se o sistema faz a validação do campo de RENAVAM do carro
    [Tags]  renavam_invalido
    Acessar area de login
    Digitar no campo usuario o usuario ativo
    Digitar no campo senha a senha do usuario ativo
    Acionar o botao de login
    Verificar sessao
    Acessar area de perfil
    Acionar botao de adicionar novo veiculo na secao Carros Cadastrados
    Preencher campos do cadastro de carro placa= IVY98F2, marca= Renault, modelo= Uno, ano= 2010, cor= Azul, capacidade=5 e categoria= SUV
    Preencher campo RENAVAM 123
    Acionar botao de cadastrar veiculo
    Verificar que o cadastro foi rejeitado

CT5- Realizar cadastro de carro com campos obrigatorios vazios
    [Documentation]  Esse teste busca verificar se o sistema permite cadastro de campos vazios
    [Tags]  campos_vazios
    Acessar area de login
    Digitar no campo usuario o usuario ativo
    Digitar no campo senha a senha do usuario ativo
    Acionar o botao de login
    Verificar sessao
    Acessar area de perfil
    Acionar botao de adicionar novo veiculo na secao Carros Cadastrados
    Acionar botao de cadastrar veiculo
    Verificar mensagens de erro