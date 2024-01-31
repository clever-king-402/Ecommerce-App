import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/repository/repository.dart';
import 'package:ecommerce_app/features/auth/ui/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<CommonState> {
  final EcommerceRepository repository;
  RegisterCubit({required this.repository}) : super(CommonInitialState());

  registerUser({required User user}) async {
    final response = await repository.register(
        name: user.fullName,
        email: user.email,
        password: user.password,
        phone: user.phoneNumber,
        address: user.address);
    response.fold((erro) => emit(CommonErrorState(message: erro)), (item) => emit(CommonSuccessState(item: item)));
  }
}
