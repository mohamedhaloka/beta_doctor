import 'package:beta_doctor/config/app_events.dart';
import 'package:beta_doctor/config/app_states.dart';
import 'package:beta_doctor/utilities/extensions/date_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/message_model.dart';

class ChatRoomBloc extends Bloc<AppEvents, AppStates> {
  ChatRoomBloc() : super(Start()) {
    on<Send>(_sendMessage);
  }

  void _sendMessage(AppEvents event, Emitter emit) {

  }
}
