//
//  MemberViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/23.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MemberViewController.h"

@interface MemberViewController ()

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    memberAPI = [[MemberAPITool alloc] init];
    
    _memberEntity = [memberAPI getMemberEntity];
    
    shadowView = [[UIView alloc] initWithFrame:self.view.bounds];
    [shadowView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.8]];
    [shadowView setAlpha:0];
    //[shadowView addTarget:self action:@selector(tappedBackButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shadowView];
    
    memberView = [[MemberView alloc] initWithFrame:self.view.bounds andColor:self.themeColor andMemberEntity:_memberEntity];
    [memberView setDelegate:self];
    [self.view addSubview:memberView];
    
    [memberView setFrame:CGRectMake(self.view.frame.size.width, 0, memberView.frame.size.width, memberView.frame.size.height)];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleModelViewPan:)];
    panGestureRecognizer.delegate = self;
    [memberView addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleModelViewTap:)];
    [tapGestureRecognizer setDelegate:self];
    [memberView addGestureRecognizer:tapGestureRecognizer];
    
    ServiceAPITool *sat = [[ServiceAPITool alloc] init];
    [sat getAllMessageCount];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memberLogin) name:@"memberLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getMessageList:) name:@"getMessageList" object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotification) name:@"getNotification" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated {
    if (memberView.frame.origin.x != 0) {
        [UIView animateWithDuration:0.4
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [shadowView setAlpha:1];
                             [memberView setFrame:CGRectMake(0, 0, memberView.frame.size.width, memberView.frame.size.height)];
                         }
                         completion:^(BOOL finished){
                             //[currentView removeFromSuperview];
                         }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Member View Delegate

- (void)memberViewDidTapButton:(ViewControllerType)viewControllerType {
    if (_delegate && [_delegate respondsToSelector:@selector(pushViewControllerWithViewControllerType:andParameter:)]) {
        [_delegate pushViewControllerWithViewControllerType:viewControllerType andParameter:nil];
    }
    
    [self handleModelViewTap:nil];
}

- (void)memberViewDidLoginWithPhone:(NSString *)phone andPassword:(NSString *)password {
    [memberAPI loginWithPhone:phone andPassword:password];
}

#pragma mark - Notification

- (void)memberLogin {
    _memberEntity = [memberAPI getMemberEntity];
    [memberView removeFromSuperview];
    memberView = [[MemberView alloc] initWithFrame:self.view.bounds andColor:self.themeColor andMemberEntity:_memberEntity];
    [memberView setDelegate:self];
    [self.view addSubview:memberView];
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleModelViewPan:)];
    panGestureRecognizer.delegate = self;
    [memberView addGestureRecognizer:panGestureRecognizer];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleModelViewTap:)];
    [tapGestureRecognizer setDelegate:self];
    [memberView addGestureRecognizer:tapGestureRecognizer];
}

- (void)getMessageList:(NSNotification *)noti {
    [memberView refreshMessageCount:[noti.object intValue]];
}

#pragma mark - Gesture

- (void)handleModelViewTap:(id)sender {
    //NSLog(@"1");
    [UIView animateWithDuration:0.4
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [shadowView setAlpha:0];
                         [memberView setFrame:CGRectMake(self.view.frame.size.width, 0, memberView.frame.size.width, memberView.frame.size.height)];
                     }
                     completion:^(BOOL finished){
                         //[currentView removeFromSuperview];
                         [self.view removeFromSuperview];
                         [self willMoveToParentViewController:nil];
                         [self removeFromParentViewController];
                     }];
}

- (void)handleModelViewPan:(id)sender {
    UIView *currentView = memberView;
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)sender;
    CGPoint translation = [panGesture translationInView:panGesture.view];
    //NSLog(@"%@",panGesture.view);
    if ([panGesture.view isKindOfClass:[MemberView class]]) {
        if (panGesture.state == UIGestureRecognizerStateEnded) {
            float d = 0;
            if (translation.x > self.view.frame.size.width / 3) {
                d = self.view.frame.size.width;
            }
            
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 if (d == self.view.frame.size.width) {
                                     [currentView setFrame:CGRectMake(self.view.frame.size.width - 1, 0, currentView.frame.size.width, currentView.frame.size.height)];
                                     [shadowView setAlpha:0];
                                 } else {
                                     [currentView setFrame:CGRectMake(0, 0, currentView.frame.size.width, currentView.frame.size.height)];
                                     [shadowView setAlpha:1];
                                 }
                                 //[self backtoPreViewWithAnimation:ViewAnimationsBlurin andDistance:1 - currentView.frame.origin.x / 320];
                             } completion:^(BOOL finished){
                                 if (d == self.view.frame.size.width) {
                                     //[self backtoPreViewWithAnimation:ViewAnimationsBlurin andDistance:0];
                                     [self.view removeFromSuperview];
                                     [self willMoveToParentViewController:nil];
                                     [self removeFromParentViewController];
                                 }
                             }];
        } else {
            if (translation.x > 0) {
                [currentView setFrame:CGRectMake(translation.x, 0, currentView.frame.size.width, currentView.frame.size.height)];
                [shadowView setAlpha:1 - translation.x / self.view.frame.size.width];
            }
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
