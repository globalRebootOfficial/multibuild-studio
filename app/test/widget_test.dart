import 'package:flutter_test/flutter_test.dart';
import 'package:multibuild_studio/main.dart';

void main() {
  testWidgets('shows studio title and build controls', (tester) async {
    await tester.pumpWidget(const MultiBuildStudioApp());
    expect(find.text('multibuild-studio'), findsOneWidget);
    expect(find.text('Build'), findsOneWidget);
    expect(find.text('BUILD LOG'), findsOneWidget);
  });
}