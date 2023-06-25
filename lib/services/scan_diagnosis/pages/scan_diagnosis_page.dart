import 'dart:io';
import 'dart:math';

import 'package:beta_doctor/utilities/components/custom_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanDiagnosisPage extends StatefulWidget {
  const ScanDiagnosisPage({Key? key}) : super(key: key);

  @override
  State<ScanDiagnosisPage> createState() => _ScanDiagnosisPageState();
}

class _ScanDiagnosisPageState extends State<ScanDiagnosisPage> {
  File? imageFile;

  int type = 1;
  String? msg;
  bool loading = false;

  Future<void> chooseImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    imageFile = File(pickedImage.path);
    msg = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: imageFile != null ? null : chooseImage,
                child: Column(
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (imageFile != null) ...[
                          Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                border: Border.all(
                                    color: theme.colorScheme.primary),
                                image: DecorationImage(
                                    image: FileImage(imageFile!))),
                          ),
                          const SizedBox(height: 16),
                        ],
                        if (msg != null) ...[
                          Text(
                            msg!,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: theme.colorScheme.primary,
                          child: const Icon(
                            CupertinoIcons.arrow_up_circle,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          imageFile == null ? 'اختر الصورة' : 'اختر صورة أخرى',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
                    if (imageFile != null)
                      CustomBtn(
                        text: 'تشخيص',
                        buttonColor: Theme.of(context).colorScheme.primary,
                        height: 40,
                        onTap: () async {
                          loading = true;
                          setState(() {});
                          await Future.delayed(
                              Duration(seconds: Random().nextInt(10)));
                          loading = false;
                          setState(() {});

                          if (type == 4) {
                            type = 1;
                          }
                          switch (type) {
                            case 1:
                              msg = 'No Diabetic Retinopathy';
                              break;
                            case 2:
                              msg = 'Level 3, Proliferate_DR';
                              break;
                            case 3:
                              msg = 'Level 4, severe';
                              break;
                          }

                          type++;

                          setState(() {});
                        },
                      )
                  ],
                ),
              ),
              if (loading)
                Container(
                  color: Colors.white30,
                  child: const CircularProgressIndicator(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
