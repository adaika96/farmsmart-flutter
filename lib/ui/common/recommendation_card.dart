import 'package:farmsmart_flutter/ui/common/roundedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _Constants {
  static String textDivider = '- ';
  static EdgeInsets titlesPadding = const EdgeInsets.only(top: 21.0);
  static EdgeInsets descriptionPadding = const EdgeInsets.only(top: 12.5);
  static EdgeInsets actionsPadding = const EdgeInsets.only(top: 15.5);
  static double horizontalActionsSeparation = 12;
}

class RecommendationCardViewModel {
  String imagePath;
  String title;
  String subtitle;
  String description;
  String leftActionText;
  String rightActionText;
  Function leftAction;
  Function rightAction;

  RecommendationCardViewModel({
    this.imagePath,
    this.title,
    this.subtitle,
    this.description,
    this.leftActionText,
    this.rightActionText,
    this.leftAction,
    this.rightAction,
  });
}

class RecommendationCardStyle {
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final TextStyle descriptionTextStyle;
  final RoundedButtonStyle leftActionButtonStyle;
  final RoundedButtonStyle rightActionButtonStyle;
  final double imageHeight;
  final BorderRadiusGeometry imageBorderRadius;
  final int descriptionMaxLines;
  final EdgeInsets contentPadding;

  const RecommendationCardStyle({
    this.titleTextStyle,
    this.subtitleTextStyle,
    this.descriptionTextStyle,
    this.leftActionButtonStyle,
    this.rightActionButtonStyle,
    this.imageHeight,
    this.imageBorderRadius,
    this.descriptionMaxLines,
    this.contentPadding,
  });

  RecommendationCardStyle copyWith({
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    TextStyle descriptionTextStyle,
    RoundedButtonStyle leftActionButtonStyle,
    RoundedButtonStyle rightActionButtonStyle,
    double imageHeight,
    BorderRadiusGeometry imageBorderRadius,
    int descriptionMaxLines,
    EdgeInsets contentPadding,
  }) {
    return RecommendationCardStyle(
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      descriptionTextStyle: descriptionTextStyle ?? this.descriptionTextStyle,
      leftActionButtonStyle:
          leftActionButtonStyle ?? this.leftActionButtonStyle,
      rightActionButtonStyle:
          rightActionButtonStyle ?? this.rightActionButtonStyle,
      imageHeight: imageHeight ?? this.imageHeight,
      imageBorderRadius: imageBorderRadius ?? this.imageBorderRadius,
      descriptionMaxLines: descriptionMaxLines ?? this.descriptionMaxLines,
      contentPadding: contentPadding ?? this.contentPadding,
    );
  }
}

class _DefaultStyle extends RecommendationCardStyle {
  final TextStyle titleTextStyle = const TextStyle(
    color: Color(0xff1a1b46),
    fontSize: 17,
    fontWeight: FontWeight.w500,
  );
  final TextStyle subtitleTextStyle = const TextStyle(
    color: Color(0xff1a1b46),
    fontSize: 17,
  );
  final TextStyle descriptionTextStyle = const TextStyle(
    color: Color(0xff767690),
    fontSize: 14,
  );
  final RoundedButtonStyle leftActionButtonStyle = const RoundedButtonStyle(
    backgroundColor: Color(0xffe9eaf2),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    buttonTextStyle: TextStyle(
        fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xff4c4e6e)),
    iconEdgePadding: 5,
    height: 40,
    width: double.infinity,
    buttonIconSize: null,
    iconButtonColor: Color(0xFFFFFFFF),
    buttonShape: BoxShape.rectangle,
  );
  final RoundedButtonStyle rightActionButtonStyle = const RoundedButtonStyle(
    backgroundColor: Color(0xffe9eaf2),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    buttonTextStyle: TextStyle(
        fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xff4c4e6e)),
    iconEdgePadding: 5,
    height: 40,
    width: double.infinity,
    buttonIconSize: null,
    iconButtonColor: Color(0xFFFFFFFF),
    buttonShape: BoxShape.rectangle,
  );
  final double imageHeight = 152;
  final BorderRadiusGeometry imageBorderRadius =
      const BorderRadius.all(Radius.circular(12.0));
  final int descriptionMaxLines = 2;

  final EdgeInsets contentPadding = const EdgeInsets.all(32.0);

  const _DefaultStyle({
    TextStyle titleTextStyle,
    TextStyle subtitleTextStyle,
    TextStyle descriptionTextStyle,
    RoundedButtonStyle leftActionButtonStyle,
    RoundedButtonStyle rightActionButtonStyle,
    double imageHeight,
    BorderRadiusGeometry imageBorderRadius,
    int descriptionMaxLines,
    EdgeInsets contentPadding,
  });
}

const RecommendationCardStyle _defaultStyle = const _DefaultStyle();

class RecommendationCard extends StatelessWidget {
  final RecommendationCardStyle _style;
  final RecommendationCardViewModel _viewModel;

  RecommendationCard({
    Key key,
    @required RecommendationCardViewModel viewModel,
    RecommendationCardStyle style = _defaultStyle,
  })  : this._style = style,
        this._viewModel = viewModel,
        super(key: key);

  static RoundedButtonStyle _defaultRoundedButtonStyle = RoundedButtonStyle(
    backgroundColor: Color(0xffe9eaf2),
    borderRadius: BorderRadius.all(Radius.circular(8)),
    buttonTextStyle: TextStyle(
        fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xff4c4e6e)),
    iconEdgePadding: 5,
    height: 40,
    width: double.infinity,
    buttonIconSize: null,
    iconButtonColor: Color(0xFFFFFFFF),
    buttonShape: BoxShape.rectangle,
  );

  static RoundedButtonStyle _addedRoundedButtonStyle =
      _defaultRoundedButtonStyle.copyWith(
    backgroundColor: Color(0xffffffff),
    buttonTextStyle: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Color(0xff4c4e6e),
    ),
  );

  static RoundedButtonStyle _addToPlotRoundedButtonStyle =
      _defaultRoundedButtonStyle.copyWith(
    backgroundColor: Color(0xff24d900),
    buttonTextStyle: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: Color(0xffffffff),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: _style.contentPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTopRoundedImage(),
            _buildTitles(),
            _buildDescription(),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Container _buildTopRoundedImage() {
    return Container(
      width: double.infinity,
      height: _style.imageHeight,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: _style.imageBorderRadius,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(_viewModel.imagePath),
        ),
      ),
    );
  }

  Padding _buildTitles() {
    return Padding(
      padding: _Constants.titlesPadding,
      child: Row(
        children: <Widget>[
          Text(
            _viewModel.title,
            style: _style.titleTextStyle,
          ),
          Text(
            _Constants.textDivider,
            style: _style.subtitleTextStyle,
          ),
          Text(
            _viewModel.subtitle,
            style: _style.subtitleTextStyle,
          ),
        ],
      ),
    );
  }

  Padding _buildDescription() {
    return Padding(
      padding: _Constants.descriptionPadding,
      child: Text(
        _viewModel.description,
        style: _style.descriptionTextStyle,
        maxLines: _style.descriptionMaxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Padding _buildActions() {
    return Padding(
      padding: _Constants.actionsPadding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: RoundedButton(
              style: _style.leftActionButtonStyle,
              viewModel: RoundedButtonViewModel(
                title: _viewModel.leftActionText,
                onTap: _viewModel.leftAction,
              ),
            ),
          ),
          SizedBox(
            width: _Constants.horizontalActionsSeparation,
          ),
          Expanded(
            child: RoundedButton(
              style: _style.rightActionButtonStyle,
              viewModel: RoundedButtonViewModel(
                title: _viewModel.rightActionText,
                onTap: _viewModel.rightAction,
              ),
            ),
          )
        ],
      ),
    );
  }
}
