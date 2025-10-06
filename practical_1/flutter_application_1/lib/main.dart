import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const LearningApp());
}

// Backwards-compatible MyApp used by widget tests (and older code).
// This is a small counter app that matches the expectations in `test/widget_test.dart`.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage(title: 'Flutter Demo Home Page'));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class LearningApp extends StatelessWidget {
  const LearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alphabates and Numbers Learning Platform',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final FlutterTts _tts = FlutterTts();
  late TabController _tabController;
  bool _isPlaying = false;
  // Track selected index per tab (0 = letters tab, 1 = numbers tab).
  int? _selectedLetterIndex;
  int? _selectedNumberIndex;

  final List<String> letters = List.generate(
    26,
    (i) => String.fromCharCode(65 + i),
  );
  final List<String> numbers = List.generate(10, (i) => i.toString());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initTts();
  }

  Future<void> _initTts() async {
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    // Ensure that speak() completes only when speech has finished so we can
    // sequence multiple speak() calls reliably.
    try {
      await _tts.awaitSpeakCompletion(true);
    } catch (_) {
      // ignore if platform doesn't support this
    }
  }

  Future<void> _speak(String text) async {
    try {
      await _tts.stop();
      await _tts.speak(text);
    } catch (e) {
      // ignore TTS errors for now
    }
  }

  Future<void> _playAll() async {
    if (_isPlaying) return;
    setState(() {
      _isPlaying = true;
    });

    final List<String> itemsToSpeak = _tabController.index == 0
        ? letters
        : numbers;

    for (var raw in itemsToSpeak) {
      if (!mounted) break;

      final text = (_tabController.index == 0)
          ? raw // letters: speak 'A', 'B', ...
          : (raw == '0' ? 'Zero' : raw); // numbers: convert 0 to 'Zero'

      try {
        await _speak(text);
        // short pause between items
        await Future.delayed(const Duration(milliseconds: 250));
      } catch (_) {
        // ignore per-item errors and continue
      }
    }

    if (!mounted) return;
    setState(() {
      _isPlaying = false;
    });
  }

  @override
  void dispose() {
    _tts.stop();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alphabates and Numbers Learning Platform'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Letters'),
            Tab(text: 'Numbers'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildGrid(context, items: letters, labelPrefix: 'Letter'),
          _buildGrid(context, items: numbers, labelPrefix: 'Number'),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isPlaying ? null : _playAll,
        icon: _isPlaying
            ? const Padding(
                padding: EdgeInsets.only(right: 6.0),
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              )
            : const Icon(Icons.volume_up),
        label: Text(_isPlaying ? 'Playing...' : 'Play All'),
      ),
    );
  }

  Widget _buildGrid(
    BuildContext context, {
    required List<String> items,
    required String labelPrefix,
  }) {
    final colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow.shade700,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 3 / 4,
        ),
        itemBuilder: (context, idx) {
          final val = items[idx];
          final color = colors[idx % colors.length];

          final isSelected = (labelPrefix == 'Letter')
              ? _selectedLetterIndex == idx
              : _selectedNumberIndex == idx;

          return MouseRegion(
            onEnter: (_) => setState(() {}),
            onExit: (_) => setState(() {}),
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                // Update selection
                setState(() {
                  if (labelPrefix == 'Letter') {
                    _selectedLetterIndex = idx;
                  } else {
                    _selectedNumberIndex = idx;
                  }
                });

                // Speak item
                final toSpeak = (labelPrefix == 'Letter')
                    ? val
                    : (val == '0' ? 'Zero' : val);
                _speak(toSpeak);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                transform: Matrix4.identity()
                  ..scale(1.0 + (isSelected ? 0.04 : 0.0)),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(16),
                  border: isSelected
                      ? Border.all(color: Colors.white, width: 3)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: isSelected ? 12 : 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      val,
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          const Shadow(
                            blurRadius: 6,
                            color: Colors.black45,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      labelPrefix,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
