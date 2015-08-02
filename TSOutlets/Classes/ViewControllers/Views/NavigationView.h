//
//  NavigationView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavigationViewDelegate;

@interface NavigationView : UIView
{
    UINavigationBar*        navigationBar;
    UINavigationBar*        navigationBarNew;
    
    NSMutableArray*         navigationBarArray;
}
@property (weak, nonatomic)     id<NavigationViewDelegate>      delegate;
@property (assign, nonatomic)   int                             color;
@property (assign, nonatomic)   BOOL                            hasNew;

- (id)initWithFrame:(CGRect)frame andColor:(int)color andTitle:(NSString *)title;
- (void)createNextNavigationBarWithColor:(UIColor *)color andTitle:(NSString *)title andIsIndex:(BOOL)isIndex;
- (void)createBeforeNavigationBar;
- (void)createFirstNavigationBar;
- (void)changeNavigationBarWithRatio:(float)ratio;
- (void)changeNavigationBarAddArray;
- (void)changeNavigationBarDeleteArray;

- (void)didGetMessage:(BOOL)message;

@end

@protocol NavigationViewDelegate <NSObject>
- (void)navigationViewDidTapBackButton:(NavigationView *)navigationView;
- (void)navigationViewDidTapQRCodeButton:(NavigationView *)navigationView;
- (void)navigationViewDidTapMemberButton;
@end