import 'package:flutter/material.dart';

void main() => runApp(const MultiBuildStudioApp());

class MultiBuildStudioApp extends StatelessWidget {
  const MultiBuildStudioApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'multibuild-studio',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8B7CFF), brightness: Brightness.dark), useMaterial3: true),
        home: const StudioHomePage(),
      );
}

class StudioHomePage extends StatefulWidget {
  const StudioHomePage({super.key});
  @override
  State<StudioHomePage> createState() => _StudioHomePageState();
}

class _StudioHomePageState extends State<StudioHomePage> {
  String target = 'Android APK';
  String language = 'Lua';
  String source = 'print("Hello from multibuild-studio")';
  final logs = <String>['Welcome. This is an early UI scaffold.', 'Compiler execution is not connected yet.'];
  final targets = const ['Android APK', 'Windows EXE', 'Lua bytecode', 'JavaScript bundle'];
  final languages = const ['Lua', 'JavaScript', 'TypeScript', 'Python', 'C', 'C++', 'Rust', 'Java', 'Kotlin'];
  final editorController = TextEditingController(text: 'print("Hello from multibuild-studio")');
  @override
  void dispose() { editorController.dispose(); super.dispose(); }
  void log(String value) => setState(() => logs.insert(0, value));
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('multibuild-studio'), actions: const [Padding(padding: EdgeInsets.all(12), child: Center(child: Text('EARLY SCAFFOLD')))]),
        body: LayoutBuilder(builder: (context, constraints) {
          final config = _configuration(context);
          final editor = _editor(context);
          if (constraints.maxWidth < 760) return Column(children: [Expanded(flex: 2, child: config), const Divider(height: 1), Expanded(flex: 3, child: editor)]);
          return Row(children: [SizedBox(width: 260, child: config), const VerticalDivider(width: 1), Expanded(child: editor)]);
        }),
      );
  Widget _configuration(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
        Text('BUILD CONFIGURATION', style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(value: target, decoration: const InputDecoration(labelText: 'Target'), items: targets.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) { if (v != null) setState(() => target = v); }),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(value: language, decoration: const InputDecoration(labelText: 'Language'), items: languages.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(), onChanged: (v) { if (v != null) setState(() => language = v); }),
        const SizedBox(height: 20),
        FilledButton.icon(onPressed: () => log('Build requested: $language → $target. No compiler is connected yet.'), icon: const Icon(Icons.play_arrow), label: const Text('Build')),
        const SizedBox(height: 8),
        OutlinedButton.icon(onPressed: () => log('Project export is not implemented yet.'), icon: const Icon(Icons.archive_outlined), label: const Text('Export project')),
        const SizedBox(height: 20),
        const ListTile(contentPadding: EdgeInsets.zero, leading: Icon(Icons.folder_open), title: Text('Untitled project'), subtitle: Text('Local demo workspace')),
      ]);
  Widget _editor(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(padding: const EdgeInsets.all(12), color: Theme.of(context).colorScheme.surfaceContainer, child: Row(children: [const Icon(Icons.code, size: 18), const SizedBox(width: 8), Text('main source'), const Spacer(), Text(language)])),
        Expanded(child: Padding(padding: const EdgeInsets.all(12), child: TextField(controller: editorController, onChanged: (v) => source = v, expands: true, maxLines: null, minLines: null, textAlignVertical: TextAlignVertical.top, style: const TextStyle(fontFamily: 'monospace', fontSize: 14), decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Write source code here…')))),
        SizedBox(height: 160, child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('BUILD LOG', style: Theme.of(context).textTheme.labelLarge), const SizedBox(height: 8), Expanded(child: ListView.builder(itemCount: logs.length, itemBuilder: (context, index) => Padding(padding: const EdgeInsets.symmetric(vertical: 2), child: Text('› ${logs[index]}', style: Theme.of(context).textTheme.bodySmall))))]))),
      ]);
}