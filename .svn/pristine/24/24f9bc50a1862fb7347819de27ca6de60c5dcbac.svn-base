//
//  GuideViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    guideScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [guideScrollView setContentSize:CGSizeMake(guideScrollView.frame.size.width, guideScrollView.frame.size.height * 5)];
    [guideScrollView setShowsVerticalScrollIndicator:NO];
    [guideScrollView setBounces:NO];
    [guideScrollView setPagingEnabled:YES];
    [guideScrollView setDelegate:self];
    [guideScrollView setTag:0];
    [self.view addSubview:guideScrollView];
    
    UIImageView *guideImage1 = [[UIImageView alloc] initWithFrame:guideScrollView.bounds];
    [guideImage1 setImage:[UIImage imageNamed:@"GuideView_1"]];
    [guideImage1 setContentMode:UIViewContentModeScaleAspectFill];
    [guideImage1 setClipsToBounds:YES];
    [guideScrollView addSubview:guideImage1];
    
    UIImageView *guideImage2 = [[UIImageView alloc] initWithFrame:(CGRect){0, guideScrollView.frame.size.height * 1, guideScrollView.frame.size}];
    [guideImage2 setImage:[UIImage imageNamed:@"GuideView_2"]];
    [guideImage2 setContentMode:UIViewContentModeScaleAspectFill];
    [guideImage2 setClipsToBounds:YES];
    [guideScrollView addSubview:guideImage2];
    
    UIImageView *guideImage3 = [[UIImageView alloc] initWithFrame:(CGRect){0, guideScrollView.frame.size.height * 2, guideScrollView.frame.size}];
    [guideImage3 setImage:[UIImage imageNamed:@"GuideView_3"]];
    [guideImage3 setContentMode:UIViewContentModeScaleAspectFill];
    [guideImage3 setClipsToBounds:YES];
    [guideScrollView addSubview:guideImage3];
    
    UIImageView *guideImage4 = [[UIImageView alloc] initWithFrame:(CGRect){0, guideScrollView.frame.size.height * 3, guideScrollView.frame.size}];
    [guideImage4 setImage:[UIImage imageNamed:@"GuideView_4"]];
    [guideImage4 setContentMode:UIViewContentModeScaleAspectFill];
    [guideImage4 setClipsToBounds:YES];
    [guideScrollView addSubview:guideImage4];
    
    UIView *pager1 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 2.5f, self.view.frame.size.height * 0.09f, 5, 5)];
    pager1.layer.cornerRadius = pager1.frame.size.height / 2;
    [pager1 setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [pager1 setTag:1];
    [self.view addSubview:pager1];
    
    UIView *pager2 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 2.5f, self.view.frame.size.height * 0.12f, 5, 5)];
    pager2.layer.cornerRadius = pager2.frame.size.height / 2;
    [pager2 setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [pager2 setAlpha:0.5];
    [pager2 setTag:2];
    [self.view addSubview:pager2];
    
    UIView *pager3 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 2.5f, self.view.frame.size.height * 0.15f, 5, 5)];
    pager3.layer.cornerRadius = pager3.frame.size.height / 2;
    [pager3 setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [pager3 setAlpha:0.5];
    [pager3 setTag:3];
    [self.view addSubview:pager3];
    
    UIView *pager4 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 2.5f, self.view.frame.size.height * 0.18f, 5, 5)];
    pager4.layer.cornerRadius = pager4.frame.size.height / 2;
    [pager4 setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    [pager4 setAlpha:0.5];
    [pager4 setTag:4];
    [self.view addSubview:pager4];
    
    guideDirect = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 25.f, self.view.frame.size.height * 0.88f, 50, 32)];
    [guideDirect setImage:[UIImage imageNamed:@"GuideDirect"]];
    [guideDirect setAlpha:0];
    [self.view addSubview:guideDirect];
    
    [UIView animateWithDuration:2.f delay:0.f options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionRepeat animations:^{
        [guideDirect setAlpha:1];
        guideDirect.transform = CGAffineTransformMakeTranslation(0, 20);
    } completion:^(BOOL finished) {
    }];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tiktok) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    } else if (scrollView.contentOffset.y < scrollView.frame.size.height * 0.5) {
        [[self.view viewWithTag:1] setAlpha:1];
        [[self.view viewWithTag:2] setAlpha:0.5];
        [[self.view viewWithTag:3] setAlpha:0.5];
        [[self.view viewWithTag:4] setAlpha:0.5];
    } else if (scrollView.contentOffset.y < scrollView.frame.size.height * 1.5) {
        [[self.view viewWithTag:1] setAlpha:0.5];
        [[self.view viewWithTag:2] setAlpha:1];
        [[self.view viewWithTag:3] setAlpha:0.5];
        [[self.view viewWithTag:4] setAlpha:0.5];
    } else if (scrollView.contentOffset.y < scrollView.frame.size.height * 2.5) {
        [[self.view viewWithTag:1] setAlpha:0.5];
        [[self.view viewWithTag:2] setAlpha:0.5];
        [[self.view viewWithTag:3] setAlpha:1];
        [[self.view viewWithTag:4] setAlpha:0.5];
    } else if (scrollView.contentOffset.y < scrollView.frame.size.height * 3.5) {
        [[self.view viewWithTag:1] setAlpha:0.5];
        [[self.view viewWithTag:2] setAlpha:0.5];
        [[self.view viewWithTag:3] setAlpha:0.5];
        [[self.view viewWithTag:4] setAlpha:1];
    } else {
        [[self.view viewWithTag:1] setAlpha:0];
        [[self.view viewWithTag:2] setAlpha:0];
        [[self.view viewWithTag:3] setAlpha:0];
        [[self.view viewWithTag:4] setAlpha:0];
        [guideDirect setAlpha:0];
    }
    
    [timer invalidate];
    timer = nil;
    
    if (scrollView.contentOffset.y == scrollView.frame.size.height * 4) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(tiktok) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= scrollView.frame.size.height * 3) {
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tiktok) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= scrollView.frame.size.height * 3) {
        timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(tiktok) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}

- (void)tiktok {
    [timer invalidate];
    timer = nil;
    
    if (guideScrollView.contentOffset.y < guideScrollView.frame.size.height * 0.5) {
        [guideScrollView setContentOffset:CGPointMake(0, guideScrollView.frame.size.height * 1) animated:YES];
    } else if (guideScrollView.contentOffset.y < guideScrollView.frame.size.height * 1.5) {
        [guideScrollView setContentOffset:CGPointMake(0, guideScrollView.frame.size.height * 2) animated:YES];
    } else if (guideScrollView.contentOffset.y < guideScrollView.frame.size.height * 2.5) {
        [guideScrollView setContentOffset:CGPointMake(0, guideScrollView.frame.size.height * 3) animated:YES];
    } else if (guideScrollView.contentOffset.y < guideScrollView.frame.size.height * 3.5) {
        [guideScrollView setContentOffset:CGPointMake(0, guideScrollView.frame.size.height * 4) animated:YES];
    } else if (guideScrollView.contentOffset.y == guideScrollView.frame.size.height * 4 && self){
        [self.view removeFromSuperview];
        [self willMoveToParentViewController:nil];
        [self removeFromParentViewController];
    }
}

@end
