//
//  IndexEntity.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/7.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ItemEntity.h"
#import "EventEntity.h"

@interface IndexEntity : NSObject

@property (strong, nonatomic) EventEntity*  mallEvent;
@property (strong, nonatomic) EventEntity*  shopEvent;
@property (strong, nonatomic) EventEntity*  shopEventTwo;

@property (strong, nonatomic) NSArray*      itemArray;

@property (strong, nonatomic) NSString*     advertisement;

+ (IndexEntity *)getIndexEntity;

@end
