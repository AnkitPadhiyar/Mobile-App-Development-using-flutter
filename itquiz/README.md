
# itquiz

Simple subject-wise IT quiz Flutter app (sample MCQs for 5 subjects).

## Run

Ensure Flutter is installed and your device/emulator is available. In PowerShell:

```powershell
flutter pub get
flutter run
```

## Quiz files

- `lib/models/question.dart` - Question model
- `lib/data/questions.dart` - Sample questions for 5 subjects
- `lib/screens/home_screen.dart` - Subject list and entry
- `lib/screens/quiz_screen.dart` - Quiz flow UI
- `lib/screens/result_screen.dart` - Shows the score
- `lib/widgets/option_tile.dart` - Reusable option widget

Each subject currently contains 8 sample questions (you can expand them in `lib/data/questions.dart`).

UI Improvements:
- Brighter, card-based subject list on the home screen
- Progress bar, styled question card and modern option tiles in the quiz screen
- Colorful result card with percentage
 - Immediate right/wrong feedback after submitting each answer
 - Brighter app theme and vivid accent colors (less like a plain form)

If you want more polish (animations, persistence, or shuffled/randomized options), tell me which and I'll add it.
