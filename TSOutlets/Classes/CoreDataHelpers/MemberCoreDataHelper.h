//
//  MemberCoreDataHelper.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/8.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberEntity.h"

@interface MemberCoreDataHelper : NSObject

+ (MemberEntity *)getMemberEntity;

+ (BOOL)checkLoginStatus;
+ (BOOL)checkSync;

+ (BOOL)loginMemberAndSaveMember:(MemberEntity *)memberEntity;
+ (BOOL)updateMemberInfo:(MemberEntity *)memberEntity;
+ (BOOL)syncMemberInfo;
+ (BOOL)logoutMember;

+ (NSString *)getMemberToken;
+ (NSString *)getDeviceInfo;

@end
