part of 'lost_cubit.dart';

abstract class LostState extends Equatable {
  const LostState();
}

class LostInitial extends LostState {
  @override
  List<Object> get props => [];
}

class LostLoading extends LostState {
  @override
  List<Object> get props => [];
}

class LostLoaded extends LostState {
  final List<LostEntity> losts;

  LostLoaded({required this.losts});

  @override
  List<Object> get props => [losts];
}

class LostFailure extends LostState {
  @override
  List<Object> get props => [];
}
