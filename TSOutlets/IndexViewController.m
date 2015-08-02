//
//  ViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/16.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "IndexViewController.h"
#import "QRCodeReaderViewController.h"

@implementation IndexViewController

#pragma mark - views Controller

- (void)initFirstViewWithParameter:(NSDictionary *)parameter
{
    self.enableGesture = NO;
    
    indexView = [[IndexView alloc] initWithFrame:self.view.bounds];
    [indexView setDelegate:self];
    [self.view addSubview:indexView];
}

#pragma mark - index Delegate

- (void)indexViewDidTappedButton:(IndexView *)indexView withType:(ViewControllerType)type andParameter:(NSDictionary *)parameter {
    [self pushViewControllerWithViewControllerType:type andParameter:parameter];
}

- (void)tappedQRCodeButton {
    static QRCodeReaderViewController *reader = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        reader                        = [QRCodeReaderViewController new];
        reader.modalPresentationStyle = UIModalPresentationFormSheet;
    });
    reader.delegate = self;
    
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        NSLog(@"Completion with result: %@", resultAsString);
    }];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self presentViewController:reader animated:YES completion:NULL];
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self dismissViewControllerAnimated:YES completion:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCodeReader" message:result delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
