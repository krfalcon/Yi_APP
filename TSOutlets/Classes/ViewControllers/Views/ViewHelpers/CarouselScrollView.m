//
//  CarouselScrollView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/25.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "CarouselScrollView.h"

@implementation CarouselScrollView

- (id)initWithFrame:(CGRect)frame andImages:(NSArray *)array andTheme:(NSString *)theme {
    self = [super initWithFrame:frame];
    if (self) {
        scale = self.frame.size.width / 375.f;
        
        count = (int)array.count;
        
        carouselScroll = [[UIScrollView alloc]initWithFrame:self.bounds];
        carouselScroll.contentSize = CGSizeMake(self.frame.size.width * (count + 1), self.frame.size.height - 20 * scale);
        carouselScroll.pagingEnabled = YES;
        carouselScroll.showsHorizontalScrollIndicator = NO;
        carouselScroll.delegate = self;
        [self addSubview:carouselScroll];
        
        if (count > 1) {
            
            pageView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - count * 18.f * scale + 1 * scale) / 2.f, self.frame.size.height - 19 * scale, count * 20.f * scale - 3 * scale, 20 * scale)];
            [self addSubview:pageView];
            
            for (int i = 0; i < count; i ++) {
                MDIncrementalImageView *imgView = [[MDIncrementalImageView alloc]init];
                imgView.frame = CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height - 20 * scale);
                imgView.showLoadingIndicatorWhileLoading = YES;
                [imgView setImageUrl:[NSURL URLWithString:[array objectAtIndex:i]]];
                [carouselScroll addSubview:imgView];
                
                UIImageView *pageImage = [[UIImageView alloc] initWithFrame:CGRectMake(20 * scale * i, 0, 19 * scale, 17 * scale)];
                [pageImage setImage:[UIImage imageNamed:@"Page_NotCurrent"]];
                if ([theme isEqualToString:@"Red"]) [pageImage setImage:[UIImage imageNamed:@"Page_NotCurrent_Red"]];
                [pageView addSubview:pageImage];
            }
            
            MDIncrementalImageView *imgView2 = [[MDIncrementalImageView alloc]init];
            imgView2.frame = CGRectMake(count * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height - 20 * scale);
            imgView2.showLoadingIndicatorWhileLoading = YES;
            [imgView2 setImageUrl:[NSURL URLWithString:[array objectAtIndex:0]]];
            [carouselScroll addSubview:imgView2];
            
            currentPageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 19 * scale, 17 * scale)];
            [currentPageView setImage:[UIImage imageNamed:@"Page_Current"]];
            if ([theme isEqualToString:@"Red"]) [currentPageView setImage:[UIImage imageNamed:@"Page_Current_Red"]];
            [pageView addSubview:currentPageView];
            
            [self addTimer];
        } else if (count > 0) {
            carouselScroll.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height - 20 * scale);
            MDIncrementalImageView *imgView = [[MDIncrementalImageView alloc]init];
            imgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 20 * scale);
            imgView.showLoadingIndicatorWhileLoading = YES;
            [imgView setImageUrl:[NSURL URLWithString:[_array objectAtIndex:0]]];
            [carouselScroll addSubview:imgView];
        } else {
            [self setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 0)];
        }
    }
    return self;
}
//添加定时器方法
- (void) addTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    //返回当前的消息循环对象
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
//删除定时器方法
- (void) deleteTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)nextPage {
    int page = 0;
    
    if (carouselScroll.contentOffset.x >= self.frame.size.width * count) {
        page = 0;
    }else{
        page = carouselScroll.contentOffset.x / self.frame.size.width + 1;
    }
    CGFloat offsetX = page * carouselScroll.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [carouselScroll setContentOffset:offset animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"%f",scrollView.contentOffset.x);
    if (carouselScroll.contentOffset.x >= count * carouselScroll.frame.size.width) {
        carouselScroll.contentOffset = CGPointMake(fabs(carouselScroll.contentOffset.x - count * carouselScroll.frame.size.width), 0);
    } else if (carouselScroll.contentOffset.x < 0) {
        carouselScroll.contentOffset = CGPointMake(carouselScroll.contentOffset.x +  count * carouselScroll.frame.size.width, 0);
    }
    
    int i = roundf(carouselScroll.contentOffset.x / carouselScroll.frame.size.width);
    (i >= count) ? i = 0 : i;
    [currentPageView setFrame:CGRectMake(20 * scale * i, 0, 19 * scale, 17 * scale)];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self deleteTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}

@end
