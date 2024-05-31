import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? photoURL; 

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.photoURL, 
  });

  // Método copyWith
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? photoURL,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  @override
  List<Object?> get props => [id, name, email, photoURL]; 
}