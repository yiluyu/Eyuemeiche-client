//
//  MyInfoVC.m
//  Eyuemeiche
//
//  Created by yu on 16/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "MyInfoVC.h"
#import "MyInfoConfig.h"

@interface MyInfoVC ()

@property (nonatomic, readwrite, strong)MyInfoView *infoView;

@end

@implementation MyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.infoView = [[MyInfoView alloc] initWithFrame:CGRectZero];
    _infoView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [self.view addSubview:_infoView];
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    //block
    [self setInfoViewBlock];
    
    //发起请求
    [self requestMyInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)setInfoViewBlock {
    SELF_WEAK();
    //进入个人详情页
    _infoView.enterPersonalModifyBlcok = ^{
        [weakSelf enterMyInfoModifyVC];
    };
    
    //点击cell
    _infoView.myInfoCellClick = ^(NSIndexPath *indexPath) {
        [weakSelf enterCellVC:indexPath];
    };
    
    //退出登录
    _infoView.clickLogoutBlcok = ^{
        YLYLog(@"未完成 ------ 点击退出登录");
    };
    
    //点击钱包
    _infoView.clickMoneyBlcok = ^{
        [weakSelf enterMoneyVC];
    };
    //点击优惠券
    _infoView.clickCouponsBlcok = ^{
        [weakSelf enterCouponsVC];
    };
    //点击积分
    _infoView.clickPointsBlcok = ^{
        [weakSelf enterPointsVC];
    };
}

- (void)enterMoneyVC {
    WalletVC *nextVC = [[WalletVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

- (void)enterCouponsVC {
    YLYLog(@"未完成 ----- 进入优惠券页面");
}

- (void)enterPointsVC {
    [[YLYHelper shareHelper] showHudViewWithString:@"积分商城即将开放, 敬请期待!"];
    return;
}

//修改资料
- (void)enterMyInfoModifyVC {
    MyInfoModifyVC *nextVC = [[MyInfoModifyVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}
//车辆管理
- (void)enterCellVC:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        YLYLog(@"进入车辆管理");
        CarModifyVC *nextVC = [[CarModifyVC alloc] init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    
    if (indexPath.row == 1) {
        YLYLog(@"进入修改手机号");
        
    }
}


#pragma -mark 网络
- (void)requestMyInfo {
    YLYLog(@"未完成 ----- 我的详情网络请求");
    [_infoView refreshViewData:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
