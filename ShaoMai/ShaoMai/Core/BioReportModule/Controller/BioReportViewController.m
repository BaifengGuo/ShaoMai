//
//  BioReportViewController.m
//  BioEhealth
//
//  Created by MacBook on 17/3/28.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import "BioReportViewController.h"
#import "BioMineHealthHistoryCellTypeOne.h"
#import "BioMineReportModel.h"
#import "BioAddReportViewController.h"
#import "UIScrollView+RefreshAndPagination.h"
#import <MJRefresh/MJRefreshNormalHeader.h>
#import "BioSeeAboutPhysicalExamRecordAPI.h"
#import "BioDelPhysicalExamRecordAPI.h"
@interface BioReportViewController ()<UITableViewDelegate,UITableViewDataSource,BioAddReportViewControllerDelegate,BioPaginationDelegate>
@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) NSInteger selectIndex;
@end

@implementation BioReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"体检报告";
    self.navItemTitle = @"添加";
    
    [self.view addSubview:self.tableView];
    [BioMineHealthHistoryCellTypeOne registerWithTableView:self.tableView];
    
    [self.tableView loadFirstPage];
    
}

- (void)addBtnClicked{
    BioAddReportViewController *addReportVc = [[BioAddReportViewController alloc]init];
    addReportVc.title = @"新增体检报告";
    addReportVc.delegate = self;
    [self.navigationController pushViewController:addReportVc animated:YES];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarH+kStatusBarH, self.view.bounds.size.width, self.view.bounds.size.height-kNavBarH-kStatusBarH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BioBgColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView addHeaderWithPaginationDelegate:self];
        [_tableView addFooterWithPaginationDelegate:self];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableView.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BioMineHealthHistoryCellTypeOne *cell = [BioMineHealthHistoryCellTypeOne cellWithTableView:tableView forIndexPath:indexPath];
    cell.btn.tag = indexPath.row;
    cell.timeTitleLabel.text = @"检查时间:";
    cell.contentTitleLabel.text = @"体检描述:";
    
    BioMineReportModel *model = self.tableView.items[indexPath.row];
    cell.timeLabel.text = [NSDate dateWithTimeIntervalString:(long)model.physicalExamDate dateFormat:@"yyyy-MM-dd"];
    cell.contentLabel.text = model.physicalExamOrgName;
    cell.clickedBlock = ^(NSInteger index){
        self.selectIndex = index;
        [self addUIAlertControllerMessage:@"确定删除该条体检报告?"];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BioH(90)+BioH(70);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BioAddReportViewController *addReportVc = [[BioAddReportViewController alloc]init];
    addReportVc.title = @"体检报告详情";
    BioMineReportModel *model = self.tableView.items[indexPath.row];
    addReportVc.model = model;
    addReportVc.delegate = self;
    [self.navigationController pushViewController:addReportVc animated:YES];
}
#pragma mark - BioMineAddReportViewControllerDelegate
- (void)reportInfoSaveSucceed{
    [self.tableView loadFirstPage];
}


#pragma mark --------======确认提示框提醒======---------
- (void)theConfirmationResponseOfThePromptBox{
    [self delegateReportRequest];
    
}
#pragma mark - request
//获取体检记录信息
#pragma mark - BioPaginationDelegate
- (void)paginationDataWithView:(UIScrollView *)view pageNo:(NSInteger)pageNo pageSize:(NSInteger)pageSize{
    NSDictionary *params = @{
                             @"pageNo":[NSString stringWithFormat:@"%ld",(long)pageNo],
                             @"pageSize":[NSString stringWithFormat:@"%ld",(long)pageSize]
                             };
    BioSeeAboutPhysicalExamRecordAPI * api = [[BioSeeAboutPhysicalExamRecordAPI alloc]initWithSeeAboutPhysicalExamRecordParams:params];
    [api startWithCompletion:^(BioAPIResponse *response) {
//        NSLog(@"======%@",response);
        if (response.success) {
             [BioProgressHUD showTextHUD:@"查询成功"];
//            [self.tableView.items removeAllObjects];
            NSMutableArray * arry = [NSMutableArray array];
            [response.data[@"r"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BioMineReportModel *model = [BioMineReportModel mj_objectWithKeyValues:obj];
                [arry addObject:model];
            }];
            [self.tableView reloadData: arry];
            [self.view addSubview:self.tableView];
            [BioMineHealthHistoryCellTypeOne registerWithTableView:self.tableView];
        }else{
            [BioProgressHUD hiddenHUDWithMessage:response.msg];
        }

        
    }];
    
}


//删除意见记录信息
- (void)delegateReportRequest{
    BioMineReportModel *model = self.tableView.items[self.selectIndex];
    NSDictionary * params = @{
                              @"userId": BioStringIsNill([BioUserInfoManager userInfo].userId),
                              @"physicalExamReportId": BioStringIsNill(model.physicalExamReportId)
                              };
    BioDelPhysicalExamRecordAPI * api = [[BioDelPhysicalExamRecordAPI alloc]initWithDelPhysicalExamRecordParams:params];
    [api startWithCompletion:^(BioAPIResponse *response) {
        if(response.success){
            [BioProgressHUD showTextHUD:@"删除成功"];
            [self.tableView.items removeObjectAtIndex:self.selectIndex];
            [self.tableView reloadData];
        }else{
            [BioProgressHUD showTextHUD:response.msg];
        }

    }];
    
}

@end
