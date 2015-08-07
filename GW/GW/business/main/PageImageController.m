//
//  PageImageController.m
//  GW
//
//  Created by wqw on 14/12/16.
//  Copyright (c) 2014年 Navinfo. All rights reserved.
//

#import "PageImageController.h"
#import "MainViewController.h"
#import "BaseNavigationController.h"
@interface PageImageController ()

@end

@implementation PageImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (id)initWithPageNumber:(NSInteger)num allCount:(NSInteger)allNum
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.PageImage = [[UIImageView alloc] initWithFrame:
                          CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
        self.PageImage.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:self.PageImage];
        if (num == allNum-1)
        {
            UIButton* skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
            skipButton.backgroundColor = [UIColor clearColor];
            [skipButton setImage:[UIImage imageNamed:@"guide_button"] forState:UIControlStateNormal];
            skipButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)/2-98/2, CGRectGetHeight(self.view.frame)-62, 98, 33);
            
            [skipButton addTarget:self action:@selector(skipButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:skipButton];

        }
    }
    return self;
}

- (void)skipButton:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    MainViewController *manView =   [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil];
    BaseNavigationController *oNavigation = [[BaseNavigationController alloc]initWithRootViewController:manView];
    [manView release];
    
    oNavigation.navigationBar.translucent = NO;
    oNavigation.navigationBar.barStyle = UIBarStyleBlack;
    [self presentViewController:oNavigation animated:NO completion:nil];
    
    [oNavigation release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
