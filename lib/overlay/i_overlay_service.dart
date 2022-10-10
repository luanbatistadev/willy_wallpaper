abstract class IOverlayService {
  Future<void> showSuccessSnackBar(String content);
  Future<void> showErrorSnackBar(String content);
}
