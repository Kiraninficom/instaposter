import 'dart:convert';
import 'package:click/pages/getapi.dart';
import 'package:click/utils/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

amountdetuction({var amount, var title, var type}) async {
  var message;

  try {
    http.Response response =
        await http.post(Uri.parse("${baseurl}withdrawAmount"), body: {
      'amount': '$amount',
      'plan_type': '$type',
      'remark': '$title',
    }, headers: {
      'token': token
    });
    var mapreduce = json.decode(response.body);
    message = "${mapreduce['response']['response_message']}";
    await SentApi().getbalancedata();
    await SentApi().getdownloadandsharedata();
    return true;
  } catch (e) {
    Fluttertoast.showToast(msg: message);
    return false;
  }
}

sendcount(var id) async {
  http.Response response = await http.post(Uri.parse(downloadandsharecounter),
      headers: {'token': token}, body: {'action': id});
  await SentApi().getbalancedata();
  await SentApi().getdownloadandsharedata();
  if (response.statusCode == 200) {}
}
