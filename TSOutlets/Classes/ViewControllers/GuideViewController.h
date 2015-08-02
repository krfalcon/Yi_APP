//
//  GuideViewController.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController <UIScrollViewDelegate>
{
    UIScrollView*                           guideScrollView;
    UIImageView*                            guideDirect;
    NSTimer*                                timer;
}

@end
