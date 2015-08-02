//
//  ImageCoreDataHelper.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/26.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageCoreDataHelper : NSObject

+ (BOOL)addImage:(NSData *)image WithUrl:(NSString *)url;
+ (NSDictionary *)getAllImages;
+ (NSData *)getOneImageByUrl:(NSString *)url;
@end
