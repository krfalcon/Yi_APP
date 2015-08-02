//
//  ConfigCoreDataHelper.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/27.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigCoreDataHelper : NSObject

+ (BOOL)setUpdateDate:(NSString *)datetime;

+ (NSString *)getUpdateDate;
+ (BOOL)checkAppGuideSign:(NSString *)guideSign;

@end
