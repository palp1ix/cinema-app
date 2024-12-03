import 'package:auto_route/auto_route.dart';
import 'package:cinema/data/models/reserve/reserve.dart';
import 'package:cinema/data/models/session/session.dart';
import 'package:cinema/presentation/home/view/home.dart';
import 'package:cinema/presentation/movie/view/movie.dart';
import 'package:cinema/presentation/payment/view/payment.dart';
import 'package:cinema/presentation/auth/pages/signin/view/signin.dart';
import 'package:cinema/presentation/auth/pages/signup/view/signup.dart';
import 'package:cinema/presentation/ticket/view/ticket_page.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: MovieRoute.page, path: '/movie'),
        AutoRoute(page: TicketRoute.page, path: '/ticket'),
        AutoRoute(page: PaymentRoute.page, path: '/payment'),
        AutoRoute(page: SignInRoute.page, path: '/signin'),
        AutoRoute(page: SignUpRoute.page, path: '/signup'),
      ];
}
