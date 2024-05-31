part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class SettingsLoadRequested extends SettingsEvent {}

class SettingsUpdateRequested extends SettingsEvent {
  final User user;
  final String name;
  final String? photoURL;

  const SettingsUpdateRequested({
    required this.user,
    required this.name,
    this.photoURL,
  });

  @override
  List<Object> get props => [user, name, photoURL ?? ''];
}

class SettingsImagePicked extends SettingsEvent {
  final String imagePath;

  const SettingsImagePicked({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}