import 'package:ecommerce_app/common/bloc/common_state.dart';
import 'package:ecommerce_app/common/services/shared_pre_data.dart';
import 'package:ecommerce_app/features/splash/modal/startup_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartUpCubit extends Cubit<CommonState> {
  StartUpCubit() : super(CommonInitialState());

  fetchInitialData() async {
    emit(CommonLoadingState());
    await Future.delayed(Duration(seconds: 3));
    final isFirstTime = await SharedPrefServices.isFirstTime;
    emit(CommonSuccessState(item: StartUpData(isLogin: true, isFirstTime: isFirstTime)));
  }
}
