# Cuida+

Cuida+ é um aplicativo Flutter de primeiros socorros criado para orientar pessoas em situações de emergência, com telas rápidas, linguagem simples e apoio de um assistente com inteligência artificial.

O objetivo do app é ajudar o usuário a tomar decisões iniciais com mais calma enquanto busca atendimento adequado. Ele reúne instruções para situações comuns, situações graves e acidentes domésticos, como engasgo, sangramento, queimadura, dor no peito, AVC, convulsão, intoxicação, choque elétrico e afogamento.

> O Cuida+ não substitui atendimento médico, SAMU, bombeiros ou avaliação profissional. Em risco imediato, acione o serviço de emergência da sua região.

## Por que este app é importante

Em uma emergência, muitas pessoas travam, ficam nervosas ou não sabem qual deve ser o primeiro passo. Ter uma orientação clara e rápida pode ajudar a:

- manter a calma nos primeiros minutos;
- reconhecer sinais de gravidade;
- evitar ações perigosas, como dar água, induzir vômito ou mover a pessoa sem necessidade;
- orientar primeiros cuidados até a chegada do socorro;
- facilitar o acesso a contatos e instruções de emergência.

## Funcionalidades

- Tela inicial com categorias de incidentes.
- Guias rápidos para emergências comuns.
- Telas com passo a passo para cada situação.
- Seção de situações graves, incluindo dor no peito, AVC e convulsão.
- Seção de acidentes domésticos, incluindo intoxicação, choque elétrico e afogamento.
- Assistente integrado via backend Node/Express.
- Configuração do endpoint do assistente por `--dart-define`.

## Tecnologias

- Flutter
- Dart
- Node.js
- Express
- OpenAI API

## Estrutura do projeto

```text
.
├── lib/              # App Flutter
├── ios/              # Projeto iOS
├── android/          # Projeto Android
├── backend/          # API Node/Express
├── assets/           # Arquivos estáticos do app
└── test/             # Testes Flutter
```

## Pré-requisitos

Antes de rodar o projeto, instale:

- Flutter configurado na máquina;
- Xcode para rodar no simulador iOS;
- Node.js e npm para o backend;
- uma chave da OpenAI para usar o assistente.

Confira se o Flutter está ok:

```bash
flutter doctor
```

## Como baixar o projeto

Clone o repositório e entre na pasta do projeto:

```bash
git clone <url-do-repositorio>
cd cuida-mais-app
```

## Como rodar o backend

Entre na pasta do backend:

```bash
cd backend
```

Instale as dependências:

```bash
npm install
```

Crie o arquivo `.env`:

```bash
cp .env.example .env
```

Edite o `.env` e preencha:

```env
PORT=3001
OPENAI_API_KEY=sua_chave_aqui
OPENAI_MODEL=gpt-5.4-mini
```

Rode o backend:

```bash
PORT=3001 npm run dev
```

O servidor ficará disponível em:

```text
http://localhost:3001
```

Endpoint usado pelo app:

```text
POST /assistant/message
```

## Como rodar o app no simulador iOS

Instale as dependências Flutter:

```bash
flutter pub get
```

Abra o simulador:

```bash
open -a Simulator
```

Se nenhum iPhone abrir, no app Simulator vá em:

```text
File > Open Simulator > iOS > iPhone
```

Depois rode o app apontando para o backend na porta `3001`:

```bash
flutter run \
  --dart-define=ASSISTANT_API_BASE_URL=http://localhost:3001 \
  --dart-define=ASSISTANT_API_PATH=/assistant/message
```

Se quiser escolher um dispositivo específico:

```bash
flutter devices
```

Depois use o nome ou id exibido:

```bash
flutter run -d "iPhone 17" \
  --dart-define=ASSISTANT_API_BASE_URL=http://localhost:3001 \
  --dart-define=ASSISTANT_API_PATH=/assistant/message
```

## Rodando backend e app juntos

Use dois terminais.

Terminal 1:

```bash
cd backend
PORT=3001 npm run dev
```

Terminal 2:

```bash
flutter run \
  --dart-define=ASSISTANT_API_BASE_URL=http://localhost:3001 \
  --dart-define=ASSISTANT_API_PATH=/assistant/message
```

## Comandos úteis

Analisar o projeto:

```bash
flutter analyze
```

Rodar build iOS para simulador:

```bash
flutter build ios --simulator --debug \
  --dart-define=ASSISTANT_API_BASE_URL=http://localhost:3001 \
  --dart-define=ASSISTANT_API_PATH=/assistant/message
```

Listar dispositivos:

```bash
flutter devices
```

## Observações

- No simulador iOS, `localhost` aponta para a sua máquina.
- Em um iPhone físico, troque `localhost` pelo IP do computador na rede.
- O backend precisa estar rodando antes de usar o assistente no app.
- Para mudar a porta, atualize o `PORT` no backend e o `ASSISTANT_API_BASE_URL` no comando do Flutter.
