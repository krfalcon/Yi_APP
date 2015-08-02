//
//  OnlinePointView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/20.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "OnlinePointView.h"

@implementation OnlinePointView

- (void)getInfo:(NSObject *)memberEntity {
    UIScrollView *pointScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight)];
    pointScrollView.contentSize = CGSizeMake(pointScrollView.contentSize.width, 667 * self.scale - self.titleHeight);
    pointScrollView.showsVerticalScrollIndicator = NO;
    pointScrollView.delegate = self;
    [self addSubview:pointScrollView];
    
    UIView *levelView = [[UIView alloc] initWithFrame:CGRectMake(0, 50 * self.scale, 250 * self.scale, 20 * self.scale)];
    levelView.layer.cornerRadius = levelView.frame.size.height / 2;
    levelView.backgroundColor = Color(255, 209, 216, 1);
    [pointScrollView addSubview:levelView];
    
    NSMutableAttributedString *levelString = [[NSMutableAttributedString alloc] initWithString:@"Lv白金会员"];
    [levelString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11.0 * self.scale] range:NSMakeRange(0, 2)];
    [levelString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13.0 * self.scale] range:NSMakeRange(2, levelString.length - 2)];
    
    UILabel *levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(175 * self.scale, 0, 75 * self.scale, 20 * self.scale)];
    levelLabel.attributedText = levelString;
    levelLabel.textColor = ThemeRed;
    [levelView addSubview:levelLabel];
    
    UIView *numberView = [[UIView alloc] initWithFrame:CGRectMake(-22.5 * self.scale, 25 * self.scale, 195 * self.scale, 45 * self.scale)];
    numberView.layer.cornerRadius = numberView.frame.size.height / 2;
    numberView.backgroundColor = ThemeRed;
    [pointScrollView addSubview:numberView];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 * self.scale, 0, 145 * self.scale, 25 * self.scale)];
    numberLabel.text = @"No.0000001";
    numberLabel.textColor = AbsoluteWhite;
    numberLabel.font = [UIFont systemFontOfSize:20.f * self.scale];
    [numberView addSubview:numberLabel];
    
    UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 * self.scale, 25 * self.scale, 145 * self.scale, 20 * self.scale)];
    pointLabel.text = @"剩余积分：200";
    pointLabel.textColor = AbsoluteWhite;
    pointLabel.textAlignment = NSTextAlignmentRight;
    pointLabel.font = [UIFont systemFontOfSize:14.f * self.scale];
    [numberView addSubview:pointLabel];
    
    //进度条
    
    NSMutableAttributedString *currentLevelString = [[NSMutableAttributedString alloc] initWithString:@"当前等级\n钻石"];
    [currentLevelString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12.0 * self.scale] range:NSMakeRange(0, 4)];
    [currentLevelString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0 * self.scale] range:NSMakeRange(4, currentLevelString.length - 4)];
    
    UILabel *currentLevel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 100 * self.scale, 60 * self.scale, 40 * self.scale)];
    currentLevel.attributedText = currentLevelString;
    currentLevel.textColor = ThemeRed;
    currentLevel.textAlignment = NSTextAlignmentCenter;
    currentLevel.numberOfLines = 0;
    [pointScrollView addSubview:currentLevel];
    
    NSMutableAttributedString *nextLevelString = [[NSMutableAttributedString alloc] initWithString:@"下一等级\n黑金"];
    [nextLevelString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12.0 * self.scale] range:NSMakeRange(0, 4)];
    [nextLevelString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0 * self.scale] range:NSMakeRange(4, nextLevelString.length - 4)];
    
    UILabel *nextLevel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 65 * self.scale, 100 * self.scale, 60 * self.scale, 40 * self.scale)];
    nextLevel.attributedText = nextLevelString;
    nextLevel.textColor = Color(165, 165, 155, 1);
    nextLevel.textAlignment = NSTextAlignmentCenter;
    nextLevel.numberOfLines = 0;
    [pointScrollView addSubview:nextLevel];
    
    UIView *progressBarOutline = [[UIView alloc] initWithFrame:CGRectMake(70 * self.scale, 115 * self.scale, self.frame.size.width - 140 * self.scale, 5 * self.scale)];
    progressBarOutline.layer.cornerRadius = progressBarOutline.frame.size.height / 2;
    progressBarOutline.layer.borderWidth = 0.5f;
    progressBarOutline.layer.borderColor = ThemeRed.CGColor;
    [pointScrollView addSubview:progressBarOutline];
    
    UIView *progressBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (self.frame.size.width - 140 * self.scale) * 0.4, 5 * self.scale)];
    progressBar.layer.cornerRadius = progressBar.frame.size.height / 2;
    progressBar.backgroundColor = ThemeRed;
    [progressBarOutline addSubview:progressBar];
    
    //累计积分情况
    
    NSMutableAttributedString *currentPointString = [[NSMutableAttributedString alloc] initWithString:@"累计积分\n74000"];
    [currentPointString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12.0 * self.scale] range:NSMakeRange(0, 4)];
    [currentPointString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15.0 * self.scale] range:NSMakeRange(4, currentPointString.length - 4)];
    
    UILabel *currentPoint = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 - 65 * self.scale, 130 * self.scale, 60 * self.scale, 40 * self.scale)];
    currentPoint.attributedText = currentPointString;
    currentPoint.textColor = ThemeRed;
    currentPoint.textAlignment = NSTextAlignmentCenter;
    currentPoint.numberOfLines = 0;
    [pointScrollView addSubview:currentPoint];
    
    NSMutableAttributedString *nextPointString = [[NSMutableAttributedString alloc] initWithString:@"升级积分\n100000"];
    [nextPointString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12.0 * self.scale] range:NSMakeRange(0, 4)];
    [nextPointString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15.0 * self.scale] range:NSMakeRange(4, nextPointString.length - 4)];
    
    UILabel *nextPoint = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 + 5 * self.scale, 130 * self.scale, 60 * self.scale, 40 * self.scale)];
    nextPoint.attributedText = nextPointString;
    nextPoint.textColor = ThemeRed;
    nextPoint.textAlignment = NSTextAlignmentCenter;
    nextPoint.numberOfLines = 0;
    [pointScrollView addSubview:nextPoint];
    
    UILabel *slashLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.center.x - 5, 130 * self.scale, 10 * self.scale, 40 * self.scale)];
    slashLabel.text = @"/";
    slashLabel.textColor = ThemeRed;
    slashLabel.textAlignment = NSTextAlignmentCenter;
    slashLabel.font = [UIFont systemFontOfSize:15 * self.scale];
    [pointScrollView addSubview:slashLabel];
    
    UIButton *levelInfoButton = [[UIButton alloc] initWithFrame:CGRectMake(250 * self.scale, 170 * self.scale, self.frame.size.width - 250 * self.scale, 40 * self.scale)];
    [pointScrollView addSubview:levelInfoButton];
    
    UILabel *levelInfoLabel = [[UILabel alloc] initWithFrame:levelInfoButton.bounds];
    levelInfoLabel.text = @"什么是积分和等级？";
    levelInfoLabel.textColor = ThemeRed;
    levelInfoLabel.font = [UIFont systemFontOfSize:12 * self.scale];
    [levelInfoButton addSubview:levelInfoLabel];
    
    UIImageView *levelInfoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MemberView_Tri_Red"]];
    [levelInfoImage setFrame:CGRectMake(levelInfoButton.frame.size.width - 15 * self.scale, 14 * self.scale, 9 * self.scale, 12 * self.scale)];
    [levelInfoButton addSubview:levelInfoImage];
    
    //特权
    
    UILabel *privilegeLabel = [[UILabel alloc] initWithFrame:CGRectMake(- 15 * self.scale, 200 * self.scale, 130 * self.scale, 25 * self.scale)];
    privilegeLabel.layer.cornerRadius = privilegeLabel.frame.size.height / 2;
    privilegeLabel.layer.backgroundColor = ThemeRed.CGColor;
    privilegeLabel.text = @"我的特权";
    privilegeLabel.textColor = AbsoluteWhite;
    privilegeLabel.textAlignment = NSTextAlignmentCenter;
    privilegeLabel.font = [UIFont systemFontOfSize:20 * self.scale];
    [pointScrollView addSubview:privilegeLabel];
    
    UIScrollView *privilegeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 230 * self.scale, self.frame.size.width, 130 * self.scale)];
    privilegeScrollView.backgroundColor = ThemeRed;
    [pointScrollView addSubview:privilegeScrollView];
    
    UIButton *privilegeButton = [[UIButton alloc] initWithFrame:CGRectMake(250 * self.scale, 370 * self.scale, self.frame.size.width - 230 * self.scale, 25 * self.scale)];
    privilegeButton.layer.cornerRadius = privilegeButton.frame.size.height / 2;
    privilegeButton.layer.borderWidth = 1.f;
    privilegeButton.layer.borderColor = Color(177, 177, 177, 1).CGColor;
    [pointScrollView addSubview:privilegeButton];
    
    UILabel *privilegeButtonLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 0 * self.scale, self.frame.size.width - 280 * self.scale, 25 * self.scale)];
    privilegeButtonLabel.text = @"下一级解锁特权";
    privilegeButtonLabel.textColor = Color(109, 87, 87, 1);
    privilegeButtonLabel.textAlignment = NSTextAlignmentLeft;
    privilegeButtonLabel.font = [UIFont systemFontOfSize:13 * self.scale];
    [privilegeButton addSubview:privilegeButtonLabel];
    
    UIImageView *privilegeButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MemberView_Tri_Gray"]];
    [privilegeButtonImage setFrame:CGRectMake(privilegeButton.frame.size.width - 35 * self.scale, 6 * self.scale, 9 * self.scale, 12 * self.scale)];
    [privilegeButton addSubview:privilegeButtonImage];

    
    //详细按钮
    
    UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 225 * self.scale) / 2, 420 * self.scale, 225 * self.scale, 40 * self.scale)];
    detailButton.exclusiveTouch = YES;
    [detailButton addTarget:self action:@selector(tappedDetailButton) forControlEvents:UIControlEventTouchUpInside];
    [pointScrollView addSubview:detailButton];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:detailButton.bounds];
    detailLabel.layer.cornerRadius = detailLabel.frame.size.height / 2;
    detailLabel.layer.backgroundColor = ThemeRed.CGColor;
    detailLabel.text = @"查看积分明细";
    detailLabel.textColor = AbsoluteWhite;
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.font = [UIFont boldSystemFontOfSize:25 * self.scale];
    [detailButton addSubview:detailLabel];
}

#pragma mark - Button Tapping Events

- (void)tappedDetailButton {
    if (_delegate && [_delegate respondsToSelector:@selector(onlinePointViewDidTapDetailButton)]) {
        [_delegate onlinePointViewDidTapDetailButton];
    }
}

#pragma mark - Scroll View Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidScroll)]) {
        [_delegate scrollViewDidScroll];
    }
}

@end
