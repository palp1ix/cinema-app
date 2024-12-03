import 'package:auto_route/auto_route.dart';
import 'package:cinema/domain/auth_manager/auth_manager.dart';
import 'package:cinema/router/router.dart';
import 'package:get_it/get_it.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authManager = GetIt.I<AuthManager>();
    if (authManager.getStatus() == AuthStatus.loggedIn) {
      resolver.next(true);
    } else {
      resolver.redirect(const SignInRoute());
    }
  }
}
