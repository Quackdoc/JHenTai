import 'package:jhentai/src/pages/base/base_page_state.dart';

import '../../../model/gallery.dart';
import '../../../widget/loading_state_indicator.dart';

class DashboardPageState extends BasePageState {
  LoadingState ranklistLoadingState = LoadingState.idle;
  LoadingState popularLoadingState = LoadingState.idle;

  List<Gallery> ranklistGallerys = List.empty(growable: true);
  List<Gallery> popularGallerys = List.empty(growable: true);
}
