import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'state.dart';

class RegisterHandler extends Cubit<RegisterState> {
  RegisterHandler() : super(RegisterInitial()) {
    _intial();
  }

  _intial() {
    emit(
      RegisterCurrentState(
        currentState: CurrentState.mainScreen,
        typeValue: null,
        durationValue: null,
        countValue: null,
      ),
    );
  }


  back() {
    if (state is RegisterCurrentState &&
        (state as RegisterCurrentState).currentState == CurrentState.infoType) {
      emit(
        (state as RegisterCurrentState)
            .copyWith(currentState: CurrentState.mainScreen),
      );
    } else if (state is RegisterCurrentState &&
        (state as RegisterCurrentState).currentState ==
            CurrentState.infoDuration) {
      emit(
        (state as RegisterCurrentState)
            .copyWith(currentState: CurrentState.infoType),
      );
    } else if (state is RegisterCurrentState &&
        (state as RegisterCurrentState).currentState ==
            CurrentState.infoCounts) {
      emit(
        (state as RegisterCurrentState)
            .copyWith(currentState: CurrentState.infoDuration),
      );
    }
  }


}
