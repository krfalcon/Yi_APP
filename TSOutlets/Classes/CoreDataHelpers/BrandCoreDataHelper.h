//
//  BrandCoreDataHelper.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/9.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopEntity.h"

@interface BrandCoreDataHelper : NSObject

+ (ShopEntity *)setFavoriteBrandWithBrandID:(ShopEntity *)brand;

+ (NSString *)checkFavoriteSync;
+ (BOOL)syncFavorite;
+ (BOOL)clearFavorite;
+ (BOOL)setFavorite:(NSArray *)array;

@end
