import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:loggin/main.dart';
import 'package:loggin/welcome.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var passwordVisible = false.obs;

  final LocalStorage storage = LocalStorage('app_storage');

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadSavedEmail();
  }

  // Cargar correo almacenado
  Future<void> _loadSavedEmail() async {
    await storage.ready;
    String? savedEmail = storage.getItem('saved_email');
    if (savedEmail != null) {
      emailController.text = savedEmail;
    }
  }

  // Guardar correo en el almacenamiento local
  Future<void> _saveEmail(String email) async {
    await storage.ready;
    storage.setItem('saved_email', email);
  }

  // Validar email
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Por favor, ingresa tu correo electrónico';
    }
    if (!GetUtils.isEmail(email)) {
      return 'Correo electrónico no válido';
    }
    return null;
  }

  // Validar contraseña
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Por favor, ingresa tu contraseña';
    }
    if (password.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  // Iniciar sesión y guardar el correo
  Future<void> login() async {
    String email = emailController.text;
    String password = passwordController.text;

    final emailError = validateEmail(email);
    final passwordError = validatePassword(password);

    if (emailError != null || passwordError != null) {
      Get.snackbar('Error', emailError ?? passwordError!);
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));

    await storage.ready;
    storage.setItem('token', 'fake_token_123');
    await _saveEmail(email);

    isLoading.value = false;
    Get.to(Welcome());
  }

  // Verificar si el usuario ya está autenticado
  Future<void> checkLoginStatus() async {
    await storage.ready;
    String? token = storage.getItem('token');
    if (token != null) {
      //Get.to(Welcome());
    }
  }

  // Cerrar sesión
  Future<void> logout() async {
    await storage.ready;
    storage.deleteItem('token');
    Get.to(LoginView());
  }
}
