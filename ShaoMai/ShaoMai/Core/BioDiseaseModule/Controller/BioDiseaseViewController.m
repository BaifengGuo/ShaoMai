//
//  BioDiseaseViewController.m
//  BioEhealth
//
//  Created by MacBook on 17/3/30.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import "BioDiseaseViewController.h"
#import "BioDiseaseTableViewCell.h"
#import "BioMineDiseaseModel.h"
#import "BioAddDiseaseViewController.h"
#import "BioDiseaseSeeAboutAPI.h"
#import "BioDiseaseDeleatAPI.h"
#import "UIScrollView+RefreshAndPagination.h"
#import <MJRefresh/MJRefreshNormalHeader.h>
@interface BioDiseaseViewController ()<BioAddDiseaseViewControllerDelegate,UITableViewDelegate,UITableViewDataSource,BioPaginationDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation BioDiseaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"既往病史";
    self.navItemTitle = @"添加";
    
    [self.view addSubview:self.tableView];
    [BioDiseaseTableViewCell registerWithTableView:self.tableView];
    
    [self.tableView loadFirstPage];
}

- (void)addBtnClicked{
    BioAddDiseaseViewController *addDiseaseVc = [[BioAddDiseaseViewController alloc]init];
    addDiseaseVc.title = @"记录详情";
    addDiseaseVc.delegate = self;
    [self.navigationController pushViewController:addDiseaseVc animated:YES];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarH+kStatusBarH, self.view.width, self.view.height-kNavBarH-kStatusBarH) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = BioBgColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView addHeaderWithPaginationDelegate:self];
        [_tableView addFooterWithPaginationDelegate:self];
    }
    return _tableView;
}

#pragma mark - UItabelViewDelegate && UITabelViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableView.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BioDiseaseTableViewCell *cell = [BioDiseaseTableViewCell cellWithTableView:tableView forIndexPath:indexPath];
    cell.timeTitleLabel.text = @"诊断时间:";
    cell.nameTitleLabel.text  =@"疾病名称:";
    cell.locationTitleLabel.text = @"就医医院:";
    cell.btn.tag = indexPath.row;
    BioMineDiseaseModel *model = self.tableView.items[indexPath.row];
    cell.timeLabel.text = [NSDate dateWithTimeIntervalString:(long)model.diagnosisTime dateFormat:@"yyyy-MM-dd"];
    NSMutableArray * diseaseNameArr = [NSMutableArray array];
    if (model.disease.count!=0) {
        [model.disease enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [diseaseNameArr addObject:[obj objectForKey:@"diseasesName"]];
        }];
    }
    NSString *diseaseName = [diseaseNameArr componentsJoinedByString:@" "];
    cell.nameLabel.text = diseaseName;
    cell.locationLabel.text = model.hospitalName;
    cell.clickedBlock = ^(NSInteger index){
         self.selectIndex = index;
        [self addUIAlertControllerMessage:@"确定删除该条疾病史信息?"];
        
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return BioH(130)+BioH(70);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BioAddDiseaseViewController *diseaseInfoVc = [[BioAddDiseaseViewController alloc]init];
    diseaseInfoVc.title = @"疾病史详情";
    diseaseInfoVc.model = self.tableView.items[indexPath.row];
    diseaseInfoVc.delegate = self;
    [self.navigationController pushViewController:diseaseInfoVc animated:YES];
}

#pragma mark - BioAddDiseaseViewControllerDelegate
- (void)diseaseInfoSaveSucceed{
    [self.tableView loadFirstPage];
}


#pragma mark --------======确认提示框提醒======---------
- (void)theConfirmationResponseOfThePromptBox{
     [self delegateDiseaseRequest];
    
}

#pragma mark --------=== request获取疾病史信息===--------
#pragma mark - BioPaginationDelegate
- (void)paginationDataWithView:(UIScrollView *)view pageNo:(NSInteger)pageNo pageSize:(NSInteger)pageSize{
   
    NSDictionary *params = @{
                             @"pageNo":[NSString stringWithFormat:@"%ld",(long)pageNo],
                             @"pageSize":[NSString stringWithFormat:@"%ld",(long)pageSize]
                             };
    BioDiseaseSeeAboutAPI *api = [[BioDiseaseSeeAboutAPI alloc]initWithDiseaseParams:params];
    [api startWithCompletion:^(BioAPIResponse *response) {
        NSLog(@"======%@",response);
        if (response.success) {
            [BioProgressHUD showTextHUD:@"查询成功"];
            NSMutableArray *array = [NSMutableArray array];
            [response.data[@"pastMedicalHistoryList"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BioMineDiseaseModel *model = [BioMineDiseaseModel mj_objectWithKeyValues:obj];
                [array addObject:model];
            }];
            [self.tableView reloadData:array];
        }
        [BioProgressHUD hiddenHUDWithMessage:response.msg];
    }];

}

#pragma mark --------=== 删除疾病史信息===--------
- (void)delegateDiseaseRequest{
   
    BioMineDiseaseModel *model = self.tableView.items[self.selectIndex];
    NSDictionary * params = @{
                              @"pastMedicalHistoryId":BioStringIsNill(model.pastMedicalHistoryId)
                              };
    BioDiseaseDeleatAPI * api = [[BioDiseaseDeleatAPI alloc]initWithDiseaseParams:params];
    [api startWithCompletion:^(BioAPIResponse *response) {
        if (response.success) {
             [BioProgressHUD showTextHUD:@"删除成功."];
            [self.tableView.items removeObjectAtIndex:self.selectIndex];
            [self.tableView reloadData];
        }else{
            [BioProgressHUD showTextHUD:response.msg];
        }
    }];

}

@end
