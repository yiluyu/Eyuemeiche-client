//
//  AddCarVC.m
//  Eyuemeiche
//
//  Created by yu on 19/04/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "AddCarVC.h"
#import "MyInfoConfig.h"
#import "AddCarModel.h"

@interface AddCarVC ()
{
    
}

@property (nonatomic, readwrite, strong)UIScrollView *scrollView;

@property (nonatomic, readwrite, strong)YLYRootView *headerView;

@property (nonatomic, readwrite, strong)YLYRootButton *bottomBtn;

@end

@implementation AddCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加车辆";
    
    [self initBaseData];
    [self creatSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBaseData {
    
}

- (void)creatSubViews {
    [self creatScroll];
    [self creatHeader];
    [self creatBottom];
}

- (void)creatScroll {
    
}

- (void)creatHeader {
    
}

- (void)creatBottom {
    
}

@end
