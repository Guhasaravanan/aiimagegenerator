import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:imagegenerator/feature/prompt/repos/prompt_repo.dart';
import 'package:meta/meta.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptInitialEvent>(promptInitialEvent);

    on<PromptEnteredEvent>(promptEnteredEvent);
  }

  FutureOr<void> promptEnteredEvent(
      PromptEnteredEvent event, Emitter<PromptState> emit) async {
    emit(GenerateImagePromptLoadState());
    Uint8List? bytes = await Promptrepo.generateimage(event.prompt);
    if (bytes != null) {
      emit(GenerateImagePromptSuccessState(bytes));
    } else {
      emit(GenerateImagePromptErrorState());
    }
  }

  FutureOr<void> promptInitialEvent(
      PromptInitialEvent event, Emitter<PromptState> emit) async {
    Uint8List bytes = await rootBundle
        .load('assets/batman.png')
        .then((bdl) => bdl.buffer.asUint8List());
    emit(GenerateImagePromptSuccessState(bytes));
  }
}
