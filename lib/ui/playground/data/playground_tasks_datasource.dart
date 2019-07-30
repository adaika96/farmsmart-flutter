import 'package:farmsmart_flutter/model/loading_status.dart';
import 'package:farmsmart_flutter/ui/mockData/MockRecordTransactionViewModel.dart';
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransaction.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/RecordTransactionListItem.dart';
import 'package:farmsmart_flutter/data/bloc/article/ArticleListProvider.dart';
import 'package:farmsmart_flutter/data/bloc/plot/PlotDetailProvider.dart';
import 'package:farmsmart_flutter/data/bloc/plot/PlotListProvider.dart';
import 'package:farmsmart_flutter/data/model/mock/MockPlot.dart';
import 'package:farmsmart_flutter/data/repositories/article/implementation/MockArticlesRepository.dart';
import 'package:farmsmart_flutter/ui/LandingPage.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleList.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockLandingPageViewModel.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_atom_datasource.dart';
import 'package:farmsmart_flutter/ui/bottombar/persistent_bottom_navigation_bar.dart';
import 'package:farmsmart_flutter/data/repositories/plot/implementation/MockPlotRepository.dart';
import 'package:farmsmart_flutter/ui/discover/ArticleList.dart';
import 'package:farmsmart_flutter/ui/common/ActionSheet.dart';
import 'package:farmsmart_flutter/ui/common/carousel_view.dart';
import 'package:farmsmart_flutter/ui/mockData/MockActionSheetViewModel.dart';
import 'package:farmsmart_flutter/ui/mockData/MockFarmDetailsViewModel.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotDetail.dart';
import 'package:farmsmart_flutter/ui/myplot/PlotList.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_data_source.dart';
import 'package:farmsmart_flutter/ui/playground/data/playground_stagecard_datasource.dart';
import 'package:farmsmart_flutter/ui/playground/playground_button_present_modal.dart';
import 'package:farmsmart_flutter/ui/playground/playground_widget.dart';
import 'package:farmsmart_flutter/ui/profile/FarmDetails.dart';
import 'package:farmsmart_flutter/ui/profile/FarmDetailsListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossHeader.dart';
import 'package:farmsmart_flutter/ui/profitloss/ProfitLossListItem.dart';
import 'package:farmsmart_flutter/ui/profitloss/mockRepositoryTryout/MockTransactionRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../playground_view.dart';
import 'playground_persistent_bottom_navigation_bar_datasource.dart';

class PlayGroundTasksDataSource implements PlaygroundDataSource {
  @override
  List<PlaygroundWidget> getList() {
    return [
      //Add Your tasks here
      PlaygroundWidget(
          title: 'TASK FARM-62 View-Prof-Loss-Statement',
          child: PlaygroundView(
            widgetList: [
              PlaygroundWidget(
                title: 'TASK FARM-62 Profit-Loss Header',
                child: ProfitLossHeader(
                    viewModel: MockProfitLossHeaderViewModel.build(),
                    style: ProfitLossHeaderStyle.defaultStyle()),
              ),
              PlaygroundWidget(
                title: 'TASK FARM-62 Profit-Loss Item Negative',
                child: ProfitLossListItem(
                    viewModel: MockProfitLossListItemViewModel.buildNegative(),
                    style: ProfitLossItemStyle.defaultStyle()),
              ),
              PlaygroundWidget(
                title: 'TASK FARM-62 Profit-Loss Item Positive',
                child: ProfitLossListItem(
                    viewModel: MockProfitLossListItemViewModel.buildPositive(),
                    style: ProfitLossItemStyle.defaultStyle()),
              ),
            ],
          )),
      PlaygroundWidget(
          title: 'FARM-355 Generic Action Sheet',
          child: PlaygroundView(
            widgetList: [
              PlaygroundWidget(
                title: 'FARM-355 Generic Action Sheet - Simple',
                child: Container(
                  height: 350,
                  child: ActionSheet(
                      viewModel: MockActionSheetViewModel.buildStandard(),
                      style: ActionSheetStyle.defaultStyle()),
                ),
              ),
              PlaygroundWidget(
                title: 'FARM-355 Generic Action Sheet - Larger',
                child: Container(
                  height: 420,
                  child: ActionSheet(
                      viewModel: MockActionSheetViewModel.buildStandardBigger(),
                      style: ActionSheetStyle.defaultStyle()),
                ),
              ),
              PlaygroundWidget(
                  title: 'FARM-355 Generic Action Sheet - With icons',
                  child: Container(
                    height: 350,
                    child: ActionSheet(
                        viewModel: MockActionSheetViewModel.buildWithIcon(),
                        style: ActionSheetStyle.defaultStyle()),
                  )),
              PlaygroundWidget(
                  title: 'FARM-355 Generic Action Sheet - With checkBox',
                  child: Container(
                      height: 350,
                      child: ActionSheet(
                          viewModel:
                              MockActionSheetViewModel.buildWithCheckBox(),
                          style: ActionSheetStyle.defaultStyle()))),
            ],
          )),
      PlaygroundWidget(
          title: 'FARM-355 Generic Action Sheet - Type 4',
          child: Container(
              height: 350,
              child: ActionSheet(
                  viewModel: MockActionSheetViewModel.buildWithCheckBox(),
                  style: ActionSheetStyle.defaultStyle()))),

      PlaygroundWidget(
        title: 'TASK FARM-278 State carousel view',
        child: Container(
          height: 162,
          child: CarouselView(
            children: PlaygroundStageCardDataSource().getList(),
          ),
        ),
      ),
      PlaygroundWidget(
          title: "FARM-280 Update Discover",
          child: ArticleList(
              viewModelProvider: ArticleListProvider(
                  title: "Test",
                  repository: MockArticlesRepository(articleCount: 2000)))),
      PlaygroundWidget(
        title: "FARM-48 Landing Page",
        child: PlaygroundButtonPresentModal(
          child: LandingPage(viewModel: MockLandingPageViewModel.build()),
        ),
      ),
      PlaygroundWidget(
        title: 'FARM-59 Record a Cost/Sale',
        child: PlaygroundView(widgetList: [
          PlaygroundWidget(
            title: 'Record a Sale',
            child: RecordTransaction(
              viewModel: MockRecordTransactionViewModel.buildSaleTransaction(),
            ),
          ),
          PlaygroundWidget(
            title: 'Record a Cost',
            child: RecordTransaction(
              viewModel: MockRecordTransactionViewModel.buildCostTransaction(),
            ),
          ),
          PlaygroundWidget(
            title: 'View a Sale',
            child: RecordTransaction(
              viewModel: MockRecordTransactionViewModel.buildViewSale(),
            ),
          ),
          PlaygroundWidget(
            title: 'View a Cost',
            child: RecordTransaction(
              viewModel: MockRecordTransactionViewModel.buildViewCost(),
            ),
          ),
        ]),
      ),
      PlaygroundWidget(
        title: "FARM-280 Update Discover",
        child: ArticleList(
          viewModelProvider: ArticleListProvider(
              title: "Test",
              repository: MockArticlesRepository(articleCount: 2000)),
        ),
      ),
      PlaygroundWidget(
        title: "FARM-342 Persistent Bottom navigation bar",
        child: PersistentBottomNavigationBar(
          backgroundColor: Colors.white,
          tabs: PlaygroundPersistentBottomNavigationBar().getList(),
        ),
      ),
      PlaygroundWidget(
          title: 'TASK FARM-365 Plot',
          child: PlaygroundView(widgetList: [
            PlaygroundWidget(
                title: "FARM-365 Plot Repository",
                child: PlotList(
                    provider: PlotListProvider(
                        title: "Test", repository: MockPlotRepository()))),
            PlaygroundWidget(
                title: "FARM-365 Plot Detail",
                child: PlotDetail(
                  provider: PlotDetailProvider(
                      MockPlotEntity().build(), MockPlotRepository()),
                ))
          ])),
      PlaygroundWidget(
        title: 'TASK FARM-443 Farm Details',
        child: PlaygroundView(
          widgetList: [
            PlaygroundWidget(
              title: "FARM-443 Show farm details",
              child: FarmDetails(
                viewModel: MockFarmDetailsViewModel.build(),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
