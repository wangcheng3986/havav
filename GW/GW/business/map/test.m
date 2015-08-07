//
//  test.m
//  GW
//
//  Created by wqw on 14/11/27.
//  Copyright (c) 2014年 Navinfo. All rights reserved.
//

#import "test.h"

@interface test ()

@end

@implementation test

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setMapView:_mapView];
    self.LongPressure =NO;
    [self loadMapBaseParameter];
    [_mapView initDataDic];
    
    
    
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
