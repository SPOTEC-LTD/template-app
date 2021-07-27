import 'package:template/widgets/refresher/refresh_status.dart';

abstract class Refreshable {
  RefreshStatus refreshStatus = RefreshStatus.initial;
  bool get isListEmpty;
  bool noMore = false;
}
