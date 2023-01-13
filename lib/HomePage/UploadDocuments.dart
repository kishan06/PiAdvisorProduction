import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piadvisory/Common/CustomNextButton.dart';
import 'package:piadvisory/Common/app_bar.dart';
import 'package:piadvisory/SideMenu/Subscribe/Mysubscription.dart';
import 'package:piadvisory/Utils/Constants.dart';
import 'package:piadvisory/Utils/textStyles.dart';
import 'package:piadvisory/api/tax_planning/methods/documents_upload_tax_planning_api_methods.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:piadvisory/api/tax_planning/models/documents_upload_tax_planning_model.dart';
import 'tax-planning.dart';

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({
    required this.userId,
    required this.uploadedDocs,
    Key? key,
  }) : super(key: key);

  final int userId;
  final DocumentsUploadTaxPlanningModel? uploadedDocs;

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  String viewImgBaseUrl = "${ApiConstant.base}public/public/Image/";

  //form 16
  bool isForm16FileImg = false;
  String? form16FileImgPath;
  bool showForm16Validator = false;
  bool showForm16ImgFormatMsg = true;
  bool showForm16Img = false;
  String? form16ImgName;

  //itr
  bool isItrFileImg = false;
  String? itrFileImgPath;
  bool showItrValidator = false;
  bool showItrImgFormatMsg = true;
  bool showItrImg = false;
  String? itrImgName;

  //other docs
  bool isOtherDocsFileImg = false;
  String? otherDocsFileImgPath;
  bool showOtherDocumentsValidator = false;
  bool showOtherDocumentsImgFormatMsg = true;
  bool showOtherDocumentsImg = false;
  String? otherDocumentsImgName;

  XFile? form16Img;
  XFile? itrImg;
  XFile? otherDocsImg;

  Future<XFile?> pickImg() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  bool showViewImgBtn = false;
  bool showSubmitBtn = true;
  bool showSubmitBtnLoader = false;

  @override
  void initState() {
    super.initState();
    if (widget.uploadedDocs != null) {
      form16ImgName = widget.uploadedDocs!.form16ImgName;
      itrImgName = widget.uploadedDocs!.itrImgName;
      otherDocumentsImgName = widget.uploadedDocs!.otherDocImgName;

      showViewImgBtn = true;

      //form 16
      showForm16Validator = false;
      showForm16ImgFormatMsg = false;
      showForm16Img = true;

      //itr
      showItrValidator = false;
      showItrImgFormatMsg = false;
      showItrImg = true;

      //other docs
      showOtherDocumentsValidator = false;
      showOtherDocumentsImgFormatMsg = false;
      showOtherDocumentsImg = true;
      if (showOtherDocumentsImg != null &&
          itrImgName != null &&
          form16ImgName != null) {
        setState(() {
          showForm16Validator = false;
          showItrValidator = false;
          showOtherDocumentsValidator = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Taxplanning()));
        return Future.value(false);
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          titleTxt: "Upload Documents",
          bottomtext: false,
          navigateToTaxPlanning: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(
            children: [
              SizedBox(height: 27),
              //form 16
              StatefulBuilder(
                builder: (context, setForm16State) {
                  return UploadContainer(
                    isFileImage: isForm16FileImg,
                    imgPath: form16FileImgPath,
                    imgUrl: form16ImgName != null
                        ? viewImgBaseUrl + form16ImgName!
                        : viewImgBaseUrl,
                    viewImg: showViewImgBtn,
                    showValidatorText: showForm16Validator,
                    imgName: form16ImgName,
                    showImg: showForm16Img,
                    showImgFormatMsg: showForm16ImgFormatMsg,
                    title: 'Form 16',
                    validatorText: 'Please upload form 16',
                    onUploadBtnPressed: () async {
                      XFile? form16 = await pickImg();
                      if (form16 != null) {
                        form16Img = form16;
                        setForm16State(() {
                          showForm16Validator = false;
                          showForm16ImgFormatMsg = false;
                          showForm16Img = true;
                          var pathList = form16Img!.path.split('/');
                          form16ImgName = pathList[pathList.length - 1];
                          isForm16FileImg = true;
                          form16FileImgPath = form16.path;
                        });
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 27),

              //itr
              StatefulBuilder(
                builder: (context, setItrState) {
                  return UploadContainer(
                    isFileImage: isItrFileImg,
                    imgPath: itrFileImgPath,
                    imgUrl: itrImgName != null
                        ? viewImgBaseUrl + itrImgName!
                        : viewImgBaseUrl,
                    viewImg: showViewImgBtn,
                    imgName: itrImgName,
                    showImg: showItrImg,
                    showImgFormatMsg: showItrImgFormatMsg,
                    showValidatorText: showItrValidator,
                    title: 'Last Year ITR',
                    validatorText: 'Please upload last year ITR',
                    onUploadBtnPressed: () async {
                      XFile? itr = await pickImg();
                      if (itr != null) {
                        itrImg = itr;
                        setItrState(() {
                          showItrValidator = false;
                          showItrImgFormatMsg = false;
                          showItrImg = true;
                          var pathList = itrImg!.path.split('/');
                          itrImgName = pathList[pathList.length - 1];
                          isItrFileImg = true;
                          itrFileImgPath = itr.path;
                        });
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 27),

              //other docs
              StatefulBuilder(builder: (context, setDocState) {
                return UploadContainer(
                  isFileImage: isOtherDocsFileImg,
                  imgPath: otherDocsFileImgPath,
                  imgUrl: otherDocumentsImgName != null
                      ? viewImgBaseUrl + otherDocumentsImgName!
                      : viewImgBaseUrl,
                  viewImg: showViewImgBtn,
                  showImgFormatMsg: showOtherDocumentsImgFormatMsg,
                  showImg: showOtherDocumentsImg,
                  imgName: otherDocumentsImgName,
                  showValidatorText: showOtherDocumentsValidator,
                  title: 'Other Documents',
                  validatorText: 'Please upload other documents',
                  onUploadBtnPressed: () async {
                    XFile? otherDoc = await pickImg();
                    if (otherDoc != null) {
                      otherDocsImg = otherDoc;
                      setDocState(
                        () {
                          showOtherDocumentsValidator = false;
                          showOtherDocumentsImgFormatMsg = false;
                          showOtherDocumentsImg = true;
                          var pathList = otherDocsImg!.path.split('/');
                          otherDocumentsImgName = pathList[pathList.length - 1];
                          isOtherDocsFileImg = true;
                          otherDocsFileImgPath = otherDoc.path;
                        },
                      );
                    }
                  },
                );
              }),
              SizedBox(height: 27),
              StatefulBuilder(
                builder: (context, setBtnState) {
                  return Column(
                    children: [
                      Visibility(
                        visible: showSubmitBtn,
                        child: SizedBox(
                          width: double.infinity,
                          child: CustomNextButton(
                            text: "Submit",
                            ontap: () {
                              if (widget.uploadedDocs != null) {
                                if (form16Img == null &&
                                    itrImg == null &&
                                    otherDocsImg == null) {
                                  Flushbar(
                                    message: "Please upload document image",
                                    duration: const Duration(seconds: 3),
                                  ).show(context);
                                  return;
                                }

                                setBtnState(() {
                                  showSubmitBtn = false;
                                  showSubmitBtnLoader = true;
                                });

                                //submit docs

                                //form 16
                                if (form16Img != null &&
                                    itrImg == null &&
                                    otherDocsImg == null) {
                                  uploadFrom16(
                                          widget.userId.toString(), form16Img!)
                                      .then((isUploaded) {
                                    setBtnState(() {
                                      showSubmitBtn = true;
                                      showSubmitBtnLoader = false;
                                    });
                                    if (isUploaded) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Taxplanning(),
                                        ),
                                      );
                                      Flushbar(
                                        message: "Documents uploaded",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    } else {
                                      Flushbar(
                                        message: "Cannot upload documents",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    }
                                  });
                                }

                                //form 16 and itr
                                if (form16Img != null &&
                                    itrImg != null &&
                                    otherDocsImg == null) {
                                  uploadFrom16NItr(widget.userId.toString(),
                                          form16Img!, itrImg!)
                                      .then((isUploaded) {
                                    setBtnState(() {
                                      showSubmitBtn = true;
                                      showSubmitBtnLoader = false;
                                    });
                                    if (isUploaded) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Taxplanning(),
                                        ),
                                      );
                                      Flushbar(
                                        message: "Documents uploaded",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    } else {
                                      Flushbar(
                                        message: "Cannot upload documents",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    }
                                  });
                                }

                                //form 16 and other
                                if (form16Img != null &&
                                    itrImg == null &&
                                    otherDocsImg != null) {
                                  uploadFrom16NOther(widget.userId.toString(),
                                          form16Img!, otherDocsImg!)
                                      .then((isUploaded) {
                                    setBtnState(() {
                                      showSubmitBtn = true;
                                      showSubmitBtnLoader = false;
                                    });
                                    if (isUploaded) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Taxplanning(),
                                        ),
                                      );
                                      Flushbar(
                                        message: "Documents uploaded",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    } else {
                                      Flushbar(
                                        message: "Cannot upload documents",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    }
                                  });
                                }

                                //itr
                                if (itrImg != null &&
                                    form16Img == null &&
                                    otherDocsImg == null) {
                                  uploadItr(widget.userId.toString(), itrImg!)
                                      .then((isUploaded) {
                                    setBtnState(() {
                                      showSubmitBtn = true;
                                      showSubmitBtnLoader = false;
                                    });
                                    if (isUploaded) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Taxplanning(),
                                        ),
                                      );
                                      Flushbar(
                                        message: "Documents uploaded",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    } else {
                                      Flushbar(
                                        message: "Cannot upload documents",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    }
                                  });
                                }

                                //itr and other
                                if (form16Img == null &&
                                    itrImg != null &&
                                    otherDocsImg != null) {
                                  uploadItrNOther(widget.userId.toString(),
                                          itrImg!, otherDocsImg!)
                                      .then((isUploaded) {
                                    setBtnState(() {
                                      showSubmitBtn = true;
                                      showSubmitBtnLoader = false;
                                    });
                                    if (isUploaded) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Taxplanning(),
                                        ),
                                      );
                                      Flushbar(
                                        message: "Documents uploaded",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    } else {
                                      Flushbar(
                                        message: "Cannot upload documents",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    }
                                  });
                                }

                                //other
                                if (otherDocsImg != null &&
                                    form16Img == null &&
                                    itrImg == null) {
                                  uploadOtherDocs(widget.userId.toString(),
                                          otherDocsImg!)
                                      .then((isUploaded) {
                                    setBtnState(() {
                                      showSubmitBtn = true;
                                      showSubmitBtnLoader = false;
                                    });
                                    if (isUploaded) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Taxplanning(),
                                        ),
                                      );
                                      Flushbar(
                                        message: "Documents uploaded",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    } else {
                                      Flushbar(
                                        message: "Cannot upload documents",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    }
                                  });
                                }

                                //all docs
                                if (form16Img != null &&
                                    itrImg != null &&
                                    otherDocsImg != null) {
                                  setBtnState(() {
                                    showSubmitBtn = false;
                                    showSubmitBtnLoader = true;
                                  });
                                  addDocuments(widget.userId.toString(),
                                          form16Img, itrImg, otherDocsImg)
                                      .then((uploaded) {
                                    setBtnState(() {
                                      showSubmitBtn = true;
                                      showSubmitBtnLoader = false;
                                    });
                                    if (uploaded) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Taxplanning(),
                                        ),
                                      );
                                      Flushbar(
                                        message: "Documents uploaded",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    } else {
                                      Flushbar(
                                        message: "Cannot upload documents",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    }
                                  });
                                }

                                //--
                              } else {
                                //validation
                                //form 16
                                if (form16Img != null) {
                                  setState(() {
                                    showForm16Validator = false;
                                  });
                                }
                                if (form16Img == null) {
                                  setState(() {
                                    showForm16Validator = true;
                                  });
                                }

                                //itr
                                if (itrImg == null) {
                                  setState(() {
                                    showItrValidator = true;
                                  });
                                }
                                if (itrImg != null) {
                                  setState(() {
                                    showItrValidator = false;
                                  });
                                }

                                //other docs
                                if (otherDocsImg == null) {
                                  setState(() {
                                    showOtherDocumentsValidator = true;
                                  });
                                }
                                if (otherDocsImg != null) {
                                  setState(() {
                                    showOtherDocumentsValidator = false;
                                  });
                                }

                                //submit all docs
                                if (form16Img != null &&
                                    itrImg != null &&
                                    otherDocsImg != null) {
                                  setBtnState(() {
                                    showSubmitBtn = false;
                                    showSubmitBtnLoader = true;
                                  });
                                  addDocuments(widget.userId.toString(),
                                          form16Img, itrImg, otherDocsImg)
                                      .then((uploaded) {
                                    setBtnState(() {
                                      showSubmitBtn = true;
                                      showSubmitBtnLoader = false;
                                    });
                                    if (uploaded) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Taxplanning(),
                                        ),
                                      );
                                      Flushbar(
                                        message: "Documents uploaded",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                      SystemChannels.textInput
                                          .invokeMethod('TextInput.hide');
                                    } else {
                                      Flushbar(
                                        message: "Cannot upload documents",
                                        duration: const Duration(seconds: 3),
                                      ).show(context);
                                    }
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: showSubmitBtnLoader,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 82)
            ],
          ),
        ),
      ),
    );
  }
}

class UploadContainer extends StatelessWidget {
  const UploadContainer({
    Key? key,
    this.imgName,
    this.onUploadBtnPressed,
    this.showImgFormatMsg = true,
    this.showImg = false,
    this.isFileImage = false,
    this.imgUrl,
    this.imgPath,
    required this.viewImg,
    required this.validatorText,
    required this.showValidatorText,
    required this.title,
  }) : super(key: key);

  final String title; //heading e.g. From 16
  final String validatorText; //e.g. Please upload img
  final String? imgName;
  final void Function()? onUploadBtnPressed; //img upload btn
  final bool showValidatorText;
  final bool showImg;
  final bool showImgFormatMsg;
  final bool viewImg;
  final String? imgUrl;
  final bool isFileImage;
  final String? imgPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE6E6E6)),
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: blackStyle(context).copyWith(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              )),
          SizedBox(
            height: 21,
          ),
          Container(
            height: 58,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF707070)),
                borderRadius: BorderRadius.all(Radius.circular(4))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //upload btn
                InkWell(
                  onTap: onUploadBtnPressed,
                  child: Container(
                      color: Color(0xFF008083),
                      height: 29,
                      width: 111,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          SvgPicture.asset("assets/images/7.Upload.svg"),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Upload File",
                            style: blackStyle(context)
                                .copyWith(fontSize: 10, color: Colors.white),
                          ),
                        ],
                      )),
                ),
                Text(
                  "Max file size 2 MB",
                  style: blackStyle(context).copyWith(
                      fontSize: 14,
                      color: Get.isDarkMode ? Colors.white : Colors.black),
                ),
                SizedBox(
                  width: 1,
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Visibility(
            visible: showImg,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(imgName ?? 'NULL', overflow: TextOverflow.ellipsis),
                  Visibility(
                    visible: viewImg,
                    child: OutlinedButton(
                      onPressed: () {
                        showImageViewer(
                          doubleTapZoomable: true,
                          context,
                          isFileImage
                              ? Image.file(File(imgPath!)).image
                              : Image.network(imgUrl ??
                                      "https://picsum.photos/id/1001/4912/3264")
                                  .image,
                        );
                      },
                      child: Text("View Image"),
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: showImgFormatMsg,
            child: Text(
              "Image Should be of PNG, JPG",
              style: blackStyle(context).copyWith(
                fontSize: 10,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 6),
          Visibility(
            visible: showValidatorText,
            child: Text(
              validatorText,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
