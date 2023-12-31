part of 'package:api_bloc/api_bloc.dart';

/// An extended abstract class of [BlocController] specifically made for
/// fetching api request.
///
/// ```dart
/// class GetUserController extends GetController {
///
///   @override
///   Future<void> request() async {
///     Response response = await Response.get('https://base.url/api/user',
///       onProgress: (double progress) {
///         emit(GetLoadingState<double>(data: progress));
///         }
///       );
///
///     UserModel model = UserModel.fromJson(response.data);
///     emit(GetSuccessState<UserModel>(data: model));
///   }
///
///   @override
///   bool get autoDispose => true;
/// }
/// ```
///
/// now, when we emitting the [GetStates] don't forget to define the object
/// type to emphasize the data that we're going to use in [ApiBloc].
/// ```dart
/// // in controller
/// Future<void> request() async {
///   emit(GetSuccessState<UserModel>(data: model));
/// }
///
/// // in blocbuilder
/// ApiBloc.builder(
///   controller: controller,
///   builder: (context, state, child) {
///     if (state is GetSuccessState<UserModel>){
///       return Text(state.data!.userName);
///     } else {
///       return const CircularProgressIndicator();
///     }
///   }
/// )
/// ```
abstract class GetController extends BlocController<GetStates> {
  /// This is constructor of fetching api request with its initial value
  /// is [GetLoadingState] and also automatically calling [run] on init.
  GetController({Map<String, dynamic> args = const {}})
      : super(value: const GetLoadingState()) {
    run(args);
  }

  /// A neccessary function to override when we extends this controller.
  ///
  ///```dart
  /// @override
  /// Future<void> request() async {
  ///   Response response = await Response.get('https://base.url/api/user',
  ///     onProgress: (double progress) {
  ///       emit(GetLoadingState<double>(data: progress));
  ///       }
  ///     );
  ///
  ///   UserModel model = UserModel.fromJson(response.data);
  ///   emit(GetSuccessState<UserModel>(data: model));
  /// }
  /// ```
  Future<void> request({required Map<String, dynamic> args});

  /// now, when we emitting the [GetStates] don't forget to define the object
  /// type to emphasize the data that we're going to use in [ApiBloc].
  /// ```dart
  /// // in controller
  /// Future<void> request() async {
  ///   emit(GetSuccessState<UserModel>(data: model));
  /// }
  ///
  /// // in blocbuilder
  /// ApiBloc(
  ///   controller: controller,
  ///   builder: (context, state, child) {
  ///     if (state is GetSuccessState<UserModel>){
  ///       return Text(state.data!.userName);
  ///     } else {
  ///       return const CircularProgressIndicator();
  ///     }
  ///   }
  /// )
  /// ```
  @override
  void emit(GetStates<Object?> value) => super.emit(value);

  @override
  Future<void> run([Map<String, dynamic> args = const {}]) async {
    emit(const GetLoadingState());
    try {
      await request(args: args);
    } catch (e) {
      emit(GetErrorState(message: '$e'));
    }
  }

  /// Whether the controller that we created and associated to certain route
  /// should be automatically dispose or not. By default it's `true`.
  @override
  bool get autoDispose => super.autoDispose;
}
