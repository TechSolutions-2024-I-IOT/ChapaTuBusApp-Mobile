import 'dart:io';

import 'package:chapa_tu_bus_app/account_management/domain/entities/user.dart';
import 'package:chapa_tu_bus_app/account_management/domain/interfaces/i_auth_repository.dart';
import 'package:chapa_tu_bus_app/account_management/infrastructure/data/local_database_datasource.dart';
import 'package:chapa_tu_bus_app/account_management/infrastructure/data_sources/firebase_auth_datasource.dart';
import 'package:chapa_tu_bus_app/account_management/infrastructure/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AuthRepositoryImpl implements IAuthRepository {
  final FirebaseAuthDatasource _firebaseAuthDatasource;
  final LocalDatabaseDatasource _localDatabaseDatasource; // Data source local

  AuthRepositoryImpl({
    required FirebaseAuthDatasource firebaseAuthDatasource,
    required LocalDatabaseDatasource localDatabaseDatasource,
  })  : _firebaseAuthDatasource = firebaseAuthDatasource,
        _localDatabaseDatasource = localDatabaseDatasource;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Autenticación con Firebase
      final userCredential = await _firebaseAuthDatasource
          .signInWithEmailAndPassword(email: email, password: password);

      // 2. Obtener el usuario de Firebase
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // 3. Intentar obtener el usuario de la base de datos local
        UserModel? localUser =
            await _localDatabaseDatasource.getUserById(firebaseUser.uid);

        // 4. Si no existe en local, crear un nuevo UserModel
        if (localUser == null) {
          localUser = UserModel(
            id: firebaseUser.uid,
            name: firebaseUser.displayName ?? '',
            email: firebaseUser.email ?? '',
            photoURL: firebaseUser.photoURL 
                      ?? 'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgQrn0h8YlouX1uYeAHOjVV_1zOiEzM0Q_Ftq_kDVXy8XUJVc2bLiMCHa6-hYHGBKHswAnzu6McRzACcS7kAwtq0Q8f-2vzFpOtBmnMGs9M7a5avCRCGuyMzRRUOGHLTNxlzQ1WcwgmM6xhJ-_3GycyKrQstuDFIVisogfV9FaYpaJzfciWLj8B1VOxlfA/s1600/Ellipse%2049.png',
          );

          // 5. Guardar el nuevo usuario en la base de datos local
          await _localDatabaseDatasource.insertUser(localUser);
        }
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final userCredential = await _firebaseAuthDatasource.signInWithGoogle();
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // 1. Intentar obtener el usuario de la base de datos local
        UserModel? localUser =
            await _localDatabaseDatasource.getUserById(firebaseUser.uid);

        // 2. Si no existe en local, crear un nuevo UserModel
        if (localUser == null) {
          localUser = UserModel(
            id: firebaseUser.uid,
            name: firebaseUser.displayName ?? '',
            email: firebaseUser.email ?? '',
            photoURL: firebaseUser.photoURL,
          );

          // 3. Guardar el nuevo usuario en la base de datos local
          await _localDatabaseDatasource.insertUser(localUser);
        }
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // 1. Registrar el usuario en Firebase
      final userCredential = await _firebaseAuthDatasource
          .signUpWithEmailAndPassword(email: email, password: password);

      // 2. Obtener el usuario de Firebase
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // 3. Crear un nuevo UserModel
        final userModel = UserModel(
          id: firebaseUser.uid,
          name: name,
          email: firebaseUser.email ?? '',
          photoURL: firebaseUser.photoURL,
        );

        // 4. Guardar el nuevo usuario en la base de datos local
        await _localDatabaseDatasource.insertUser(userModel);
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    // 1. Obtén el usuario actual de Firebase (antes de cerrar sesión)
    final firebaseUser = _firebaseAuthDatasource.getCurrentUser();
    String? userId; // Variable para almacenar el ID del usuario

    // 2. Obtiene el ID del usuario si existe
    if (firebaseUser != null) {
      userId = firebaseUser.uid;
    }

    // 3. Cierra la sesión en Firebase
    await _firebaseAuthDatasource.signOut();

    // 4. Elimina el usuario de la base de datos local (si se obtuvo el ID)
    if (userId != null) {
      await _localDatabaseDatasource.deleteUser(userId);
    }
  }

  @override
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuthDatasource.resetPassword(email: email);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    // 1. Obtener el usuario de Firebase
    final firebaseUser = _firebaseAuthDatasource.getCurrentUser();

    if (firebaseUser != null) {
      // 2. Intentar obtener el usuario de la base de datos local
      final localUser =
          await _localDatabaseDatasource.getUserById(firebaseUser.uid);

      // 3. Si existe en local, convertirlo a una entidad de dominio
      if (localUser != null) {
        return User(
          id: localUser.id,
          name: localUser.name,
          email: localUser.email,
          photoURL: localUser.photoURL,
        );
      }
    }
    return null;
  }

  @override
  Future<void> updateUser({required User user}) async {
    var userModel = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      photoURL: user.photoURL,
    );
    await _localDatabaseDatasource.updateUser(userModel);

    // (Opcional) Subir la imagen a Firebase Storage y actualizar photoURL en Firestore
    if (user.photoURL != null && user.photoURL!.startsWith('file://')) {
      await _uploadImageToFirebaseStorage(user.id, user.photoURL!);
      // Obtener la URL de descarga de Firebase Storage
      final downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('user_images/${user.id}')
          .getDownloadURL();
      // Actualizar photoURL creando una nueva instancia de UserModel
      userModel = userModel.copyWith(photoURL: downloadURL);
      await _localDatabaseDatasource.updateUser(userModel);
    }
  }

  Future<void> _uploadImageToFirebaseStorage(String userId, String filePath) async {
    try {
      final file = XFile(filePath.replaceAll('file://', ''));
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('user_images/$userId')
          .putFile(file as File);
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      throw Exception('Error uploading image to Firebase Storage');
    }
  }
  
}
