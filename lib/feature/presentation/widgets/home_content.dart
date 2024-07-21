import 'package:flutter/material.dart';
import 'package:x_o_game_play/feature/presentation/friend_scr.dart';
import 'package:x_o_game_play/feature/presentation/pc_scr.dart';

import '../../../generated/assets.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.deepPurple,Colors.purpleAccent,Colors.purple,],begin: Alignment.topCenter,end: Alignment.bottomLeft)

        ),
      child: Padding(
         padding: const EdgeInsets.only(top: 70),
        child: Column(
          children: [
             const Text('XO game',style: TextStyle(fontSize: 60,fontFamily: 'first'),),
            const Text(' TIC TAC TOE',style: TextStyle(fontSize:20,fontFamily: 'second',color: Colors.white)),
            const SizedBox(height: 90,),
            CircleAvatar(
              child: Image.asset(Assets.imgLogo,height: 220,),radius: 125,
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: () => {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FriendScr()))},
              child:const Text('Play VS Friend ',style: TextStyle(fontSize:16,fontFamily: 'second')),
              style:ElevatedButton.styleFrom(fixedSize:Size(280,50))),
            const SizedBox(height: 30,),
            ElevatedButton(
                onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PcScr())),
                child:const Text('Play VS Pc ',style: TextStyle(fontSize:16,fontFamily: 'second')),
                style:ElevatedButton.styleFrom(fixedSize:Size(280,50))),

          ],
            ),
      )
    );
  }
}
