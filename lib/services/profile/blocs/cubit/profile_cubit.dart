import 'package:beta_doctor/services/profile/models/appointment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../base/base_state.dart';
import '../../models/user_model.dart';

class ProfileCubit extends Cubit<BaseState<UserModel>> {
  ProfileCubit() : super(const BaseState());


  List<String> selectedDays = <String>[];

  List<AppointmentModel>appointmentsList = <AppointmentModel>[];

  List<MapEntry<TextEditingController,TextEditingController>> pricingList = <MapEntry<TextEditingController,TextEditingController>>[];
}
