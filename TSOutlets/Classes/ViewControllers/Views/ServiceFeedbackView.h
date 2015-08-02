//
//  ServiceFeedbackView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/3.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"
#import "FeedbackEntity.h"

@protocol ServiceFeedbackViewDelegate;

@interface ServiceFeedbackView : TempletView<UIActionSheetDelegate, UIScrollViewDelegate>
{
    UIScrollView *feedbackScrollView;
}

@property (weak,nonatomic)   id<ServiceFeedbackViewDelegate>          delegate;

- (void)createFeedbackScrollWithArray:(NSArray *)array;
- (void)refreshFeedbackScrollWithArray:(NSArray *)array;

@end

@protocol ServiceFeedbackViewDelegate <NSObject>

- (void)serviceFeedbackView:(ServiceFeedbackView *)serviceFeedbackView didStartDragScrollView:(UIScrollView *)scrollView;
- (void)serviceFeedbackViewDidTapFeedbackButton;
- (void)serviceFeedbackViewDidRefresh;

@end