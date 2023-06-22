import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../base/base_state.dart';
import '../../../../base/utils.dart';
import '../../../../base/widgets/fields/text_input_field.dart';
import '../../../../handlers/shared_handler.dart';
import '../../../../routers/routers.dart';
import '../../../../utilities/components/auth_body.dart';
import '../../../../utilities/components/custom_btn.dart';
import '../blocs/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController email = TextEditingController(),
      password = TextEditingController();

  LoginCubit loginCubit = LoginCubit();

  @override
  Widget build(BuildContext context) {
    return AuthBody(
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Image.asset("assets/images/splash.png"),
          ),
          const SizedBox(
            height: 99,
          ),
          TextInputField(
            hintText: "البريد الإلكتروني",
            controller: email,
          ),
          TextInputField(
            hintText: "كلمة المرور",
            controller: password,
          ),
          BlocConsumer<LoginCubit, BaseState>(
            bloc: loginCubit,
            listener: (_, BaseState state) {
              if (state.isSuccess) {
                SharedHandler.instance?.setData(
                  SharedKeys().user,
                  value: state.item,
                );
                Navigator.pushNamed(context, Routes.home);
              } else if (state.isFailure) {
                showSnackBar(
                  context,
                  state.failure?.message,
                  type: SnackBarType.error,
                );
              }
            },
            builder: (_, BaseState state) => CustomBtn(
              buttonColor: Theme.of(context).colorScheme.primary,
              text: "دخول",
              height: 40,
              loading: state.isInProgress,
              onTap: () => loginCubit.login(
                email: email.text,
                password: password.text,
              ),
            ),
          ),
          const SizedBox(
            height: 14
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                const Text("ليس لديك حساب؟ "),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.register);
                  },
                  child: Text(
                    "انشاء حساب",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
