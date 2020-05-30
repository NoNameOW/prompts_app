import 'package:flutter/material.dart';
import 'package:prompt_app/models/prompt.dart';
import 'package:prompt_app/models/user.dart';
import 'package:prompt_app/services/database.dart';
import 'package:prompt_app/shared/textinputdecor.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prompt_app/Screens/wrapper.dart';



class PromptPage extends StatefulWidget {

  
  @override
  _PromptPageState createState() => _PromptPageState();

  

}

class _PromptPageState extends State<PromptPage> {
  final DataBaseService _database = DataBaseService();
  String answer = 'No answer yet!';
  String error = '';
  String text = 'Loading Prompt...';
  String title = '';
  String ourResponse = '';
  Color responseColor = Colors.red;
  final _formKey = GlobalKey<FormState>();

  


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    dynamic reldata = _database.getRelevantData(user.uid).then((value) {
      text = value['text'];
      if (value['response'] != null){
        print('olo');
        setState(() => ourResponse = value['response']);
      }
      setState(() => title = value['title']);

    });
    print(reldata.runtimeType);
    print(text);
    print(ourResponse);
     
    return StreamProvider<QuerySnapshot>.value(
      value: _database.prompts,
          child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
                height: 250,
                width: 450,
              child: Card(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Text(
                          text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold
                            
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0,),

                    Text(
                      'your answer:',
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                      ),
                    Text(
                      ourResponse,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold

                      ),
                      ),
                  ],
                ),
                
                color: Colors.blue[300],
              ),
            ),
            SizedBox(height: 25.0,),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: (val) => val.isEmpty? 'Enter a response': null,
                decoration: textInputDecor.copyWith(hintText : 'Enter your answer here!'),
                onChanged:(val) {
                  setState(() => answer = val);
                },
              ),
            ),
            RaisedButton.icon(
              icon: Icon(Icons.file_upload),
              onPressed: () async {
                if (_formKey.currentState.validate()){
                  dynamic result = await _database.addResponse(title, user.uid, answer);
                  if (result == null){
                    setState(() { 
                      responseColor = Colors.red;
                      error = 'Failed to submit response. try again';
                      });
                    print(ourResponse);
                    setState(() => ourResponse = answer);
                    print(answer);
                    print(result);
                  } else{
                    setState(() { 
                      responseColor = Colors.green;
                      error = 'Response Submitted';
                    });
                  }
                }
              },
              label: Text('SUBMIT'),
            ),
            Text(
              error,
              style: TextStyle(
                  color: responseColor,
                  fontSize: 14.0

                )

            )
          ]
        )
        
      ),
    );
  
  }
}