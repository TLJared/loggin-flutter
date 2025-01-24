import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggin/controller/controller.dart';

void main() {
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
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
                const Icon(
                  Icons.school,
                  size: 80,
                  color: Colors.cyan,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
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
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: const Icon(Icons.lock),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                Obx(() {
                  // Botón de carga basado en el estado del controlador
                  return loginController.isLoading.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            final emailError = loginController
                                .validateEmail(emailController.text);
                            final passwordError = loginController
                                .validatePassword(passwordController.text);

                            if (emailError != null) {
                              Get.snackbar('Error', emailError);
                              return;
                            }

                            if (passwordError != null) {
                              Get.snackbar('Error', passwordError);
                              return;
                            }

                            loginController.login(
                              emailController.text,
                              passwordController.text,
                            );
                          },
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
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        );
                }),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/registerP');
                  },
                  child: const Text(
                    "¿No tienes cuenta? Regístrate",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.cyan,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/ResetP');
                  },
                  child: const Text(
                    "¿Se te olvidó la contraseña?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.cyan,
                    ),
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
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:loggin/controller/controller.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   MyApp({super.key});

//   final LoginController loginController = Get.put(LoginController());

//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Colors.grey[200]),
//       backgroundColor: Colors.grey[200],
//       body: Center(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.school,
//                   size: 80,
//                   color: Colors.cyan,
//                 ),
//                 const SizedBox(height: 20),
//                 const Text(
//                   'Iniciar Sesión',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.cyan,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     prefixIcon: const Icon(Icons.email),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Contraseña',
//                     prefixIcon: const Icon(Icons.lock),
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                   ),
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 30),
//                 Obx(() {
//                   // Botón de carga basado en el estado del controlador
//                   return loginController.isLoading.value
//                       ? const CircularProgressIndicator()
//                       : ElevatedButton(
//                           onPressed: () {
//                             final emailError = loginController
//                                 .validateEmail(emailController.text);
//                             final passwordError = loginController
//                                 .validatePassword(passwordController.text);

//                             if (emailError != null) {
//                               Get.snackbar('Error', emailError);
//                               return;
//                             }

//                             if (passwordError != null) {
//                               Get.snackbar('Error', passwordError);
//                               return;
//                             }

//                             loginController.login(
//                               emailController.text,
//                               passwordController.text,
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 15, horizontal: 80),
//                             backgroundColor: Colors.cyan,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: const Text(
//                             'Iniciar Sesión',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.white,
//                             ),
//                           ),
//                         );
//                 }),
//                 const SizedBox(height: 10),
//                 TextButton(
//                   onPressed: () {
//                     Get.toNamed('');
//                   },
//                   child: const Text(
//                     "¿No tienes cuenta? Regístrate",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.cyan,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 TextButton(
//                   onPressed: () {
//                     Get.toNamed('');
//                   },
//                   child: const Text(
//                     "¿Se te olvidó la contraseña?",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.cyan,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
