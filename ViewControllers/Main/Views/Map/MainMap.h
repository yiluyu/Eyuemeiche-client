//
//  MainMap.h
//  Eyuemeiche
//
//  Created by yu on 26/02/2018.
//  Copyright © 2018 yu. All rights reserved.
//

#import "YLYRootView.h"

#import <MAMapKit/MAMapKit.h>

@interface MainMap : YLYRootView

@property (nonatomic, readwrite, strong)MAMapView *mapView;

@end
