import 'dart:convert';
import 'dart:typed_data';

import 'shared_prefs_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsClient {
  Future<void> setCarouselViewedStatus(bool data) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.setBool(SharedPrefsStringConst.carouselState, data);
  }

  Future<bool> get getCarouselViewedStatus async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    return globalPreferences.getBool(SharedPrefsStringConst.carouselState) ??
        false;
  }

  Future<void> setAccessToken(String token) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.setString(
        SharedPrefsStringConst.accessToken, token);
  }

  Future<String?> get getAccessToken async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    return globalPreferences.getString(SharedPrefsStringConst.accessToken);
  }

  Future<void> setUserType(String value) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    print("trying to set usertype $value");
    await globalPreferences.setString(SharedPrefsStringConst.userType, value);
  }

  Future<String?> get getUserType async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    print("this is the value user trying to get here ");

    return globalPreferences.getString(SharedPrefsStringConst.userType);
  }

  Future<void> signOut() async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await Future.wait([
      globalPreferences.remove(SharedPrefsStringConst.accessToken),
      globalPreferences.remove(SharedPrefsStringConst.userType),
      globalPreferences.remove(SharedPrefsStringConst.uid),
      globalPreferences.remove(SharedPrefsStringConst.username),
      globalPreferences.remove(SharedPrefsStringConst.userFirstname),
      globalPreferences.remove(SharedPrefsStringConst.userLastname),
      globalPreferences.remove(SharedPrefsStringConst.dpUrl),
      globalPreferences.remove(SharedPrefsStringConst.selectedCardDetails),
      globalPreferences.remove(SharedPrefsStringConst.userCode),
      globalPreferences.remove(SharedPrefsStringConst.allowSharedLink),
      globalPreferences.remove(SharedPrefsStringConst.email),
      globalPreferences.remove(SharedPrefsStringConst.number),
    ]);
  }

  Future<void> resetData() async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await Future.wait([
      globalPreferences.remove(SharedPrefsStringConst.username),
      globalPreferences.remove(SharedPrefsStringConst.userFirstname),
      globalPreferences.remove(SharedPrefsStringConst.userLastname),
      globalPreferences.remove(SharedPrefsStringConst.dpUrl),
      globalPreferences.remove(SharedPrefsStringConst.selectedCardDetails),
      globalPreferences.remove(SharedPrefsStringConst.userCode),
      globalPreferences.remove(SharedPrefsStringConst.allowSharedLink),
      globalPreferences.remove(SharedPrefsStringConst.email),
      globalPreferences.remove(SharedPrefsStringConst.number),
    ]);
  }

  Future<void> setProfileUid(String profileUid) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.setString(SharedPrefsStringConst.uid, profileUid);
  }

  Future<String?> get getProfileUid async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    return globalPreferences.getString(SharedPrefsStringConst.uid);
  }

  Future<void> setUserName(String username) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.setString(
        SharedPrefsStringConst.username, username);
  }

  Future<void> allowSharedLink(bool value) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.setBool(
        SharedPrefsStringConst.allowSharedLink, value);
  }

  Future<bool> allowSharedLinkStatus() async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    return globalPreferences.getBool(
          SharedPrefsStringConst.allowSharedLink,
        ) ??
        false;
  }

  Future<String?> get getUserName async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    return globalPreferences.getString(SharedPrefsStringConst.username);
  }

  Future<void> setUserFirstName(String userFirstname) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.setString(
        SharedPrefsStringConst.userFirstname, userFirstname);
  }

  Future<String?> get getUserFirstName async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    return globalPreferences.getString(SharedPrefsStringConst.userFirstname);
  }

  Future<void> setUserLastName(String userLastname) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.setString(
        SharedPrefsStringConst.userLastname, userLastname);
  }

  Future<void> setIsRegisterd() async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.setBool(SharedPrefsStringConst.userRegiterd, true);
  }

  Future<bool> get getIsRegisterd async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    return globalPreferences.getBool(SharedPrefsStringConst.userRegiterd) ??
        false;
  }

  Future<String?> get getUserLastName async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    return globalPreferences.getString(SharedPrefsStringConst.userLastname);
  }

  Future<String?> get getDpUrl async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    return globalPreferences.getString(SharedPrefsStringConst.dpUrl);
  }

  Future<void> setDpUrl(String dpUrl) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.setString(SharedPrefsStringConst.dpUrl, dpUrl);
  }

  Future<void> setTutorialStatus(bool value) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.setBool(
        SharedPrefsStringConst.tutorialStatus, value);
  }

  Future<bool> get getTutorialStatus async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    return globalPreferences.getBool(SharedPrefsStringConst.tutorialStatus) ??
        false;
  }

  Future<void> setUserCode(String value) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.setString(SharedPrefsStringConst.userCode, value);
  }

  Future<String?> get getUserCode async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    return globalPreferences.getString(SharedPrefsStringConst.userCode);
  }

  Future<void> removeUserName() async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await Future.wait([
      globalPreferences.remove(SharedPrefsStringConst.userType),
      globalPreferences.remove(SharedPrefsStringConst.accessToken),
      globalPreferences.remove(SharedPrefsStringConst.uid),
      globalPreferences.remove(SharedPrefsStringConst.username),
      globalPreferences.remove(SharedPrefsStringConst.userFirstname),
      globalPreferences.remove(SharedPrefsStringConst.userLastname),
      globalPreferences.remove(SharedPrefsStringConst.dpUrl),
      globalPreferences.remove(SharedPrefsStringConst.selectedCardDetails),
      globalPreferences.remove(SharedPrefsStringConst.userCode),
      globalPreferences.remove(SharedPrefsStringConst.allowSharedLink),
      globalPreferences.remove(SharedPrefsStringConst.email),
      globalPreferences.remove(SharedPrefsStringConst.number),
    ]);
  }

  Future<void> setSelectedCardDetails(Map<String, dynamic> data) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.setString(
        SharedPrefsStringConst.selectedCardDetails, jsonEncode(data));
  }

  Future<Map<String, dynamic>> get getSelectedCardDetails async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    final response =
        globalPreferences.getString(SharedPrefsStringConst.selectedCardDetails);
    if (response?.isEmpty ?? true) {
      return {};
    }
    return jsonDecode(response ?? "");
  }

  Future<Uint8List?> getImageByteCodes(String prefKey) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    Uint8List? imageBytes;
    final response = globalPreferences.getString(prefKey);
    if (response != null) {
      imageBytes = base64Decode(response);
    }
    return imageBytes;
  }

  Future<void> setImageByteCodes(Uint8List? data, String prefKey) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    if (data == null) return;
    String base64Image = base64Encode(data);
    await globalPreferences.setString(prefKey, base64Image);
  }

  Future<void> clearDataForKey(String prefKey) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.remove(prefKey);
  }

  Future<void> setStringdata(String key, String value) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    await globalPreferences.setString(key, value);
  }

  Future<String?> getStringdata(String key) async {
    final SharedPreferences globalPreferences =
        await SharedPreferences.getInstance();
    return globalPreferences.getString(key);
  }
}
