import 'package:beta_doctor/services/home/models/home_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../base/utils.dart';
import '../../../config/api_names.dart';
import '../../../handlers/shared_handler.dart';
import '../../../network/network_handler.dart';
import '../../../utilities/components/custom_page_body.dart';
import '../../../utilities/theme/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeModel? homeModel;
  String? userName;

  @override
  void initState() {
    getUserName();
    getHomeData();
    super.initState();
  }

  Future<void> getUserName() async {

    userName = await SharedHandler.instance?.getData(
      key: SharedKeys().user,
      valueType: ValueType.map,
    )['name'];
    setState(() {});
  }

  void getHomeData() async {
    try {
      final Response? response = await NetworkHandler.instance?.get(
        url: ApiNames.home,
        withToken: true,
      );

      if (response == null) return;
      if (!mounted) return;

      homeModel = HomeModel.fromJson(response.data['data']);
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return CustomPageBody(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // if (userName != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 21,
                      backgroundImage: NetworkImage(
                          "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("مرحباً بك🖐",
                            style: AppTextStyles.w500.copyWith(fontSize: 14)),
                        Text("دكتور محمد",
                            style: AppTextStyles.w700.copyWith(fontSize: 20)),
                      ],
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
            Divider(
              height: 0,
              color: Theme.of(context).dividerColor,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                child: homeModel == null
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "الجلسات القادمة",
                            style: AppTextStyles.w600.copyWith(
                                fontSize: 18,
                                color: themeData.colorScheme.primary),
                          ),
                          ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            itemBuilder: (_, int index) => Ink(
                              color: Colors.grey[50],
                              child: ListTile(
                                title: Text('مكالمة فيديو'),
                                subtitle: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.time,
                                      color: Colors.grey[500]!,
                                      size: 15,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      homeModel!
                                              .appointments![index].startTime ??
                                          '',
                                      style:
                                          TextStyle(color: Colors.grey[500]!),
                                    )
                                  ],
                                ),
                                trailing: SizedBox(
                                  width: 90,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      InkWell(
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemCount: homeModel!.appointments?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                          const Divider(),
                          Text(
                            "العملاء المتابعين",
                            style: AppTextStyles.w600.copyWith(
                                fontSize: 18,
                                color: themeData.colorScheme.primary),
                          ),
                          ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            itemBuilder: (_, int index) => Ink(
                              color: Colors.grey[50],
                              child: ListTile(
                                onTap: () {},
                                title: Text(
                                    homeModel!.patients![index].name ?? ''),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'اضغط لمعرفة تفاصيل أكثر',
                                    style: TextStyle(color: Colors.grey[500]!),
                                  ),
                                ),
                                trailing: const Icon(CupertinoIcons.arrow_left),
                              ),
                            ),
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 12),
                            itemCount: homeModel!.patients?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
