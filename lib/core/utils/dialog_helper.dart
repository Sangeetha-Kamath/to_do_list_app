import 'package:get/get.dart';
import '../widgets/app_confirmation_dialog.dart';

class DialogHelper {
  DialogHelper._();

  static void showConfirmation({
    required String title,
    required String message,
    required Function() onConfirm,
    String confirmText = "Confirm",
    String cancelText = "Cancel",
    bool isDanger = false,
  }) {
    Get.dialog(
      AppConfirmationDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        isDanger: isDanger,
        onConfirm: onConfirm,
      ),
    );
  }
}