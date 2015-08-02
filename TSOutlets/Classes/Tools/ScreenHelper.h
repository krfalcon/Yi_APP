//
//  ScreenHelper.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/17.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#ifndef TSOutlets_ScreenHelper_h
#define TSOutlets_ScreenHelper_h

#endif

#define iPhone4 ([[UIScreen mainScreen] bounds].size.height == 480)
#define iPhone5 ([[UIScreen mainScreen] bounds].size.height == 568)
#define iPhone6 ([[UIScreen mainScreen] bounds].size.height == 667)
#define iPhone6Plus ([[UIScreen mainScreen] bounds].size.height == 736)
#define iPhone6PlusScreenRect CGRectMake(0, 0, 414, 736);
#define iPhone6ScreenRect CGRectMake(0, 0, 375, 667);
#define iPhone5ScreenRect CGRectMake(0, 0, 320, 568);
#define iPhone4ScreenRect CGRectMake(0, 0, 320, 480);
#define iPhone5ScreenRectIOS6 CGRectMake(0, -20, 320, 568);
#define iPhone4ScreenRectIOS6 CGRectMake(0, -20, 320, 480);
#define SYS_VER [[[UIDevice currentDevice] systemVersion] floatValue]

#define DeviceInfo [NSString stringWithFormat:@"%@ %@",[[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]]

#define iPhone6Scale 375.f/320.f
#define iPhone6PlusScale 414.f/320.f

//frame

#define selfWidth self.frame.size.width
#define selfHeight self.frame.size.height

//Guide Sign
#define GuideSign_App  @"GUIDE_SIGN_1_0_APP"
#define GuideSign_Index @"GUIDE_SIGN_1_0_INDEX"

//Public Color

#define Color(r,g,b,a)          [UIColor colorWithRed:    r/255.f green:    g/255.f blue:    b/255.f alpha:a]

#define AbsoluteBlack           [UIColor colorWithRed:  0.f/255.f green:  0.f/255.f blue:  0.f/255.f alpha:1]
#define AbsoluteWhite           [UIColor colorWithRed:255.f/255.f green:255.f/255.f blue:255.f/255.f alpha:1]
#define AbsoluteClear           [UIColor clearColor]

#define AllScale self.frame.size.width / 375.f

//Colors

//Red

#define ThemeRed                [UIColor colorWithRed:255.f/255.f green: 79.f/255.f blue:104.f/255.f alpha:1]

#define ThemeRed_255_184_194    [UIColor colorWithRed:255.f/255.f green:184.f/255.f blue:194.f/255.f alpha:1]
#define ThemeRed_255_231_237    [UIColor colorWithRed:255.f/255.f green:231.f/255.f blue:237.f/255.f alpha:1]
#define ThemeRed_136_028_018    [UIColor colorWithRed:136.f/255.f green: 28.f/255.f blue: 18.f/255.f alpha:1]
#define ThemeRed_103_014_014    [UIColor colorWithRed:103.f/255.f green: 14.f/255.f blue: 14.f/255.f alpha:1]

//Blue

#define ThemeBlue               [UIColor colorWithRed:  0.f/255.f green:157.f/255.f blue:239.f/255.f alpha:1]

#define ThemeBlue_123_204_225   [UIColor colorWithRed:124.f/255.f green:205.f/255.f blue:255.f/255.f alpha:1]
#define ThemeBlue_028_188_255   [UIColor colorWithRed: 28.f/255.f green:188.f/255.f blue:255.f/255.f alpha:1]
#define ThemeBlue_177_231_255   [UIColor colorWithRed:177.f/255.f green:231.f/255.f blue:255.f/255.f alpha:1]
#define ThemeBlue_018_050_085   [UIColor colorWithRed: 18.f/255.f green: 50.f/255.f blue: 85.f/255.f alpha:1]
#define ThemeBlue_232_248_255   [UIColor colorWithRed:232.f/255.f green:248.f/255.f blue:255.f/255.f alpha:1]

//Yellow

#define ThemeYellow             [UIColor colorWithRed:255.f/255.f green:180.f/255.f blue: 92.f/255.f alpha:1]
#define ThemeYellowOrange       [UIColor colorWithRed:255.f/255.f green:142.f/255.f blue:107.f/255.f alpha:1]


#define ThemeYellowHint         [UIColor colorWithRed:189.f/255.f green:177.f/255.f blue:162.f/255.f alpha:1]
#define ThemeYellowTitle        [UIColor colorWithRed:121.f/255.f green: 74.f/255.f blue: 29.f/255.f alpha:1]
#define ThemeYellowFont         [UIColor colorWithRed:170.f/255.f green:104.f/255.f blue: 24.f/255.f alpha:1]