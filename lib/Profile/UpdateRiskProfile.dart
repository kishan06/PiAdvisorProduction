import 'package:flutter/material.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/Profile/Model/RiskProfileQuestions.dart';
import 'package:piadvisory/Profile/ProfileMain.dart';
import 'package:piadvisory/Utils/textStyles.dart';

class UpdateRiskProfile extends StatefulWidget {
  const UpdateRiskProfile({Key? key}) : super(key: key);

  @override
  State<UpdateRiskProfile> createState() => _UpdateRiskProfileState();
}

class _UpdateRiskProfileState extends State<UpdateRiskProfile> {
  final selectedage = TextEditingController();
  String selectedmartialstatus = "Select";

  bool onclickoflow = false;
  bool onclickofmedium = false;
  bool onclickofhigh = false;
  late List<RiskProfile> quesglobal;
  @override
  void initState() {
    setList();
    super.initState();
  }

  Future _showAgePicker() async {
    FocusScope.of(context).unfocus();
    final data = await showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: const Age(),
        );
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
        selectedage.text = data;
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
                  "40",
                  style: blackStyle(context)
                      .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 18,
                ),
                Text("Portfolio Type"),
                Text(
                  "Conservative",
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
                        primary: Colors.white,
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
  // Future _showMartialpicker() async {
  //   FocusScope.of(context).unfocus();
  //   final data = await showModalBottomSheet<dynamic>(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
  //         child: const MartialStatus(),
  //       );
  //     },
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(30),
  //         topRight: Radius.circular(30),
  //       ),
  //     ),
  //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  //   );

  //   if (data != null) {
  //     setState(() {
  //       selectedmartialstatus = data;
  //     });
  //   }
  // }

  // Future _showReviewInvestmentpicker() async {
  //   FocusScope.of(context).unfocus();
  //   final data = await showModalBottomSheet<dynamic>(
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (context) {
  //       return Container(
  //         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
  //         child: const ReviewInvestment(),
  //       );
  //     },
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(30),
  //         topRight: Radius.circular(30),
  //       ),
  //     ),
  //     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  //   );

  //   if (data != null) {
  //     setState(() {
  //       _selectedinvestment = data;
  //     });
  //   }
  // }
  void setList() {
    List<RiskProfile> ques = [
      RiskProfile(
        dropdown: CustomRiskDropDown(
          agecontroller: selectedage,
          selectedage: "select",
          ontap: () => _showAgePicker(),
        ),
        question: 'What is your Age?',
      ),
      RiskProfile(
        dropdown: CustomRiskDropDown(),
        question: "What is your investment horizon?",
      ),
      RiskProfile(
        dropdown: CustomRiskDropDown(),
        question: "Why are you Investing?",
      ),
      RiskProfile(
        dropdown: CustomRiskDropDown(),
        question: "What is your liquid net worth?",
      ),
      RiskProfile(
        dropdown: CustomRiskDropDown(),
        question: "My income sources (current and future) are",
      ),
      RiskProfile(
        dropdown: CustomRiskDropDown(),
        question: "How familiar are you with Stocks,Bonds and ETFs?",
      ),
      RiskProfile(
        dropdown: CustomRiskDropDown(),
        question:
            "Which of the following statements best describe your attitude towards investing?",
      ),
      RiskProfile(
        dropdown: CustomRiskDropDown(),
        question:
            "How would you react if your portfolio lost 10% or more of its value in a year?",
      ),
    ];
    setState(() {
      quesglobal = ques;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
          titleTxt: "Update Financial and Risk Profile", bottomtext: false),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 27,
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
              height: 33,
            ),
            Expanded(
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var 
                      value in quesglobal) ...[
                        Text(
                          value.question,
                          style: blackStyle(context).copyWith(fontSize: 10),
                        ),
                        value.dropdown,
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                      SizedBox(
                          width: double.infinity,
                          child: CustomNextButton(
                            text: "Submit",
                            ontap: () {
                              buildRiskAlertDialog();
                            },
                          )),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomRiskDropDown extends StatelessWidget {
  const CustomRiskDropDown(
      {Key? key, this.selectedage = "Select", this.ontap, this.agecontroller})
      : super(key: key);

  final String? selectedage;
  final void Function()? ontap;
  final TextEditingController? agecontroller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: agecontroller,
      onTap: (() => ontap!()),
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
