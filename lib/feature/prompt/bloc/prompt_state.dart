part of 'prompt_bloc.dart';

@immutable
sealed class PromptState {}

final class PromptInitial extends PromptState {}

final class GenerateImagePromptLoadState extends PromptState {}

final class GenerateImagePromptSuccessState extends PromptState {
  final Uint8List uint8list;

  GenerateImagePromptSuccessState(this.uint8list);
}

final class GenerateImagePromptErrorState extends PromptState {}
