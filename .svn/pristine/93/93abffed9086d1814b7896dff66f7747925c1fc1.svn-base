//
//  ServiceInfoView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/10.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ServiceInfoView.h"

@implementation ServiceInfoView

- (void)getServiceInfoWithHTML:(NSString *)html {
//    UIWebView *webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight)];
//    webview.scrollView.scrollEnabled = YES;
//    webview.scrollView.delegate = self;
//    webview.backgroundColor = AbsoluteWhite;
//    webview.scalesPageToFit = YES;
//    webview.autoresizesSubviews = YES;
//    webview.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
//    
//    NSString *str = [NSString stringWithFormat:@"<html><head><style>body{margin:0 0 200 0;padding:0}</style></head><body>%@</body></html>", html];
//    [webview loadHTMLString:str baseURL:[NSURL URLWithString:@"http://blyyc.dgshare.cn"]];
//    
//    [self addSubview:webview];

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight)];
    [scrollView setDelegate:self];
    [self addSubview:scrollView];
    
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
    
    UIImageView *contentImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width * 4303 / 700)];
    [contentImage setImage:[UIImage imageNamed:@"ServiceInfo"]];
    [scrollView addSubview:contentImage];
    
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, 0 * self.scale + contentImage.frame.size.height)];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(serviceInfoView:didStartDragScrollView:)]) {
        [_delegate serviceInfoView:self didStartDragScrollView:scrollView ];
    }
}

@end
