class Seat {
  final int id;
  final SeatStatus status;

  Seat({required this.id, required this.status});
}

enum SeatStatus { free, occupied }
