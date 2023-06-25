import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../handlers/shared_handler.dart';
import '../../../routers/navigator.dart';
import '../../../utilities/components/arrow_back.dart';
import '../../../utilities/components/custom_page_body.dart';
import '../../../utilities/theme/text_styles.dart';
import '../widgets/info_section.dart';

class PatentDetailsPage extends StatefulWidget {
  const PatentDetailsPage({super.key});

  @override
  State<PatentDetailsPage> createState() => _PatentDetailsPageState();
}

class _PatentDetailsPageState extends State<PatentDetailsPage> {
  int? userId;

  bool loading = false;

  TextEditingController comment = TextEditingController();
  @override
  void initState() {
    getItems();
    super.initState();
  }

  Future<void> getUserID() async {
    userId = (await SharedHandler.instance?.getData(
        key: SharedKeys().user,
        valueType: ValueType.map) as Map<String, dynamic>)['id'];
  }

  void getItems() async {
    await getUserID();
    loading = true;
    setState(() {});
    await Future.delayed(const Duration(seconds: 2));
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomPageBody(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .2,
        leading: InkWell(
          onTap: () => CustomNavigator.pop(),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Row(
            children: const [
              SizedBox(width: 16),
              ArrowBack(),
            ],
          ),
        ),
        titleSpacing: 4,
        title: Text(
          loading ? '' : ('اسراء ابو العنيين'),
          style: AppTextStyles.w500.copyWith(fontSize: 18),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: const Color(0xffD3E4FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'اسراء ابو العنيين',
                    style: AppTextStyles.w700.copyWith(fontSize: 26),
                  ),
                  Divider(
                    height: 32,
                    color: Theme.of(context).dividerColor,
                  ),
                  InfoSection(
                    label: "معلومات عن المريض",
                    body: ReadMoreText(
                      'ما نوع مرض السكري الذي تعاني منه ؟ النوع الاول\n'
                      'ما مدة إصابتك بالسُكري ؟  أقل من 6 أشهر\n'
                      'معدل قياسك للسكر؟  مرتين في اليوم',
                      trimLines: 3,
                      colorClickableText: Theme.of(context).colorScheme.primary,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: '\t\tاظهر المزيد',
                      trimExpandedText: '\t\tاختصار',
                      moreStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                      lessStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        launch("tel:+2010011593381");
                      },
                      icon: const Icon(Icons.call)),
                  Divider(
                    height: 32,
                    color: Theme.of(context).dividerColor,
                  ),
                ],
              ),
            ),
    );
  }
}

class DoctorCommentsController {
  DoctorCommentsController._();

  static DoctorCommentsController instance = DoctorCommentsController._();

  Map<String, List<String>> comments = {};

  void addComment({required String userId, required String comment}) {
    List<String>? list = comments[userId] ?? [];
    comments[userId] = [comment, ...list];
  }
}
