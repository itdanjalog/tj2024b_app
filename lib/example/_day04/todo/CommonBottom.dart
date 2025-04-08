import 'package:flutter/material.dart';

class CommonBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [

            Expanded(
              child: TextButton.icon(
                onPressed: () => { Navigator.pushNamed(context, '/') },
                icon: Icon(Icons.home, color: Colors.black,size: 25,),
                label: Text('홈', style: TextStyle(color: Colors.black))
              ),
            ),

            SizedBox(width: 10),

            Expanded(
              child: TextButton.icon(
                onPressed: () => { Navigator.pushNamed(context, '/save') },
                icon: Icon(Icons.add_box, color: Colors.black,size: 25,),
                label: Text('등록', style: TextStyle(color: Colors.black)),
              ),
            ),

            SizedBox(width: 10),
            
            Expanded(
              child: TextButton.icon(
                onPressed: () => {  Navigator.pushNamed(context, '/')  },
                icon: Icon(Icons.adb, color: Colors.black,size: 25,),
                label: Text('비고', style: TextStyle(color: Colors.black)),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
