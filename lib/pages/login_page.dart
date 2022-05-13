part of 'pages.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AccountController accountController = Get.put(AccountController());
  var togglePassword = true.obs;
  var toggleLoadingAnimation = false.obs;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: mainColor,
    ));
    DeviceScreen.setup(context: context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: DeviceScreen.devHeight,
        width: DeviceScreen.devWidth,
        padding:
            const EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 10),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowIndicator();
              return false;
            },
            child: ListView(
              shrinkWrap: true,
              children: [
                _upperComponent(),
                _lowerComponent(),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _upperComponent() {
    const double _textWidgetHeight = 60;
    double _allocatedHeight = (DeviceScreen.devHeight / 2) - (2 * 10);
    return SizedBox(
      height: _allocatedHeight,
      width: DeviceScreen.devWidth,
      child: Column(
        children: [
          SizedBox(
            height: _textWidgetHeight,
            child: Text(
              'My APPS',
              style: headerFontStyle.copyWith(color: mainColor),
            ),
          ),
          Container(
              height: _allocatedHeight - _textWidgetHeight,
              width: DeviceScreen.devWidth,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(defaultMargin),
              decoration: BoxDecoration(
                  // color: Colors.red,
                  image: DecorationImage(
                      fit: BoxFit.contain, image: AssetImage(logoOnly)))),
        ],
      ),
    );
  }

  Widget _lowerComponent() {
    double _allocatedHeight = (DeviceScreen.devHeight / 2) - (2 * 10);
    return SizedBox(
      height: _allocatedHeight,
      width: DeviceScreen.devWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: DeviceScreen.devWidth,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: secondColor,
              // border: Border.all(color: Colors.black),
            ),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: blackFontStyle2.copyWith(color: mainColor),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: defaultMargin / 2),
          Container(
            width: DeviceScreen.devWidth,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: secondColor,
              // border: Border.all(color: Colors.black),
            ),
            child: Obx(
              () => TextField(
                controller: passwordController,
                obscureText: togglePassword.value,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: blackFontStyle2.copyWith(color: mainColor),
                  suffixIcon: IconButton(
                      onPressed: () =>
                          togglePassword.value = !togglePassword.value,
                      icon: Icon(
                        togglePassword.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: mainColor,
                      )),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultMargin * 1.5),
          Obx(
            () => SizedBox(
              height: 50,
              width: DeviceScreen.devWidth,
              child: toggleLoadingAnimation.value
                  ? Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        backgroundColor: mainColor,
                        color: secondColor,
                        strokeWidth: 5,
                      ),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        loginToAccount();
                      },
                      child: Text(
                        'Login',
                        style: blackFontStyle.copyWith(color: Colors.white),
                      ),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          backgroundColor:
                              MaterialStateProperty.all(mainColor)),
                    ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> loginToAccount() async {
    try {
      toggleLoadingAnimation.value = true;
      if (emailController.text == '') {
        showWarning('Email cannot be empty');
        return;
      } else {
        if (!GetUtils.isEmail(emailController.text)) {
          showWarning('Invalid Email');
          return;
        }
      }
      if (passwordController.text == '') {
        showWarning('Password cannot be empty');
        return;
      }
      await accountController.loginToAccount(
          email: emailController.text, password: passwordController.text);
    } finally {
      toggleLoadingAnimation.value = false;
    }
  }

  void showWarning(String message) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar('Invalid input', message,
          snackStyle: SnackStyle.FLOATING,
          colorText: Colors.white,
          backgroundColor: Colors.red,
          borderRadius: 15,
          icon: const Icon(Icons.error_outline, color: Colors.white));
    }
  }
}
