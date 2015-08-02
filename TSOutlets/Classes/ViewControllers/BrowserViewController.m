//
//  BrowserViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/7/3.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "BrowserViewController.h"

@implementation BrowserViewController

- (void)initFirstViewWithParameter:(NSDictionary *)parameter {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    NSURL *url =[NSURL URLWithString:@"http://mp.weixin.qq.com/s?__biz=MjM5MDMxMTE4OQ==&mid=200289040&idx=2&sn=2e7727380124bb920e160c35987542b7&scene=1&from=groupmessage&isappinstalled=0#rd"];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
}

@end
