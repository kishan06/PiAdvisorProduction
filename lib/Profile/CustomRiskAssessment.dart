// ignore_for_file: file_names

import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:piadvisory/Profile/RiskAssestmentRepository/RiskAssestment.dart';
import 'package:piadvisory/Utils/base_manager.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../Common/CustomTextFormFields.dart';
import '/Common/CustomNextButton.dart';
import '/HomePage/Homepage.dart';
import '/Utils/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:another_flushbar/flushbar.dart';
import '../Common/app_bar.dart';
import 'ProfileMain.dart';
import '/Utils/Dialogs.dart';

class CustomAssessment extends StatefulWidget {
  const CustomAssessment({Key? key}) : super(key: key);

  @override
  State<CustomAssessment> createState() => _CustomAssessmentState();
}

class _CustomAssessmentState extends State<CustomAssessment> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  late List<TextEditingController> _controllertextediting = [
    selectedage,
    selectedinvestment,
    selectedinvesting,
    selectedannualincome,
    selectedliquid,
    selectedincome,
    selectedstocks,
    selectedattitude,
    selectedreact
  ];

  final selectedage = TextEditingController();
  final selectedinvestment = TextEditingController();
  final selectedinvesting = TextEditingController();
  final selectedannualincome = TextEditingController();
  final selectedliquid = TextEditingController();
  final selectedincome = TextEditingController();
  final selectedstocks = TextEditingController();
  final selectedattitude = TextEditingController();
  final selectedreact = TextEditingController();
  var _totalScore = 0;
  late final Future? myFuture;
  @override
  void initState() {
    super.initState();
    myFuture = getRiskQuestions().getQuestions();
    getAns();
    setValues();
  }

  getAns() async {
    await getRiskQuestions().getAnswers();

    if (answers.data != null && answers.data!.isNotEmpty) {
      setState(() {
        _totalScore = answers.data!.last.totalScore!;
      });
    }

    replaceLoaderWithRiskText();
  }

  List classcontent = [
    Age(),
    Investment(),
    Investing(),
    AnnualIncome(),
    liquid(),
    Income(),
    StocksPicker(),
    Attitude(),
    React(),
  ];

  bool showRiskText = false;
  bool showRiskTextLoader = true;

  void replaceRiskTextWithLoader() {
    setState(() {
      showRiskText = false;
      showRiskTextLoader = true;
    });
  }

  void replaceLoaderWithRiskText() {
    setState(() {
      showRiskText = true;
      showRiskTextLoader = false;
    });
  }

  setValues() {
    var dataLength = answers.data?.length ?? 1;
    for (var i = 0; i < dataLength; i++) {
      _controllertextediting[i].text =
          answers.data?[i].riskAnswerMaster?.answer ?? "";
    }
  }

  Future _custombottomsheet(index) async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: classcontent[index]);
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );

    if (data != null) {
      setState(() {
        _controllertextediting[index].text = data;
      });
    }
  }

  buildRiskAlertDialog() {
    return showDialog(
      context: context,
      builder: (context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            child: FittedBox(
              child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    size: 30,
                  )),
            ),
          ),
          AlertDialog(
            insetPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            contentPadding: EdgeInsets.fromLTRB(24, 8, 24, 24),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            // contentPadding:
            //     EdgeInsets.all(
            //         10),
            title: Center(
              child: Text(
                "Thank you for updating your Risk Profile",
                textAlign: TextAlign.center,
                style: blackStyle(context).copyWith(fontSize: 25),
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Risk Score",
                  style: blackStyle(context),
                ),
                Text(
                  riskscore?.toString() ?? "0",
                  style: blackStyle(context)
                      .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 18,
                ),
                Text("Portfolio Type"),
                Text(
                  portfolioType,
                  style: blackStyle(context)
                      .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 34,
                ),
                Divider(
                  indent: 40,
                  endIndent: 40,
                  thickness: 2,
                ),
                SizedBox(
                  height: 17.5,
                ),
                SizedBox(
                  width: 104.4,
                  height: 38.86,
                  child: TextButton(
                    child: Text("Ok!"),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFF008083)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileMain()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _validateData() {
    final isValid = _form.currentState?.validate();
    if (isValid! &&
        _controllertextediting[0].text.isNotEmpty &&
        _controllertextediting[1].text.isNotEmpty &&
        _controllertextediting[2].text.isNotEmpty &&
        _controllertextediting[3].text.isNotEmpty &&
        _controllertextediting[4].text.isNotEmpty &&
        _controllertextediting[5].text.isNotEmpty &&
        _controllertextediting[6].text.isNotEmpty &&
        _controllertextediting[7].text.isNotEmpty &&
        _controllertextediting[8].text.isNotEmpty) {
      UploadData();
    } else {
      Flushbar(
        message: "Please fill all fields",
        duration: const Duration(seconds: 3),
      ).show(context);
      // _btnController1.error();
      // Timer(Duration(seconds: 2), () {
      //   _btnController1.reset();
      // });
    }
  }

  UploadData() async {
    int len = question.data!.length;
    List<Map<String, dynamic>> updata = [];
    for (var i = 1; i < len + 1; i++) {
      updata.add({"id": i, "answer": _controllertextediting[i - 1].text});
    }
    final data = await getRiskQuestions().postQuestions(updata);
    if (data.status == ResponseStatus.SUCCESS) {
      buildRiskAlertDialog();
    } else {
      return utils.showToast(data.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          titleTxt: "Financial and Risk Profile", bottomtext: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                height: 213,
                width: MediaQuery.of(context).size.width * 1,
                child: Image.asset(
                  "assets/images/updatedrisklogo.png",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FutureBuilder(
                future: myFuture,
                builder: (ctx, snapshot) {
                  if (snapshot.data == null) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Lottie.asset(
                            "assets/images/lf30_editor_jc6n8oqe.json",
                            repeat: true,
                            height: 150,
                            width: 150,
                          ),
                        ),
                      ],
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      print("response is ${snapshot.data}");
                      return Center(
                        child: Text(
                          '${snapshot.error} occured',
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }
                  }
                  return _buildBody(
                    context,
                  );
                },
              ),

              //_buildBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          Visibility(
            visible: showRiskText,
            child: Text(
              "Your Previous Risk Score Was : ${_totalScore}",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Visibility(
            visible: showRiskTextLoader,
            child: const SizedBox(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.amber,
                ),
              ),
            ),
          ),
          ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: question.data?.length ?? 9,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 34,
                      ),
                      Text(
                        question.data?[index].questions.toString() ?? "adwad",
                        style: blackStyle(context),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      CustomRiskDropDown(
                          controller: _controllertextediting[index],
                          ontap: () {
                            // pickers[index];
                            // _showAgePicker();
                            _custombottomsheet(index);
                          })
                    ],
                  ),
                );
              }),
          SizedBox(
            height: 15,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     left: 20,
          //     right: 20,
          //   ),
          SizedBox(
              width: double.infinity,
              child: CustomNextButton(
                text: "Submit",
                ontap: () {
                  _validateData();
                  //   buildRiskAlertDialog();
                },
              )),
          const SizedBox(
            height: 20,
          )
          //  RoundedLoadingButton(
          //   height: 60,
          //   resetAfterDuration: true,
          //   resetDuration: Duration(seconds: 5),
          //   width: MediaQuery.of(context).size.width * 1,
          //   color: const Color.fromRGBO(247, 129, 4, 1),
          //   successColor: const Color.fromRGBO(247, 129, 4, 1),
          //   controller: _btnController1,
          //   onPressed: () {
          //     buildRiskAlertDialog();
          //      //=> _validateData(),
          //   },
          //   valueColor: Colors.black,
          //   borderRadius: 10,
          //   child: Text(
          //     "Submit",
          //     style: TextStyle(
          //       color: Color(0xFFFFFFFF),
          //       fontSize: 20,
          //       fontFamily: 'Helvetica',
          //     ),
          //   ),
          // ),
          // )
        ],
      ),
    );
  }
}

class CustomRiskDropDown extends StatelessWidget {
  const CustomRiskDropDown(
      {Key? key, this.selectedage = "Select", this.ontap, this.controller})
      : super(key: key);

  final String? selectedage;
  final void Function()? ontap;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      onTap: () => ontap!(),
      readOnly: true,
      cursorColor: Colors.grey,
      style: const TextStyle(
        fontFamily: 'Product Sans',
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            onPressed: (() => ontap!()),
          ),
          hintStyle: TextStyle(
              fontSize: 16,
              fontFamily: 'Product Sans',
              color: Color(0xFF6B6B6B).withOpacity(0.30),
              fontWeight: FontWeight.bold),
          hintText: selectedage),
    );
  }
}

class Age extends StatefulWidget {
  const Age({Key? key}) : super(key: key);

  @override
  State<Age> createState() => _AgeState();
}

class _AgeState extends State<Age> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Age", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "18-25");
                  }),
                  title: const Text("18-25"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "26-35");
                  }),
                  title: const Text("26-35"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "36-45");
                  }),
                  title: const Text("36-45"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "46-59");
                  }),
                  title: const Text("46-59"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "60 Above");
                  }),
                  title: const Text("60 Above"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class Investment extends StatefulWidget {
  const Investment({Key? key}) : super(key: key);

  @override
  State<Investment> createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child:
                Text("Select Investment horizon", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Long term investment");
                  }),
                  title: const Text("Long term investment"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Short term investment");
                  }),
                  title: const Text("Short term investment"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class Investing extends StatefulWidget {
  const Investing({Key? key}) : super(key: key);

  @override
  State<Investing> createState() => _InvestingState();
}

class _InvestingState extends State<Investing> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Investing", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Major Purchase");
                  }),
                  title: const Text("Major Purchase"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Retirement");
                  }),
                  title: const Text("Retirement"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Education");
                  }),
                  title: const Text("Education"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "General Savings");
                  }),
                  title: const Text("General Savings"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Other");
                  }),
                  title: const Text("Other"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class AnnualIncome extends StatefulWidget {
  const AnnualIncome({Key? key}) : super(key: key);

  @override
  State<AnnualIncome> createState() => _AnnualIncomeState();
}

class _AnnualIncomeState extends State<AnnualIncome> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child:
                Text("Select Pre tax AnnualIncome", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "0 - 2.5 Lakh Rs");
                  }),
                  title: const Text("0 - 2.5 Lakh Rs"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "2.5 - 5 Lakh Rs");
                  }),
                  title: const Text("2.5 - 5 Lakh Rs"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "5 - 10 Lakh Rs");
                  }),
                  title: const Text("5 - 10 Lakh Rs"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "10 - 20 Lakh Rs");
                  }),
                  title: const Text("10 - 20 Lakh Rs"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Over 20 Lakh Rs");
                  }),
                  title: const Text("Over 20 Lakh Rs"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class liquid extends StatefulWidget {
  const liquid({Key? key}) : super(key: key);

  @override
  State<liquid> createState() => _liquidState();
}

class _liquidState extends State<liquid> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select liquid net worth", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Less than 5 Lakh Rs");
                  }),
                  title: const Text("Less than 5 Lakh Rs"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Between 5 - 10 Lakh Rs");
                  }),
                  title: const Text("Between 5 - 10 Lakh Rs"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Between 10 - 15 Lakh Rs");
                  }),
                  title: const Text("Between 10 - 15 Lakh Rs"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Between 15 - 25 Lakh Rs");
                  }),
                  title: const Text("Between 15 - 25 Lakh Rs"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Above 25 Lakh Rs");
                  }),
                  title: const Text("Above 25 Lakh Rs"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class Income extends StatefulWidget {
  const Income({Key? key}) : super(key: key);

  @override
  State<Income> createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text("Select Income sources", style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Very Unstable");
                  }),
                  title: const Text("Very Unstable"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Unstable");
                  }),
                  title: const Text("Unstable"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Somewhat Stable");
                  }),
                  title: const Text("Somewhat Stable"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Stable");
                  }),
                  title: const Text("Stable"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Very Stable");
                  }),
                  title: const Text("Very Stable"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class StocksPicker extends StatefulWidget {
  const StocksPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<StocksPicker> createState() => _StocksPickerState();
}

class _StocksPickerState extends State<StocksPicker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text(
                "Select How Familiar are you with Stocks,Bonds and ETFs",
                style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Very Familiar");
                  }),
                  title: const Text("Very Familiar"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Familiar");
                  }),
                  title: const Text("Familiar"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Somewhat familiar");
                  }),
                  title: const Text("Somewhat familiar"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Not familiar");
                  }),
                  title: const Text("Not familiar"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "New to Investing");
                  }),
                  title: const Text("New to Investing"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class Attitude extends StatefulWidget {
  const Attitude({Key? key}) : super(key: key);

  @override
  State<Attitude> createState() => _AttitudeState();
}

class _AttitudeState extends State<Attitude> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text(
                "Select Which of the following statements best describe your attitude towards investing?",
                style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context,
                        "I’m not comfortable with losses. Capital preservation is my highest priority");
                  }),
                  title: const Text(
                      "I’m not comfortable with losses. Capital preservation is my highest priority"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context,
                        "I do not mind taking small risks in order to achieve slightly higher returns");
                  }),
                  title: const Text(
                      "I do not mind taking small risks in order to achieve slightly higher returns"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context,
                        "I want my portfolio to grow moderately in the long-term while minimizing the risk.");
                  }),
                  title: const Text(
                      "I want my portfolio to grow moderately in the long-term while minimizing the risk."),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context,
                        "I’m comfortable with extreme fluctuations in my portfolio value in order to maximize returns in the long term.");
                  }),
                  title: const Text(
                      "I’m comfortable with extreme fluctuations in my portfolio value in order to maximize returns in the long term."),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class React extends StatefulWidget {
  const React({Key? key}) : super(key: key);

  @override
  State<React> createState() => _ReactState();
}

class _ReactState extends State<React> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Text(
                "Select How would you react if your portfolio lost 10% or more of its value in a year?",
                style: blackStyle(context)),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Sell everything");
                  }),
                  title: const Text("Sell everything"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Sell part of my holdings");
                  }),
                  title: const Text("Sell part of my holdings"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context,
                        "Reallocate funds into a conservative asset class");
                  }),
                  title: const Text(
                      "Reallocate funds into a conservative asset class"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Do Nothing");
                  }),
                  title: const Text("Do Nothing"),
                ),
                ListTile(
                  onTap: (() {
                    Navigator.pop(context, "Buy More");
                  }),
                  title: const Text("Buy More"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
