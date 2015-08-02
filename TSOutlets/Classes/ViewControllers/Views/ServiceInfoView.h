//
//  ServiceInfoView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/10.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

@protocol ServiceInfoViewDelegate;

@interface ServiceInfoView : TempletView<UIScrollViewDelegate>

@property (weak,nonatomic)   id<ServiceInfoViewDelegate>      delegate;

- (void)getServiceInfoWithHTML:(NSString *)html;

@end

@protocol ServiceInfoViewDelegate <NSObject>

- (void)serviceInfoView:(ServiceInfoView *)serviceInfoView didStartDragScrollView:(UIScrollView *)scrollView;

@end
