abstract class AuthStates{}

class AuthInitState extends AuthStates{}

class OnTextFieldValidationChange extends AuthStates{}

class LoginState extends AuthStates{}
class LogoutState extends AuthStates{}



class VerifyingPhoneNumberLoadingState extends AuthStates{}
class VerifyingPhoneNumberSuccessState extends AuthStates{}
class VerifyingPhoneNumberErrorState extends AuthStates{}

class CreateUserCollectionLoadingState extends AuthStates{}
class CreateUserCollectionSuccessState extends AuthStates{}
class CreateUserCollectionFailureState extends AuthStates{}

class VerifyingCodeLoadingState extends AuthStates{}
class VerifyingCodeSuccessState extends AuthStates{}
class VerifyingCodeErrorState extends AuthStates{}


