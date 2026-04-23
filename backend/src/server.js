import 'dotenv/config';

import cors from 'cors';
import express from 'express';
import OpenAI from 'openai';

const app = express();
const port = Number(process.env.PORT || 3000);
const model = process.env.OPENAI_MODEL || 'gpt-5.4-mini';
const apiKey = process.env.OPENAI_API_KEY;

if (!apiKey) {
  throw new Error('OPENAI_API_KEY nao configurada.');
}

const openai = new OpenAI({ apiKey });

app.use(cors());
app.use(express.json({ limit: '1mb' }));

app.get('/health', (_request, response) => {
  response.json({ ok: true });
});

function extractResponseText(aiResponse) {
  if (
    typeof aiResponse?.output_text == 'string' &&
    aiResponse.output_text.trim().length > 0
  ) {
    return aiResponse.output_text.trim();
  }

  if (!Array.isArray(aiResponse?.output)) {
    return '';
  }

  const parts = [];

  for (const item of aiResponse.output) {
    if (!Array.isArray(item?.content)) {
      continue;
    }

    for (const content of item.content) {
      if (
        content?.type == 'output_text' &&
        typeof content.text == 'string' &&
        content.text.trim().length > 0
      ) {
        parts.push(content.text.trim());
      }
    }
  }

  return parts.join('\n').trim();
}

function normalizeStringList(value) {
  if (!Array.isArray(value)) {
    return [];
  }

  return value
    .filter((item) => typeof item == 'string')
    .map((item) => item.trim())
    .filter((item) => item.length > 0);
}

function normalizeAssistantPayload(rawText) {
  try {
    const parsed = JSON.parse(rawText);
    if (!parsed || typeof parsed != 'object') {
      throw new Error('Invalid JSON payload');
    }

    const summary =
      typeof parsed.summary == 'string' ? parsed.summary.trim() : '';
    const immediateSteps = normalizeStringList(parsed.immediate_steps);
    const alerts = normalizeStringList(parsed.alerts);
    const followUpQuestion =
      typeof parsed.follow_up_question == 'string'
        ? parsed.follow_up_question.trim()
        : '';

    const message =
      summary ||
      immediateSteps[0] ||
      alerts[0] ||
      followUpQuestion ||
      rawText.trim();

    return {
      message,
      summary: summary || null,
      immediateSteps,
      alerts,
      followUpQuestion: followUpQuestion || null,
    };
  } catch (_) {
    return {
      message: rawText.trim(),
      summary: rawText.trim(),
      immediateSteps: [],
      alerts: [],
      followUpQuestion: null,
    };
  }
}

app.post('/assistant/message', async (request, response) => {
  try {
    const { prompt, conversation = [], conversationId } = request.body ?? {};

    if (typeof prompt != 'string' || prompt.trim().length == 0) {
      return response.status(400).json({
        error: 'Campo "prompt" obrigatorio.',
      });
    }

    const userPrompt = prompt.trim();
    const normalizedConversation = Array.isArray(conversation)
        ? conversation
            .filter((message) =>
              message &&
              (message.role == 'user' || message.role == 'assistant') &&
              typeof message.content == 'string' &&
              message.content.trim().length > 0,
            )
            .map((message) => ({
              role: message.role,
              content: message.content.trim(),
            }))
        : [];

    const openAiRequest = {
      model,
      instructions:
        'Voce e o assistente virtual do app Cuida+. Responda em portugues do Brasil, com linguagem simples, acolhedora e objetiva. Priorize orientacoes curtas de primeiros cuidados e sinais de alerta. Seja conservador em temas de saude: nao invente diagnosticos, nao prescreva tratamentos complexos e nao informe doses de remedios. Quando houver risco, destaque claramente que a pessoa deve procurar atendimento urgente. Responda sempre em JSON valido, sem markdown e sem texto fora do JSON, usando este formato exato: {"summary":"resumo curto","immediate_steps":["passo 1","passo 2"],"alerts":["alerta 1"],"follow_up_question":"pergunta opcional curta"}. Use no maximo 1 resumo curto, ate 4 passos imediatos, ate 3 alertas e 1 pergunta final opcional.',
      reasoning: {
        effort: 'minimal',
      },
      text: {
        verbosity: 'low',
      },
      max_output_tokens: 600,
    };

    if (typeof conversationId == 'string' && conversationId.trim().length > 0) {
      openAiRequest.previous_response_id = conversationId.trim();
      openAiRequest.input = [
        {
          role: 'user',
          content: userPrompt,
        },
      ];
    } else {
      const hasPromptAsLastMessage =
        normalizedConversation.length > 0 &&
        normalizedConversation[normalizedConversation.length - 1].role ==
          'user' &&
        normalizedConversation[normalizedConversation.length - 1].content ==
          userPrompt;

      openAiRequest.input = hasPromptAsLastMessage
        ? normalizedConversation
        : [
            ...normalizedConversation,
            {
              role: 'user',
              content: userPrompt,
            },
          ];
    }

    const aiResponse = await openai.responses.create(openAiRequest);
    const rawText = extractResponseText(aiResponse);

    if (!rawText) {
      return response.status(502).json({
        error: 'A OpenAI nao retornou texto.',
        details: JSON.stringify(aiResponse.output ?? []),
      });
    }

    const assistantPayload = normalizeAssistantPayload(rawText);

    return response.json({
      message: assistantPayload.message,
      summary: assistantPayload.summary,
      immediateSteps: assistantPayload.immediateSteps,
      alerts: assistantPayload.alerts,
      followUpQuestion: assistantPayload.followUpQuestion,
      conversationId: aiResponse.id,
    });
  } catch (error) {
    console.error('[assistant/message]', error);

    const statusCode =
      typeof error?.status == 'number' && error.status >= 400
        ? error.status
        : 500;
    const details =
      typeof error?.message == 'string' && error.message.trim().length > 0
        ? error.message
        : 'Falha ao gerar resposta do assistente.';

    return response.status(500).json({
      error: 'Falha ao gerar resposta do assistente.',
      details,
      statusCode,
    });
  }
});

app.listen(port, () => {
  console.log(`Cuida+ backend rodando em http://localhost:${port}`);
});
