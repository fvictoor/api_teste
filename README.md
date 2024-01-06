# Requerimentos
Antes de executar os testes automatizados, é necessário instalar o seguinte programa:
- [Pyhton 3.12](https://www.python.org/downloads/)

Após a instalação do programa, é preciso instalar as seguintes bibliotecas usando o comando abaixo:
```bash
pip install robotframework
pip install robotframework-requests
pip install robotframework-faker
```
### Documentação das tecnologias usada
- [Robot Framework](https://robotframework.org/?tab=1#getting-started)
- [RequestLibrary](https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html#library-documentation-top)
- [FakerLibrary](https://guykisel.github.io/robotframework-faker/)



### Preparação do Ambiente Concluída
Para executar o teste automatizado com interface, utilize o seguinte comando:
```
robot -d ./logs ./api_teste.robot
```