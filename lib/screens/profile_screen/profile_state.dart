part of 'profile_cubit.dart';

@immutable
abstract class ProfileStates {}

class ProfileInitial extends ProfileStates {}

class ProfileChangeImageState extends ProfileStates {}

class ProfileSetImageState extends ProfileStates {}
class ProfileGetDataState extends ProfileStates {}

