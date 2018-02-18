//
//  MainViewController.m
//  EDongMeiCheDemo
//
//  Created by yu on 30/10/2017.
//  Copyright © 2017 yu. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"

/* 跳转页面 */
#import "LoginViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //监听登陆状态
    [self addLoginNotificationObserver];
    
    //模拟登陆失败
    [self loginFaild];
    
    
    //场外群报价
//    [self giveMoney];
    
    
//    UIView *testView = [[UIView alloc] init];
//    testView.frame = YLY6Rect(10, 10, 200, 200);
//    testView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:testView];
//
//
//
//    YLYLog(@"%f, %f", SCREEN_WIDTH, SCREEN_HEIGHT);
    
    
    
    
    
}

#pragma -mark 报价
//报价
- (void)giveMoney {
    CGFloat BTCDollar = 13231;
    CGFloat ETHDollar = 1135.9;
    CGFloat dollarExchange = 6.495495;
    
    CGFloat BTCJPYen = 1627623;
    CGFloat ETHJPYen = 139657;
    CGFloat JPYenExchange = 0.058368;
    
    CGFloat otherGroupBTCPrice = 104000;
    CGFloat otherGroupETHPrice = 9000;
    
    CGFloat groupConductBTCPrice = otherGroupBTCPrice;
    CGFloat groupConductETHPrice = otherGroupETHPrice;
    
    NSString *ret = [NSString stringWithFormat:@"\n\n-------------------\n\n当前时间价格：\nBitfinex:BTC-%.1f元(%.0f刀), ETH-%.1f元(%.0f刀)\ncheckcoin:BTC-%.1f元(%0.f円),ETH-%.1f元(%.0f円)\n场外群成交价:BTC-%0.f元,ETH-%0.f元\n群内指导价:BTC-%0.f~%.0f元,ETH-%0.f~%.0f元\n\n-------------------", BTCDollar*dollarExchange, BTCDollar, ETHDollar*dollarExchange, ETHDollar, BTCJPYen*JPYenExchange, BTCJPYen, ETHJPYen*JPYenExchange, ETHJPYen, otherGroupBTCPrice, otherGroupETHPrice, groupConductBTCPrice-200, groupConductBTCPrice+100, groupConductETHPrice-20, groupConductETHPrice+10];
    
    YLYLog(@"%@", ret);
}



/* 事件 */


/* 功能方法 */
//监听登陆状态
- (void)addLoginNotificationObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(skipLoginVC)
                                                 name:@"skipLoginVC"
                                               object:nil];
    
}

//跳转登陆页
- (void)skipLoginVC {
    YLYPropertyManager *propertyManager = [YLYPropertyManager sharePropertyManager];
    if (propertyManager.loginVCShowing == YES) {
        return;
    } else {
        AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if (del.loginNavi == nil) {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            del.loginNavi = [[UINavigationController alloc] initWithRootViewController:loginVC];
            del.loginNavi.navigationBar.hidden = YES;
            del.loginNavi.navigationBar.translucent = NO;
        }
        
        [del.mainNavi presentViewController:del.loginNavi animated:YES completion:^{
            propertyManager.loginVCShowing = YES;
            [del.loginNavi popToRootViewControllerAnimated:NO];
        }];
        
    }
    
    
}

//登陆失败
- (void)loginFaild {
    //3秒后发起登陆失败
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"skipLoginVC" object:nil];
    });
}



/* VC机制 */
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
}


/* 内存释放 */
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
