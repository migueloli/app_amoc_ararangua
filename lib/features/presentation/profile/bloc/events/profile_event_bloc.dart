import 'package:equatable/equatable.dart';

abstract class ProfileEventBloc extends Equatable {
  const ProfileEventBloc();
}

class GetProfileEventBloc extends ProfileEventBloc {
  final bool resend;
  const GetProfileEventBloc({this.resend = false});

  @override
  List<Object?> get props => [];
}

class SaveProfileEventBloc extends ProfileEventBloc {
  const SaveProfileEventBloc();

  @override
  List<Object?> get props => [];
}

class PageProfileEventBloc extends ProfileEventBloc {
  final int page;
  const PageProfileEventBloc({required this.page});

  @override
  List<Object?> get props => [page];
}
