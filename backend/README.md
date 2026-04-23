# Cuida+ Backend

Backend minimo em Node/Express para intermediar as chamadas do app Flutter para a OpenAI.

## 1. Configurar

Copie o arquivo de exemplo:

```bash
cp .env.example .env
```

Preencha ao menos:

```env
OPENAI_API_KEY=sua_chave_aqui
OPENAI_MODEL=gpt-5
PORT=3000
```

## 2. Instalar dependencias

```bash
npm install
```

## 3. Rodar em desenvolvimento

```bash
npm run dev
```

O servidor sobe em `http://localhost:3000`.

## 4. Endpoint esperado pelo Flutter

`POST /assistant/message`

Request:

```json
{
  "prompt": "Estou com febre",
  "conversationId": "resp_123",
  "conversation": [
    { "role": "assistant", "content": "Ola!..." },
    { "role": "user", "content": "Estou com febre" }
  ]
}
```

Response:

```json
{
  "message": "Resposta do assistente",
  "conversationId": "resp_456"
}
```

## 5. Conectar no Flutter

Na raiz do app:

```bash
flutter run \
  --dart-define=ASSISTANT_API_BASE_URL=http://localhost:3000 \
  --dart-define=ASSISTANT_API_PATH=/assistant/message
```
