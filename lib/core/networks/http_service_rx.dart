abstract class RxHttpService {
  Stream rxGet(
    String subURL, {
    Map<String, String> header,
    Map<String, String> query,
  });

  Stream rxPost(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
  });

  Stream rxPut(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
  });

  Stream rxPatch(
    String subURL, {
    Map<String, String> header,
    Map<String, String> body,
  });

  Stream rxDelete(
    String subURL, {
    Map<String, String> header,
    Map<String, String> query,
  });
}
