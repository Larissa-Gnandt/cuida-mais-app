import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cuidamais/features/assistant/data/services/assistant_conversation_storage.dart';
import 'package:cuidamais/features/assistant/domain/models/assistant_message.dart';
import 'package:cuidamais/features/assistant/domain/models/assistant_reply.dart';
import 'package:cuidamais/features/assistant/domain/services/assistant_service.dart';
import 'package:cuidamais/features/assistant/presentation/screens/assistant_screen.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('assistant screen renders initial content', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AssistantScreen(
          assistantService: _FakeAssistantService(),
          conversationStorage: const AssistantConversationStorage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('CUIDA+'), findsOneWidget);
    expect(find.text('Assistente Virtual'), findsOneWidget);
    expect(find.textContaining('Como posso auxiliar'), findsOneWidget);
  });

  testWidgets('assistant screen sends a local mock response', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AssistantScreen(
          assistantService: _FakeAssistantService(),
          conversationStorage: const AssistantConversationStorage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final textField = find.byType(TextField);

    await tester.ensureVisible(textField);
    await tester.enterText(textField, 'Estou com febre');
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pump();

    expect(find.text('Estou com febre'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 600));

    expect(find.textContaining('hidratacao'), findsOneWidget);
  });
}

class _FakeAssistantService implements AssistantService {
  @override
  Future<AssistantReply> sendMessage({
    required String prompt,
    required List<AssistantMessage> conversation,
    String? conversationId,
  }) async {
    return const AssistantReply(
      message: 'Resposta fake com hidratacao e observacao.',
      conversationId: 'conv_teste',
    );
  }
}
