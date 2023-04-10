import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petopia/features/domain/usecases/firebase_usecases/resetPassword/reset_password_usecase.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordCubit({required this.resetPasswordUseCase})
      : super(ResetPasswordInitial());

  Future<void> passwordReset({required String? email}) async {
    emit(ResetPasswordInitial());
    try {
      await resetPasswordUseCase.call(email!);
      emit(ResetPasswordSuccess());
    } on SocketException catch(_) {
      emit(ResetPasswordFailure());
    } catch (_) {
      emit(ResetPasswordFailure());
    }
  }
}
