import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  TextEditingController fnameController=TextEditingController();
  TextEditingController lnameController=TextEditingController();
  TextEditingController addressController=TextEditingController();
  TextEditingController postCodeController=TextEditingController();
  int currenentStap=0;
  bool isCompleted=false;

  //late VoidCallback onStepContinue;
  //late VoidCallback onStepCencel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stepper Widget Demo'),
      ),
      body: isCompleted ? buildComplete() :Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(primary: Colors.orange)
        ),
        child: Stepper(
          //type: StepperType.horizontal,
            steps: getSteps(),
          currentStep: currenentStap,
          onStepTapped: (step)=>setState(() {
            currenentStap=step;
          }),
          onStepContinue: (){
            final lastStep=currenentStap==getSteps().length-1;
            if(lastStep){
              setState(() {
                isCompleted=true;
              });
              print('completed');
            }
            else{
              setState(()=>currenentStap +=1);
            }
          },
          onStepCancel: (){
            currenentStap==0 ? null : setState(()=>currenentStap -=1);
          },
          // controlsBuilder: (context,{onStepContinue,onStepCancel}){
          //   return Container(
          //     margin: EdgeInsets.only(top: 50),
          //     child: Row(
          //       children: [
          //         Expanded(child: ElevatedButton(
          //           child: Text('Continue'),
          //           onPressed: onStepContinue,
          //         )),
          //         SizedBox(width: 12,),
          //         Expanded(child: ElevatedButton(
          //           child: Text('Back'),
          //           onPressed: onStapCancel,
          //         )
          //         )
          //       ],
          //     ),
          //   );
          // },
        ),
      ),
    );
  }

  List<Step> getSteps()=>[
    Step(
      state: currenentStap > 0? StepState.complete : StepState.indexed,
      isActive: currenentStap>=0,
        title: Text('Account'),
        content: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'First Name'
              ),
              controller: fnameController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Last Name'
              ),
              controller: lnameController,
            ),
          ],
        )
    ),
    Step(
        state: currenentStap > 1? StepState.complete : StepState.indexed,
      isActive: currenentStap>=1,
        title: Text('Address'),
        content: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  labelText: 'Address'
              ),
              controller: addressController,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: 'Post Code'
              ),
              controller: postCodeController,
            ),
          ],
        )
    ),
    Step(
        state: currenentStap > 2? StepState.complete : StepState.indexed,
      isActive: currenentStap>=2,
        title: Text('Complete'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8,),
            Text('First Name: ${fnameController.text}',),
            SizedBox(height: 8,),
            Text('Last Name: ${lnameController.text}'),
            SizedBox(height: 8,),
            Text('Address: ${addressController.text}'),
            SizedBox(height: 8,),
            Text('Post Code: ${postCodeController.text}'),
          ],
        )
    ),
  ];

  Widget buildControlls(context,onStepContinue, onStepCancel){
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Row(
        children: [
          Expanded(child: ElevatedButton(
            child: Text('Continue'),
            onPressed: onStepContinue,
          )),
          SizedBox(width: 12,),
          Expanded(child: ElevatedButton(
            child: Text('Back'),
            onPressed: onStepCancel,
          ))
        ],
      ),
    );
  }

  Widget buildComplete(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wb_cloudy_sharp,size: 100,),
          SizedBox(height: 24,),
          Text('Success'),
          SizedBox(height: 54,),
          ElevatedButton(
              onPressed: (){
                setState(() {
                  isCompleted=false;
                  currenentStap=0;

                  fnameController.clear();
                  lnameController.clear();
                  addressController.clear();
                  postCodeController.clear();
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text('Reset'),
              ),
          )
        ],
      ),
    );
  }
}
