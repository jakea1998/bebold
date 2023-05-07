part of 'reports_bloc.dart';

enum ReportsStatus { loading, loaded, error, initial }

class ReportsState extends Equatable {
  final DateTime? startDate;
  final DateTime? endDate;
  final ReportsStatus? reportsStatus;
  final List<UserModel>? totalUsers;
  final List<UserModel>? witnessed;
  final List<UserModel>? accepted;
  const ReportsState({this.startDate, this.endDate, this.reportsStatus,this.totalUsers,this.witnessed,this.accepted});
  factory ReportsState.initial() {
    return ReportsState(reportsStatus:ReportsStatus.initial, startDate:null, endDate:null, totalUsers:null,witnessed:[],accepted: []);
  }
  ReportsState copyWith(
      {DateTime? startDate,
  DateTime? endDate,
  ReportsStatus? reportsStatus,
  List<UserModel>? totalUsers,
  List<UserModel>? witnessed,
  List<UserModel>? accepted}) {
    return ReportsState(
       reportsStatus:reportsStatus ?? this.reportsStatus, startDate:startDate ?? this.startDate, endDate:endDate ??this.endDate, totalUsers:totalUsers ?? this.totalUsers,witnessed: witnessed ?? this.witnessed,accepted: accepted ?? this.accepted);
  }
  @override
  List<Object?> get props => [startDate, endDate, reportsStatus,totalUsers,witnessed,accepted];
}


