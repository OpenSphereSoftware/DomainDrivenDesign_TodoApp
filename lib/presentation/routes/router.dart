import 'package:auto_route/auto_route.dart';
import 'package:dddcourse/presentation/notes/note_form/note_form_page.dart';
import 'package:dddcourse/presentation/notes/notes_overview/notes_overview_page.dart';
import 'package:dddcourse/presentation/sign_in/sign_in_page.dart';
import 'package:dddcourse/presentation/splash/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignInPage, initial: false),
    AutoRoute(page: NotesOverviewPage, initial: false),
    AutoRoute(page: NoteFormPage, initial: false, fullscreenDialog: true),
  ],
)
class $AppRouter {}
