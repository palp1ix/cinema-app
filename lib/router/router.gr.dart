// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomePage();
    },
  );
}

/// generated route for
/// [MoviePage]
class MovieRoute extends PageRouteInfo<MovieRouteArgs> {
  MovieRoute({
    Key? key,
    required Session session,
    List<PageRouteInfo>? children,
  }) : super(
          MovieRoute.name,
          args: MovieRouteArgs(
            key: key,
            session: session,
          ),
          initialChildren: children,
        );

  static const String name = 'MovieRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MovieRouteArgs>();
      return MoviePage(
        key: args.key,
        session: args.session,
      );
    },
  );
}

class MovieRouteArgs {
  const MovieRouteArgs({
    this.key,
    required this.session,
  });

  final Key? key;

  final Session session;

  @override
  String toString() {
    return 'MovieRouteArgs{key: $key, session: $session}';
  }
}

/// generated route for
/// [PaymentPage]
class PaymentRoute extends PageRouteInfo<PaymentRouteArgs> {
  PaymentRoute({
    Key? key,
    required List<int> selectedSeats,
    required Session session,
    required DateTime date,
    required Reserve reserve,
    List<PageRouteInfo>? children,
  }) : super(
          PaymentRoute.name,
          args: PaymentRouteArgs(
            key: key,
            selectedSeats: selectedSeats,
            session: session,
            date: date,
            reserve: reserve,
          ),
          initialChildren: children,
        );

  static const String name = 'PaymentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PaymentRouteArgs>();
      return PaymentPage(
        key: args.key,
        selectedSeats: args.selectedSeats,
        session: args.session,
        date: args.date,
        reserve: args.reserve,
      );
    },
  );
}

class PaymentRouteArgs {
  const PaymentRouteArgs({
    this.key,
    required this.selectedSeats,
    required this.session,
    required this.date,
    required this.reserve,
  });

  final Key? key;

  final List<int> selectedSeats;

  final Session session;

  final DateTime date;

  final Reserve reserve;

  @override
  String toString() {
    return 'PaymentRouteArgs{key: $key, selectedSeats: $selectedSeats, session: $session, date: $date, reserve: $reserve}';
  }
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignInPage();
    },
  );
}

/// generated route for
/// [SignUpPage]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SignUpPage();
    },
  );
}

/// generated route for
/// [TicketPage]
class TicketRoute extends PageRouteInfo<TicketRouteArgs> {
  TicketRoute({
    Key? key,
    required String title,
    required Session session,
    List<PageRouteInfo>? children,
  }) : super(
          TicketRoute.name,
          args: TicketRouteArgs(
            key: key,
            title: title,
            session: session,
          ),
          initialChildren: children,
        );

  static const String name = 'TicketRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TicketRouteArgs>();
      return TicketPage(
        key: args.key,
        title: args.title,
        session: args.session,
      );
    },
  );
}

class TicketRouteArgs {
  const TicketRouteArgs({
    this.key,
    required this.title,
    required this.session,
  });

  final Key? key;

  final String title;

  final Session session;

  @override
  String toString() {
    return 'TicketRouteArgs{key: $key, title: $title, session: $session}';
  }
}
