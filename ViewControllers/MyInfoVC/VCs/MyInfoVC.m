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
    SELF_WEAK();
    //进入个人详情页
    _infoView.enterPersonalModifyBlcok = ^{
        [weakSelf enterMyInfoModifyVC];
    };
    
    //点击cell
    _infoView.myInfoCellClick = ^(NSIndexPath *indexPath) {
        YLYLog(@"未完成 ------ 点击cell %@", indexPath);
    };
    
    //退出登录
    _infoView.clickLogoutBlcok = ^{
        YLYLog(@"未完成 ------ 点击退出登录");
    };
    
    //发起请求
    [self requestMyInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//修改资料
- (void)enterMyInfoModifyVC {
    MyInfoModifyVC *nextVC = [[MyInfoModifyVC alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
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
