import 'package:flutter_test/flutter_test.dart';

import 'package:cuidamais/app.dart';

void main() {
  testWidgets('assistant screen renders initial content', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CuidaMaisApp());

    expect(find.text('CUIDA+'), findsOneWidget);
    expect(find.text('Assistente Virtual'), findsOneWidget);
    expect(find.text('ASSISTENTE'), findsOneWidget);
    expect(find.textContaining('Como posso auxiliar'), findsOneWidget);
  });
}
