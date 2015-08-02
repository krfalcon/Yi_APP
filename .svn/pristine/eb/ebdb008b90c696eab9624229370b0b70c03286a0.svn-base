//
//  CarouselScrollView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/25.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDIncrementalImageView.h"

@interface CarouselScrollView : UIView<UIScrollViewDelegate>
{
    float                                               scale;
    int                                                 count;
    
    UIScrollView*                                       carouselScroll;
    UIView*                                             pageView;
    UIImageView*                                        currentPageView;
}

- (id)initWithFrame:(CGRect)frame andImages:(NSArray *)array andTheme:(NSString *)theme;

@property(nonatomic, weak) NSTimer *timer;
@property(nonatomic, weak) NSArray *array;

- (void)addTimer;
- (void)deleteTimer;

@end
