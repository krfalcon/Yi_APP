//
//  IndexView.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/18.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "TempletView.h"
#import "CarouselScrollView.h"
#import "IndexEntity.h"
#import "ArticleCoreDataHelper.h"

@protocol IndexViewDelegate;

@interface IndexView : TempletView<UIScrollViewDelegate,MDIncrementalImageViewDelegate>
{
    UIScrollView*                                       indexScrollView;
    
    UIView*                                             topView;
    
    UIView*                                             pageOneView;
    UIView*                                             pageTwoView;
    
    UIButton*                                           mallEventButton;
    UIButton*                                           shopEventButton;
    UIButton*                                           shopEventTwoButton;
    UIScrollView*                                       itemScrollView;
}

@property (strong, nonatomic) id<IndexViewDelegate>     delegate;
@property (strong, nonatomic) IndexEntity*              indexEntity;

@end

@protocol IndexViewDelegate <NSObject>

- (void)indexViewDidTappedButton:(IndexView *)indexView withType:(ViewControllerType)type andParameter:(NSDictionary *)parameter;

@end