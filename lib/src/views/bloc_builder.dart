part of 'package:api_bloc/api_bloc.dart';

// /// Signature for a function that builds a widget tree based on the current [BlocStates].
// typedef BlocBuilder<T extends BlocRequest> = Widget Function(
//   BuildContext context,
//   T state,
//   Widget child,
// );

// /// Signature for a function that listens to changes in the [BlocStates].
// ///
// /// The [S] type parameter represents an optional generic type that can be used
// /// to provide additional data or constraints to the listener.
// typedef OnBlocListener<S extends Object?> = void Function(
//   BuildContext context,
//   BlocStates<S> state,
// );

// /// Main widget on dealing [BlocStates] changes in [controller].
// class ApiBloc<T extends BlocRequest> extends StatelessWidget {
//   /// Default constructor for [ApiBloc].
//   ///
//   /// The [controller] is a required parameter of type [BlocRequest] that
//   /// manages the state.
//   ///
//   /// The [builder] is an optional parameter of type [BlocBuilder] that builds
//   /// a widget tree based on the current [BlocStates].
//   ///
//   /// The [listener] is an optional parameter of type [BlocListener] that
//   /// listens to changes in the [BlocStates].
//   ///
//   /// The [child] is a required parameter of type [Widget] which will be used
//   /// when no [builder] is provided. By default returning a [Placeholder].
//   ///
//   /// ```dart
//   /// ApiBloc(
//   ///   controller: ReadRequest(),
//   ///   listener: (context, state) => log(state.toString());
//   ///   builder: (context, state, child) {
//   ///     if (state is ReadSuccessState<Model>){
//   ///       return Text(state.model!.userName);
//   ///     } else if (state is ReadErrorState){
//   ///       return Text('Oops something is wrong\nReason: ${state.message}');
//   ///     } else {
//   ///       return const CircularProgressIndicator();
//   ///     }
//   ///   }
//   /// );
//   /// ```
//   const ApiBloc({
//     super.key,
//     this.child = const Placeholder(),
//     this.listener,
//     this.builder,
//   });

//   /// The child widget to be rendered when no [builder] is provided.
//   final Widget child;

//   /// The [BlocBuilder] function that rebuild its widget by listening to changes
//   /// in [BlocRequest].
//   final BlocBuilder<T>? builder;

//   /// The [BlocListener] function that listens to changes in the [BlocStates].
//   final BlocListener<T>? listener;

//   /// Constructor for [ApiBloc] with [BlocBuilder] only.
//   ///
//   /// Use this constructor when you want to use only the [builder] function to build the widget tree
//   /// based on the current [BlocStates].
//   const ApiBloc.builder({
//     super.key,
//     this.child = const Placeholder(),
//     required this.builder,
//   })  : assert(builder != null, 'Builder is required'),
//         listener = null;

//   /// Constructor for [ApiBloc] with [BlocListener] only.
//   ///
//   /// Use this constructor when you want to use only the [listener] function
//   /// to listen to changes in the [BlocStates].
//   const ApiBloc.listener(
//       {super.key,
//       required this.listener,
//       required this.child})
//       : assert(listener != null, 'Listener is required'),
//         builder = null;

//   /// Creates a new instance of [ApiBloc] with the given parameters replaced.
//   ///
//   /// The [key] parameter is an optional key to be used for the new [ApiBloc] instance.
//   /// The [controller] parameter is an optional [BlocRequest] that manages the state.
//   /// The [listener] parameter is an optional [BlocListener] that listens to changes in the [BlocStates].
//   /// The [builder] parameter is an optional [BlocBuilder] that rebuilds its widget based on the current [BlocStates].
//   /// The [child] parameter is an optional child widget to be rendered when no [builder] is provided.
//   ///
//   /// Returns a new [ApiBloc] instance with the specified parameters replaced.
//   ApiBloc<T> copyWith({
//     Key? key,
//     BlocListener<T>? listener,
//     BlocBuilder<T>? builder,
//     Widget? child,
//   }) {
//     return ApiBloc(
//       key: key ?? this.key,
//       listener: listener ?? this.listener,
//       builder: builder ?? this.builder,
//       child: child ?? this.child,
//     );
//   }

//   /// Creates a new instance of [ApiBloc] with listeners and builders for the WriteIdleState.
//   ///
//   /// The [listener] parameter is an optional [OnBlocListener] that listens to the [WriteIdleState].
//   /// The [builder] parameter is an optional [OnBlocBuilder] that rebuilds its widget tree based on the [WriteIdleState].
//   ///
//   /// Returns a new [ApiBloc] instance with the specified listeners and builders for the WriteIdleState.
//   ///
//   /// ```dart
//   /// ApiBloc(
//   ///   controller: BlocRequest(),
//   /// ).onIdle<int>(
//   ///   listener: (context, state) {
//   ///     /* your code here */
//   ///   }, builder: (context, state) {
//   ///     /* your code here */
//   ///   }
//   /// )
//   /// ```
//   ApiBloc<T> onIdle<S extends Object?>({
//     OnBlocListener<S>? listener,
//     OnBlocBuilder<S>? builder,
//   }) {
//     return this.copyWith(
//       listener: (context, state) {
//         final controller = context.read
//         if (listener != null) {
//           assert(controller is WriteRequest,
//               "In onIdle listener, The provided controller must be a WriteRequest. This requirement is due to the design based on known states pattern.");
//           if (controller is WriteRequest && state is WriteIdleState<S>) {
//             listener(context, state);
//           }
//         }
//         if (this.listener != null) this.listener!(context, state);
//       },
//       builder: (context, state, child) {
//         if (builder != null) {
//           assert(controller is WriteRequest,
//               "In onIdle builder, The provided controller must be a WriteRequest. This requirement is due to the design based on known states pattern.");
//           if (controller is WriteRequest && state is WriteIdleState<S>) {
//             return builder(context, state, child);
//           }
//         }
//         if (this.builder != null) return this.builder!(context, state, child);
//         return child;
//       },
//     );
//   }

//   /// Extends the [ApiBloc] with custom logic to handle loading states.
//   ///
//   /// The `onLoading` method allows you to specify custom listener and builder functions
//   /// to handle loading states based on the provided [BlocRequest].
//   ///
//   /// If [listener] is specified and the controller is of type [ReadRequest] or [WriteRequest],
//   /// it will be called when the state is a loading state.
//   ///
//   /// If [builder] is specified and the controller is of type [ReadRequest] or [WriteRequest],
//   /// it will be used to build the widget tree when the state is a loading state.
//   ///
//   /// When neither [listener] nor [builder] is specified, the default listener and builder
//   /// functions provided during [ApiBloc] instantiation will be used.
//   ///
//   /// ```dart
//   /// ApiBloc(
//   ///   controller: BlocRequest(),
//   /// ).onLoading<double>(
//   ///   listener: (context, state) {
//   ///     /* your code here */
//   ///   }, builder: (context, state) {
//   ///     /* your code here */
//   ///   }
//   /// )
//   /// ```
//   ApiBloc<T> onLoading<S extends Object?>({
//     OnBlocListener<S>? listener,
//     OnBlocBuilder<S>? builder,
//   }) {
//     return this.copyWith(
//       listener: (context, state) {
//         if (listener != null) {
//           assert(controller is ReadRequest || controller is WriteRequest,
//               "In onLoading listener, The provided controller must be either a ReadRequest or a WriteRequest. This requirement is due to the design based on known states pattern.");
//           if (controller is ReadRequest && state is ReadLoadingState<S>) {
//             listener(context, state);
//           } else if (controller is WriteRequest &&
//               state is WriteLoadingState<S>) {
//             listener(context, state);
//           }
//         }
//         if (this.listener != null) this.listener!(context, state);
//       },
//       builder: (context, state, child) {
//         if (builder != null) {
//           assert(controller is ReadRequest || controller is WriteRequest,
//               "In onLoading builder, The provided controller must be either a ReadRequest or a WriteRequest. This requirement is due to the design based on known states pattern.");
//           if (controller is ReadRequest && state is ReadLoadingState<S>) {
//             return builder(context, state, child);
//           } else if (controller is WriteRequest &&
//               state is WriteLoadingState<S>) {
//             return builder(context, state, child);
//           }
//         }
//         if (this.builder != null) return this.builder!(context, state, child);
//         return child;
//       },
//     );
//   }

//   /// Extends the [ApiBloc] with custom logic to handle success states.
//   ///
//   /// The `onSuccess` method allows you to specify custom listener and builder functions
//   /// to handle success states based on the provided [BlocRequest].
//   ///
//   /// If [listener] is specified and the controller is of type [ReadRequest] or [WriteRequest],
//   /// it will be called when the state is a success state.
//   ///
//   /// If [builder] is specified and the controller is of type [ReadRequest] or [WriteRequest],
//   /// it will be used to build the widget tree when the state is a success state.
//   ///
//   /// When neither [listener] nor [builder] is specified, the default listener and builder
//   /// functions provided during [ApiBloc] instantiation will be used.
//   ///
//   /// ```dart
//   /// ApiBloc(
//   ///   controller: BlocRequest(),
//   /// ).onSuccess<YourModel>(
//   ///   listener: (context, state) {
//   ///     /* your code here */
//   ///   }, builder: (context, state) {
//   ///     /* your code here */
//   ///   }
//   /// )
//   /// ```
//   ApiBloc<T> onSuccess<S extends Object>({
//     OnBlocListener<S>? listener,
//     OnBlocBuilder<S>? builder,
//   }) {
//     return this.copyWith(
//       listener: (context, state) {
//         if (listener != null) {
//           assert(controller is ReadRequest || controller is WriteRequest,
//               "In onSuccess listener, The provided controller must be either a ReadRequest or a WriteRequest. This requirement is due to the design based on known states pattern.");
//           if (controller is ReadRequest && state is ReadSuccessState<S>) {
//             listener(context, state);
//           } else if (controller is WriteRequest &&
//               state is WriteSuccessState<S>) {
//             listener(context, state);
//           }
//         }
//         if (this.listener != null) this.listener!(context, state);
//       },
//       builder: (context, state, child) {
//         if (builder != null) {
//           assert(controller is ReadRequest || controller is WriteRequest,
//               "In onSuccess builder, The provided controller must be either a ReadRequest or a WriteRequest. This requirement is due to the design based on known states pattern.");
//           if (controller is ReadRequest && state is ReadSuccessState<S>) {
//             return builder(context, state, child);
//           } else if (controller is WriteRequest &&
//               state is WriteSuccessState<S>) {
//             return builder(context, state, child);
//           }
//         }
//         if (this.builder != null) return this.builder!(context, state, child);
//         return child;
//       },
//     );
//   }

//   /// Creates a new instance of [ApiBloc] with listeners and builders for the WriteIdleState.
//   ///
//   /// The [listener] parameter is an optional [OnBlocListener] that listens to the [WriteFailedState].
//   /// The [builder] parameter is an optional [OnBlocBuilder] that rebuilds its widget tree based on the [WriteFailedState].
//   ///
//   /// Returns a new [ApiBloc] instance with the specified listeners and builders for the WriteIdleState.
//   ///
//   /// ```dart
//   /// ApiBloc(
//   ///   controller: BlocRequest(),
//   /// ).onFailed<YourModel>(
//   ///   listener: (context, state) {
//   ///     /* your code here */
//   ///   }, builder: (context, state) {
//   ///     /* your code here */
//   ///   }
//   /// )
//   /// ```
//   ApiBloc<T> onFailed<S extends Object>({
//     OnBlocListener<S>? listener,
//     OnBlocBuilder<S>? builder,
//   }) {
//     return this.copyWith(
//       listener: (context, state) {
//         if (listener != null) {
//           assert(controller is WriteRequest,
//               "In onFailed listener, The provided controller must be a WriteRequest. This requirement is due to the design based on known states pattern.");
//           if (controller is WriteRequest && state is WriteFailedState<S>) {
//             listener(context, state);
//           }
//         }
//         if (this.listener != null) this.listener!(context, state);
//       },
//       builder: (context, state, child) {
//         if (builder != null) {
//           assert(controller is WriteRequest,
//               "In onFailed builder, The provided controller must be a WriteRequest. This requirement is due to the design based on known states pattern.");
//           if (controller is WriteRequest && state is WriteFailedState<S>) {
//             return builder(context, state, child);
//           }
//         }
//         if (this.builder != null) return this.builder!(context, state, child);
//         return child;
//       },
//     );
//   }

//   /// Extends the [ApiBloc] with custom logic to handle error states.
//   ///
//   /// The `onError` method allows you to specify custom listener and builder functions
//   /// to handle error states based on the provided [BlocRequest].
//   ///
//   /// If [listener] is specified and the controller is of type [ReadRequest] or [WriteRequest],
//   /// it will be called when the state is an error state.
//   ///
//   /// If [builder] is specified and the controller is of type [ReadRequest] or [WriteRequest],
//   /// it will be used to build the widget tree when the state is an error state.
//   ///
//   /// When neither [listener] nor [builder] is specified, the default listener and builder
//   /// functions provided during [ApiBloc] instantiation will be used.
//   ///
//   /// ```dart
//   /// ApiBloc(
//   ///   controller: BlocRequest(),
//   /// ).onError<Map<String, dynamic>>(
//   ///   listener: (context, state) {
//   ///     /* your code here */
//   ///   }, builder: (context, state) {
//   ///     /* your code here */
//   ///   }
//   /// )
//   /// ```
//   ApiBloc<T> onError<S extends Object?>({
//     OnBlocListener<S>? listener,
//     OnBlocBuilder<S>? builder,
//   }) {
//     return this.copyWith(
//       listener: (context, state) {
//         if (listener != null) {
//           assert(controller is ReadRequest || controller is WriteRequest,
//               "In onError listener, The provided controller must be either a ReadRequest or a WriteRequest. This requirement is due to the design based on known states pattern.");
//           if (controller is ReadRequest && state is ReadErrorState<S>) {
//             listener(context, state);
//           } else if (controller is WriteRequest &&
//               state is WriteErrorState<S>) {
//             listener(context, state);
//           }
//         }
//         if (this.listener != null) this.listener!(context, state);
//       },
//       builder: (context, state, child) {
//         if (builder != null) {
//           assert(controller is ReadRequest || controller is WriteRequest,
//               "In onError builder, The provided controller must be either a ReadRequest or a WriteRequest. This requirement is due to the design based on known states pattern.");
//           if (controller is ReadRequest && state is ReadErrorState<S>) {
//             return builder(context, state, child);
//           } else if (controller is WriteRequest &&
//               state is WriteErrorState<S>) {
//             return builder(context, state, child);
//           }
//         }
//         if (this.builder != null) return this.builder!(context, state, child);
//         return child;
//       },
//     );
//   }

//   /// Extends the [ApiBloc] with custom logic to handle custom states.
//   ///
//   /// The [onState] method allows you to specify custom listener and builder functions
//   /// to handle custom states based on the provided [S] BlocStates model.
//   ///
//   /// When neither [listener] nor [builder] is specified, the default listener and builder
//   /// functions provided during [ApiBloc] instantiation will be used.
//   ///
//   /// ```dart
//   /// ApiBloc(
//   ///   controller: BlocRequest(),
//   /// ).onState<BlocStates<double>>(
//   ///   listener: (context, state) {
//   ///     /* your code here */
//   ///   }, builder: (context, state) {
//   ///     /* your code here */
//   ///   }
//   /// )
//   /// ```
//   ApiBloc<T> onState<S extends T>({
//     BlocListener<S>? listener,
//     BlocBuilder<S>? builder,
//   }) {
//     return this.copyWith(
//       listener: (context, state) {
//         if (listener != null && state is S) listener(context, state);
//         if (this.listener != null) this.listener!(context, state);
//       },
//       builder: (context, state, child) {
//         if (builder != null && state is S) {
//           return builder(context, state, child);
//         }
//         if (this.builder != null) {
//           return this.builder!(context, state, child);
//         }
//         return child;
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<T>(
//         valueListenable: controller,
//         builder: (context, value, child) {
//           if (listener != null) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               listener!(context, value);
//             });
//           }

//           return builder != null ? builder!(context, value, child!) : child!;
//         },
//         child: child);
//   }
// }

typedef OnBlocBuilder<State extends BlocStates> = Widget Function(
  BuildContext context,
  State state,
  Widget child,
);

class BlocBuilder<Request extends BlocRequest<State>, State extends BlocStates>
    extends BlocConsumer<Request, State> {
  BlocBuilder({
    super.key,
    required super.builder,
    super.child,
  }) : super(listener: (context, state) {});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.read<Request>(),
      builder: (context, state, child) {
        if (builder == null) return child!;
        return builder!(context, state, child!);
      },
      child: child,
    );
  }
}