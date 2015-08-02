//
//  OnlinePointDetailView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/20.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "OnlinePointDetailView.h"

@implementation OnlinePointDetailView

- (void)getInfo:(NSObject *)memberEntity {
    NSString *pointRemaining = @"5000";
    
    UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(180 * self.scale, self.titleHeight + 25 * self.scale, self.frame.size.width - 150 * self.scale, 30 * self.scale)];
    pointLabel.layer.cornerRadius = pointLabel.frame.size.height / 2;
    pointLabel.layer.borderColor = ThemeRed.CGColor;
    pointLabel.layer.borderWidth = 1.f;
    pointLabel.text = [NSString stringWithFormat:@"     剩余积分：%@", pointRemaining];
    pointLabel.textColor = ThemeRed;
    pointLabel.font = [UIFont systemFontOfSize:18 * self.scale];
    [self addSubview:pointLabel];
    
    UIScrollView *pointScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight + 75 * self.scale, self.frame.size.width, self.frame.size.height - (self.titleHeight + 80 * self.scale))];
    [self addSubview:pointScrollView];
    
    [pointScrollView addSubview:[self createPointDetailWithFrame:CGRectMake(0, 65 * self.scale * 0, pointScrollView.frame.size.width, 65 * self.scale)
                                                        andTitle:@"礼品兑换"
                                                         andTime:@"2015-05-02 13:24:30"
                                                       andPoints:@"-300"]];
    
    [pointScrollView addSubview:[self createPointDetailWithFrame:CGRectMake(0, 65 * self.scale * 1, pointScrollView.frame.size.width, 65 * self.scale)
                                                        andTitle:@"小游戏"
                                                         andTime:@"2015-05-02 13:24:30"
                                                       andPoints:@"+300"]];
    
    [pointScrollView addSubview:[self createPointDetailWithFrame:CGRectMake(0, 65 * self.scale * 2, pointScrollView.frame.size.width, 65 * self.scale)
                                                        andTitle:@"礼品兑换"
                                                         andTime:@"2015-05-02 13:24:30"
                                                       andPoints:@"10"]];
}

- (UIView *)createPointDetailWithFrame:(CGRect)frame andTitle:(NSString *)title andTime:(NSString *)time andPoints:(NSString *)points {
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(5 * self.scale,frame.origin.y + 5 * self.scale, frame.size.width - 10 * self.scale, 60 * self.scale)];
    pointView.layer.cornerRadius = 10 * self.scale;
    pointView.layer.borderColor = ThemeRed.CGColor;
    pointView.layer.borderWidth = 1.5f;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 10 * self.scale, pointView.frame.size.width / 2 - 10 * self.scale, 20 * self.scale)];
    titleLabel.text = title;
    titleLabel.textColor = ThemeRed;
    titleLabel.font = [UIFont systemFontOfSize:17 * self.scale];
    [pointView addSubview:titleLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 30 * self.scale, pointView.frame.size.width / 2 - 10 * self.scale, 20 * self.scale)];
    timeLabel.text = time;
    timeLabel.textColor = Color(119, 119, 119, 1);
    timeLabel.font = [UIFont systemFontOfSize:15 * self.scale];
    [pointView addSubview:timeLabel];
    
    UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(pointView.frame.size.width / 2, 10 * self.scale, pointView.frame.size.width / 2 - 10 * self.scale, 40 * self.scale)];
    pointLabel.text = points;
    pointLabel.textAlignment = NSTextAlignmentRight;
    if ([points intValue] < 0) {
        pointLabel.textColor = ThemeBlue;
    } else {
        pointLabel.textColor = ThemeRed;
    }
    pointLabel.font = [UIFont systemFontOfSize:36 * self.scale];
    [pointView addSubview:pointLabel];
    
    return pointView;
}

@end
