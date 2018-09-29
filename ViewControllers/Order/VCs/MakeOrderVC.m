//
//  MakeOrderVC.m
//  Eyuemeiche
//
//  Created by yu on 2018/5/22.
//  Copyright © 2018 yu. All rights reserved.
//

#import "MakeOrderVC.h"
#import "MakeOrderConfig.h"

@interface MakeOrderVC () <UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    CGFloat scale;
    
    NSArray *baseArray;//基本信息数组
    NSInteger carNoIndex;//服务车辆下标
    
    NSMutableArray *serviceArray;//洗车服务数组
    
    NSMutableArray *photoArray;//照片数组
    
    NSArray *tableData;//table数组
}

@property (nonatomic, readwrite, strong)UITableView *tableView;
@property (nonatomic, readwrite, strong)MakeOrderFootView *footerView;//照片模块
@property (nonatomic, readwrite, strong)MakeOrderBottomView *bottomView;

@end

@implementation MakeOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = (self.type == kNormalType)?@"创建订单":@"预约订单";
    
    scale = [BootUnit shareUnit].rate;
    
    [self initBaseData];
    [self createSubViews];
    [self sendRequests];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setNavigationBarStyle];
}

//设置导航
- (void)setNavigationBarStyle {
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark data
- (void)initBaseData {
    carNoIndex = -1;//未选择
    
    [self firstViewData];
    [self secondViewData];
    [self thirdViewData];
    
    tableData = @[baseArray, serviceArray];
}

- (void)firstViewData {
    //基本信息
    NSMutableArray *tempArr = [[NSMutableArray alloc] initWithCapacity:0];
    //服务车辆
    MakeOrderBaseModel *serviceCarModel = [[MakeOrderBaseModel alloc] init];
    serviceCarModel.icon = @"icon_makeOrder_服务车辆";
    serviceCarModel.title = @"服务车辆";
    serviceCarModel.detail = @"请选择";
    [tempArr addObject:serviceCarModel];
    //车辆位置数据
    MakeOrderBaseModel *locationModel = [[MakeOrderBaseModel alloc] init];
    locationModel.icon = @"icon_makeOrder_车辆位置";
    locationModel.title = @"车辆位置";
    locationModel.detail = @"北京朝阳区花佳怡小区";//self.baseDict[@"address"];
    [tempArr addObject:locationModel];
    baseArray = [NSArray arrayWithArray:tempArr];
    
    if (self.type == kReserveType) {
        //预约时间
        MakeOrderBaseModel *timeModel = [[MakeOrderBaseModel alloc] init];
        timeModel.icon = @"icon_makeOrder_预约时间";
        timeModel.title = @"预约时间";
        timeModel.detail = @"请选择洗车时间";
        [tempArr addObject:timeModel];
        baseArray = [NSArray arrayWithArray:tempArr];
    }
}

- (void)secondViewData {
    //洗车服务
    serviceArray = [[NSMutableArray alloc] initWithCapacity:0];
    MakeOrderContentModel *waiguanModel = [[MakeOrderContentModel alloc] init];
    waiguanModel.icon = @"icon_makeOrderVC_清洗外观";
    waiguanModel.title = @"清洗外观";
    waiguanModel.detail = @"￥20.00";
    [serviceArray addObject:waiguanModel];
    
    MakeOrderSelectModel *clearAirConditionerModel = [[MakeOrderSelectModel alloc] init];
    clearAirConditionerModel.selected = NO;
    clearAirConditionerModel.icon = @"icon_makeOrderVC_清洁空调管道和消毒";
    clearAirConditionerModel.title = @"清洁空调管道和消毒";
    clearAirConditionerModel.detail = @"￥20.00";
    [serviceArray addObject:clearAirConditionerModel];
    
    MakeOrderSelectModel *clearInnerModel = [[MakeOrderSelectModel alloc] init];
    clearInnerModel.selected = NO;
    clearInnerModel.icon = @"icon_makeOrderVC_室内干洗和皮革护理";
    clearInnerModel.title = @"室内干洗和皮革护理";
    clearInnerModel.detail = @"￥100.00";
    [serviceArray addObject:clearInnerModel];
    
    MakeOrderSelectModel *waxingModel = [[MakeOrderSelectModel alloc] init];
    waxingModel.selected = NO;
    waxingModel.icon = @"icon_makeOrderVC_整车打蜡";
    waxingModel.title = @"整车打蜡";
    waxingModel.detail = @"￥50.00";
    [serviceArray addObject:waxingModel];
    
    MakeOrderSelectModel *clearEngineModel = [[MakeOrderSelectModel alloc] init];
    clearEngineModel.selected = NO;
    clearEngineModel.icon = @"icon_makeOrderVC_清洗发动机";
    clearEngineModel.title = @"清洗发动机";
    clearEngineModel.detail = @"￥200.00";
    [serviceArray addObject:clearEngineModel];
}

- (void)thirdViewData {
    //照片
    
    
}

#pragma -mark views
- (void)createSubViews {
    [self createBottomView];
    [self createTableView];
    [self createFooterView];
}

- (void)createTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                  style:UITableViewStyleGrouped];
    _tableView.backgroundColor = COLOR_VC_BG;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[MakeOrderContentCell class]
       forCellReuseIdentifier:@"MakeOrderContentCell"];
    [_tableView registerClass:[MakeOrderSelectCell class]
       forCellReuseIdentifier:@"MakeOrderSelectCell"];
    [_tableView registerClass:[MakeOrderBaseCell class]
       forCellReuseIdentifier:@"MakeOrderBaseCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(_bottomView.mas_top).offset(0);
    }];
}

- (void)createFooterView {
    YLYRootView *back = [[YLYRootView alloc] initWithFrame:YLY6Rect(0, 0, 375, 312)];
    self.footerView = [[MakeOrderFootView alloc] initWithFrame:YLY6Rect(0, 0, 375, 312)];
    [back addSubview:_footerView];
    
    _tableView.tableFooterView = back;
    
    SELF_WEAK();
    //触发事件
    _footerView.addPhotoClickBlock = ^ {
        YLYLog(@"调起图片controller");
        [weakSelf photoAlertClick];
    };
    
}

- (void)createBottomView {
    self.bottomView = [[MakeOrderBottomView alloc] init];
    [self.view addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-SAFETY_AREA_HEIGHT);
        make.height.mas_equalTo(56*scale);
    }];
    
    SELF_WEAK();
    _bottomView.makeOrderClick = ^{
        [weakSelf pushOrderConfirmVC];
    };
}

#pragma -mark tableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FIT(62);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;//不设置则默认使用header高度
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *backView = [[UIView alloc] initWithFrame:YLY6Rect(0, 0, 750, 62)];
    backView.backgroundColor = COLOR_CLEAR;
    
    MakeOrderHeaderItem *header = [[MakeOrderHeaderItem alloc] init];
    [backView addSubview:header];
    [header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(FIT(51));
    }];
    if (section == 0) {
        header.iconImage.image = [UIImage imageNamed:@"icon_makeOrderVC_基本信息"];
        header.titleLabel.text = @"基本信息";
    }
    if (section == 1) {
        header.iconImage.image = [UIImage imageNamed:@"icon_makeOrderVC_洗车服务"];
        header.titleLabel.text = @"洗车服务";
    }
    
    return backView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FIT(56);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //基本信息
    if (indexPath.section == 0) {
        MakeOrderBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MakeOrderBaseCell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[MakeOrderBaseCell alloc] initWithStyle:UITableViewCellStyleValue2
                                            reuseIdentifier:@"MakeOrderBaseCell"];
        }
        if (indexPath.row == 1) {
            [cell showArrow:NO];
        } else {
            [cell showArrow:YES];
        }
        MakeOrderBaseModel *model = [baseArray objectAtIndex:indexPath.row];
        [cell refreshModel:model];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    //洗车服务
    if (indexPath.section == 1) {
        //外观清洗
        if (indexPath.row == 0) {
            MakeOrderContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MakeOrderContentCell" forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[MakeOrderContentCell alloc] initWithStyle:UITableViewCellStyleValue2
                                                   reuseIdentifier:@"MakeOrderContentCell"];
            }
            MakeOrderContentModel *model = serviceArray[indexPath.row];
            [cell refreshModel:model];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            //多选项
            MakeOrderSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MakeOrderSelectCell" forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[MakeOrderSelectCell alloc] initWithStyle:UITableViewCellStyleValue2
                                                  reuseIdentifier:@"MakeOrderSelectCell"];
            }
            MakeOrderSelectModel *model = serviceArray[indexPath.row];
            [cell refreshModel:model];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            YLYLog(@"选择车辆");
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row > 0) {
            MakeOrderSelectModel *clickModel = serviceArray[indexPath.row];
            clickModel.selected = !clickModel.selected;
            
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            YLYLog(@"%ld-%ld", indexPath.section, indexPath.row);
        }
    }
    
}

#pragma -mark 方法


#pragma -mark 交互
//进入订单确认页
- (void)pushOrderConfirmVC {
    //判断是否选择车牌
//    if (carNoIndex == -1) {
//        [[YLYHelper shareHelper] showHudViewWithString:@"请先选择车辆!"];
//        return;
//    }
    
    OrderConfirmVC *nextVC = [[OrderConfirmVC alloc] init];
    //重新组合数据
    NSMutableArray *nextBaseArray = [[NSMutableArray alloc] initWithCapacity:baseArray.count];
    for (NSInteger i = 0; i < baseArray.count; i ++) {
        MakeOrderBaseModel *model = baseArray[i];
        MakeOrderContentModel *nextModel = [[MakeOrderContentModel alloc] init];
        nextModel.icon = model.icon;
        nextModel.title = model.title;
        nextModel.detail = model.detail;
        
        [nextBaseArray addObject:nextModel];
    }
    NSMutableArray *nextServiceArray = [[NSMutableArray alloc] initWithCapacity:serviceArray.count];
    for (NSInteger i = 0; i < serviceArray.count; i ++) {
        if (i == 0) {
            MakeOrderContentModel *model = serviceArray[i];
            [nextServiceArray addObject:model];
        } else {
            MakeOrderSelectModel *selectModel = serviceArray[i];
            //是否勾选
            if (selectModel.selected == NO) {
                continue;
            }
            
            MakeOrderContentModel *nextModel = [[MakeOrderContentModel alloc] init];

            nextModel.icon = selectModel.icon;
            nextModel.title = selectModel.title;
            nextModel.detail = selectModel.detail;
            
            [nextServiceArray addObject:nextModel];
        }
    }
    
    nextVC.baseArray = nextBaseArray;
    nextVC.serviceArray = nextServiceArray;
    [self.navigationController pushViewController:nextVC animated:YES];
}

//打开图片选择
- (void)photoAlertClick {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    // 设置代理
    imagePickerController.delegate = self;
    // 是否允许编辑（默认为NO）
    imagePickerController.allowsEditing = YES;
    
    // 创建一个警告控制器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    // 设置警告响应事件
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 设置照片来源为相机
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        // 设置进入相机时使用前置或后置摄像头
        imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        // 展示选取照片控制器
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];
    UIAlertAction *photosAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // 添加警告按钮
        [alert addAction:cameraAction];
    }
    [alert addAction:photosAction];
    [alert addAction:cancelAction];
    // 展示警告控制器
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma -mark 照片控制器代理
// 完成图片的选取后调用的方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 选取完图片后跳转回原控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    /* 此处参数 info 是一个字典，下面是字典中的键值 （从相机获取的图片和相册获取的图片时，两者的info值不尽相同）
     * UIImagePickerControllerMediaType; // 媒体类型
     * UIImagePickerControllerOriginalImage; // 原始图片
     * UIImagePickerControllerEditedImage; // 裁剪后图片
     * UIImagePickerControllerCropRect; // 图片裁剪区域（CGRect）
     * UIImagePickerControllerMediaURL; // 媒体的URL
     * UIImagePickerControllerReferenceURL // 原件的URL
     * UIImagePickerControllerMediaMetadata // 当数据来源是相机时，此值才有效
     */
    // 从info中将图片取出，并加载到imageView当中
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //把照片传入控件进行显示
    [self.footerView showImageData:image];
    
//    // 创建保存图像时需要传入的选择器对象（回调方法格式固定）
//    SEL selectorToCall = @selector(image:didFinishSavingWithError:contextInfo:);
//    // 将图像保存到相册（第三个参数需要传入上面格式的选择器对象）
//    UIImageWriteToSavedPhotosAlbum(image, self, selectorToCall, NULL);
}

// 取消选取调用的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 保存图片后到相册后，回调的相关方法，查看是否保存成功
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil){
        YLYLog(@"Image was saved successfully.");
    } else {
        YLYLog(@"An error happened while saving the image.");
        YLYLog(@"Error = %@", error);
    }
}

#pragma -mark 请求
- (void)sendRequests {
    [self requestList];
}

- (void)requestList {
    
}

@end
