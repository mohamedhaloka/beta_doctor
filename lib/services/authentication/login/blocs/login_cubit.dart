import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../base/base_state.dart';
import '../../../../base/failure.dart';
import '../../../../config/api_names.dart';
import '../../../../network/network_handler.dart';

class LoginCubit extends Cubit<BaseState> {
  LoginCubit() : super(const BaseState());

  void login({required String email, required String password}) async {
    try {
      emit(const BaseState(status: BaseStatus.inProgress));

      final FormData formData = FormData.fromMap({
        'email': email,
        'password': password,
      });
      final Response? response = await NetworkHandler.instance?.post(
        url: ApiNames.login,
        body: formData,
      );
      if (response == null) return;
      emit(BaseState(status: BaseStatus.success, item: response.data['data']));
    } on DioError catch (e) {
      String? msg = e.response?.data.toString();

      if (e.response?.data is Map &&
          (e.response?.data as Map).containsKey('message')) {
        msg = e.response?.data['message'];
      }
      final Failure failure = Failure(
        message: msg,
      );
      emit(BaseState(status: BaseStatus.failure, failure: failure));
    }
  }
}
