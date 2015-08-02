//
//  OfflinePointView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/20.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "OfflinePointView.h"

@implementation OfflinePointView

- (void)getInfo:(NSObject *)memberEntity {
    UIScrollView *pointScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight)];
    pointScrollView.contentSize = CGSizeMake(pointScrollView.contentSize.width, 667 * self.scale - self.titleHeight);
    pointScrollView.showsVerticalScrollIndicator = NO;
    pointScrollView.delegate = self;
    [self addSubview:pointScrollView];
    
    UIView *numberView = [[UIView alloc] initWithFrame:CGRectMake(-30 * self.scale, 25 * self.scale, 250 * self.scale, 60 * self.scale)];
    numberView.layer.cornerRadius = numberView.frame.size.height / 2;
    numberView.backgroundColor = ThemeRed;
    [pointScrollView addSubview:numberView];
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(35 * self.scale, 0, 145 * self.scale, 25 * self.scale)];
    numberLabel.text = @"No.0000001";
    numberLabel.textColor = AbsoluteWhite;
    numberLabel.font = [UIFont systemFontOfSize:20.f * self.scale];
    [numberView addSubview:numberLabel];
    
    UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(120 * self.scale, 25 * self.scale, 120 * self.scale, 35 * self.scale)];
    pointLabel.text = @"剩余积分 / 累计积分\n5000 / 70000";
    pointLabel.textColor = AbsoluteWhite;
    pointLabel.textAlignment = NSTextAlignmentCenter;
    pointLabel.numberOfLines = 0;
    pointLabel.font = [UIFont boldSystemFontOfSize:11.f * self.scale];
    [numberView addSubview:pointLabel];
    
    //特权说明
    
    UILabel *privilegeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 100 * self.scale, 100 * self.scale, 112.5 * self.scale, 25 * self.scale)];
    privilegeLabel.layer.cornerRadius = privilegeLabel.frame.size.height / 2;
    privilegeLabel.layer.backgroundColor = ThemeRed.CGColor;
    privilegeLabel.text = @"特权说明";
    privilegeLabel.textColor = AbsoluteWhite;
    privilegeLabel.textAlignment = NSTextAlignmentCenter;
    privilegeLabel.font = [UIFont systemFontOfSize:20 * self.scale];
    [pointScrollView addSubview:privilegeLabel];
    
    UIScrollView *privilegeScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(5 * self.scale, 130 * self.scale, self.frame.size.width - 10 * self.scale, 280 * self.scale)];
    privilegeScroll.layer.cornerRadius = 5.f * self.scale;
    privilegeScroll.layer.borderColor = ThemeRed.CGColor;
    privilegeScroll.layer.borderWidth = 1.5f * self.scale;
    privilegeScroll.contentSize = CGSizeMake(privilegeScroll.frame.size.width, privilegeScroll.frame.size.height + 1000);
    privilegeScroll.showsVerticalScrollIndicator = NO;
    privilegeScroll.delegate = self;
    privilegeScroll.tag = 900;
    [pointScrollView addSubview:privilegeScroll];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的\n内容很长的"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft ;
    paragraphStyle.lineSpacing = 3.f * self.scale;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange (0 ,[attributedString length])];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 5 * self.scale, privilegeScroll.frame.size.width - 10 * self.scale,230 * self.scale)];
    [contentLabel setAttributedText:attributedString];
    [contentLabel setBackgroundColor:AbsoluteClear];
    [contentLabel setTextColor:ThemeRed];
    [contentLabel setNumberOfLines:0];
    [contentLabel setFont:[UIFont systemFontOfSize:18 * self.scale]];
    [contentLabel sizeToFit];
    [privilegeScroll addSubview:contentLabel];
    
    [privilegeScroll setContentSize:CGSizeMake(privilegeScroll.frame.size.width, contentLabel.frame.size.height + 10 * self.scale)];
    
    UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(pointScrollView.frame.size.width - 12 * self.scale, 135 * self.scale, 4 * self.scale, 25 * self.scale)];
    indicatorView.layer.cornerRadius = 2.f * self.scale;
    indicatorView.backgroundColor = ThemeRed;
    indicatorView.tag = 901;
    [pointScrollView addSubview:indicatorView];
    
    //详细按钮
    
    UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 225 * self.scale) / 2, 420 * self.scale, 225 * self.scale, 40 * self.scale)];
    detailButton.exclusiveTouch = YES;
    [detailButton addTarget:self action:@selector(tappedDetailButton) forControlEvents:UIControlEventTouchUpInside];
    [pointScrollView addSubview:detailButton];
    
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:detailButton.bounds];
    detailLabel.layer.cornerRadius = detailLabel.frame.size.height / 2;
    detailLabel.layer.backgroundColor = ThemeRed.CGColor;
    detailLabel.text = @"查看最近交易";
    detailLabel.textColor = AbsoluteWhite;
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.font = [UIFont boldSystemFontOfSize:25 * self.scale];
    [detailButton addSubview:detailLabel];
}

#pragma mark - Button Tapping Events

- (void)tappedDetailButton {
    if (_delegate && [_delegate respondsToSelector:@selector(offlinePointViewDidTapDetailButton)]) {
        [_delegate offlinePointViewDidTapDetailButton];
    }
}

#pragma mark - Scroll View Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidScroll)]) {
        [_delegate scrollViewDidScroll];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 900) {
        UIView *indicatorView = [self viewWithTag:901];
        CGRect frame = CGRectMake(indicatorView.frame.origin.x, 135 * self.scale, 4 * self.scale, 25 * self.scale);
        float d;
        if (scrollView.contentOffset.y < 0) {
            d = scrollView.contentOffset.y;
            
            indicatorView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + d / (5 * self.scale - d / 20));
            //indicatorView.transform = CGAffineTransformMake(1, 0, 0, 1 + scrollView.contentOffset.y / scrollView.frame.size.height, 0, scrollView.contentOffset.y / 25 * self.scale);
        } else if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= scrollView.contentSize.height - scrollView.frame.size.height) {
            indicatorView.frame = CGRectMake(frame.origin.x, frame.origin.y + scrollView.contentOffset.y / (scrollView.contentSize.height - scrollView.frame.size.height) * (scrollView.frame.size.height - 35 * self.scale), frame.size.width, frame.size.height);
        } else if (scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height) {
            d = ((scrollView.contentSize.height - scrollView.frame.size.height) - scrollView.contentOffset.y);
            indicatorView.frame = CGRectMake(frame.origin.x, frame.origin.y + scrollView.frame.size.height - 35 * self.scale - d / (5 * self.scale - d / 20), frame.size.width, frame.size.height + d / (5 * self.scale - d / 20));
        }
    }
}

@end
