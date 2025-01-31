import '../../../network/eh_request.dart';
import '../../../utils/eh_spider_parser.dart';
import '../../../utils/log.dart';
import '../../base/base_page_logic.dart';
import 'gallerys_page_state.dart';

class GallerysPageLogic extends BasePageLogic {
  @override
  int get tabIndex => 0;

  @override
  bool get useSearchConfig => true;

  @override
  final GallerysPageState state = GallerysPageState();

  @override
  Future<List<dynamic>> getGallerysAndPageInfoByPage(int pageIndex) async {
    Log.info('get gallery data, pageIndex:$pageIndex', false);

    return await EHRequest.requestGalleryPage(
      pageNo: pageIndex,
      searchConfig: state.searchConfig,
      parser: EHSpiderParser.galleryPage2GalleryListAndPageInfo,
    );
  }

  void updateBody() {
    update([bodyId]);
  }
}
