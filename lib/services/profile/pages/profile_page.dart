import 'package:beta_doctor/services/authentication/register/pages/registration_page.dart';
import 'package:beta_doctor/services/profile/blocs/cubit/profile_cubit.dart';
import 'package:beta_doctor/services/profile/models/appointment_model.dart';
import 'package:beta_doctor/services/profile/widgets/pricing_item.dart';
import 'package:beta_doctor/services/profile/widgets/profile_header.dart';
import 'package:beta_doctor/services/profile/widgets/sliver_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/base_state.dart';
import '../../../base/utils.dart';
import '../../../base/widgets/fields/text_input_field.dart';
import '../../../utilities/components/custom_btn.dart';
import '../blocs/cubit/get_profile_cubit.dart';
import '../blocs/cubit/update_profile_cubit.dart';
import '../models/user_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController name = TextEditingController(),
      phone = TextEditingController(),
      day = TextEditingController(),
      month = TextEditingController(),
      year = TextEditingController(),
      department = TextEditingController(),
      bio = TextEditingController();

  final GetProfileCubit getProfileCubit = GetProfileCubit();
  final UpdateProfileCubit updateProfileCubit = UpdateProfileCubit();
  @override
  void initState() {
    getProfileCubit.getProfileDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: Builder(builder: (context) {
        final profileCubit = context.read<ProfileCubit>();

        return MultiBlocListener(
          listeners: [
            BlocListener<UpdateProfileCubit, BaseState<UserModel>>(
              bloc: updateProfileCubit,
              listener: (BuildContext context, BaseState<UserModel> state) {
                if (state.isSuccess) {
                  showSnackBar(
                    context,
                    'تم تحديث البيانات بنجاح',
                    type: SnackBarType.success,
                  );
                }
              },
            ),
            BlocListener<GetProfileCubit, BaseState<UserModel>>(
              bloc: getProfileCubit,
              listener: (BuildContext context, BaseState<UserModel> state) {
                if (state.isSuccess) {
                  if (state.item == null) return;
                  name.text = state.item!.name;
                  phone.text = state.item!.phone;
                  bio.text = state.item!.bio;
                  department.text = state.item!.department;
                  day.text = state.item!.birthday.day.toString();
                  month.text = state.item!.birthday.month.toString();
                  year.text = state.item!.birthday.year.toString();
                } else if (state.isFailure) {
                  showSnackBar(
                    context,
                    state.failure?.message,
                    type: SnackBarType.error,
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<GetProfileCubit, BaseState<UserModel>>(
            bloc: getProfileCubit,
            builder: (BuildContext context, BaseState<UserModel> state) =>
                Scaffold(
              body: Stack(
                children: [
                  SliverBody(
                    collapsedHeight: 60,
                    expandedHeight: 250,
                    flexibleSpace: ProfileHeader(
                      name: name.text,
                      department: department.text,
                    ),
                    child: SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'المعلومات الشخصية',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                TextInputField(
                                  hintText: "نبذه شخصية",
                                  controller: bio,
                                  maxLines: 4,
                                ),
                                TextInputField(
                                  hintText: "رقم الهاتف",
                                  controller: phone,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: TextInputField(
                                        hintText: "اليوم",
                                        controller: day,
                                        maxLength: 2,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    Flexible(
                                      child: TextInputField(
                                        hintText: "الشهر",
                                        controller: month,
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
                                        controller: year,
                                        maxLength: 4,
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                  ],
                                ),
                                TextInputField(
                                  hintText: "كلمة المرور",
                                ),
                                TextInputField(
                                  hintText: "التخصص",
                                  controller: department,
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    Text(
                                      'المواعيد',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () => setState(() {
                                        profileCubit.appointmentsList.add(
                                          AppointmentModel(
                                            from: TimeOfDay.now(),
                                            to: TimeOfDay.now(),
                                          ),
                                        );
                                      }),
                                      child: CircleAvatar(
                                        radius: 14,
                                        backgroundColor:
                                            theme.colorScheme.primary,
                                        child: const Icon(
                                          Icons.add,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Row(
                                    children: [
                                      'Sat',
                                      'Sun',
                                      'Mon',
                                      'Thu',
                                      'Wed',
                                      'The',
                                      'Fri'
                                    ]
                                        .map((e) => Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2),
                                                child: InkWell(
                                                  onTap: () {
                                                    if (profileCubit
                                                        .selectedDays
                                                        .contains(e)) {
                                                      profileCubit.selectedDays
                                                          .remove(e);
                                                    } else {
                                                      profileCubit.selectedDays
                                                          .add(e);
                                                    }
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  12)),
                                                      color: profileCubit
                                                              .selectedDays
                                                              .contains(e)
                                                          ? theme.colorScheme
                                                              .primary
                                                          : null,
                                                      border: Border.all(
                                                        color: profileCubit
                                                                .selectedDays
                                                                .contains(e)
                                                            ? theme.colorScheme
                                                                .primary
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        e,
                                                        style: TextStyle(
                                                            color: profileCubit
                                                                    .selectedDays
                                                                    .contains(e)
                                                                ? Colors.white
                                                                : Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                ),
                                Column(
                                  children: profileCubit.appointmentsList
                                      .map((e) => Dismissible(
                                            key: UniqueKey(),
                                            background: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                              color: Colors.red,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: const [
                                                  Icon(
                                                    CupertinoIcons.trash,
                                                    color: Colors.white,
                                                  ),
                                                  Icon(
                                                    CupertinoIcons.trash,
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onDismissed: (d) {
                                              profileCubit.appointmentsList
                                                  .remove(e);
                                              setState(() {});
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () async {
                                                        final pickedTime =
                                                            await showTimePicker(
                                                                context:
                                                                    context,
                                                                initialTime:
                                                                    e.from);
                                                        if (pickedTime ==
                                                            null) {
                                                          return;
                                                        }
                                                        e.from = pickedTime;
                                                        setState(() {});
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              'من',
                                                              style: TextStyle(
                                                                color: theme
                                                                    .colorScheme
                                                                    .primary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              '${e.from.minute} : ${e.from.hour}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () async {
                                                        final pickedTime =
                                                            await showTimePicker(
                                                                context:
                                                                    context,
                                                                initialTime:
                                                                    e.to);
                                                        if (pickedTime == null)
                                                          return;
                                                        e.to = pickedTime;
                                                        setState(() {});
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              'إلي',
                                                              style: TextStyle(
                                                                color: theme
                                                                    .colorScheme
                                                                    .primary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              '${e.to.minute} : ${e.to.hour}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                                const Divider(),
                                Row(
                                  children: [
                                    Text(
                                      'تحديد التكلفة',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    InkWell(
                                      onTap: () => setState(() {
                                        profileCubit.pricingList.add(
                                          MapEntry(
                                            TextEditingController(),
                                            TextEditingController(),
                                          ),
                                        );
                                      }),
                                      child: CircleAvatar(
                                        radius: 14,
                                        backgroundColor:
                                            theme.colorScheme.primary,
                                        child: const Icon(
                                          Icons.add,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                ListView.separated(
                                  itemBuilder: (_, int index) => Dismissible(
                                    onDismissed: (d) {
                                      profileCubit.pricingList.remove(
                                          profileCubit.pricingList[index]);
                                    },
                                    background: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Icon(
                                            CupertinoIcons.trash,
                                            color: Colors.white,
                                          ),
                                          Icon(
                                            CupertinoIcons.trash,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    key: UniqueKey(),
                                    child: PricingItemWidget(
                                        profileCubit.pricingList[index]),
                                  ),
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 12),
                                  itemCount: profileCubit.pricingList.length,
                                  padding: const EdgeInsets.only(
                                      bottom: 20, top: 10),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                ),
                          BlocBuilder<UpdateProfileCubit,
                              BaseState<UserModel>>(
                            bloc: updateProfileCubit,
                            builder: (BuildContext context,
                                BaseState<UserModel> state)=> CustomBtn(
                                    buttonColor: theme.colorScheme.primary,
                                    text: "تعديل الحساب",
                                    height: 40,
                                    loading: state.isInProgress,
                                    onTap: () {
                                        DateTime newBirthday = DateTime(
                                          year.text.toInt(),
                                          month.text.toInt(),
                                          day.text.toInt(),
                                        );
                                        updateProfileCubit.updateProfile(
                                            name: name.text,
                                            phone: phone.text,
                                            birthday: newBirthday, bio: bio.text,);

                                    },
                                  ),
                                ),
                              ],
                            )),
                      ]),
                    ),
                  ),
                  if (state.isInProgress)
                    Container(
                      width: size.width,
                      height: size.height,
                      color: Colors.white70,
                      child: const Center(child: CircularProgressIndicator()),
                    )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
