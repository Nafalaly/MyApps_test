part of '../pages.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool passVisible = false;

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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailure) {
          showWarning(formStatus.failMessage, context);
          context.read<LoginBloc>().add(LoginDismissible());
        }
        if (formStatus is SubmissionSuccess) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return Dashboard(account: formStatus.account!);
          }), (route) => false);
          // context.read<LoginBloc>().add(NavigateToDashBoard());
        }
      },
      child: SizedBox(
        height: _allocatedHeight,
        width: DeviceScreen.devWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Container(
                  width: DeviceScreen.devWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: secondColor,
                  ),
                  child: TextField(
                    controller: emailController,
                    onChanged: (val) {
                      context
                          .read<LoginBloc>()
                          .add(LoginUsernameChanged(username: val));
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: blackFontStyle2.copyWith(color: mainColor),
                      border: InputBorder.none,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: defaultMargin / 2),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Container(
                  width: DeviceScreen.devWidth,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: secondColor,
                    // border: Border.all(color: Colors.black),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: state.passwordVisible,
                    onChanged: (val) {
                      context
                          .read<LoginBloc>()
                          .add(LoginPasswordChanged(password: val));
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: blackFontStyle2.copyWith(color: mainColor),
                      suffixIcon: IconButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(PasswordSetVisible(
                                visibleStatus: !state.passwordVisible));
                          },
                          icon: Icon(
                            state.passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: mainColor,
                          )),
                      border: InputBorder.none,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: defaultMargin * 1.5),
            loginButton(),
          ],
        ),
      ),
    );
  }

  Widget loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SizedBox(
          height: 50,
          width: DeviceScreen.devWidth,
          child: state.formStatus is FormSubmitting
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
                    context.read<LoginBloc>().add(LoginSubmitted());
                  },
                  child: Text(
                    'Login',
                    style: blackFontStyle.copyWith(color: Colors.white),
                  ),
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      backgroundColor: MaterialStateProperty.all(mainColor)),
                ),
        );
      },
    );
  }

  void showWarning(String message, context) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.white),
          Container(
            padding: const EdgeInsets.only(left: 10),
            width: DeviceScreen.devWidth - 100,
            child: Text(
              message,
              style: blackFontStyle2.copyWith(color: Colors.white),
              maxLines: 2,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.deepOrange,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
