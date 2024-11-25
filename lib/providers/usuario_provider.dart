import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../service/usuario_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  String? tipoUsuario;
  int userId = 0;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> registrarUsuario(UsuarioDTO usuario) async {
    _isLoading = true;
    notifyListeners();

    final success = await _userService.registerUser(usuario);

    _isLoading = false;
    notifyListeners();

    return success;
  }

  Future<bool> login(
      String email, String password, BuildContext context) async {
    final userData = await _userService.login(email, password);

    if (userData != null) {
      tipoUsuario = userData['tipoUsuario'];
      userId = userData['userId'];
      notifyListeners();

      // Redirige según el tipo de usuario
      if (tipoUsuario == 'empresa') {
        Navigator.pushReplacementNamed(context, '/home');
      } else if (tipoUsuario == 'cliente') {
        Navigator.pushReplacementNamed(context, '/home2');
      }
      return true;
    } else {
      return false;
    }
  }
}
