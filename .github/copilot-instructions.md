# Copilot Instructions for AI Agents

## Project Overview
This is a Flutter app for autism care, connecting parents and doctors. The app features onboarding, authentication (sign in/up), a dashboard, and profile management. The UI is responsive and uses custom sizing utilities.

## Architecture & Structure
- **Entry Point:** `lib/main.dart` initializes the app and sets up `SizeConfig` for responsive layouts.
- **Features:**
  - `lib/features/` contains modular features: `auth`, `on_boarding`, `dash_board`, `splash`.
  - Each feature is split into `views` (with `screens` and `widgets`), and some have `cubit` or `models` for state/data.
- **State Management:** Uses `flutter_bloc` for onboarding flow (`OnBoardingCubit`).
- **UI Patterns:**
  - Responsive sizing via `SizeConfig` (`lib/core/utilies/sizes/sized_config.dart`).
  - Consistent use of `SafeArea`, `Scaffold`, and custom paddings.
  - Asset-driven UI: images and Lottie animations from `assets/`.

## Developer Workflows
- **Build:**
  - Standard Flutter: `flutter run` for development, `flutter build <platform>` for release.
- **Test:**
  - Run widget tests: `flutter test` (see `test/widget_test.dart`).
- **Analyze/Lint:**
  - Use `flutter analyze` (configured by `analysis_options.yaml`, extends `flutter_lints`).
- **Assets:**
  - Add images to `assets/images/`, Lottie files to `assets/lottie/`. Register new assets in `pubspec.yaml`.

## Project-Specific Conventions
- **Navigation:**
  - Uses `Navigator.pushReplacement` for onboarding and auth transitions.
  - Onboarding steps are defined in `on_boarding/models/on_boarding_steps_list.dart` and rendered via a `PageView`.
- **UI Consistency:**
  - Colors: Primary accent is `#FF7F3E`.
  - Buttons and text fields use rounded corners and consistent padding.
- **State:**
  - Onboarding state managed by `OnBoardingCubit` (see `on_boarding/cubit/on_boarding_cubit.dart`).
- **Sizing:**
  - Always use `SizeConfig.width`/`height` for paddings, margins, and widget sizes.

## Integration & Dependencies
- **Key Packages:**
  - `flutter_bloc`, `lottie`, `flutter_animate`, `smooth_page_indicator`.
- **Adding Packages:**
  - Add to `pubspec.yaml` and run `flutter pub get`.

## Examples
- **Onboarding Navigation:**
  - See `on_boarding/views/screens/on_boarding_screen.dart` for navigation and state pattern.
- **Sign Up UI:**
  - See `auth/sign_up/views/widgets/sign_up_screen_body.dart` for form and asset usage.

## Notes
- No backend integration is present; all flows are local/UI only.
- Follow the modular feature structure for new screens or flows.
- Keep all new assets registered in `pubspec.yaml`.

---
For questions or unclear patterns, check the relevant feature directory or ask for clarification.
