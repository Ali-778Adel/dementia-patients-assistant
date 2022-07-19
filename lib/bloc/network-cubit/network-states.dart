import 'package:untitled/bloc/network-cubit/network-cubit.dart';

abstract class NetworkStates{}

class NSInitState extends NetworkStates{}

class CheckConnectivityStat extends NetworkStates{}
class TextFieldChangeState extends NetworkStates{}

class SetHostDataLoadingState extends NetworkStates{}
class SetHostDataSuccessState extends NetworkStates{}
// class SetHostDataLoadingState extends NetworkStates{}

class SetGuestDataLoadingState extends NetworkStates{}

class SendMissionsToFriendLoadingState extends NetworkStates{}
class SendMissionsToFriendSuccessState extends NetworkStates{}
class SendMissionsToFriendFailureState extends NetworkStates{}

class UpdateFireStoreMissionsLoadingState extends NetworkStates{}
class UpdateFireStoreMissionsSuccessState extends NetworkStates{}
class UpdateFireStoreMissionsFailureState extends NetworkStates{}

class DeleteFireStoreMissionsLoadingState extends NetworkStates{}
class DeleteFireStoreMissionsSuccessState extends NetworkStates{}
class DeleteFireStoreMissionsFailureState extends NetworkStates{}

class GetUserByPhoneNumberLoadingState extends NetworkStates{}
class GetUserByPhoneNumberSuccessState extends NetworkStates{}
class GetUserByPhoneNumberFailureState extends NetworkStates{}

class CheckUserCollaboratesLoadingState extends NetworkStates{}
class CheckUserCollaboratesSuccessState extends NetworkStates{}
class CheckUserCollaboratesFailureState extends NetworkStates{}

class GetFireStoreDataLoadingState extends NetworkStates{}
class GetFireStoreDataSuccessState extends NetworkStates{}
class GetFireStoreDataFailureState extends NetworkStates{}

class GetFirebaseStreamLoadingState extends NetworkStates{}
class GetFirebaseStreamSuccessState extends NetworkStates{}
class GetFirebaseStreamFailureState extends NetworkStates{}


class ChangeLayoutState extends NetworkStates{}
