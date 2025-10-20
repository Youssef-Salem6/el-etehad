// get_current_state.dart

part of 'get_current_cubit.dart';

@immutable
sealed class GetCurrentState {}

final class GetCurrentInitial extends GetCurrentState {}

final class GetCurrentSuccess extends GetCurrentState {
  final CurrencyModel currencyModel;
  
  GetCurrentSuccess({required this.currencyModel});
}

final class GetCurrentFailure extends GetCurrentState {
  final String error;
  
  GetCurrentFailure({required this.error});
}

final class GetCurrentLoading extends GetCurrentState {}