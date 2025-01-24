import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo/usuario no puede ser vacío';
    }

    final caracteres = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!caracteres.hasMatch(value)) {
      return 'Ingresa un correo válido';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña no puede ser vacía';
    }
    if (value.length < 8) {
      return 'La contraseña debe tener mínimo 8 caracteres';
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    await Future.delayed(
        const Duration(seconds: 2)); // Simulación de un retraso
    isLoading.value = false;
    if (email == 'jared@gmail.com' && password == '12345678') {
      Get.snackbar('Éxito', 'Inicio de sesión exitoso');
    } else {
      Get.snackbar('Error', 'Credenciales incorrectas');
    }
  }
}
