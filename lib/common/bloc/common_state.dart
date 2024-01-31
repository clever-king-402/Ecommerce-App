sealed class CommonState {}

class CommonInitialState extends CommonState {}

class CommonLoadingState extends CommonState {}

class CommonErrorState<String> extends CommonState {
  final String message;

  CommonErrorState({required this.message});

}

class CommonSuccessState<Type> extends CommonState {
  final Type item;

  CommonSuccessState({required this.item});
}
