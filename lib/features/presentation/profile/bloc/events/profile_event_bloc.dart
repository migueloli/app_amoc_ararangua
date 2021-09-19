import 'package:equatable/equatable.dart';

abstract class ProfileEventBloc extends Equatable {
  const ProfileEventBloc();
}

class GetProfileEventBloc extends ProfileEventBloc {
  const GetProfileEventBloc();

  @override
  List<Object?> get props => [];
}

class SaveProfileEventBloc extends ProfileEventBloc {
  const SaveProfileEventBloc();

  @override
  List<Object?> get props => throw UnimplementedError();
}
