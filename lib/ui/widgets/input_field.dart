import 'package:TODO/ui/size_config.dart';
import 'package:TODO/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  const InputField({Key? key,
  required this.title,
  required this.note,
  this.textEditingController,
  this.widget,
  }) : super(key: key);
 final String title;
 final String note;
 final TextEditingController? textEditingController;
 final Widget ?widget;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric( horizontal: 10,vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: Themes().titlestyle,),
          Container( padding: EdgeInsets.only(left: 16),
                    margin: const EdgeInsets.only(top: 8,),
                    width: SizeConfig.screenWidth,
                    height:42 ,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
                    border: Border.all(color:Get.isDarkMode?Colors.white: Colors.black,width: 1.2)
                    ),
                              child:Row(
                                children: [
                                  Expanded(child: TextFormField(
                                    style: Themes().subtitlestyle,
                                    autofocus: false,
                                    readOnly: widget!=null,
                                    decoration: InputDecoration( hintText: note,
                                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(
                                      color: Theme.of(context).backgroundColor,width: 0
                                    )),
                                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
                                      color: Theme.of(context).backgroundColor,width: 0
                                    )),
                                    ),
                                  )),
                                widget??Container()],
                              ),
          ),
        ],
      ),
    );
  }
}
