//
//  ServiceViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/3.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ServiceViewController.h"

@interface ServiceViewController ()

@end

@implementation ServiceViewController

- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    serviceCustomView = [[ServiceCustomView alloc] initWithFrame:self.view.bounds];
    //eventMallView.eventListArray = [ArticleCoreDataHelper getEventList];
    [serviceCustomView setDelegate:self];
    [self.view addSubview:serviceCustomView];
    
    [[SingleCase singleCase].coredataOperationQueue addOperationWithBlock:^{
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [serviceCustomView getServiceTrafficWithHTML:[ArticleCoreDataHelper getServiceQA]];
        }];
    }];
    
    self.currentView = serviceCustomView;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldRecordLog" object:@"Service List"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(postFeedbackWithFeedback:) name:@"postFeedback" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFeedback:) name:@"getFeedbackList" object:nil];
}

#pragma mark - Norification
- (void)postFeedbackWithFeedback:(NSNotification *)noti {
    ServiceAPITool *sat = [[ServiceAPITool alloc] init];
    [sat postFeedback:noti.object];
}

- (void)getFeedback:(NSNotification *)noti {
    [serviceFeedbackView refreshFeedbackScrollWithArray:noti.object];
}


#pragma mark - Views Delegate 

- (void)serviceInfoView:(ServiceInfoView *)serviceInfoView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)serviceTrafficView:(ServiceTrafficView *)serviceTrafficView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)serviceCustomView:(ServiceCustomView *)serviceCustomView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)serviceFeedbackView:(ServiceFeedbackView *)serviceFeedbackView didStartDragScrollView:(UIScrollView *)scrollView {
    [self wheelViewShouldHide];
}

- (void)serviceCustomViewDidTapReplyButton {
    [self pushViewControllerWithViewControllerType:ViewControllerTypeReply andParameter:nil];
}

- (void)serviceFeedbackViewDidTapFeedbackButton {
    [self didTappedEditViewWithTpye:3 andMemberEntity:nil];
}

- (void)serviceFeedbackViewDidRefresh {
    ServiceAPITool *sat = [[ServiceAPITool alloc] init];
    //[serviceFeedbackView refreshFeedbackScrollWithArray:[sat getLoaclFeedback]];
    [sat getAllFeedback];
}

#pragma mark - Wheel View

- (void)wheelViewTappedButton1 {
    [self popToIndexViewController];
}

- (void)wheelViewTappedButton2 {
    if (!serviceTrafficView) {
        serviceTrafficView = [[ServiceTrafficView alloc] initWithFrame:self.view.bounds];
        [serviceTrafficView setAlpha:0];
        [serviceTrafficView setDelegate:self];
        [self.view addSubview:serviceTrafficView];
        
        [[SingleCase singleCase].coredataOperationQueue addOperationWithBlock:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [serviceTrafficView getServiceTrafficWithHTML:[ArticleCoreDataHelper getServiceTraffic]];
            }];
        }];
    }
    
    self.nextView = serviceTrafficView;
    [self showNextView];
}

- (void)wheelViewTappedButton3 {
    if (!serviceInfoView) {
        serviceInfoView = [[ServiceInfoView alloc] initWithFrame:self.view.bounds];
        [serviceInfoView setAlpha:0];
        [serviceInfoView setDelegate:self];
        [self.view addSubview:serviceInfoView];
        
        [[SingleCase singleCase].coredataOperationQueue addOperationWithBlock:^{
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [serviceInfoView getServiceInfoWithHTML:[ArticleCoreDataHelper getServiceInfo]];
            }];
        }];
    }
    
    self.nextView = serviceInfoView;
    [self showNextView];
}

- (void)wheelViewTappedButton4 {
    self.nextView = serviceCustomView;
    [self showNextView];
}

- (void)wheelViewTappedButton5 {
    if (!serviceFeedbackView) {
        serviceFeedbackView = [[ServiceFeedbackView alloc] initWithFrame:self.view.bounds];
        [serviceFeedbackView setDelegate:self];
        [serviceFeedbackView setAlpha:0];
        [self.view addSubview:serviceFeedbackView];
        
//        ServiceAPITool *sat = [[ServiceAPITool alloc] init];
//        [serviceFeedbackView refreshFeedbackScrollWithArray:[sat getLoaclFeedback]];
//        [sat getAllFeedback];
    }
    
    self.nextView = serviceFeedbackView;
    [self showNextView];
}

@end
