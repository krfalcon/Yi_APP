//
//  NavigationView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "NavigationView.h"
#import "ScreenHelper.h"

@implementation NavigationView

-(id)initWithFrame:(CGRect)frame andColor:(int)color andTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设定颜色
        self.color = color;//0红色 1蓝色 2黄色
        UIColor *themeColor;
        switch (color) {
            case 0:
                themeColor = ThemeRed;
                break;
            case 1:
                themeColor = ThemeBlue;
                break;
            case 2:
                themeColor = ThemeYellow;
                break;
            default:
                themeColor = ThemeRed;
                break;
        }
        self.backgroundColor = themeColor;
        
        //设定高度
        float height = 64.f;
        float font = 20.f;
        if (iPhone6Plus) {
            height = 96.f;
            font = 30.f;
        }
        
        [self setFrame:CGRectMake(0, 0, self.frame.size.width, 64)];
        
        navigationBar = [[UINavigationBar alloc] init];
        [navigationBar setClipsToBounds:YES];
        [navigationBar setTranslucent:NO];
        [navigationBar setFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, 64.f)];
        [navigationBar setBarTintColor:themeColor];
        [navigationBar setTintColor:[UIColor whiteColor]];
        [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20.f]}];
        [navigationBar setShadowImage:nil];
        [self addSubview:navigationBar];
        
        UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:title];
        [navigationBar pushNavigationItem:navigationItem animated:YES];
        
        UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
        [back addTarget:self action:@selector(tappedCodeButton) forControlEvents:UIControlEventTouchUpInside];
        [navigationBar addSubview:back];
        
        UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 35, 30)];
        [backImage setImage:[UIImage imageNamed:@"NaviCode"]];
        [back addSubview:backImage];
        
        UIButton *member = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 20, 60, 44)];
        [member addTarget:self action:@selector(tappedMemberButton) forControlEvents:UIControlEventTouchUpInside];
        [member setTag:11];
        [self insertSubview:member atIndex:10];
        
        UIImageView *memberImage = [[UIImageView alloc] initWithFrame:CGRectMake(25, 7, 30, 30)];
        [memberImage setImage:[UIImage imageNamed:@"NaviMember"]];
        [memberImage setTag:10];
        [member addSubview:memberImage];
        
        navigationBarArray = [[NSMutableArray alloc] init];
        [navigationBarArray addObject:navigationBar];
    }
    return self;
}

- (void)tappedCodeButton {
    if (_delegate && [_delegate respondsToSelector:@selector(navigationViewDidTapQRCodeButton:)]) {
        [_delegate navigationViewDidTapQRCodeButton:self ];
    }
}

- (void)tappedBackButton {
    if (_delegate && [_delegate respondsToSelector:@selector(navigationViewDidTapBackButton:)]) {
        [_delegate navigationViewDidTapBackButton:self ];
    }
}

- (void)tappedMemberButton {
    if (_delegate && [_delegate respondsToSelector:@selector(navigationViewDidTapMemberButton)]) {
        [_delegate navigationViewDidTapMemberButton];
    }
}

- (void)createNextNavigationBarWithColor:(UIColor *)color andTitle:(NSString *)title andIsIndex:(BOOL)isIndex {
    self.backgroundColor = color;
    navigationBarNew = [[UINavigationBar alloc] init];
    [navigationBarNew setClipsToBounds:YES];
    [navigationBarNew setTranslucent:NO];
    [navigationBarNew setAlpha:0];
    [navigationBarNew setFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, 64.f)];
    [navigationBarNew setBarTintColor:color];
    [navigationBarNew setTintColor:[UIColor whiteColor]];
    [navigationBarNew setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20.f]}];
    [navigationBarNew setShadowImage:nil];
    [self insertSubview:navigationBarNew belowSubview:[self viewWithTag:11]];
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:title];
    [navigationBarNew pushNavigationItem:navigationItem animated:YES];
    
    if (isIndex) {
        UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
        [back addTarget:self action:@selector(tappedCodeButton) forControlEvents:UIControlEventTouchUpInside];
        [navigationBar addSubview:back];
        
        UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 35, 30)];
        [backImage setImage:[UIImage imageNamed:@"NaviCode"]];
        [back addSubview:backImage];
    } else {
        UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
        [back addTarget:self action:@selector(tappedBackButton) forControlEvents:UIControlEventTouchUpInside];
        [navigationBarNew addSubview:back];
        
        UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 30, 30)];
        [backImage setImage:[UIImage imageNamed:@"NaviBack"]];
        [back addSubview:backImage];
    }
    
//    UIButton *member = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 20, 60, 44)];
//    [member addTarget:self action:@selector(tappedMemberButton) forControlEvents:UIControlEventTouchUpInside];
//    [navigationBarNew addSubview:member];
//    
//    UIImageView *memberImage = [[UIImageView alloc] initWithFrame:CGRectMake(25, 7, 30, 30)];
//    [memberImage setImage:[UIImage imageNamed:@"NaviMember"]];
//    [member addSubview:memberImage];
}

- (void)createBeforeNavigationBar {
    navigationBarNew = [navigationBarArray objectAtIndex:(navigationBarArray.count - 2)];
    self.backgroundColor = navigationBarNew.barTintColor;
    [self insertSubview:navigationBarNew belowSubview:[self viewWithTag:11]];
    //NSLog(@"%@",  navigationBarNew);
    _hasNew = YES;
}

- (void)createFirstNavigationBar {
    navigationBarNew = [navigationBarArray firstObject];
    self.backgroundColor = navigationBarNew.barTintColor;
    [self insertSubview:navigationBarNew belowSubview:[self viewWithTag:11]];
    
    int count = (int)navigationBarArray.count - 1;
    for (int i = 1; i < count; i++) {
        [navigationBarArray removeObjectAtIndex:1];
    }
    
    _hasNew = YES;
}

- (void)changeNavigationBarWithRatio:(float)ratio {
    [navigationBar setAlpha:ratio];
    [navigationBarNew setAlpha:1 - ratio];
}

- (void)changeNavigationBarAddArray {
    
    [navigationBar removeFromSuperview];
    navigationBar = navigationBarNew;
    [navigationBarArray addObject:navigationBar];
    navigationBarNew = nil;
    
    _hasNew = NO;
}

- (void)changeNavigationBarDeleteArray {
    
    [navigationBar removeFromSuperview];
    navigationBar = navigationBarNew;
    [navigationBarArray removeLastObject];
    navigationBarNew = nil;
    
    _hasNew = NO;
}

- (void)didGetMessage:(BOOL)message {
    [(UIImageView *)[self viewWithTag:10] setImage:[UIImage imageNamed:message ? @"NaviMember_Msg" : @"NaviMember"]];
}

@end
