//
//  GuideViewController.m
//  GW
//
//  Created by wqw on 14/12/16.
//  Copyright (c) 2014年 Navinfo. All rights reserved.
//

#import "GuideViewController.h"
#import "PageImageController.h"
#import "App.h"
@interface GuideViewController ()
{
    NSMutableArray *viewControllers;
    
}
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.coverList = [NSArray arrayWithObjects:
//                 @"map_cdp_ic",
//                 @"map_lpp_ic",
//                 @"message_vehicleDiagnosis_failure" , nil];
    //适配iphone4S
    enum SCREEN_SIZE   deviceSize = [App getScreenSize];
    if (deviceSize == SCREEN_SIZE_960_640)
    {
        self.coverList = [NSArray arrayWithObjects:
                          @"guide_start_1_4s",
                          @"guide_start_2_4s", nil];
    }
    else
    {
        self.coverList = [NSArray arrayWithObjects:
                          @"guide_start_1",
                          @"guide_start_2", nil];
    }

    NSUInteger numberPages = self.coverList.count;
    if (deviceSize == SCREEN_SIZE_960_640)
    {
        guideScrollView.contentSize = CGSizeMake(CGRectGetWidth(guideScrollView.frame)*numberPages, [UIScreen mainScreen].applicationFrame.size.height  );
    }
    else
    {
        guideScrollView.contentSize = CGSizeMake(CGRectGetWidth(guideScrollView.frame)*numberPages, CGRectGetHeight(guideScrollView.frame));
    }

    NSLog(@"guideScrollView.frame.size.height: %f",guideScrollView.frame.size.height);
    guideScrollView.scrollsToTop = NO;
    guideScrollView.pagingEnabled = YES;
    
    viewControllers = [[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < numberPages; i++)
    {
        [viewControllers addObject:[NSNull null]];
    }

    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
//    [self loadScrollViewWithPage:2];


    // Do any additional setup after loading the view from its nib.
}

- (void) loadScrollViewWithPage:(NSUInteger)page
{
    NSInteger indexCount = self.coverList.count;
    if (page >= indexCount)
        return;
    
    PageImageController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null])
    {
        controller = [[PageImageController alloc] initWithPageNumber:page allCount:indexCount];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
    }

    
    // 将controller控制器对应View添加到UIScrollView中
    if (controller.view.superview == nil)
    {
        CGRect frame = guideScrollView.frame;
        frame.origin.x = CGRectGetWidth(frame) * page;
        frame.origin.y = 0;
        // 设置该控制器对应的View的大小和位置
        controller.view.frame = frame;

        controller.PageImage.image = [UIImage imageNamed:[self.coverList objectAtIndex:page]];
        // 将controller控制器添加为当前控制器的子控制器。
        [self addChildViewController:controller];
        // 将controller控制器对应的View添加到UIScrollView中
        [guideScrollView addSubview:controller.view];
    }
    
}


#pragma mark -UIPageControl-Delegate
- (IBAction)chagePageView:(id)sender
{
    NSInteger page = [sender currentPage];
    // 创建一个CGRect对象，该CGRect区域代表了该UIScrollView将要显示的页
    CGRect bounds = guideScrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds) * page;
    bounds.origin.y = 0;
    // 控制UIScrollView滚动到指定区域
    [guideScrollView scrollRectToVisible:bounds animated:YES];
    
//    [self loadScrollViewWithPage:page - 1];
//    [self loadScrollViewWithPage:page];
//    [self loadScrollViewWithPage:page + 1];
}
#pragma mark -UIScrollViewDelegate
// 来自UIScrollViewDelegate的方法，当用户滚动UIScrollView后激发该方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = CGRectGetWidth(scrollView.frame);
    NSLog(@"scrollView.contentOffset.x: %f",scrollView.contentOffset.x);
    
    NSUInteger page = floor((scrollView.contentOffset.x
                             - pageWidth / 2) / pageWidth) + 1;
    
    pageControlView.currentPage = page;
    
//    [self loadScrollViewWithPage:page - 1];
//    [self loadScrollViewWithPage:page];
//    [self loadScrollViewWithPage:page + 1];
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

- (void)dealloc {
    [guideScrollView release];
    [pageControlView release];

    [_coverList release];
    [super dealloc];
}
- (void)viewDidUnload {
    [guideScrollView release];
    guideScrollView = nil;
    [pageControlView release];
    pageControlView = nil;

    [super viewDidUnload];
}
@end
