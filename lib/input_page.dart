
import 'package:bmi_calculator/results_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'inner_card.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'results_page.dart';
import 'calculator_brain.dart';


enum Gender {Male , Female}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  Gender selectedGender ;
  int height = 180;
  int weight = 45;
  int age = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: Row(
            children: <Widget>[
              Expanded(
                child: ReusableCard(
                  onPress: () {
                    setState(() {
                      selectedGender = Gender.Male ;
                    });
                  },
                  colour: selectedGender == Gender.Male ?
                      kActiveColor :
                      kInactiveColor ,

                cardChild: InnerCard(
                    icon: FontAwesomeIcons.mars,
                    label:'MALE'
                ),
                ),

              ),

              Expanded(child: ReusableCard(
                onPress: () {
                  setState(() {
                    selectedGender = Gender.Female ;
                  });
                },
                colour: selectedGender == Gender.Female ?
                kActiveColor :
                kInactiveColor,
              cardChild: InnerCard(icon: FontAwesomeIcons.venus , label: 'FEMALE'),
              ),
              ),
            ],
          ),
          ),

          Expanded(child:ReusableCard(colour: kActiveColor,
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('HEIGHT',
              style: TextStyle(
                color: Color(0xFF8D8E98),
                fontSize: 18.0,
              ),
              ),
              Row (
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,

                children: <Widget>[
                  Text(height.toString(),
                  style: kNumberTextStyles,
                  ),
                  Text('cm',
                  style: kTextStyles,
                  ),
                ],
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.white,
                inactiveTrackColor: Color(0xFF8D8E98),
                  thumbColor: Color(0xFFEB1555),
                  overlayColor: Color(0x29EB1555),
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 15.0),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 30.0),
                ),
                child: Slider(
                  value: height.toDouble(),
                  min: 120.0,
                  max: 240.0,
                  onChanged: (double newValue) {
                    setState(() {
                      height = newValue.round();
                    });
                  },
                ),
              )
            ],
          ),
          ),
          ),

             Expanded(child: Row(
                 children: <Widget>[
                 Expanded(child: ReusableCard(colour: kActiveColor,
                 cardChild: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Text('WEIGHT',
                     style: kTextStyles,
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Text(weight.toString(),
                         style: kNumberTextStyles,
                         ),
                       ],
                     ),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         RoundIconButton(
                           icon: FontAwesomeIcons.minus,
                           onPressed: () {
                             setState(() {
                               weight -- ;
                             });
                           },
                         ),
                         SizedBox(
                           width: 18.0,
                         ),
                         Row(
                           children: <Widget>[
                             RoundIconButton(icon: FontAwesomeIcons.plus,
                             onPressed: () {
                               setState(() {
                                 weight ++ ;
                               });
                             },),
                           ],
                         ),
                       ],

                     ),
                   ],
                 ),),
                 ),
                   Expanded(child: ReusableCard(colour: kActiveColor,
                   cardChild: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Text('AGE',
                       style: kTextStyles,
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                           Text(age.toString(),
                           style: kNumberTextStyles,
                           ),
                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: <Widget>[
                           RoundIconButton(
                             icon: FontAwesomeIcons.minus,
                             onPressed: () {
                               setState(() {
                                 age --;
                               });
                             },
                           ),
                           SizedBox(
                             width: 18.0,
                           ),
                           Row(
                             children: <Widget>[
                               RoundIconButton(
                                 icon: FontAwesomeIcons.plus,
                                 onPressed: () {
                                   setState(() {
                                     age ++;
                                   });
                                 },
                               ),
                             ],
                           )
                         ],
                       )
                       
                     ],
                   ),),
                   ),
      ],
    ),
    ),
          BottomButton(
            buttonTitle : 'CALCULATE',
            onTap : () {

              CalculatorBrain calc = CalculatorBrain(height, weight);

              Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsPage(
                bmiResult : calc.calculateBmi(),
                resultText : calc.getResult(),
                interpretation : calc.getInterpretation(),
              )));
            },
           ),
    ],
    ),
    );
  }
}

class BottomButton extends StatelessWidget {

  BottomButton({@required this.onTap,@required this.buttonTitle});

  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(buttonTitle,
          style: kLargeButtonTextStyles,
          ),
        ),
        color: Color(0xFFEB1555),
        margin: EdgeInsets.only(top: 10),
        width: double.infinity,
        height: kBottomContainerHeight,
      ),
    );
  }
}

class RoundIconButton extends StatelessWidget {
  RoundIconButton({@ required this.icon,@required this.onPressed});

   final IconData icon ;
   final Function onPressed ;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      child: Icon(icon),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape : CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}



