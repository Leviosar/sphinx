# Autenticação

**Escopo**: Aplicativo de quiz

**Nível**: Meta do usuário

**Ator Primário**: Usuário

**Stakeholders e seus interesses**:

Usuário: deseja se autenticar na aplicação para poder utiliza-la.

Sistema: deseja identificar de maneira única os usuários através de sua Google Account, salvando os acessos em seu banco de dados.

**Pré condições**:

- O usuário deve possuir uma Google Account.

- O usuário deve possuir conexão com a internet.

**Pós condições**:

- O usuário é autenticado, tendo um token de sessão atrelado a seu dispositivo.

- Dados pessoais do usuário são atualizados conforme o que está na sua Google Account.

**Fluxo básico**:

1. O usuário abre a aplicação e é direcionado para a tela de login.

2. O usuário inicia o processo de autenticação.

3. O aplicativo identifica a Google Account padrão do dispositivo.

4. O aplicativo envia os dados da conta para o servidor.

5. O servidor verifica se o usuário existe no banco de dados.

6. O servidor gera um JWT único e persiste no banco de dados.

7. O servidor retorna o JWT para o aplicativo.

8. O aplicativo persiste o JWT em memória.

9. O usuário autenticado vai para a próxima tela.

**Extensões**:

2. (a) O usuário não tem uma conta padrão.
    1. O usuário escolhe uma Google Account para se autenticar.

5. (a) O usuário não existe no banco de dados.
    1. Insere o usuário no banco com os seus dados da Google Account.

**Requisitos especiais**:

A requisição de autenticação não pode demorar mais do que 2 segundos com uma internet banda larga.

**Frequência de ocorrência**:

Uma vez a cada sessão do usuário.

# Criar partida

**Escopo**: Aplicativo de quiz

**Nível**: Subfunção

**Ator Primário**: Usuário

**Stakeholders e seus interesses**:

Usuário: deseja criar uma partida configurável.

**Pré condições**:

- O usuário está autenticado.

- O usuário possui conexão a internet.

**Pós condições**:

- Uma partida do jogo é criada em memória.

**Fluxo básico**:

1. O aplicativo exibe as opções de customização pré definidas.

2. O usuário escolhe as regras da partida, baseado nas opções passadas em 2.

3. O usuário confirma as suas escolhas e realiza a ação para finalizar a criação de partida.

4. O aplicativo persiste as escolhas do usuário em memória interna em forma de um novo objeto Game.

**Frequência de ocorrência**:

Muito frequente.

# Jogar partida singleplayer

**Escopo**: Aplicativo de quiz

**Nível**: Meta de usuário

**Ator Primário**: Usuário

**Stakeholders e seus interesses**:

Usuário: deseja iniciar uma partida do jogo, podendo customizar regras da partida.

**Pré condições**:

- O usuário está autenticado.

- O usuário possui conexão a internet.

**Pós condições**:

- Uma partida singleplayer do jogo é realizada.

**Fluxo básico**:

1. O usuário realiza a ação para iniciar o processo de criação de partida.

2. Inclui **Criar partida**.

3. O aplicativo mostra a pergunta e suas respectivas alternativas de resposta.

4. O usuário faz sua escolha de resposta.

5. O aplicativo mostra se a resposta do usuário estava correta ou não.

Os passos de 3 a 5 se repetem enquanto houverem perguntas.

6. O aplicativo mostra uma recapitulação da partida, mostrando a pontuação do usuário.

7. O usuário confirma o final da partida e é encaminhado para a tela inicial da aplicação.

8. O aplicativo envia para o servidor os dados completos da partida.

9. O servidor persiste a partida no banco de dados.

**Extensões**:

*. (a) - O usuário opta por cancelar a criação de partida.

1. O aplicativo descarta as opções selecionadas até o momento.

2. O aplicativo retorna para a última página acessada do usuário.

**Frequência de ocorrência**:

Muito frequente.

# Jogar uma partida multiplayer

**Escopo**: Aplicativo de quiz

**Nível**: Meta de usuário

**Ator Primário**: Usuário

**Stakeholders e seus interesses**:

Usuário: deseja iniciar uma partida do jogo, podendo customizar regras da partida, além de desafiar um outro jogador para participar da partida.

**Pré condições**:

- O usuário está autenticado.

- O usuário possui conexão a internet.

**Pós condições**:

- Uma partida multiplayer do jogo é iniciada.

- O jogador desafiado recebe o desafio em seu próprio aplicativo.

**Fluxo básico**:

1. O usuário realiza a ação para iniciar o processo de criação de partida.

2. Inclui **criar partida**

3. O usuário escolhe qual outro jogador irá desafiar, identificado pelo e-mail de cadastro.

4. O aplicativo persiste as escolhas do usuário em memória interna e dá início a partida do Jogador 1.

5. O aplicativo mostra a pergunta e suas respectivas alternativas de resposta.

6. O usuário faz sua escolha de resposta.

7. O aplicativo mostra se a resposta do usuário estava correta ou não.

Os passos de 5 a 7 se repetem enquanto houverem perguntas.

8. O aplicativo mostra uma recapitulação da partida, mostrando a pontuação do Jogador.

9. O usuário confirma o final da partida e é encaminhado para a tela inicial da aplicação.

10. O aplicativo envia para o servidor os dados completos da partida do Jogador.

11. O servidor persiste a partida no banco de dados do Jogador.

12. O Jogador 2 recebe em seu aplicativo os dados do desafio.

13. O Jogador 2 aceita o desafio e se dá início a partida do Jogador 2.

Os passos de 5 a 11 acontecem novamente, dessa vez para o Jogador 2.

18. Ambos os jogadores recebem em seus aplicativos dados sobre o desafio e quem foi o vencedor.

**Extensões**:

13. (a) O Jogador 2 não aceita o desafio.
    1. O aplicativo envia para o servidor os dados do desafio não aceito.
    2. O servidor atualiza o desafio para marcar que este não foi aceito.
    3. O Jogador 1 recebe em seu aplicativo que o desafio não foi aceito.

**Frequência de ocorrência**:

Muito frequente.

# Modelo

**Escopo**:
**Nível**:
**Ator Primário**: 
**Stakeholders e seus interesses**:
**Pré condições**:
**Pós condições**:
**Fluxo básico**:
**Extensões**:
**Requisitos especiais**:
**Tecnologia**:
**Frequência de ocorrência**: