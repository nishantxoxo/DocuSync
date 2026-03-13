// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:docu_sync/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SentMessageBox extends StatelessWidget {
 final String message;
  String name;
  SentMessageBox({
    Key? key,
    required this.message,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Column(
        children: [
            Row(mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                        Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                        // SizedBox(width: 3,)
                      ],),
          Row(
            children: [
               Expanded(child: SizedBox.shrink()),
              Container(
                width: 350 * 0.7,
                decoration: BoxDecoration(
                    color: kBlueColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(3),
                        bottomLeft: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                        
          
          
                      Row( mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                message,
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                ),
              ),
             
            ],
          ),
        ],
      ),
    );
  }
}






class MessageBox extends StatelessWidget {
 final String message;
 String name;
  MessageBox({
    Key? key,
    required this.name,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: Row(
        children: [
          Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),)
                      ],),
              Container(
                width: 350 * 0.7,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(5))),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
              
                       
              
                      Row( mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                               message,
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.outfit(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              
                              ),
                            ),
                          ),
                        ],
                      ),
                     
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox.shrink())
        ],
      ),
    );
  }
}
