import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seetle/src/repository/authRepository.dart';
// * ---------------------------------------------------------------------------
// * AuthController
// * ---------------------------------------------------------------------------

class AuthController extends StateNotifier<AsyncValue<bool>> {
  AuthController({required this.authRepo}) : super(const AsyncData(false));

  final AuthRepository authRepo;
  late BuildContext context;

  Future<bool> registerData(String userName, String birthday, String nickName, String password, String imageName,String base64Image, String email, String phone) async {
    state = const AsyncValue.loading();

    final newState =
        await AsyncValue.guard(() => authRepo.registerData(userName, birthday, nickName, password, imageName, base64Image, email, phone));
    
    if (mounted) {
      state = newState;
    }
    return newState.value!;
  }

  Future<bool> compareNickname(String nickName) async {
    state = const AsyncValue.loading();

    final newState =
        await AsyncValue.guard(() => authRepo.compareNickname(nickName));
    
    if (mounted) {
      state = newState;
    }
    return newState.value!;
  }

  Future<bool> loginAction(String emailOrNumber) async {
    state = const AsyncValue.loading();

    final newState =
        await AsyncValue.guard(() => authRepo.loginAction(emailOrNumber));
    
    if (mounted) {
      state = newState;
    }
    return newState.value!;
  }

  Future<bool> loginWithPassword(String emailOrNumber, String password) async {
    state = const AsyncValue.loading();

    final newState =
        await AsyncValue.guard(() => authRepo.loginWithPassword(emailOrNumber, password));
    
    if (mounted) {
      state = newState;
    }
    return newState.value!;
  }
}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthController, AsyncValue<bool>>((ref) {
  return AuthController(authRepo: ref.watch(authRepositoryProvider));
});
