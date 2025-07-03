import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';
  final _idCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<LoginController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _idCtrl,
              decoration: const InputDecoration(labelText: 'User ID'),
            ),
            const SizedBox(height: 16),
            Obx(
              () =>
                  ctrl.error.value != null
                      ? Text(
                        ctrl.error.value!,
                        style: const TextStyle(color: Colors.red),
                      )
                      : const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),
            Obx(
              () =>
                  ctrl.loading.value
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                        onPressed: () => ctrl.login(_idCtrl.text.trim()),
                        child: const Text('Entrar'),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
