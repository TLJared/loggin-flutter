import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggin/controller/controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login App',
      home: LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    loginController.checkLoginStatus();

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.grey[200]),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.school, size: 80, color: Colors.cyan),
                const SizedBox(height: 20),
                const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyan),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: loginController.emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Obx(() {
                  return TextField(
                    controller: loginController.passwordController,
                    obscureText: loginController.passwordVisible.value,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginController.passwordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          loginController.passwordVisible.toggle();
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 30),
                Obx(() {
                  return loginController.isLoading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: loginController.login,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 80),
                            backgroundColor: Colors.cyan,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Iniciar Sesión',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        );
                }),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/');
                  },
                  child: const Text(
                    "¿No tienes cuenta? Regístrate",
                    style: TextStyle(fontSize: 16, color: Colors.cyan),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/');
                  },
                  child: const Text(
                    "¿Se te olvidó la contraseña?",
                    style: TextStyle(fontSize: 16, color: Colors.cyan),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
