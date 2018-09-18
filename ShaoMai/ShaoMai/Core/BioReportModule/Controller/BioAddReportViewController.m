//
//  BioAddReportViewController.m
//  BioEhealth
//
//  Created by MacBook on 17/3/29.
//  Copyright © 2017年 LouKit. All rights reserved.
//

#import "BioAddReportViewController.h"
#import "BioMineHealthHistoryDetailItemView.h"
#import <BioTool/BioDatePickerView.h>
#import "BioMineAddFileView.h"
#import "BioHealthFilesRecordInfoView.h"
#import "BioMineAddFileModel.h"
#import "TZImagePickerController.h"
#import "BioSavePhysicalExamRecordAPI.h"
#import "BioUpdatePhysicalExamRecordAPI.h"
#import "BioTextView.h"
@interface BioAddReportViewController ()<BioMineHealthHistoryDetailItemViewDelegate,TZImagePickerControllerDelegate,BioMineAddFileViewDelegate>
{
    UIImageView * bgView;
}
@property (nonatomic, strong) BioMineHealthHistoryDetailItemView *timeView;
@property (nonatomic, strong) BioMineHealthHistoryDetailItemView *organizationView;
@property (nonatomic, strong) BioMineHealthHistoryDetailItemView *physicalDescription;
@property (nonatomic, strong) BioDatePickerView *datePicker;
@property (nonatomic, strong) BioMineAddFileView *fileView;
@property (nonatomic, strong) BioHealthFilesRecordInfoView *recordInfoView;
@property (nonatomic, strong) BioTextView * textView;
@property(nonatomic,strong) NSArray *recoredFilePath;

@end

@implementation BioAddReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareUI];
    
    if (self.model) {
        [self addRecordInfoView];
        __weak __typeof(self) weakSelf = self;
        self.fileView.AddFileImageHeight = ^(CGFloat height) {
            weakSelf.recordInfoView.frame =CGRectMake(0, CGRectGetMaxY(self->bgView.frame)+80 +height, weakSelf.view.width, weakSelf.view.height-CGRectGetMaxY(weakSelf.fileView.frame)-BioH(140));
            
        };
    }
//    此处判断是医师端添加记录还是自己天添加的记录，医生端天添加的记录只展示，不可以修改
    if(self.model){
        if(![self.model.createUserName isEqualToString:BioStringIsNill([BioUserInfoManager userInfo].name)]){
            self.addBtn.hidden = YES;
            self.timeView.userInteractionEnabled = NO;
            self.organizationView.userInteractionEnabled = NO;
            self.physicalDescription.userInteractionEnabled = NO;
            self.fileView.hideDelete = YES;
        }
    }
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
}

- (void)addBtnClicked{
    if (self.timeView.detail.length == 0) {
        [self.view makeToast:@"请填写体检时间" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if(self.fileView.dataFile.count == 0){
        [self.view makeToast:@"请上传体检报告照片" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    if(self.textView.text.length == 0){
        [self.view makeToast:@"请填写体检描述" duration:1.0 position:CSToastPositionCenter];
        return;
    }
    
    if (self.model) {
        [self updateReportInfoRequest];
    }else{
        [self saveReportInfoRequest];
    }
}

- (void)prepareUI{
    
    UIView *marginView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarH+kStatusBarH, self.view.bounds.size.width, BioH(BioMargin))];
    marginView.backgroundColor = BioBgColor;
    [self.view addSubview:marginView];
    
    //体检时间
    self.timeView = [[BioMineHealthHistoryDetailItemView alloc]init];
     self.timeView.frame=CGRectMake(0, CGRectGetMaxY(marginView.frame), self.view.bounds.size.width, BioW(40));
    self.timeView.delegate = self;
    self.timeView.title = @"体检时间";
    self.timeView.detail = (long*)self.model.creationDate==nil?@"":[NSDate dateWithTimeIntervalString:(long)self.model.physicalExamDate dateFormat:@"yyyy-MM-dd"];
    self.timeView.image = [UIImage imageNamed:@"required"];
    [self.view addSubview:self.timeView];
    
    //体检机构
    self.organizationView = [[BioMineHealthHistoryDetailItemView alloc]init];
    self.organizationView.frame= CGRectMake(0, CGRectGetMaxY(self.timeView.frame), self.view.bounds.size.width, BioW(40));
    self.organizationView.title = @"体检机构";
    self.organizationView.detail = self.model.physicalExamOrgName;
    self.organizationView.keyBoardType = UIKeyboardTypeDefault;
    self.organizationView.hidenArrow = YES;
    [self.view addSubview:self.organizationView];
    
    
    //备注
    bgView= [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.organizationView.frame), self.view.bounds.size.width, BioH(120))];
    bgView.image = [UIImage imageNamed:@"item_whtite_bg"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(BioW(BioMargin), BioW(BioMargin+5), BioH(10), BioH(10));
    imageView.center = CGPointMake(BioW(BioMargin+5), bgView.bounds.size.height/2);
    imageView.image = [UIImage imageNamed:@"required"];
    [bgView addSubview:imageView];
    UILabel * describle = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame), BioW(BioMargin+5), BioW(40), BioH(20))];
    describle.center = CGPointMake(BioW(BioMargin+BioH(40)), bgView.bounds.size.height/2);
    [bgView addSubview:describle];
    describle.text = @"描述:";
    self.textView = [[BioTextView alloc]init];
    self.textView.frame = CGRectMake(CGRectGetMaxX(describle.frame)+5, BioH(2*BioMargin), kScreenW-BioMargin*2-BioW(40)*2,bgView.bounds.size.height-BioH(4*BioMargin) );
    self.textView.backgroundColor = BioBgColor;
    self.textView.text = self.model.remark?:@"";
    [bgView addSubview:self.textView];
    
  
    
    //底部添加文件视图
    self.fileView = [[BioMineAddFileView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bgView.frame), self.view.bounds.size.width, BioH(200))];
    self.fileView.delegagte = self;
    [self.view addSubview:self.fileView];
    self.fileView.imgData = [self.model.filePath mutableCopy];
    self.recoredFilePath = self.model.filePath;
}

- (void)addRecordInfoView{
    self.recordInfoView = [[BioHealthFilesRecordInfoView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.fileView.frame), self.view.bounds.size.width, self.view.bounds.size.height-CGRectGetMaxY(self.fileView.frame)-BioH(140))];
   self.recordInfoView.name = self.model.createUserName;
    self.recordInfoView.time = self.model.creationDate;
    [self.view addSubview:self.recordInfoView];
}


- (BioDatePickerView *)datePicker{
    if (!_datePicker) {
        _datePicker = [[BioDatePickerView alloc]init];
        _datePicker.frame = [UIScreen mainScreen].bounds;
        __weak __typeof(self) weakSelf = self;
        _datePicker.title = @"体检时间";
        _datePicker.selectedDate = ^(NSString *date) {
        weakSelf.timeView.detail = date;
            
        };
    }
    return _datePicker;
}

#pragma mark --------=== 上传图片的代理方法===--------
- (void)BioMineAddFileImageNsinter:(NSInteger)inter{
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
#pragma mark - BioMineHealthHistoryDetailItemViewDelegate
- (void)bioMineHealthHistoryDetailItemViewDisClicked:(UIView *)view{
    if (view == self.timeView) {
         [self.datePicker show];
    }
       
}

#pragma mark - request
//新增体检报告
- (void)saveReportInfoRequest{
    NSMutableArray *imageUrlList = [NSMutableArray array];
    [self.fileView.dataFile enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BioMineAddFileModel *model = (BioMineAddFileModel *)obj;
        [imageUrlList addObject:model.url];
    }];
    NSInteger addTime = [NSDate timeSwitchTimestamp:self.timeView.detail andFormatter:@"yyyy-MM-dd"];
    NSDictionary * params = @{
                              @"userId": BioStringIsNill([BioUserInfoManager userInfo].userId),
                              @"createUserId":BioStringIsNill([BioUserInfoManager userInfo].userId),
                              @"physicalExamDate":[NSString stringWithFormat:@"%ld",addTime],
                              @"physicalExamOrgName":BioStringIsNill(self.organizationView.detail),
                              @"filePath":imageUrlList,
                              @"remark":BioStringIsNill(self.textView.text),
                              @"creationDate":[NSString stringWithFormat:@"%ld",addTime]                              };
    BioSavePhysicalExamRecordAPI * api = [[BioSavePhysicalExamRecordAPI alloc]initWithSavePhysicalExamRecordParams:params ];
    [api startWithCompletion:^(BioAPIResponse *response) {
        if(response.success){
            [BioProgressHUD showTextHUD:@"保存成功"];
            __weak __typeof(self) weakself = self;
            if ([weakself.delegate respondsToSelector:@selector(reportInfoSaveSucceed)]) {
                [weakself.delegate reportInfoSaveSucceed];
            }
            [self performSelector:@selector(popToViewController) withObject:nil afterDelay:0.0];
        }else{
            [BioProgressHUD showTextHUD:response.msg];
        }
    }];
}

//更新体检报告
- (void)updateReportInfoRequest{
    NSMutableArray *imageUrlList = [NSMutableArray array];
    [self.fileView.dataFile enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BioMineAddFileModel *model = (BioMineAddFileModel *)obj;
        [imageUrlList addObject:model.url];
    }];
    NSInteger addTime = [NSDate timeSwitchTimestamp:self.timeView.detail andFormatter:@"yyyy-MM-dd"];
    NSDictionary * params = @{
                              @"createUserId":BioStringIsNill([BioUserInfoManager userInfo].userId),
                              @"physicalExamDate":[NSString stringWithFormat:@"%ld",addTime],
                              @"physicalExamOrgName":BioStringIsNill(self.organizationView.detail),
                              @"filePath":imageUrlList,
                              @"remark":BioStringIsNill(self.textView.text),
                              @"removedFilePath":self.recoredFilePath,
                              @"physicalExamReportId":BioStringIsNill(self.model.physicalExamReportId),
                              };
    BioUpdatePhysicalExamRecordAPI * api = [[BioUpdatePhysicalExamRecordAPI alloc]initWithUpdatePhysicalExamRecordParams:params ];
    [api startWithCompletion:^(BioAPIResponse *response) {
        if(response.success){
              [BioProgressHUD showTextHUD:@"更新成功"];
            __weak __typeof(self) weakself = self;
            if ([weakself.delegate respondsToSelector:@selector(reportInfoSaveSucceed)]) {
                [weakself.delegate reportInfoSaveSucceed];
            }
            [self performSelector:@selector(popToViewController) withObject:nil afterDelay:0.0];
        }else{
            [BioProgressHUD showTextHUD:response.msg];
        }
    }];
}

- (void)popToViewController{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
