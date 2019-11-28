import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:wmn_plus/features/profile/index.dart';
import 'dart:developer' as developer;

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  // todo: check singleton for logic in project
  static final ProfileBloc _profileBlocSingleton = ProfileBloc._internal();
  factory ProfileBloc() {
    return _profileBlocSingleton;
  }
  ProfileBloc._internal();
  
  @override
  Future<void> close() async{
    // dispose objects
    super.close();
  }

  ProfileState get initialState => UnProfileState(0);

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ProfileBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
