import 'dart:convert';

import 'package:click/Pages/authcredential.dart';
import 'package:click/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SentApi with ChangeNotifier {
  getuserdata() async {
    try {
      http.Response response =
          await http.get(Uri.parse(userprofile), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("userdata", jsonEncode(mapreduce['data']));
      userdata = mapreduce['data'];
      notifyListeners();
      if (mapreduce['data'] == [] ||
          (mapreduce['response']['response_message'] ==
                  "Invalid token or token missing" &&
              mapreduce['response']['response_code'] == "498")) {
        return "Invalid";
      } else {
        return mapreduce['data'];
      }
    } catch (e) {
      //print(e);
    }
  }

  getnotificationdata() async {
    try {
      http.Response response =
          await http.get(Uri.parse(notification), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("notification", jsonEncode(mapreduce['data']));
      notificationlist = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  getwallethistorydata() async {
    try {
      http.Response response = await http
          .get(Uri.parse(wallethistoryurl), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("wallethistory", jsonEncode(mapreduce['data']));
      wallethistory = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  getpremiumlist() async {
    try {
      http.Response response =
          await http.get(Uri.parse(premiumtemplate), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("premium", jsonEncode(mapreduce['data']));
      premiumtemplatelist = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  getqutoscategory() async {
    try {
      http.Response response = await http
          .get(Uri.parse(quotescategorylist), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("quotescategory", jsonEncode(mapreduce['data']));
      quotescategory = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  getqutosposterimiages() async {
    try {
      http.Response response =
          await http.get(Uri.parse(quoteslist), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("quotesposter", jsonEncode(mapreduce['data']));
      quotesposterimages = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  getdownloadandsharedata() async {
    try {
      http.Response response = await http
          .get(Uri.parse(downloadandsharevalue), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      downloaddata = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  getbalancedata() async {
    try {
      http.Response response =
          await http.get(Uri.parse(balanceurl), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      balancedata = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  getrequestedpremiumlist() async {
    try {
      http.Response requestedpremium = await http.get(
          Uri.parse('${baseurl}premium_request'),
          headers: {'token': token});
      var mapreduce = json.decode(requestedpremium.body);
      Authcredential()
          .savevaluetolocal("requestedpremium", jsonEncode(mapreduce['data']));
      requestedpremiumtemplatelist = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  getcscprofieldata() async {
    try {
      http.Response csc =
          await http.get(Uri.parse(cscprofile), headers: {'token': token});
      var cscresponse = json.decode(csc.body);

      Authcredential()
          .savevaluetolocal("cscprofile", jsonEncode(cscresponse['data']));
      cscvalue = cscresponse['data'];
      notifyListeners();
      return cscresponse['data'];
    } catch (e) {
      //print(e);
    }
  }

  getbuisnessprofile() async {
    try {
      http.Response buisness =
          await http.get(Uri.parse(buisnessprofile), headers: {'token': token});
      var mapresponse = json.decode(buisness.body);

      Authcredential()
          .savevaluetolocal("buisnessprofile", jsonEncode(mapresponse['data']));
      buisnessvalue = mapresponse['data'];
      notifyListeners();
      return mapresponse['data'];
    } catch (e) {
      //print(e);
    }
  }

  getfestivalprofile() async {
    try {
      http.Response festival =
          await http.get(Uri.parse(festivalprofile), headers: {'token': token});
      var mapresponse = json.decode(festival.body);
      Authcredential()
          .savevaluetolocal("festivalprofile", jsonEncode(mapresponse['data']));
      festivalprofilevalue = mapresponse['data'];
      notifyListeners();
      return mapresponse['data'];
    } catch (e) {
      //print(e);
    }
  }

  getposterimage() async {
    try {
      http.Response response =
          await http.get(Uri.parse(bannerlist), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("poster", jsonEncode(mapreduce['data']));
      poster = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getsubs() async {
    try {
      http.Response response = await http
          .get(Uri.parse(usersubscription), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential().savevaluetolocal(
          "subscriptiondetails", jsonEncode(mapreduce['data']));
      subscriptiondetail = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getcscbasic() async {
    try {
      http.Response response =
          await http.get(Uri.parse(cscservices), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("cscbasic", jsonEncode(mapreduce['data']));
      onlineserviceposter = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getcscsubservices() async {
    try {
      http.Response response =
          await http.get(Uri.parse(cscsubservices), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("cscsub", jsonEncode(mapreduce['data']));
      onlinesubservice = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getcscimage() async {
    try {
      http.Response response =
          await http.get(Uri.parse(cscimagelist), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("cscimage", jsonEncode(mapreduce['data']));
      onlineimage = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getgreetingbasic() async {
    try {
      http.Response response = await http
          .get(Uri.parse(greetingserviceurl), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("greetingbasic", jsonEncode(mapreduce['data']));
      greetingcategory = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getgreetingsubservices() async {
    try {
      http.Response response = await http
          .get(Uri.parse(greetingsubserviceurl), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("greetingsub", jsonEncode(mapreduce['data']));
      greetingssubservice = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getgreetingimage() async {
    try {
      http.Response response = await http
          .get(Uri.parse(greetingimagelisturl), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("greetingimage", jsonEncode(mapreduce['data']));
      greetingimage = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getbuisnessbasic() async {
    try {
      http.Response response =
          await http.get(Uri.parse(buisnessservice), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("buisnessbasic", jsonEncode(mapreduce['data']));
      buisnesscategory = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getbuisnesssubservices() async {
    try {
      http.Response response = await http
          .get(Uri.parse(buisnessubservice), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("buisnesssub", jsonEncode(mapreduce['data']));
      buisnesssubservice = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getbuisnessimage() async {
    try {
      http.Response response = await http
          .get(Uri.parse(buisnessimagelist), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("buisnessimage", jsonEncode(mapreduce['data']));
      buisnessimage = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getlogoservices() async {
    try {
      http.Response response =
          await http.get(Uri.parse(getlogo), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential().savevaluetolocal("logo", jsonEncode(mapreduce['data']));
      designlogo = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getrequestedlogoservices() async {
    try {
      http.Response response = await http
          .get(Uri.parse(getrequestedlogo), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("requestedlogo", jsonEncode(mapreduce['data']));
      requestedlogo = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getfacebookservices() async {
    try {
      http.Response response =
          await http.get(Uri.parse(facebooklist), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("facebook", jsonEncode(mapreduce['data']));
      facebookcover = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getpopuplist() async {
    try {
      http.Response response =
          await http.get(Uri.parse(popuplisturl), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential().savevaluetolocal("popup", jsonEncode(mapreduce['data']));
      popuplist = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getcurrentposterimage() async {
    try {
      http.Response response =
          await http.get(Uri.parse(currentposter), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("currentposter", jsonEncode(mapreduce['data']));
      currentposterimages = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getfestivalposter() async {
    try {
      http.Response response = await http
          .get(Uri.parse(festivalposterlist), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("festival", jsonEncode(mapreduce['data']));
      festivalposter = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getjobbasic() async {
    try {
      http.Response response =
          await http.get(Uri.parse(jobservice), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("jobbasic", jsonEncode(mapreduce['data']));
      jobcategory = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getjobsubservices() async {
    try {
      http.Response response =
          await http.get(Uri.parse(jobsubservice), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("jobsub", jsonEncode(mapreduce['data']));
      jobsubservicelist = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getjobimage() async {
    try {
      http.Response response =
          await http.get(Uri.parse(jobimagelist), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("jobimage", jsonEncode(mapreduce['data']));
      jobimage = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getschemebasic() async {
    try {
      http.Response response =
          await http.get(Uri.parse(schemeservice), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("schemebasic", jsonEncode(mapreduce['data']));
      schemecategory = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getschemesubservices() async {
    try {
      http.Response response = await http
          .get(Uri.parse(schemesubservice), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("schemesub", jsonEncode(mapreduce['data']));
      schemesubservicelist = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getschemeimage() async {
    try {
      http.Response response =
          await http.get(Uri.parse(schemeimagelist), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("schemeimage", jsonEncode(mapreduce['data']));
      schemeimage = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getschemevideos() async {
    try {
      http.Response response =
          await http.get(Uri.parse(schemevideolist), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("schemevideo", jsonEncode(mapreduce['data']));
      schemevideo = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getfestivalvideos() async {
    try {
      http.Response response = await http
          .get(Uri.parse(festivalvideolist), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("festivalvideo", jsonEncode(mapreduce['data']));
      festivalvideo = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getrazorpaykey() async {
    try {
      http.Response response =
          await http.get(Uri.parse(razorpaykeyurl), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      print(mapreduce);
      razorpaykeyvalue = mapreduce['data'][0]['key_id'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getpolicyandservice() async {
    try {
      http.Response response =
          await http.get(Uri.parse(policyurl), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      privacypolicydata = mapreduce['data']['privacy'];
      termandservicedata = mapreduce['data']['terms'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }

  Future getcscvideo() async {
    try {
      http.Response response =
          await http.get(Uri.parse(cscvideolist), headers: {'token': token});
      var mapreduce = json.decode(response.body);
      Authcredential()
          .savevaluetolocal("cscvideo", jsonEncode(mapreduce['data']));
      cscvideo = mapreduce['data'];
      notifyListeners();
      return mapreduce['data'];
    } catch (e) {
      //print(e);
    }
  }
}
