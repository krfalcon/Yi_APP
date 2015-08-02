//
//  OfflinePointDetailView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/20.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "OfflinePointDetailView.h"

@implementation OfflinePointDetailView

- (void)getInfo:(NSObject *)memberEntity {
    
    
    UIScrollView *pointScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight)];
    [self addSubview:pointScrollView];
    
    [pointScrollView addSubview:[self createPointDetailWithFrame:CGRectMake(0, 280 * self.scale * 0, pointScrollView.frame.size.width, 280 * self.scale)
                                                        andTitle:@"65245256834624105"
                                                         andTime:@"2015-05-02 13:24:30"
                                                     andLocation:@"南京百联汤山奥特莱斯"
                                                        andMoney:@"人民币30,000元"
                                                       andPoints:@"300"]];
}

- (UIView *)createPointDetailWithFrame:(CGRect)frame andTitle:(NSString *)title andTime:(NSString *)time andLocation:(NSString *)location andMoney:(NSString *)money andPoints:(NSString *)points {
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(10 * self.scale, frame.origin.y + 20 * self.scale, frame.size.width - 20 * self.scale, frame.size.height - 30 * self.scale)];
    pointView.layer.cornerRadius = 5 * self.scale;
    pointView.layer.borderColor = ThemeRed.CGColor;
    pointView.layer.borderWidth = 1.5f;
    pointView.clipsToBounds = YES;
    
    //序号
    UILabel *titleHead = [[UILabel alloc] initWithFrame:CGRectMake(0, 50 * self.scale * 0, 100 * self.scale, 50 * self.scale)];
    titleHead.backgroundColor = ThemeRed;
    titleHead.text = @"交易序号";
    titleHead.textColor = AbsoluteWhite;
    titleHead.textAlignment = NSTextAlignmentCenter;
    titleHead.font = [UIFont systemFontOfSize:17 * self.scale];
    [pointView addSubview:titleHead];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 * self.scale, 50 * self.scale * 0, pointView.frame.size.width - 100 * self.scale, 50 * self.scale)];
    titleLabel.text = title;
    titleLabel.textColor = ThemeRed;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17 * self.scale];
    [pointView addSubview:titleLabel];
    
    //时间
    UILabel *timeHead = [[UILabel alloc] initWithFrame:CGRectMake(0, 50 * self.scale * 1, 100 * self.scale, 50 * self.scale)];
    timeHead.backgroundColor = ThemeRed;
    timeHead.text = @"交易时间";
    timeHead.textColor = AbsoluteWhite;
    timeHead.textAlignment = NSTextAlignmentCenter;
    timeHead.font = [UIFont systemFontOfSize:17 * self.scale];
    [pointView addSubview:timeHead];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 * self.scale, 50 * self.scale * 1, pointView.frame.size.width - 100 * self.scale, 50 * self.scale)];
    timeLabel.text = time;
    timeLabel.textColor = ThemeRed;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.font = [UIFont systemFontOfSize:17 * self.scale];
    [pointView addSubview:timeLabel];
    
    //地点
    UILabel *locationHead = [[UILabel alloc] initWithFrame:CGRectMake(0, 50 * self.scale * 2, 100 * self.scale, 50 * self.scale)];
    locationHead.backgroundColor = ThemeRed;
    locationHead.text = @"交易地点";
    locationHead.textColor = AbsoluteWhite;
    locationHead.textAlignment = NSTextAlignmentCenter;
    locationHead.font = [UIFont systemFontOfSize:17 * self.scale];
    [pointView addSubview:locationHead];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 * self.scale, 50 * self.scale * 2, pointView.frame.size.width - 100 * self.scale, 50 * self.scale)];
    locationLabel.text = location;
    locationLabel.textColor = ThemeRed;
    locationLabel.textAlignment = NSTextAlignmentCenter;
    locationLabel.font = [UIFont systemFontOfSize:17 * self.scale];
    [pointView addSubview:locationLabel];
    
    //金额
    UILabel *moneyHead = [[UILabel alloc] initWithFrame:CGRectMake(0, 50 * self.scale * 3, 100 * self.scale, 50 * self.scale)];
    moneyHead.backgroundColor = ThemeRed;
    moneyHead.text = @"交易金额";
    moneyHead.textColor = AbsoluteWhite;
    moneyHead.textAlignment = NSTextAlignmentCenter;
    moneyHead.font = [UIFont systemFontOfSize:17 * self.scale];
    [pointView addSubview:moneyHead];
    
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 * self.scale, 50 * self.scale * 3, pointView.frame.size.width - 100 * self.scale, 50 * self.scale)];
    moneyLabel.text = money;
    moneyLabel.textColor = ThemeRed;
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    moneyLabel.font = [UIFont systemFontOfSize:17 * self.scale];
    [pointView addSubview:moneyLabel];
    
    //积分
    UILabel *pointsHead = [[UILabel alloc] initWithFrame:CGRectMake(0, 50 * self.scale * 4, 100 * self.scale, 50 * self.scale)];
    pointsHead.backgroundColor = ThemeRed;
    pointsHead.text = @"产生积分";
    pointsHead.textColor = AbsoluteWhite;
    pointsHead.textAlignment = NSTextAlignmentCenter;
    pointsHead.font = [UIFont systemFontOfSize:17 * self.scale];
    [pointView addSubview:pointsHead];
    
    UILabel *pointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(100 * self.scale, 50 * self.scale * 4, pointView.frame.size.width - 100 * self.scale, 50 * self.scale)];
    pointsLabel.text = points;
    pointsLabel.textColor = ThemeRed;
    pointsLabel.textAlignment = NSTextAlignmentCenter;
    pointsLabel.font = [UIFont systemFontOfSize:17 * self.scale];
    [pointView addSubview:pointsLabel];
    
    //lines
    
    UIView *lineOne = [[UIView alloc] initWithFrame:CGRectMake(100 * self.scale, 50 * self.scale * 1, pointView.frame.size.width - 100 * self.scale, 1.f)];
    lineOne.backgroundColor = ThemeRed;
    [pointView addSubview:lineOne];
    
    UIView *lineTwo = [[UIView alloc] initWithFrame:CGRectMake(100 * self.scale, 50 * self.scale * 2, pointView.frame.size.width - 100 * self.scale, 1.f)];
    lineTwo.backgroundColor = ThemeRed;
    [pointView addSubview:lineTwo];
    
    UIView *lineThree = [[UIView alloc] initWithFrame:CGRectMake(100 * self.scale, 50 * self.scale * 3, pointView.frame.size.width - 100 * self.scale, 1.f)];
    lineThree.backgroundColor = ThemeRed;
    [pointView addSubview:lineThree];
    
    UIView *lineFour = [[UIView alloc] initWithFrame:CGRectMake(100 * self.scale, 50 * self.scale * 4, pointView.frame.size.width - 100 * self.scale, 1.f)];
    lineFour.backgroundColor = ThemeRed;
    [pointView addSubview:lineFour];
    
    return pointView;
}

@end
