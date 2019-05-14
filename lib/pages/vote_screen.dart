import 'package:flutter/material.dart';
import 'package:vote_app/networking/response/vote_response.dart';


class VoteScreen extends StatefulWidget{
  static const routeName = '/vote';

  @override
  State<StatefulWidget> createState() => _VoteScreenState();
}


class _VoteScreenState extends State<VoteScreen>{

   @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final VoteModel vote = ModalRoute.of(context).settings.arguments;
    return Scaffold(appBar: AppBar(title: Text(vote.title),),
            body: Center(child:Text(vote.toString())),);
  }
}