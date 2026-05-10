import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'i_torch_service.dart';
import 'torch_service_mobile.dart';
import 'torch_service_web.dart';

final torchServiceProvider = Provider<ITorchService>(
  (_) => kIsWeb ? TorchServiceWeb() : TorchServiceMobile(),
);
