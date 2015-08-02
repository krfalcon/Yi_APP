//
//  MessageEntity.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/7/2.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageEntity : NSObject

@property (strong, nonatomic) NSString *messageID;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *point;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSObject *entity;

+ (NSArray *)information2MessageArray:(NSArray *)information;

@end
