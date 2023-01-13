// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:piadvisory/HomePage/Blog%20Repository/Model/BlogModel.dart';
import 'package:piadvisory/HomePage/Blog%20Repository/blogrepo.dart';
import 'package:piadvisory/Utils/Constants.dart';

import '../Common/app_bar.dart';

class BlogInner extends StatefulWidget {
  BlogInner({
    Key? key,
    required this.allBlogIndex,
  }) : super(key: key);

  @override
  State<BlogInner> createState() => _BlogInnerState();
  int allBlogIndex;
}

class _BlogInnerState extends State<BlogInner> {
  @override
  Widget build(BuildContext context) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return Scaffold(
      appBar: const CustomAppBar(
        titleTxt: "",
        bottomtext: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 15,
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blogs.blogAll![widget.allBlogIndex].title!,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                blogs.blogAll![widget.allBlogIndex].publishDate!,
                style: TextStyle(
                  color: Color(0xFF444444),
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Color(0xFFF6FFFF),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    ApiConstant.piImages +
                        blogs.blogAll![widget.allBlogIndex].innerBlogImage!,
                    width: 400,
                    height: 283,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                color: Color(0xFFF6FFFF),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Html(
                      data: blogs.blogAll![widget.allBlogIndex].discription!),
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Image.asset("assets/images/imgpsh_fullsize_anim.png"),
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sipiscing elit, sed diam nont ut laoreetadipiscing elit, sed diam nonummy nibh euismod tincidunt ut adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreetadipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in",
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 14,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
