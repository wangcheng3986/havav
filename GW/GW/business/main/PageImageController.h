//
//  PageImageController.h
//  GW
//
//  Created by wqw on 14/12/16.
//  Copyright (c) 2014年 Navinfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageImageController : UIViewController
@property (retain, nonatomic) UIImageView* PageImage;
- (id)initWithPageNumber:(NSInteger)num allCount:(NSInteger)allNum;
@end
