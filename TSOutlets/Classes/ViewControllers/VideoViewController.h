//
//  VideoViewController.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/9.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MotherViewController.h"

#import "VideoEntity.h"

//#import "VideoShopView.h"
#import "VideoBrandView.h"
#import "VideoMallView.h"

@interface VideoViewController : MotherViewController<VideoBrandViewDelegate, VideoMallViewDelegate>
{
    NSArray*                                            originShopVideoArray;
    
    NSString*                                           currentString;
    
    VideoMallView*                                      videoMallView;
    VideoBrandView*                                     videoBrandView;
}


@end
