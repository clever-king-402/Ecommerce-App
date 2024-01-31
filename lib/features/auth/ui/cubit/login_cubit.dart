import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<CommonState> {
  final EcommerceRepository repository;
  LoginCubit({required this.repository}) : super(CommonInitialState());
  login({
    required String email,
    required String password,
  }) async {
    emit(CommonLoadingState());
    final response = await repository.login(email: email, password: password);
    response.fold((error) => emit(CommonErrorState(message: error)),
        (loginSuccess) => emit(CommonSuccessState(item: loginSuccess)));
  }
}
