//
//  ServiceCustomView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/3.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ServiceCustomView.h"

@implementation ServiceCustomView

- (void)initView {
    UIView *upperView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, 160 * self.scale)];
    [self addSubview:upperView];
    
    UIButton *manualButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.15f, 15.f * self.scale, self.frame.size.width * 0.7f, 30 * self.scale)];
    manualButton.layer.cornerRadius = 15.f * self.scale;
    [manualButton setBackgroundColor:ThemeYellowOrange];
    [manualButton addTarget:self action:@selector(tappedCustomerButton) forControlEvents:UIControlEventTouchUpInside];
    [upperView addSubview:manualButton];
    
    UILabel *manualLabel = [[UILabel alloc] initWithFrame:manualButton.bounds];
    [manualLabel setBackgroundColor:[UIColor clearColor]];
    [manualLabel setText:@"客服"];
    [manualLabel setTextColor:AbsoluteWhite];
    [manualLabel setTextAlignment:NSTextAlignmentCenter];
    [manualLabel setFont:[UIFont systemFontOfSize:19 * self.scale]];
    [manualButton addSubview:manualLabel];
    
    UILabel *manualHint = [[UILabel alloc] initWithFrame:CGRectMake(0, 60 * self.scale, self.frame.size.width, 20 * self.scale)];
    [manualHint setBackgroundColor:[UIColor clearColor]];
    [manualHint setText:@"没有找到想要的答案？试试客服吧！"];
    [manualHint setTextColor:ThemeYellowHint];
    [manualHint setTextAlignment:NSTextAlignmentCenter];
    [manualHint setFont:[UIFont boldSystemFontOfSize:13.f * self.scale]];
    [upperView addSubview:manualHint];
    
    UIImageView *manualIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ServiceCustomView_ManualHint"]];
    [manualIcon setFrame:CGRectMake(0, 0, 10 * self.scale, 10 * self.scale)];
    [manualIcon setCenter:CGPointMake(self.frame.size.width / 2, 55 * self.scale)];
    [upperView addSubview:manualIcon];
    
    UIView *questionView = [[UIView alloc] initWithFrame:CGRectMake(-15 * self.scale, 120 * self.scale, self.frame.size.width * 0.66, 30 * self.scale)];
    questionView.layer.cornerRadius = 15.f * self.scale;
    questionView.backgroundColor = ThemeYellowOrange;
    [upperView addSubview:questionView];
    
    UILabel *questLabel = [[UILabel alloc] initWithFrame:CGRectMake(25 * self.scale, 0 * self.scale, 100 * self.scale, 30 * self.scale)];
    [questLabel setBackgroundColor:[UIColor clearColor]];
    [questLabel setText:@"常见问题"];
    [questLabel setTextColor:AbsoluteWhite];
    [questLabel setFont:[UIFont systemFontOfSize:17 * self.scale]];
    [questionView addSubview:questLabel];
    
    //lowerView
    
    lowerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight + upperView.frame.size.height, self.frame.size.width, self.frame.size.height - self.titleHeight - upperView.frame.size.height)];
    [self addSubview:lowerView];
    
    UIImageView *scrollViewBackground = [[UIImageView alloc] initWithFrame:lowerView.bounds];
    [scrollViewBackground setImage:[UIImage imageNamed:@"ServiceCustomView_Background"]];
    [lowerView addSubview:scrollViewBackground];
    
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:lowerView.bounds];
//    [lowerView addSubview:scrollView];
}

- (void)getServiceTrafficWithHTML:(NSString *)html {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:lowerView.bounds];
    [scrollView setDelegate:self];
    [lowerView addSubview:scrollView];
    
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:html];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.alignment = NSTextAlignmentLeft ;
//    paragraphStyle.lineSpacing = 3.f * self.scale;
//    [paragraphStyle setFirstLineHeadIndent:32 * self.scale];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange (0 ,[html length])];
//    
//    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.5 * self.scale, 12.5 * self.scale, self.frame.size.width - 25 * self.scale, 0)];
//    [contentLabel setAttributedText:attributedString];
//    [contentLabel setBackgroundColor:AbsoluteClear];
//    [contentLabel setTextColor:ThemeRed_103_014_014];
//    [contentLabel setNumberOfLines:0];
//    [contentLabel setFont:[UIFont systemFontOfSize:18 * self.scale]];
//    [contentLabel sizeToFit];
//    [contentLabel setFrame:(CGRect){contentLabel.frame.origin, CGSizeMake(self.frame.size.width - 25 * self.scale, contentLabel.frame.size.height)}];
//    [scrollView addSubview:contentLabel];
    
    UIImageView *contentImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width * 5316 / 700)];
    [contentImage setImage:[UIImage imageNamed:@"ServiceQA"]];
    [scrollView addSubview:contentImage];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, contentImage.frame.size.height)];
}

- (void)tappedCustomerButton {
    if (_delegate && [_delegate respondsToSelector:@selector(serviceCustomViewDidTapReplyButton)]) {
        [_delegate serviceCustomViewDidTapReplyButton];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(serviceCustomView:didStartDragScrollView:)]) {
        [_delegate serviceCustomView:self didStartDragScrollView:scrollView ];
    }
}

@end
