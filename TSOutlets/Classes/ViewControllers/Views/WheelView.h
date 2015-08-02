//
//  WheelView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnumHelper.h"

@protocol WheelViewDelegate;

@interface WheelView : UIView
{
    UIView*                                 wheelView;
    
    BOOL                                    wheelTypeArrayIsAdd;
    
    NSString*                               buttonType;
    NSMutableArray*                         wheelTypeArray;
    NSString*                               currentType;
    NSString*                               nextType;
    
    UIImageView*                            wheelImage;
    UIImageView*                            wheelHoldImage;
}

@property (weak, nonatomic) id<WheelViewDelegate>           delegate;
@property (assign, nonatomic) BOOL                          hasNew;
@property (assign, nonatomic) BOOL                          isShow;


- (id)initWithFrame:(CGRect)frame andType:(NSString *)type andColor:(NSString *)color;
- (void)createNewWheelViewWithType:(NSString *)wheelViewType andColor:(NSString *)color andButtonType:(NSString *)button;
- (void)getPreWheelView;
- (void)getFirstWheelView;
- (void)wheelAnimation;
- (void)wheelAnimationWithRatio:(float)ratio;
- (void)wheelShow;
- (void)wheelHide;

@end

@protocol WheelViewDelegate <NSObject>

- (void)wheelDidHide;
- (void)wheelDidShow;

@optional

- (void)wheelViewDidTapButton1:(WheelView *)wheelView;
- (void)wheelViewDidTapButton2:(WheelView *)wheelView;
- (void)wheelViewDidTapButton3:(WheelView *)wheelView;
- (void)wheelViewDidTapButton4:(WheelView *)wheelView;
- (void)wheelViewDidTapButton5:(WheelView *)wheelView;

@end
