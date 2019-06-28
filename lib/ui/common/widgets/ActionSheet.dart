import 'package:farmsmart_flutter/ui/common/ActionSheetLargeRoundedButtonStyle.dart';
import 'package:farmsmart_flutter/ui/common/ListDivider.dart';
import 'package:farmsmart_flutter/ui/common/headerAndFooterListView.dart';
import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';

class ActionListItemViewModel {
  String title;
  String icon;
  String checkBoxIcon;
  bool isHighlighted;
  Function action;

  ActionListItemViewModel(this.title, this.action, this.isHighlighted, {this.icon, this.checkBoxIcon});
}

class ActionSheetViewModel {
  List<ActionListItemViewModel> actions;
  String buttonTitle;

  ActionSheetViewModel(this.actions, this.buttonTitle);
}

abstract class ActionSheetStyle {
  final Color cornersColor;
  final Color backgroundColor;
  final Color dropLineColor;
  final Color cardBackgroundColor;
  final Color buttonBackgroundColor;

  final TextStyle mainTextStyle;
  final TextStyle highlightTextStyle;

  final EdgeInsets cardEdge;
  final EdgeInsets dropLineEdge;

  final Radius borderRadius;
  final Radius dropLineRadius;

  final double dropLineHeight;
  final double cardHeight;
  final double iconLineSpace;
  final double cardElevation;
  final double iconHeight;

  final int maxLines;

  ActionSheetStyle( this.cornersColor, this.backgroundColor, this.dropLineColor,
      this.cardBackgroundColor, this.buttonBackgroundColor, this.mainTextStyle, this.highlightTextStyle,
      this.cardEdge, this.dropLineEdge, this.borderRadius, this.dropLineRadius,
      this.dropLineHeight, this.cardHeight, this.iconLineSpace, this.cardElevation,
      this.iconHeight, this.maxLines);
}

class DefaultStyle implements ActionSheetStyle {
  static const Color titleColor = Color(0xFF1a1b46);
  static const Color highlightColor = Color(0xFFff6060);

  final Color cornersColor = const Color(0xFF737373);
  final Color backgroundColor = const Color(0xFFffffff);
  final Color dropLineColor = const Color(0xFFe0e1ee);
  final Color cardBackgroundColor = const Color(0x00000000);
  final Color buttonBackgroundColor = const Color(0xFFe9eaf2);

  final TextStyle mainTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: titleColor);
  final TextStyle highlightTextStyle = const TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: highlightColor);

  final EdgeInsets cardEdge = const EdgeInsets.only(left: 32, right: 32);
  final EdgeInsets dropLineEdge =
      const EdgeInsets.only(left: 160, right: 160, top: 8, bottom: 50);

  final Radius borderRadius = const Radius.circular(40);
  final Radius dropLineRadius = const Radius.circular(2.5);

  final double dropLineHeight = 5;
  final double cardHeight = 70;
  final double iconLineSpace = 21.5;
  final double cardElevation = 0;
  final double iconHeight = 16.5;

  final int maxLines = 1;

  const DefaultStyle();
}

class ActionSheet {
  static Widget build(BuildContext context, ActionSheetViewModel viewModel, {ActionSheetStyle style = const DefaultStyle()}) {

    /* FIXME: To make the modal bottom sheet autoresizable (without limit) needs to modify native file bottom_sheet
        @override
        BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
          return BoxConstraints(
            minWidth: constraints.maxWidth,
            maxWidth: constraints.maxWidth,
            minHeight: 0.0,
            maxHeight: constraints.maxHeight,
          );
  }*/
    return Container(
        color: style.cornersColor, // This line set the transparent background
        child: Container(
            decoration: BoxDecoration(
                color: style.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: style.borderRadius, topRight: style.borderRadius)),
            child: HeaderAndFooterListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: viewModel.actions.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildActionCell(style, viewModel.actions[index],
                        viewModel.actions.length, index),
                header: buildDropLine(style),
                footer: RoundedButton.build(RoundedButtonViewModel(context, title: viewModel.buttonTitle), style: ActionSheetLargeRoundedButtonStyle()))));
  }

  static Widget buildDropLine(ActionSheetStyle style) {
    return Container(
      height: style.dropLineHeight,
      margin: style.dropLineEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(style.dropLineRadius),
        color: style.dropLineColor,
      ),
    );
  }

  static Widget buildActionCell(
      ActionSheetStyle style,
      ActionListItemViewModel viewModel,
      int numberOfActions,
      int currentAction) {
    return Column(
      children: <Widget>[
        Card(
          elevation: style.cardElevation,
          color: style.cardBackgroundColor,
          child: InkWell(
            onTap: () => print(viewModel.title),
            child: Container(
              padding: style.cardEdge,
              alignment: Alignment.center,
              height: style.cardHeight,
              child: Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _buildActionContent(style, viewModel),
                    ),
                  ]),
            ),
          ),
        ),
        currentAction == numberOfActions - 1 ? Wrap() : ListDivider.build(),
      ],
    );
  }

  static List<Widget> _buildActionContent(ActionSheetStyle style, ActionListItemViewModel viewModel) {
    List<Widget> listBuilder = [];

    if (viewModel.icon != null) {
      listBuilder.add(Image.asset(viewModel.icon, height: style.iconHeight));
      listBuilder.add(SizedBox(width: style.iconLineSpace));

    } if (viewModel.title != null) {
      listBuilder.add(Text(viewModel.title,
          style: viewModel.isHighlighted
              ? style.highlightTextStyle
              : style.mainTextStyle));

    } if (viewModel.checkBoxIcon != null) {
      listBuilder.add(Expanded(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Image.asset(viewModel.checkBoxIcon, height: style.iconHeight)
        ],
      )));
    }

    return listBuilder;
  }
}
