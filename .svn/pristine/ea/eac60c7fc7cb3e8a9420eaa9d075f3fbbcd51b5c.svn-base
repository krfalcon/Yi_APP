//
//  EditView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/10.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "EditView.h"
#import "ScreenHelper.h"
#import "InputView.h"

@interface EditView ()

@end

@implementation EditView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:AbsoluteWhite];
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [scrollView setBackgroundColor:AbsoluteWhite];
    if (iPhone4) [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, 568.f)];
    [self.view addSubview:scrollView];
    
    UIView *navigation = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, 64.f)];
    navigation.backgroundColor = ThemeRed;
    [self.view addSubview:navigation];
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 44)];
    [cancel addTarget:self action:@selector(tappedCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [navigation addSubview:cancel];
    
    UILabel *cancelLabel = [[UILabel alloc] initWithFrame:cancel.bounds];
    cancelLabel.backgroundColor = AbsoluteClear;
    cancelLabel.text = @"取消";
    cancelLabel.textColor = AbsoluteWhite;
    cancelLabel.textAlignment = NSTextAlignmentCenter;
    cancelLabel.font = [UIFont boldSystemFontOfSize:16.f];
    [cancel addSubview:cancelLabel];
    
    UIButton *commit = [[UIButton alloc] initWithFrame:CGRectMake(scrollView.frame.size.width - 60, 20, 60, 44)];
    [commit addTarget:self action:@selector(tappedCommitButton) forControlEvents:UIControlEventTouchUpInside];
    [navigation addSubview:commit];
    
    UILabel *commitLabel = [[UILabel alloc] initWithFrame:commit.bounds];
    commitLabel.backgroundColor = AbsoluteClear;
    commitLabel.text = @"确认";
    commitLabel.textColor = AbsoluteWhite;
    commitLabel.textAlignment = NSTextAlignmentCenter;
    commitLabel.font = [UIFont boldSystemFontOfSize:16.f];
    [commit addSubview:commitLabel];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, scrollView.frame.size.width, 44.f)];
    title.backgroundColor = AbsoluteClear;
    title.text = @"标题来一个";
    title.textColor = AbsoluteWhite;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont boldSystemFontOfSize:20.f];
    [navigation addSubview:title];
    
    switch (_type) {
        case EditTypeName:
        {
            title.text = @"编辑姓名";
            
            UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80.f, 80.f, 40.f)];
            nickLabel.backgroundColor = AbsoluteClear;
            nickLabel.text = @"昵称:";
            nickLabel.textColor = ThemeRed;
            nickLabel.textAlignment = NSTextAlignmentCenter;
            nickLabel.font = [UIFont systemFontOfSize:16];
            [scrollView addSubview:nickLabel];
            
            InputView *nickText = [[InputView alloc] initWithFrame:CGRectMake(90, 80.f, scrollView.frame.size.width - 100.f, 40.f) andTheme:@"Red" andPlaceholder:@"" andScale:1];
            nickText.text = _memberEntity.nickName;
            nickText.placeholder = @"请输入您的昵称";
            nickText.font = [UIFont systemFontOfSize:18];
            nickText.tag = 101;
            [scrollView addSubview:nickText];
            
//            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 140.f, 80.f, 40.f)];
//            nameLabel.backgroundColor = AbsoluteClear;
//            nameLabel.text = @"姓名:";
//            nameLabel.textColor = ThemeRed;
//            nameLabel.textAlignment = NSTextAlignmentCenter;
//            nameLabel.font = [UIFont systemFontOfSize:16];
//            [scrollView addSubview:nameLabel];
//            
//            InputView *nameText = [[InputView alloc] initWithFrame:CGRectMake(90, 140.f, scrollView.frame.size.width - 100.f, 40.f) andTheme:@"Red" andPlaceholder:@"" andScale:1];
//            nameText.text = _memberEntity.name;
//            nameText.placeholder = @"请输入您的姓名";
//            nameText.font = [UIFont systemFontOfSize:18];
//            nameText.tag = 102;
//            [scrollView addSubview:nameText];
            
            [nickText becomeFirstResponder];
            
            break;
        }
        case EditTypeGender:
        {
            title.text = @"编辑性别";
            
            UIButton *male = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, scrollView.frame.size.width, 40.f)];
            male.tag = 201;
            male.exclusiveTouch = YES;
            [male addTarget:self action:@selector(tappedGenderButton:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:male];
            
            UILabel *maleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80.f, 40.f)];
            maleLabel.text = @"男";
            maleLabel.backgroundColor = AbsoluteClear;
            maleLabel.textColor = ThemeRed;
            maleLabel.textAlignment = NSTextAlignmentCenter;
            maleLabel.font = [UIFont systemFontOfSize:16];
            [male addSubview:maleLabel];
            
            UIButton *female = [[UIButton alloc] initWithFrame:CGRectMake(0, 140, scrollView.frame.size.width, 40.f)];
            female.tag = 202;
            female.exclusiveTouch = YES;
            [female addTarget:self action:@selector(tappedGenderButton:) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:female];
            
            UILabel *femaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80.f, 40.f)];
            femaleLabel.text = @"女";
            femaleLabel.backgroundColor = AbsoluteClear;
            femaleLabel.textColor = ThemeRed;
            femaleLabel.textAlignment = NSTextAlignmentCenter;
            femaleLabel.font = [UIFont systemFontOfSize:16];
            [female addSubview:femaleLabel];
            
            UIView *selected = [[UIView alloc] initWithFrame:CGRectMake(5, 85, scrollView.frame.size.width - 10, 30)];
            selected.layer.borderWidth = 1.5;
            selected.layer.borderColor = ThemeRed.CGColor;
            selected.userInteractionEnabled = NO;
            selected.tag = 203;
            [scrollView addSubview:selected];
            
            if ([_memberEntity.gender isEqualToString:@"女"]) {
                selected.transform = CGAffineTransformMakeTranslation(0, 60);
            }
            
            break;
        }
        case EditTypePhone:
        {
            title.text = @"编辑电话";
            
            UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80.f, 80.f, 40.f)];
            nickLabel.backgroundColor = AbsoluteClear;
            nickLabel.text = @"手机号:";
            nickLabel.textColor = ThemeRed;
            nickLabel.textAlignment = NSTextAlignmentCenter;
            nickLabel.font = [UIFont systemFontOfSize:16];
            [scrollView addSubview:nickLabel];
            
            InputView *nickText = [[InputView alloc] initWithFrame:CGRectMake(90, 80.f, scrollView.frame.size.width - 100.f, 40.f) andTheme:@"Red" andPlaceholder:@"" andScale:1];
            nickText.text = _memberEntity.phone;
            nickText.placeholder = @"请输入您的手机号码";
            nickText.font = [UIFont systemFontOfSize:18];
            nickText.tag = 301;
            [scrollView addSubview:nickText];
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 140.f, 80.f, 40.f)];
            nameLabel.backgroundColor = AbsoluteClear;
            nameLabel.text = @"验证码:";
            nameLabel.textColor = ThemeRed;
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.font = [UIFont systemFontOfSize:16];
            [scrollView addSubview:nameLabel];
            
            InputView *nameText = [[InputView alloc] initWithFrame:CGRectMake(90, 140.f, scrollView.frame.size.width - 210.f, 40.f) andTheme:@"Red" andPlaceholder:@"" andScale:1];
            nameText.placeholder = @"请输入验证码";
            nameText.font = [UIFont systemFontOfSize:18];
            nameText.tag = 302;
            [scrollView addSubview:nameText];
            
            UIButton *identifyingButton = [[UIButton alloc] initWithFrame:CGRectMake(scrollView.frame.size.width - 110, 140.f, 100.f, 40.f)];
            [identifyingButton setExclusiveTouch:YES];
            [identifyingButton addTarget:self action:@selector(getIdentifyingCode) forControlEvents:UIControlEventTouchUpInside];
            [scrollView addSubview:identifyingButton];
            
            UILabel *buttonLabel = [[UILabel alloc] initWithFrame:identifyingButton.bounds];
            buttonLabel.layer.cornerRadius = buttonLabel.frame.size.height / 2;
            buttonLabel.layer.backgroundColor = ThemeRed.CGColor;
            buttonLabel.tag = 99;
            buttonLabel.text = @"获取";
            buttonLabel.textColor = AbsoluteWhite;
            buttonLabel.textAlignment = NSTextAlignmentCenter;
            buttonLabel.font = [UIFont boldSystemFontOfSize:18];
            [identifyingButton addSubview:buttonLabel];
            
            [nickText becomeFirstResponder];
            
            break;
        }
        case 3:
        {
            title.text = @"反馈";
            navigation.backgroundColor = ThemeYellow;
            
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64.f, scrollView.frame.size.width, scrollView.frame.size.height - 64.f)];
            [textView setFont:[UIFont systemFontOfSize:20]];
            [textView setTag:301];
            [scrollView addSubview:textView];
            
            [textView becomeFirstResponder];
            
            break;
        }
        case 4:
        {
            title.text = @"编辑收件地址";
            
            UILabel *provinceLabel = [[UILabel alloc] initWithFrame:CGRectMake(scrollView.frame.size.width - 40.f, 80.f, 40.f, 35.f)];
            provinceLabel.backgroundColor = AbsoluteClear;
            provinceLabel.text = @"省";
            provinceLabel.textColor = ThemeRed;
            provinceLabel.textAlignment = NSTextAlignmentCenter;
            provinceLabel.font = [UIFont systemFontOfSize:20];
            [scrollView addSubview:provinceLabel];
            
            InputView *provinceText = [[InputView alloc] initWithFrame:CGRectMake(10, 80.f, scrollView.frame.size.width - 50.f, 35.f) andTheme:@"Red" andPlaceholder:@"" andScale:1];
            provinceText.text = _memberEntity.province;
            provinceText.placeholder = @"直辖市可以略过此条不填";
            provinceText.font = [UIFont systemFontOfSize:16];
            provinceText.tag = 401;
            [scrollView addSubview:provinceText];
            
            [provinceText becomeFirstResponder];
            
            UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(scrollView.frame.size.width / 2 - 40.f, 130.f, 40.f, 35.f)];
            cityLabel.backgroundColor = AbsoluteClear;
            cityLabel.text = @"市";
            cityLabel.textColor = ThemeRed;
            cityLabel.textAlignment = NSTextAlignmentCenter;
            cityLabel.font = [UIFont systemFontOfSize:20];
            [scrollView addSubview:cityLabel];
            
            InputView *cityText = [[InputView alloc] initWithFrame:CGRectMake(10, 130.f, scrollView.frame.size.width / 2 - 50.f, 35.f) andTheme:@"Red" andPlaceholder:@"" andScale:1];
            cityText.text = _memberEntity.city;
            cityText.font = [UIFont systemFontOfSize:16];
            cityText.tag = 402;
            [scrollView addSubview:cityText];
            
            UILabel *areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(scrollView.frame.size.width - 40.f, 130.f, 40.f, 35.f)];
            areaLabel.backgroundColor = AbsoluteClear;
            areaLabel.text = @"区";
            areaLabel.textColor = ThemeRed;
            areaLabel.textAlignment = NSTextAlignmentCenter;
            areaLabel.font = [UIFont systemFontOfSize:20];
            [scrollView addSubview:areaLabel];
            
            InputView *areaText = [[InputView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width / 2 + 10, 130.f, scrollView.frame.size.width / 2 - 50.f, 35.f) andTheme:@"Red" andPlaceholder:@"" andScale:1];
            areaText.text = _memberEntity.area;
            areaText.font = [UIFont systemFontOfSize:16];
            areaText.tag = 403;
            [scrollView addSubview:areaText];
            
            UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 180.f, 40.f, 35.f)];
            addressLabel.backgroundColor = AbsoluteClear;
            addressLabel.text = @"地址";
            addressLabel.textColor = ThemeRed;
            addressLabel.textAlignment = NSTextAlignmentLeft;
            addressLabel.font = [UIFont systemFontOfSize:20];
            [scrollView addSubview:addressLabel];
            
            InputView *addressText = [[InputView alloc] initWithFrame:CGRectMake(60, 180.f, scrollView.frame.size.width - 70.f, 35.f) andTheme:@"Red" andPlaceholder:@"" andScale:1];
            addressText.text = _memberEntity.address;
            addressText.font = [UIFont systemFontOfSize:16];
            addressText.tag = 404;
            [scrollView addSubview:addressText];
            
            UILabel *zipcodeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 230.f, 40.f, 35.f)];
            zipcodeLabel.backgroundColor = AbsoluteClear;
            zipcodeLabel.text = @"邮编";
            zipcodeLabel.textColor = ThemeRed;
            zipcodeLabel.textAlignment = NSTextAlignmentLeft;
            zipcodeLabel.font = [UIFont systemFontOfSize:20];
            [scrollView addSubview:zipcodeLabel];
            
            InputView *zipcodeText = [[InputView alloc] initWithFrame:CGRectMake(60, 230.f, scrollView.frame.size.width - 70.f, 35.f) andTheme:@"Red" andPlaceholder:@"" andScale:1];
            zipcodeText.text = _memberEntity.zipcode;
            zipcodeText.font = [UIFont systemFontOfSize:16];
            zipcodeText.tag = 405;
            [scrollView addSubview:zipcodeText];
            
            UILabel *receiverLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 280.f, 60.f, 35.f)];
            receiverLabel.backgroundColor = AbsoluteClear;
            receiverLabel.text = @"收件人";
            receiverLabel.textColor = ThemeRed;
            receiverLabel.textAlignment = NSTextAlignmentLeft;
            receiverLabel.font = [UIFont systemFontOfSize:20];
            [scrollView addSubview:receiverLabel];
            
            InputView *receiverText = [[InputView alloc] initWithFrame:CGRectMake(80, 280.f, scrollView.frame.size.width - 90.f, 35.f) andTheme:@"Red" andPlaceholder:@"" andScale:1];
            receiverText.text = _memberEntity.receiver;
            receiverText.font = [UIFont systemFontOfSize:16];
            receiverText.tag = 406;
            [scrollView addSubview:receiverText];
            
        }
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Events

- (void)tappedGenderButton:(UIButton *)button {
    switch (button.tag) {
        case 201:
            [scrollView viewWithTag:203].transform = CGAffineTransformMakeTranslation(0, 0);
            break;
        case 202:
            [scrollView viewWithTag:203].transform = CGAffineTransformMakeTranslation(0, 60);
            break;
        default:
            break;
    }
}

- (void)tappedCancelButton {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldHideKeyboard" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tappedCommitButton {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldHideKeyboard" object:nil];
    
    switch (_type) {
        case EditTypeName:
            _memberEntity.nickName  = [(UITextField *)[scrollView viewWithTag:101] text];
            _memberEntity.name      = [(UITextField *)[scrollView viewWithTag:102] text];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMemberInfo" object:_memberEntity];
            break;
        case EditTypeGender:
            if ([scrollView viewWithTag:203].transform.ty == 0) {
                _memberEntity.gender = @"男";
            } else {
                _memberEntity.gender = @"女";
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMemberInfo" object:_memberEntity];
            break;
        case EditTypeFeedback:
            if ([[(UITextField *)[scrollView viewWithTag:301] text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"postFeedback" object:[(UITextField *)[scrollView viewWithTag:301] text]];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"请输入反馈内容！"];
                return;
            }
            break;
        case EditTypeAddress:
            _memberEntity.province  = [(UITextField *)[scrollView viewWithTag:401] text];
            _memberEntity.city      = [(UITextField *)[scrollView viewWithTag:402] text];
            _memberEntity.area      = [(UITextField *)[scrollView viewWithTag:403] text];
            _memberEntity.address   = [(UITextField *)[scrollView viewWithTag:404] text];
            _memberEntity.zipcode   = [(UITextField *)[scrollView viewWithTag:405] text];
            _memberEntity.receiver  = [(UITextField *)[scrollView viewWithTag:406] text];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updateMemberInfo" object:_memberEntity];
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Update Phone


- (void)getIdentifyingCode {
    [(UILabel *)[scrollView viewWithTag:99] setText:@"60秒后重新获取"];
    [(UILabel *)[scrollView viewWithTag:99] setFont:[UIFont boldSystemFontOfSize:12]];
    [[(UILabel *)[scrollView viewWithTag:99] layer] setBackgroundColor:Color(161, 161, 161, 1).CGColor];
    [(UIButton *)[[scrollView viewWithTag:99] superview] setEnabled:NO];
    timeLeft = 60;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tiktok) userInfo:nil repeats:YES];
    
    //返回当前的消息循环对象
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}


- (void)tiktok {
    timeLeft --;
    if (timeLeft == 0) {
        [(UILabel *)[scrollView viewWithTag:99] setText:@"获取"];
        [(UILabel *)[scrollView viewWithTag:99] setFont:[UIFont boldSystemFontOfSize:18]];
        [[(UILabel *)[scrollView viewWithTag:99] layer] setBackgroundColor:ThemeRed.CGColor];
        [(UIButton *)[[scrollView viewWithTag:99] superview] setEnabled:YES];
        
        [timer invalidate];
        timer = nil;
    } else {
        [(UILabel *)[self.view viewWithTag:99] setText:[NSString stringWithFormat:@"%d秒后重新获取", timeLeft]];
    }
}

@end
