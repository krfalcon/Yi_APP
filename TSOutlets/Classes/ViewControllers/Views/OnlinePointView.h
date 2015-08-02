//
//  OnlinePointView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/20.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"

@protocol OnlinePointViewDelegate;

@interface OnlinePointView : TempletView <UIScrollViewDelegate>

@property (weak, nonatomic) id<OnlinePointViewDelegate>             delegate;

- (void)getInfo:(NSObject *)memberEntity;

@end

@protocol OnlinePointViewDelegate <NSObject>

- (void)scrollViewDidScroll;
- (void)onlinePointViewDidTapDetailButton;

@end
