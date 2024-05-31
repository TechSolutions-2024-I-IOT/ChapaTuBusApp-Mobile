import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoURL;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoURL,
  });

  // Método copyWith
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? photoURL,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  // Convertir un Map a un UserModel (desde la base de datos)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      photoURL: map['photoURL'],
    );
  }

  // Convertir un UserModel a un Map (para la base de datos)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoURL': photoURL,
    };
  }

  // Convertir un UserModel a un Map (para Firestore)
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoURL': photoURL,
    };
  }

  // Convertir un DocumentSnapshot a un UserModel
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      name: data['name'] ?? '', // Maneja la posibilidad de que los campos sean nulos
      email: data['email'] ?? '', 
      photoURL: data['photoURL'],
    );
  }

}