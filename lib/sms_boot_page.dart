import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SmsBootPage extends StatefulWidget {
  const SmsBootPage({
    super.key,
  });

  @override
  State<SmsBootPage> createState() => _SmsBootPageState();
}

class _SmsBootPageState extends State<SmsBootPage> {
  bool isLoading = false;
  TextEditingController mesage = TextEditingController();
  TwilioFlutter twilioFlutter = TwilioFlutter(
      accountSid: 'AC78c5307bb59b28a0708f2f3a13eeb692',
      authToken: 'effac6c10914f6f046772159083be917',
      twilioNumber: '+16823271564');
  Uint8List? fileBytes;
  String uri = '';
  String? fileName;
  String message = 'No File selected';
  // ignore: non_constant_identifier_names
  List<String> PhoneNumbers = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SMS CAMPAIGN'),
          centerTitle: true,
          backgroundColor: Color(0xffAACE44),
        ),
        body: isLoading
            ? Center(
                child: SizedBox(
                    height: 250,
                    width: 200,
                    child: Column(
                      children: [
                        LoadingIndicator(
                          indicatorType: Indicator.pacman,
                          colors: [Colors.red, Colors.blue, Colors.yellow, Colors.black, Colors.pink],
                        ),
                        const Text('Sending sms....')
                      ],
                    )))
            : Wrap(
                spacing: 30,
                runSpacing: 30,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(message),
                            const SizedBox(
                              height: 20,
                            ),
                            MaterialButton(
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(
                                  allowMultiple: true,
                                  type: FileType.custom,
                                  allowedExtensions: ['xlsx'],
                                );

                                if (result != null) {
                                  setState(() {
                                    fileBytes = result.files.first.bytes!;
                                    fileName = result.files.first.name;
                                    message = 'Selected File name is: $fileName';
                                    PhoneNumbers.clear();
                                    var decoder = SpreadsheetDecoder.decodeBytes(fileBytes!);
                                    for (var table in decoder.tables.keys) {
                                      if (decoder.tables[table]!.maxRows > 0) {
                                        for (var row in decoder.tables[table]!.rows) {
                                          setState(() {
                                            PhoneNumbers.add(row.first.toString());
                                          });
                                        }
                                      }
                                    }
                                  });
                                } else {
                                  return;
                                }
                              },
                              color: Color(0xff975FA2),
                              shape: const StadiumBorder(),
                              child: const Text(
                                'Select File',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('file extension must be *.xlsx'),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              width: 300,
                              height: 250,
                              child: TextField(
                                maxLength: 200,
                                maxLines: null,
                                minLines: 10,
                                controller: mesage,
                                decoration: InputDecoration(
                                  hintText: 'write message here',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () {
                                try {
                                  if (mesage.text.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => const AlertDialog(
                                              content: Text('Write message to send'),
                                              actions: [CloseButton()],
                                            ));
                                  } else if (PhoneNumbers.isEmpty) {
                                    showDialog(
                                        context: context,
                                        builder: (context) => const AlertDialog(
                                              content: Text('Select a file of phone numbers'),
                                              actions: [CloseButton()],
                                            ));
                                  } else {
                                    sendSms();
                                  }
                                } catch (e) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            content: Text(e.toString()),
                                            actions: [CloseButton()],
                                          ));
                                }
                              },
                              color: Color(0xff975FA2),
                              shape: const StadiumBorder(),
                              child: const Text(
                                'Send SMS',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('*Data & MSG rates may apply'),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: 250,
                              height: 450.h,
                              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: DataTable(
                                    columns: const [DataColumn(label: Text('Numbers'))],
                                    rows: PhoneNumbers.map(
                                        (e) => DataRow(cells: [DataCell(Text(e.toString()))])).toList()),
                              )),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage('assets/marketing.png'))),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text('Email: support@alliedonemarketing.com for assistance.')
                      ],
                    ),
                  )
                ],
              ));
  }

  sendSms() async {
    setState(() {
      isLoading = true;
    });
    try {
      for (var number in PhoneNumbers) {
        await twilioFlutter.sendSMS(toNumber: '+1$number', messageBody: mesage.text);
      }
      setState(() {
        isLoading = false;
        mesage.clear();
        PhoneNumbers.clear();
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
