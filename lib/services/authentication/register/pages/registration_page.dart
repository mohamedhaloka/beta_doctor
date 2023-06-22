import 'dart:io';

import 'package:beta_doctor/base/widgets/fields/text_input_field.dart';
import 'package:beta_doctor/routers/routers.dart';
import 'package:beta_doctor/services/authentication/register/blocs/cubit/handler.dart';
import 'package:beta_doctor/utilities/components/custom_btn.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../base/utils.dart';
import '../../../../config/api_names.dart';
import '../../../../handlers/shared_handler.dart';
import '../../../../network/network_handler.dart';
import '../../../../utilities/components/auth_body.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterHandler(),
      child: AuthBody(
        BlocBuilder<RegisterHandler, RegisterState>(
          builder: (context, state) {
            return WillPopScope(
              onWillPop: () async {
                if (state is RegisterCurrentState) {
                  context.read<RegisterHandler>().back();
                  return false;
                }
                return true;
              },
              child: BlocBuilder<RegisterHandler, RegisterState>(
                builder: (context, state) => const MainRegisterPage(),
              ),
            );
          },
        ),
        showBackBtn: true,
      ),
    );
  }
}

class MainRegisterPage extends StatefulWidget {
  const MainRegisterPage({super.key});

  @override
  State<MainRegisterPage> createState() => _MainRegisterPageState();
}

class _MainRegisterPageState extends State<MainRegisterPage> {
  TextEditingController name = TextEditingController(),
      email = TextEditingController(),
      phone = TextEditingController(),
      password = TextEditingController(),
      day = TextEditingController(),
      month = TextEditingController(),
      year = TextEditingController(),
      confirmPassword = TextEditingController(),
      department = TextEditingController(),
      bio = TextEditingController();

  File medicalIdPhoto = File(''), profilePhoto = File('');

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Image.asset("assets/images/splash.png"),
            ),
            const SizedBox(
              height: 99,
            ),
            TextInputField(
              hintText: "الإسم",
              controller:name,
            ),
            TextInputField(
              hintText: "البريد الإلكتروني",
              controller:email,
            ),
            TextInputField(
              hintText: "رقم الهاتف",
              controller:phone,
            ),
            Row(
              children: [
                Flexible(
                  child: TextInputField(
                    hintText: "اليوم",
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    controller:day,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Flexible(
                  child: TextInputField(
                    hintText: "الشهر",
                    controller:month,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Flexible(
                  child: TextInputField(
                    hintText: "السنة",
                    controller:year,
                    maxLength: 4,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            TextInputField(
              hintText: "التخصص المهني",
              controller:department,
            ),
            TextInputField(
              hintText: "نبذه",
              controller:bio,
              maxLines: 4,
            ),
            TextInputField(
              onTap: () async {
                await chooseImage((file) => medicalIdPhoto = file);
                setState(() {});
              },
              controller: TextEditingController(
                  text: medicalIdPhoto.path.split('/').last),
              hintText: "كارنية النقابة",
            ),
            TextInputField(
              hintText: "كلمة المرور",
              controller: password,
            ),
            TextInputField(
              hintText: "تأكيد كلمة المرور",
              controller: confirmPassword,
            ),
            CustomBtn(
              buttonColor: Theme.of(context).colorScheme.primary,
              text: "تسجيل",
              height: 40,
              loading: loading,
              onTap: () {
                if (name.text.isEmpty ||
                    email.text.isEmpty ||
                    phone.text.isEmpty ||
                    password.text.isEmpty ||
                    year.text.isEmpty ||
                    month.text.isEmpty ||
                    department.text.isEmpty ||
                    bio.text.isEmpty) {
                  showSnackBar(
                    context,
                    'جميع الحقول مطلوبة',
                    type: SnackBarType.warning,
                  );
                  return;
                }

                register();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> chooseImage(void onSuccess(File)) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    onSuccess(File(pickedImage.path));
  }

  void register() async {
    try {
      loading = true;
      setState(() {});
      String timeFormatPattern = 'yyyy-MM-dd';
      DateTime dateTime =
          DateTime(year.text.toInt(), month.text.toInt(), day.text.toInt());
      final FormData formData = FormData.fromMap({
        'name': name.text,
        'email': email.text,
        'phone': phone.text,
        'password': password.text,
        'confirmed_password': name.text,
        'department': name.text,
        'bio': bio.text,
        'birthday': DateFormat(timeFormatPattern).format(dateTime),
      });

      formData.files.add(MapEntry('medical_id_photo',
          await MultipartFile.fromFile(medicalIdPhoto.path)));
      formData.files.add(MapEntry(
          'profile_pic', await MultipartFile.fromFile(profilePhoto.path)));

      final Response? response = await NetworkHandler.instance?.post(
        url: ApiNames.register,
        body: formData,
        withToken: true,
      );

      if (response == null) return;
      if (!mounted) return;

      showSnackBar(
        context,
        'تم تسجيل الحساب بنجاح',
        type: SnackBarType.success,
      );
      SharedHandler.instance?.setData(
        SharedKeys().user,
        value: response.data['data'],
      );
      Navigator.pushNamed(context, Routes.home);
    } on DioError catch (e) {
      String? msg = e.response?.data.toString();

      if (e.response?.data is Map &&
          (e.response?.data as Map).containsKey('errors')) {
        msg = e.response?.data['errors'].toString();
      }

      showSnackBar(
        context,
        msg,
        type: SnackBarType.warning,
      );
    }
    loading = false;
    setState(() {});
  }
}

extension StringToInt on String {
  int toInt() {
    return int.tryParse(this) ?? 0;
  }
}
