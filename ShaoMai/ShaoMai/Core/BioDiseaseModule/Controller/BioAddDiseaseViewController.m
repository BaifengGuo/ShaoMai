//
//  BioAddDiseaseViewController.m
//  BioEhealth
//
//  Created by MacBook on 17/4/5.
//  Copyright © 2017年 LouKit. All rights reserved.
//
#import "TZImagePickerController.h"
#import "BioAddDiseaseViewController.h"
#import "BioMineHealthHistoryDetailItemView.h"
#import "BioMineAddFileView.h"
#import "BioHealthFilesRecordInfoView.h"
#import <BioTool/BioDatePickerView.h>
#import "BioMineAddFileModel.h"
#import "BioDiseaseTypeViewController.h"
#import "BioMineParTypeListModel.h"
#import "BioDiseaseSaveAPI.h"
#import "BioDiseeaseUpdateAPI.h"

@interface BioAddDiseaseViewController ()<BioMineHealthHistoryDetailItemViewDelegate,TZImagePickerControllerDelegate,BioMineAddFileViewDelegate>
@property (nonatomic, strong) BioMineHealthHistoryDetailItemView *timeView;
@property (nonatomic, strong) BioMineHealthHistoryDetailItemView *diseaseView;
@property (nonatomic, strong) BioMineHealthHistoryDetailItemView *hospitalView;
@property (nonatomic, strong) BioMineAddFileView *fileView;
@property (nonatomic, strong) BioHealthFilesRecordInfoView *recordInfoView;
@property (nonatomic, strong) BioDatePickerView *datePicker;

@property (nonatomic, strong) NSString *illnesCode;
@property (nonatomic, strong) NSString *otherDisease;
@property(nonatomic,strong) NSArray *recordFilethPath;
@end

@implementation BioAddDiseaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray * diseasecode = [NSMutableArray array];
    [self.model.disease enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [diseasecode addObject:[obj objectForKey:@"diseasesCode"] ];
    }];
    self.illnesCode =  [diseasecode componentsJoinedByString:@","];
    [self prepareUI];
    
    if (self.model) {
        [self addRecordInfoView];
        self.otherDisease = self.model.otherDisease;
        __weak __typeof(self) weakSelf = self;
        self.fileView.AddFileImageHeight = ^(CGFloat height) {
            weakSelf.recordInfoView.frame =CGRectMake(0, CGRectGetMaxY(weakSelf.hospitalView.frame)+80 +height, weakSelf.view.width, weakSelf.view.height-CGRectGetMaxY(weakSelf.fileView.frame)-BioH(140));
        };
    }
    
    //此处判断是医师端添加记录还是自己天添加的记录，医生端天添加的记录只展示，不可以修改
    #pragma mark --------=== 数据等待处暂时理关闭===--------
    if(self.model){

        if(![self.model.createUserName isEqualToString:[BioUserInfoManager userInfo].name]){
            self.addBtn.hidden = YES;
            self.timeView.userInteractionEnabled = NO;
            self.diseaseView.userInteractionEnabled = NO;
            self.hospitalView.userInteractionEnabled = NO;
            self.fileView.hideDelete = YES;
        }
    }

}

- (void)addBtnClicked{
    if (![self.diseaseView.detail isEqualToString:@"无"]) {
        if (self.timeView.detail.length == 0) {
            [self.view makeToast:@"请输入诊断时间" duration:1.0 position:CSToastPositionCenter];
            return;
        }
        
        if (self.diseaseView.detail.length == 0) {
            [self.view makeToast:@"请输入疾病名称" duration:1.0 position:CSToastPositionCenter];
            return;
        }
    }

    if (self.model) {
        [self updateDiseaseInfoRequest];
    }else{
        [self saveDiseaseInfoRequest];
    }
}

- (void)prepareUI{
    
    UIView *marginView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarH+kStatusBarH, kScreenW, BioH(BioMargin))];
    marginView.backgroundColor = BioBgColor;
    [self.view addSubview:marginView];
    
    //诊断时间
    self.timeView = [[BioMineHealthHistoryDetailItemView alloc]init];
    self.timeView.frame = CGRectMake(0, CGRectGetMaxY(marginView.frame), self.view.width, BioW(40));
    self.timeView.delegate = self;
    self.timeView.title = @"确诊时间";
    
    
    NSString * createTime = (long*)self.model.diagnosisTime==nil?@"":[NSDate dateWithTimeIntervalString:(long)self.model.diagnosisTime dateFormat:@"yyyy-MM-dd"];
    
    self.timeView.detail = createTime ;
    self.timeView.image = [UIImage imageNamed:@"required"];
    [self.view addSubview:self.timeView];
    
    //疾病名称
    self.diseaseView = [[BioMineHealthHistoryDetailItemView alloc]init];
    self.diseaseView.frame = CGRectMake(0, CGRectGetMaxY(self.timeView.frame), self.view.width,BioH(40));
    self.diseaseView.delegate = self;
    self.diseaseView.title = @"疾病名称";
    
    NSMutableArray * diseaseNameArr = [NSMutableArray array];
        [self.model.disease enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [diseaseNameArr addObject:[obj objectForKey:@"diseasesName"]];
        }];
    NSString *diseaseName = [diseaseNameArr componentsJoinedByString:@" "];
    self.diseaseView.detail = diseaseName;
    self.diseaseView.image = [UIImage imageNamed:@"required"];
    [self.view addSubview:self.diseaseView];
    
    //就诊医院
    self.hospitalView = [[BioMineHealthHistoryDetailItemView alloc]init];
    self.hospitalView.frame = CGRectMake(0, CGRectGetMaxY(self.diseaseView.frame), self.view.width, BioH(40));
    self.hospitalView.title = @"就诊医院";
    self.hospitalView.detail = self.model.hospitalName?:@"";
    self.hospitalView.keyBoardType = UIKeyboardTypeDefault;
    self.hospitalView.hidenArrow = YES;
    [self.view addSubview:self.hospitalView];
    
    
    //底部添加文件视图
    self.fileView = [[BioMineAddFileView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.hospitalView.frame), self.view.width, BioH(200))];
    
    self.fileView.delegagte = self;
    [self.view addSubview:self.fileView];
    self.recordFilethPath = self.model.filePath;
    self.fileView.imgData = [self.model.filePath mutableCopy];
}
-(void)BioMineAddFileImageNsinter:(NSInteger)inter{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:8 - inter delegate:self];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    [self.fileView.photos removeAllObjects];
    [self.fileView.assets removeAllObjects];
    self.fileView.photos = [photos mutableCopy];
    self.fileView.assets = [assets mutableCopy];
    [self.fileView uploadImageRequest:self.fileView.photos];
}

- (void)addRecordInfoView{
 self.recordInfoView = [[BioHealthFilesRecordInfoView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.fileView.frame)+80, self.view.width, self.view.height-CGRectGetMaxY(self.fileView.frame)-BioH(140))];
    
    self.recordInfoView.name = self.model.createUserName;
    self.recordInfoView.time = self.model.creationDate;
    [self.view addSubview:self.recordInfoView];
}

- (BioDatePickerView *)datePicker{
    if (!_datePicker) {
        _datePicker = [[BioDatePickerView alloc]init];
        _datePicker.frame = [UIScreen mainScreen].bounds;
        __weak __typeof(self) weakSelf = self;
        _datePicker.title = @"确诊时间";
        _datePicker.selectedDate = ^(NSString *date) {
          weakSelf.timeView.detail = date;
              NSLog(@"%@===%@", weakSelf.timeView.detail,date);
        };
      
    }
    return _datePicker;
}


#pragma mark - BioMineHealthHistoryDetailItemViewDelegate
- (void)bioMineHealthHistoryDetailItemViewDisClicked:(UIView *)view{
    if (view == self.timeView) {
        [self.datePicker show];
    }else if(view == self.diseaseView){
        BioDiseaseTypeViewController *typeVc = [[BioDiseaseTypeViewController alloc]init];
        typeVc.selectDisease = self.model.disease;
        typeVc.remark = self.model.remark;
        __weak __typeof (self) weakSelf = self;
        typeVc.backData = ^(NSMutableArray *code, NSString *remark)  {
            weakSelf.model.disease = code;
            
            NSMutableArray * diseaseNameArr = [NSMutableArray array];
            NSMutableArray * diseaseCodeeArr = [NSMutableArray array];
            [code enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [diseaseNameArr addObject:[obj objectForKey:@"diseasesName"]];
                [diseaseCodeeArr addObject:[obj objectForKey:@"diseasesCode"]];
            }];
            NSString *diseaseName = [diseaseNameArr componentsJoinedByString:@" "];
             NSString *diseaseCode = [diseaseCodeeArr componentsJoinedByString:@","];
            self.diseaseView.detail = diseaseName;
            self.illnesCode = diseaseCode;
            self.otherDisease = remark;
        };
        [self.navigationController pushViewController:typeVc animated:YES];
    }
}


#pragma mark - request
#pragma mark --------=== 新增疾病史信息===--------
- (void)saveDiseaseInfoRequest{
    NSMutableArray *imageUrlList = [NSMutableArray array];
    [self.fileView.dataFile enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BioMineAddFileModel *model = (BioMineAddFileModel *)obj;
        [imageUrlList addObject:model.url];
    }];
    NSInteger addTime = [NSDate timeSwitchTimestamp:self.timeView.detail andFormatter:@"yyyy-MM-dd"];
    NSDictionary * params = @{
                              @"createUserId":BioStringIsNill([BioUserInfoManager userInfo].userId),
                              @"diseaseCode": [NSArray componentsSeparatedByStringNSInter:self.illnesCode],
                              @"diagnosisTime": [NSString stringWithFormat:@"%ld",addTime],
                              @"hospitalName": BioStringIsNill(self.hospitalView.detail),
                              @"otherDiseaseName": BioStringIsNill(self.otherDisease),
                              @"filePath": imageUrlList,
                              @"remark": BioStringIsNill(self.otherDisease)
                              };
//    NSLog(@"======%@",params);
    BioDiseaseSaveAPI * api = [[BioDiseaseSaveAPI alloc]initWithDiseaseParams:params];
     __weak typeof(self) weakSelf = self;
    [api startWithCompletion:^(BioAPIResponse *response) {
        if (response.success) {
            NSLog(@"%@",response);
            [BioProgressHUD showTextHUD:@"保存成功"];
            if ([weakSelf.delegate respondsToSelector:@selector(diseaseInfoSaveSucceed)]) {
                [weakSelf.delegate diseaseInfoSaveSucceed];
                 [self performSelector:@selector(popToViewController) withObject:nil afterDelay:0.0];
                            }
                }else{
                    [BioProgressHUD showTextHUD:response.msg];
                }
    }];
}

#pragma mark --------=== 刷新疾病史信息===-------- 
- (void)updateDiseaseInfoRequest{
    NSMutableArray *imageUrlList = [NSMutableArray array];
    [self.fileView.dataFile enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BioMineAddFileModel *model = (BioMineAddFileModel *)obj;
        [imageUrlList addObject:model.url];
    }];
    NSLog(@"新图片记录====%@ 老图片记录-----%@",imageUrlList,self.recordFilethPath);
    NSInteger addTime = [NSDate timeSwitchTimestamp:self.timeView.detail andFormatter:@"yyyy-MM-dd"];
    NSDictionary * params = @{
                              @"token":BioStringIsNill([BioUserInfoManager userInfo].token),
                              @"userId": BioStringIsNill([BioUserInfoManager userInfo].userId),
                              @"pastMedicalHistoryId": BioStringIsNill(self.model.pastMedicalHistoryId) ,
                              @"createUserId": BioStringIsNill([BioUserInfoManager userInfo].userId),
                              @"diseaseCode": [NSArray componentsSeparatedByStringNSInter:self.illnesCode],
                              @"diagnosisTime": [NSString stringWithFormat:@"%ld",addTime],
                              @"hospitalName": BioStringIsNill(self.hospitalView.detail),
                              @"otherDiseaseName": BioStringIsNill(self.otherDisease),
                              @"filePath": imageUrlList,
                              @"removedFilePath": self.recordFilethPath,
                              @"remark": BioStringIsNill(self.otherDisease)

                              };
  
 
    BioDiseeaseUpdateAPI * api = [[BioDiseeaseUpdateAPI alloc]initWithDiseaseUpdateParams:params];
    __weak typeof(self) weakSelf = self;
    [api startWithCompletion:^(BioAPIResponse *response) {
        if (response.success) {
               [BioProgressHUD showTextHUD:@"更新成功"];
            if ([weakSelf.delegate respondsToSelector:@selector(diseaseInfoSaveSucceed)]) {
                [weakSelf.delegate diseaseInfoSaveSucceed];
                             }
                  [self performSelector:@selector(popToViewController) withObject:nil afterDelay:0.5];
             }else{
                 [BioProgressHUD showTextHUD:response.msg];
             }
    }];
    
}

- (void)popToViewController{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
