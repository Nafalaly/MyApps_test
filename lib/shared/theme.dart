part of 'shared.dart';

//Color greyColor = "8D82A3".toColor();
Color greyColor = "9fa8b5".toColor();
Color mainColor = "#247881".toColor();
Color secondColor = "#BCD8DA".toColor();
Color greyBackground = "F0F0F0".toColor();

String logoOnly = "assets/login_asset.png";

TextStyle greyFontStyle = GoogleFonts.poppins().copyWith(color: greyColor);
TextStyle blackFontStyle = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500);
TextStyle blackFontStyle2 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle blackFontStyle3 = GoogleFonts.poppins().copyWith(color: Colors.black);
TextStyle headerFontStyle = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 45, fontWeight: FontWeight.w900);

const double defaultMargin = 24;

// void showDefaultErrorPopUp() {
//   if (!Get.isSnackbarOpen) {
//     Get.snackbar('Something went wrong', 'Please try again later',
//         icon: const Icon(Icons.warning, color: Colors.white),
//         backgroundColor: Colors.black,
//         snackPosition: SnackPosition.TOP,
//         snackStyle: SnackStyle.GROUNDED,
//         colorText: Colors.white);
//   }
// }

// void showInternalErrorPopUp({required String message}) {
//   if (!Get.isSnackbarOpen) {
//     Get.snackbar('Cannot proceed your request', message,
//         icon: const Icon(Icons.warning, color: Colors.white),
//         backgroundColor: Colors.deepOrange,
//         snackPosition: SnackPosition.TOP,
//         snackStyle: SnackStyle.GROUNDED,
//         colorText: Colors.white);
//   }
// }

// void showDefaultConnectionProblem() {
//   if (!Get.isSnackbarOpen) {
//     Get.snackbar('Cannot communicate with server',
//         'Please make sure you have an active connection',
//         icon: const Icon(Icons.wifi_off_rounded, color: Colors.white),
//         backgroundColor: Colors.red,
//         snackPosition: SnackPosition.TOP,
//         snackStyle: SnackStyle.GROUNDED,
//         colorText: Colors.white);
//   }
// }
