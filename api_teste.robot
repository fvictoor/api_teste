*** Settings ***
Resource    ./resources/keywords.robot

*** Test Cases ***
Realizando Get
    Get - Buscando usuarios
Realizando Post
    POST - Criando um novo registro
Realizando um Patch
    PATCH - Alterando um usuário
Realizando um Delete 
    DELETE - Deletar um usuario