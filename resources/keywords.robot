*** Settings ***
Library    RequestsLibrary
Library    FakerLibrary
Resource    variaveis.robot

*** Keywords ***
Get - Buscando usuarios
    Create Session    alias=${ALIAS}    url=${URL}
    
    ${response}    GET   
    ...    url=${URL}users?access-token=${TOKEN}  
    ...    expected_status=200   
    Log  ${response.text}
    

POST - Criando um novo registro
    ${NAME}            FakerLibrary.Name Male
    ${EMAIL}           FakerLibrary.Email
    ${body}     Catenate     {"name":"${NAME}", "gender":"male", "email":"${EMAIL}", "status":"active"}

    ${body}    Evaluate    json.loads($body)
    Create Session    alias=${ALIAS}    url=${URL}
    
    ${response}    POST
    ...    url=${url}users?access-token=${TOKEN}
    ...    json=${body}
    ...    expected_status=201
    
   # Gravar Variável com ID do cliente paraos proximos testes
    ${cliente}   Set Variable      ${response.json()['id']}
    Set Global Variable    ${cliente}
    Log   Nome:${response.json()['name']} Email:${response.json()['email']} Id:${response.json()['id']}
PATCH - Alterando um usuário
    Create Session    alias=${ALIAS}    url=${URL}

    ${headers}    Create Dictionary
    ...    Accept=application/json
    ...    Content-Type=application/json
    ...    Authorization=Bearer ${TOKEN}

    ${response_old}    GET    
    ...    url=${URL}users/${cliente}?access-token=${TOKEN}  
    ...    expected_status=200   
    Log   Antes de Ser alterado: Nome:${response_old.json()['name']} Email:${response_old.json()['email']} Id:${response_old.json()['id']}

    ${NAME_NEW}            FakerLibrary.Name Female
    ${EMAIL_NEW}           FakerLibrary.Email
    ${body_new}   Catenate   {"name":"${NAME_NEW}", "email":"${EMAIL_NEW}", "status":"active"}
    Log    ${body_new}
    
    ${response_new}    PATCH
    ...    headers=${headers}
    ...    url=${url}users/${cliente}
    ...    data=${body_new}
    ...    expected_status=200
 
    Log   Nome:${response_new.json()['name']} Email:${response_new.json()['email']} Id:${response_new.json()['id']}

DELETE - Deletar um usuario

    ${headers}    Create Dictionary
    ...    Accept=application/json
    ...    Content-Type=application/json
    ...    Authorization=Bearer ${TOKEN}
    
    ${response}    GET    
    ...    url=${URL}users/${cliente}?access-token=${TOKEN}  
    ...    expected_status=200   
    Log   Usuario para Deletar: Nome:${response.json()['name']} Email:${response.json()['email']} Id:${response.json()['id']}
    
    ${response_new}    DELETE
    ...    headers=${headers}
    ...    url=${url}users/${cliente}
    ...    expected_status=204
    
    ${response}    GET    
    ...    url=${URL}users/${cliente}?access-token=${TOKEN}  
    ...    expected_status=404   
    Log   ${response.json()['message']}