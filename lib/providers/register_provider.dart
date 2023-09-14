import 'package:flutter_riverpod/flutter_riverpod.dart';

final registerStatusProvider = StateProvider.autoDispose((ref) => '');

setRegisterStatus(WidgetRef ref, String newStatus) {
  ref.read(registerStatusProvider.notifier).state = newStatus;
}
