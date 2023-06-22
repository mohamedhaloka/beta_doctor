import 'dart:io';

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

  Future<void> chooseImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;

    imageFile = File(pickedImage.path);
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
          child: InkWell(
            onTap: chooseImage,
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
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            border:
                                Border.all(color: theme.colorScheme.primary),
                            image:
                                DecorationImage(image: FileImage(imageFile!))),
                      ),
                      const SizedBox(height: 16),
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
                    onTap: () {},
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
