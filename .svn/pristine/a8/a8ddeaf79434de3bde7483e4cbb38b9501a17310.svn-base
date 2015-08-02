//
//  MemberEntity.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/19.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberEntity : NSObject

@property (strong, nonatomic) NSString*  memberID;
@property (strong, nonatomic) NSString*  name;
@property (strong, nonatomic) NSString*  nickName;
@property (strong, nonatomic) NSString*  gender;
@property (strong, nonatomic) NSString*  phone;
@property (strong, nonatomic) NSString*  image;
@property (strong, nonatomic) NSString*  token;
@property (strong, nonatomic) NSData*    portrait;
@property (assign, nonatomic) BOOL       login;

#pragma mark - address part

@property (strong, nonatomic) NSString*  province;
@property (strong, nonatomic) NSString*  city;
@property (strong, nonatomic) NSString*  area;
@property (strong, nonatomic) NSString*  address;
@property (strong, nonatomic) NSString*  zipcode;
@property (strong, nonatomic) NSString*  receiver;

#pragma mark - online part

@property (strong, nonatomic) NSString*  onlineNumber;
@property (strong, nonatomic) NSString*  onlinePoint;
@property (strong, nonatomic) NSString*  onlineLevel;
@property (strong, nonatomic) NSString*  onlineTotalPoint;
@property (strong, nonatomic) NSString*  onlineNextPoint;
@property (strong, nonatomic) NSString*  onlineNextLevel;
@property (strong, nonatomic) NSArray*   onlinePrivilege;
@property (strong, nonatomic) NSArray*   onlineHistory;

#pragma mark - offline part

@property (strong, nonatomic) NSString*  offlineNumber;
@property (strong, nonatomic) NSString*  offlineName;
@property (strong, nonatomic) NSString*  offlinePhone;
@property (strong, nonatomic) NSString*  offlinePoint;
@property (strong, nonatomic) NSString*  offlineTotalPoint;
@property (strong, nonatomic) NSString*  offlinePrivilege;
@property (strong, nonatomic) NSString*  offlineHistory;

+ (MemberEntity *)getDefaultMemberEntity;

@end
