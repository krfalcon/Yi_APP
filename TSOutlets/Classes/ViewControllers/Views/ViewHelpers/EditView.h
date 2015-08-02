//
//  EditView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/10.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberEntity.h"

typedef NS_ENUM(NSInteger, EditType) {
    EditTypeName = 0,
    EditTypeGender,
    EditTypePhone,
    EditTypeFeedback,
    EditTypeAddress
};

@interface EditView : UIViewController
{
    UIScrollView*                                           scrollView;
    
    NSTimer*                                                timer;
    int                                                     timeLeft;
}

@property (assign, nonatomic) EditType                  type;
@property (weak,nonatomic) MemberEntity*                memberEntity;

@end
