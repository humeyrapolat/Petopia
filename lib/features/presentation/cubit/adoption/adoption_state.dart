part of 'adoption_cubit.dart';

abstract class AdoptionState extends Equatable {
  const AdoptionState();
}

class AdoptionInitial extends AdoptionState {
  @override
  List<Object> get props => [];
}

class AdoptionLoading extends AdoptionState {
  @override
  List<Object> get props => [];
}

class AdoptionLoaded extends AdoptionState {
  final List<AdoptionEntity> adoptions;

  AdoptionLoaded({required this.adoptions});

  @override
  List<Object> get props => [adoptions];
}

class AdoptionFailure extends AdoptionState {
  @override
  List<Object> get props => [];
}
