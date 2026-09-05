import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/main.dart';

void main() {
  testWidgets('Hive2Home app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const Hive2HomeApp());

    expect(find.text('Hive2Home'), findsOneWidget);
  });
}