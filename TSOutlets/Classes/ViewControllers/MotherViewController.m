//
//  MotherViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/24.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MotherViewController.h"

@implementation MotherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setFrame:super.view.bounds];
    
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    _enableGesture = YES;
    
    [self.view setBackgroundColor:AbsoluteWhite];
    [self.view.layer setShadowPath:[UIBezierPath bezierPathWithRect:self.view.bounds].CGPath];
    [self.view.layer setShadowOpacity:0.3f];
    [self.view.layer setShadowRadius:5.f];
    
    UIPanGestureRecognizer *panGestureRecongizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleModelViewPan:)];
    [panGestureRecongizer setDelegate:self];
    [self.view addGestureRecognizer:panGestureRecongizer];
    
    [self initFirstViewWithParameter:nil];
//    NSLog(@"%f,%f", self.view.frame.size.width, self.view.frame.size.height);
//    NSLog(@"%f  %f  %f  %f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
//    NSLog(@"%f  %f  %f  %f", self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height);
//    NSLog(@"%@", NSStringFromClass([self class]));
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //NSLog(@"destroy");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    // 此处做兼容处理需要加上ios6.0的宏开关，保证是在6.0下使用的,6.0以前屏蔽以下代码，否则会在下面使用self.view时自动加载viewDidLoad
    if ([self.view window] == nil)// 是否是正在使用的视图
    {
        // Add code to preserve data stored in the views that might be
        // needed later.
        
        // Add code to clean up other strong references to the view in
        // the view hierarchy.
        self.view = nil;// 目的是再次进入时能够重新加载调用viewDidLoad函数。
    }
}

- (void)initFirstViewWithParameter:(NSDictionary *)parameter {
    
}

#pragma mark - Views Transform

- (void)showNextView{
    if ([_currentView isEqual:_nextView]) {
        _nextView = nil;
    } else {
        [UIView animateWithDuration:0.f
                         animations:^{
                             _currentView.alpha = 0;
                             _nextView.alpha = 1;
                         }
                         completion:^(BOOL finished){
                             _currentView = _nextView;
                             _nextView = nil;
                         }];
    }
}

#pragma mark - Asynchronous Processing

- (void)addOperationToCoredateOperationWithOperation:(NSBlockOperation *)operation {
    //添加线程约束
    if ([SingleCase singleCase].coredataOperationQueue.operations.count > 0) {
        [operation addDependency:[[SingleCase singleCase].coredataOperationQueue.operations lastObject]];
    }
    //添加到线程池
    [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
}

#pragma mark - Wheel View Controll 底部摩天轮

- (void)wheelViewShouldHide {
    if (_delegate && [_delegate respondsToSelector:@selector(wheelViewShouldHide)]) {
        [_delegate wheelViewShouldHide];
    }
}

- (void)wheelViewTappedButton1 {
    
}

- (void)wheelViewTappedButton2 {
    
}

- (void)wheelViewTappedButton3 {
    
}

- (void)wheelViewTappedButton4 {
    
}

- (void)wheelViewTappedButton5 {
    
}

#pragma mark - View Push & Pop 滑动手势...

- (void)pushViewControllerWithViewControllerType:(ViewControllerType)viewControllerType andParameter:(NSDictionary *)parameter {
    if (_delegate && [_delegate respondsToSelector:@selector(pushViewControllerWithViewControllerType:andParameter:)]) {
        [_delegate pushViewControllerWithViewControllerType:viewControllerType andParameter:parameter];
    }
}

- (void)popToIndexViewController {
    if (_delegate && [_delegate respondsToSelector:@selector(popToIndexViewController)]) {
        [_delegate popToIndexViewController];
    }
}

- (void)handleModelViewPan:(id)sender
{
    if (_enableGesture) {
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)sender;
        CGPoint translation = [panGesture translationInView:panGesture.view];
        //NSLog(@"%@",panGesture.view)
        
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
                                     [self.view setFrame:CGRectMake(self.view.frame.size.width - 0.1f, 0, self.view.frame.size.width, self.view.frame.size.height)];
                                 } else {
                                     [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                                 }
                                 if (_delegate && [_delegate respondsToSelector:@selector(popViewControllerWithRatio:)]) {
                                     [_delegate popViewControllerWithRatio:1 - self.view.frame.origin.x / self.view.frame.size.width];
                                 }
                             } completion:^(BOOL finished){
                                 if (d == self.view.frame.size.width) {
                                     if (_delegate && [_delegate respondsToSelector:@selector(popViewControllerWithRatio:)]) {
                                         [_delegate popViewControllerWithRatio:0];
                                     }
                                     
                                 }
                             }];
        } else {
            if (translation.x > 0) {
                [self.view setFrame:CGRectMake(translation.x, 0, self.view.frame.size.width, self.view.frame.size.height)];
            }
            
            if (_delegate && [_delegate respondsToSelector:@selector(popViewControllerWithRatio:)]) {
                [_delegate popViewControllerWithRatio:1 - self.view.frame.origin.x / self.view.frame.size.width];
            }
            
        }
    }
}

#pragma mark - MPMoviePlayer

- (void)didTappedVideoWithVideoUrl:(NSString *)url {
    
    //NSURL *movieUrl = [NSURL URLWithString:@"http://sm.domob.cn/ugc/151397.mp4"];
    NSURL *movieUrl = [NSURL URLWithString:url];
    
    MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:movieUrl];
    [player.view setFrame:CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width)];
    player.view.transform = CGAffineTransformMakeRotation(M_PI_2);
    [self presentMoviePlayerViewControllerAnimated:player];

//    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:movieUrl options:nil];
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
//    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
//    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//    playerLayer.frame = self.view.layer.bounds;
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    
//    [self.view.layer addSublayer:playerLayer];
//    [player play];
    

//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSData *moiveSize = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://media4.cnlive.com:8080/00/00/06/20/mp4/620.mp4"]];
//        //NSData *moiveSize = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://sm.domob.cn/ugc/151397.mp4"]];
//        NSLog(@"[视频大小] = %.2f MB",moiveSize.length / 1024.f / 1024.f);
//    });

}

#pragma mark - Image Picker

- (void)didTappedImagePickerWithTpye:(NSString *)type {
    if ([type isEqualToString:@"camera"]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [imagePicker setAllowsEditing:YES];
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        //imagePicker.view.frame = CGRectMake(0, [self superview].bounds.size.height, [self superview].bounds.size.width, [self superview].bounds.size.height);
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        [imagePicker setAllowsEditing:YES];
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImageView *patientImage = [[UIImageView alloc] init];
    patientImage.frame = CGRectMake(625, 25, 83, 103);
    UIImage *newImage = info[UIImagePickerControllerEditedImage];
    
    float newWidth = newImage.size.width * 400 / newImage.size.height;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, 400));
    // 绘制改变大小的图片
    [newImage drawInRect:CGRectMake(0, 0, newWidth, 400)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:scaledImage forKey:@"image"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"getImage" object:dic];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Edit View

- (void)didTappedEditViewWithTpye:(int)type andMemberEntity:(MemberEntity *)memberEntity {
    EditView *editView = [[EditView alloc] init];
    editView.type = type;
    editView.memberEntity = memberEntity;
    [self presentViewController:editView animated:YES completion:nil];
}

#pragma mark - Alert View  

- (void)didTappedAlertButtonWithTheme:(NSString *)theme andContent:(UIView *)content {
    if (_delegate && [_delegate respondsToSelector:@selector(alertViewShowWithTheme:andContent:)]) {
        [_delegate alertViewShowWithTheme:theme andContent:content];
    }
}

@end
