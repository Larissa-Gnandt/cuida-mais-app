import '../../domain/models/assistant_message.dart';
import '../../domain/models/assistant_reply.dart';
import '../../domain/services/assistant_service.dart';

class MockAssistantService implements AssistantService {
  @override
  Future<AssistantReply> sendMessage({
    required String prompt,
    required List<AssistantMessage> conversation,
    String? conversationId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final normalized = prompt.toLowerCase();

    if (normalized.contains('engasgo')) {
      return const AssistantReply(
        message:
            'Se a pessoa nao consegue falar, tossir ou respirar, aja rapido e busque ajuda urgente se houver piora.',
        summary:
            'Se a pessoa nao consegue falar, tossir ou respirar, aja rapido e busque ajuda urgente se houver piora.',
        immediateSteps: [
          'Se ainda conseguir tossir, incentive a tosse.',
          'Se nao conseguir respirar, realize tapas nas costas e manobra adequada para a idade.',
          'Se perder a consciencia, acione emergencia e inicie RCP.',
        ],
        alerts: [
          'Lábios arroxeados, perda de consciencia ou ausencia de respiracao exigem ajuda imediata.',
        ],
        followUpQuestion: 'O engasgo e com adulto, crianca ou bebe?',
      );
    }

    if (normalized.contains('febre')) {
      return const AssistantReply(
        message:
            'Observe a temperatura, hidrate-se e fique atento a sinais de alerta.',
        summary:
            'Observe a temperatura, hidrate-se e fique atento a sinais de alerta.',
        immediateSteps: [
          'Descanse e beba liquidos em pequenas quantidades ao longo do dia.',
          'Meça a temperatura e acompanhe a evolucao.',
        ],
        alerts: [
          'Procure atendimento se houver falta de ar, confusao, desidratacao ou piora rapida.',
        ],
        followUpQuestion: 'Qual foi a maior temperatura e ha quanto tempo comecou?',
      );
    }

    if (normalized.contains('dor') || normalized.contains('peito')) {
      return const AssistantReply(
        message:
            'Dor no peito merece atencao, principalmente se vier com falta de ar ou mal-estar intenso.',
        summary:
            'Dor no peito merece atencao, principalmente se vier com falta de ar ou mal-estar intenso.',
        alerts: [
          'Procure socorro imediatamente se houver suor frio, desmaio ou irradiacao para braco e mandibula.',
        ],
        followUpQuestion: 'A dor esta acontecendo agora? Ela irradia para braco, costas ou mandibula?',
      );
    }

    return const AssistantReply(
      message:
          'Posso te orientar com primeiros cuidados, sinais de alerta e quando buscar atendimento.',
      summary:
          'Posso te orientar com primeiros cuidados, sinais de alerta e quando buscar atendimento.',
      followUpQuestion:
          'Me conte em poucas palavras o que aconteceu ou quais sintomas voce esta sentindo.',
    );
  }
}
