part of 'reports_bloc.dart';

abstract class ReportsEvent extends Equatable {
  const ReportsEvent();

  @override
  List<Object> get props => [];
}

class ReportsEventUpdateUsers extends ReportsEvent {
  final List<UserModel> users;
  const ReportsEventUpdateUsers({required this.users});
}

class ReportsEventUpdateDate extends ReportsEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  const ReportsEventUpdateDate({this.startDate,this.endDate});
}
