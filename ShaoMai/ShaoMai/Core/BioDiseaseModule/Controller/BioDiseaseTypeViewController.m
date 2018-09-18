//
//  BioDiseaseTypeViewController.m
//  BioMineModule
//
//  Created by MacBook on 2018/9/3.
//  Copyright © 2018年 BioMac. All rights reserved.
//

#import "BioDiseaseTypeViewController.h"
#import "BioMineHealthMoreOptionsView.h"
#import "BioDiseaseDiseaseListAPI.h"
#import "BioMineParTypeListModel.h"
#import "BioTextView.h"

@interface BioDiseaseTypeViewController ()<BioMineHealthMoreOptionsViewDelegate>
@property (nonatomic, strong) BioMineHealthMoreOptionsView *optionView;
@property (nonatomic, strong) BioTextView *textView;
@property (nonatomic, strong) NSMutableArray * addArryCoed;
//记录是否选择了其他
@property(nonatomic,assign) BOOL selectedOther;
@end

@implementation BioDiseaseTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"疾病列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.optionView];
    NSMutableArray *arry = [NSMutableArray array];
    [self.selectDisease enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = obj;
        [arry addObject:@{@"code":dict[@"diseasesCode"],@"name":dict[@"diseasesName"]}];
    }];
    self.optionView.selectData = arry;
    if (self.remark.length !=0) {
        self.textView.text = self.remark;
        [self.view addSubview:self.textView];
        __weak __typeof(self) weakSelf = self;
        _optionView.OptionsHeightBlock = ^(CGFloat height) {
            weakSelf.textView.frame =CGRectMake(BioW(20), height+kNavBarH +kStatusBarH, kScreenW-BioW(41), BioH(149) );
        };
    }else{
        [self.textView removeFromSuperview];
    }
    
    
    [self getDiseaseRequest];
}


#pragma mark - BioMineHealthMoreOptionsViewDelegate
- (void)bioMineHealthMoreOptionsViewDidSelectItemWithData:(NSArray *)data object:(id)object{
   self.addArryCoed = [NSMutableArray array];
    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *dict = obj;
        [self.addArryCoed addObject:@{@"diseasesCode":dict[@"code"],@"diseasesName":dict[@"name"]}];
    }];
    
    self.selectedOther = [object boolValue];;
    if ([object boolValue]) {
        [self.view addSubview:self.textView];
        __weak __typeof(self) weakSelf = self;
        _optionView.OptionsHeightBlock = ^(CGFloat height) {
            weakSelf.textView.frame =CGRectMake(BioW(20), height+kNavBarH +kStatusBarH, kScreenW-BioW(41), BioH(149) );
        };
    }else{
        [self.textView removeFromSuperview];
    }
    
    
}

#pragma mark - request
- (void)getDiseaseRequest{
    BioDiseaseDiseaseListAPI *api = [[BioDiseaseDiseaseListAPI alloc]init];
    [api startWithCompletion:^(BioAPIResponse *response) {
        if (response.success) {
            self.optionView.data = [BioMineParTypeListModel mj_objectArrayWithKeyValuesArray:response.data[@"r"]];
        }
    }];
}

#pragma mark - lazy
- (BioMineHealthMoreOptionsView *)optionView{
    if (!_optionView) {
        _optionView = [[BioMineHealthMoreOptionsView alloc]init];
        _optionView.frame = (CGRect){0,kNavBarH + kStatusBarH,self.view.width,0};
        _optionView.delegate = self;
    }
    return _optionView;
}

- (BioTextView *)textView{
    if (!_textView) {
        _textView = [[BioTextView alloc]init];
        _textView.frame = (CGRect){BioW(20),self.optionView.bottom + BioH(10),ceil(self.view.width - BioW(41)),ceil(BioH(149))};
        _textView.placeholder = @"请输入其他疾病";
    }
    return _textView;
}
- (void)addBtnClicked{
    
    if (self.selectedOther) {
        if ([self.textView.text isEqualToString:@""]) {  //检验其他内容是否为空
            [self.view makeToast:@"其他内容不得为空" duration:1.0 position:CSToastPositionCenter];
            return;
        }
    }
    self.backData(self.addArryCoed, self.textView.text);
     [self performSelector:@selector(popToViewController) withObject:nil afterDelay:0.5];
}
- (void)popToViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
