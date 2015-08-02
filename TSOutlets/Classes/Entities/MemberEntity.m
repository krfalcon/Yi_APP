//
//  MemberEntity.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MemberEntity.h"

@implementation MemberEntity

@synthesize memberID;
@synthesize name;
@synthesize nickName;
@synthesize gender;
@synthesize phone;
@synthesize image;
@synthesize token;
@synthesize portrait;
@synthesize login;

#pragma mark - online part

@synthesize province;
@synthesize city;
@synthesize area;
@synthesize address;
@synthesize zipcode;
@synthesize receiver;

#pragma mark - online part

@synthesize onlineNumber;
@synthesize onlinePoint;
@synthesize onlineLevel;
@synthesize onlineTotalPoint;
@synthesize onlineNextPoint;
@synthesize onlineNextLevel;
@synthesize onlinePrivilege;
@synthesize onlineHistory;

#pragma mark - offline part

@synthesize offlineNumber;
@synthesize offlineName;
@synthesize offlinePhone;
@synthesize offlinePoint;
@synthesize offlineTotalPoint;
@synthesize offlinePrivilege;
@synthesize offlineHistory;

+ (MemberEntity *)getDefaultMemberEntity {
    MemberEntity *memberEntity = [[MemberEntity alloc] init];
    
    memberEntity.name = @"";
    memberEntity.nickName = @"昵称";
    memberEntity.phone = @"00000000000";
    memberEntity.gender = @"男";
    
    memberEntity.onlineNumber = @"No.0";
    memberEntity.onlinePoint = @"0";
    
    memberEntity.offlineNumber = @"未绑定";
    memberEntity.offlinePoint = @"0";
    
    memberEntity.province = @"";
    memberEntity.city = @"";
    memberEntity.area = @"";
    memberEntity.address = @"";
    memberEntity.zipcode = @"";
    memberEntity.receiver = @"";
    
    return memberEntity;
}

@end
