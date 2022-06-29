import 'package:untitled/bloc/notifications-bloc/notifications-cubit.dart';

abstract class NotificationsStates{}

class NInitState extends NotificationsStates{}

class InitializeNotificationsState extends NotificationsStates{}

class ShowNotificationsState extends NotificationsStates{}

class ShowScheduledNotificationsState extends NotificationsStates{}

class GetCurrentTimeState extends NotificationsStates{}
class RebuildState extends NotificationsStates{}
class DisposeState extends NotificationsStates{}