import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_page_controller.dart';

class RegisterPageView extends StatelessWidget {
  const RegisterPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterPageController());

    return Scaffold(
      backgroundColor: const Color(0xFFEBDED4),
      appBar: AppBar(
        title: const Text('Daftar Akun'),
        backgroundColor: const Color(0xFFF4E9CD),
        foregroundColor: Colors.brown,
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/logo.png", height: 120),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.brown.withOpacity(0.1),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Buat Akun Baru',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField(
                        controller.fullNameController,
                        "Full Name",
                        icon: Icons.person_outline,
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller.addressController,
                        "Alamat",
                        icon: Icons.home_outlined,
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller.phoneController,
                        "No HP",
                        keyboardType: TextInputType.phone,
                        icon: Icons.phone_outlined,
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller.ageController,
                        "Umur",
                        keyboardType: TextInputType.number,
                        icon: Icons.calendar_today_outlined,
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller.emailController,
                        "Email",
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 12),
                      _buildTextField(
                        controller.passController,
                        "Password",
                        isPassword: true,
                        icon: Icons.lock_outline,
                      ),
                      const SizedBox(height: 24),
                      Obx(() {
                        return ElevatedButton(
                          onPressed:
                              controller.isLoading.value
                                  ? null
                                  : controller.register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF4E9CD),
                            foregroundColor: Colors.brown,
                            minimumSize: const Size(double.infinity, 52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 2,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child:
                              controller.isLoading.value
                                  ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.brown,
                                      strokeWidth: 3,
                                    ),
                                  )
                                  : const Text(
                                    "Daftar",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                        );
                      }),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => Get.offAllNamed('/login-page'),
                        child: const Text(
                          "Sudah punya akun? Login",
                          style: TextStyle(
                            color: Colors.brown,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget helper untuk text field
  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    IconData? icon,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.brown),
        prefixIcon:
            icon != null
                ? Icon(icon, color: Colors.brown.withOpacity(0.6))
                : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.brown, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.brown.withOpacity(0.4),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.brown, width: 1.5),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
      style: const TextStyle(color: Colors.brown),
      cursorColor: Colors.brown,
    );
  }
}
