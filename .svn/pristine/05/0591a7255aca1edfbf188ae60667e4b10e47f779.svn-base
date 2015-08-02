//
//  MemberAPITool.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/1.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MemberCoreDataHelper.h"
#import "ConfigCoreDataHelper.h"
#import "BrandCoreDataHelper.h"

@interface MemberAPITool : NSObject<NSURLConnectionDelegate>
{
    NSMutableData* loginData;
    NSMutableData* confirmData;
    NSMutableData* uploadPortraitData;
    NSMutableData* uploadInfoData;
    NSMutableData* verificationData;
    NSMutableData* registerData;
    NSMutableData* resetData;
    NSMutableData* deviceData;
    
    NSMutableData* setFaveriteData;
    NSMutableData* getFaveriteData;
    
    NSMutableData* onlinePointsData;
    NSMutableData* onlineHistoryData;
    NSMutableData* offlinePointsData;
    NSMutableData* offlineHistoryData;
    NSMutableData* offlineBindData;
    
    NSURLConnection* loginConnection;
    NSURLConnection* confirmConnection;
    NSURLConnection* uploadPortraitConnection;
    NSURLConnection* uploadInfoConnection;
    NSURLConnection* verificationConnection;
    NSURLConnection* registerConnection;
    NSURLConnection* resetConnection;
    NSURLConnection* deviceConnection;
    
    NSURLConnection* setFaveriteConnection;
    NSURLConnection* getFaveriteConnection;
    
    NSURLConnection* onlinePointsConnection;
    NSURLConnection* onlineHistoryConnection;
    NSURLConnection* offlinePointsConnection;
    NSURLConnection* offlineHistoryConnection;
    NSURLConnection* offlineBindConnection;
}

@property (strong,nonatomic) MemberEntity*      memberEntity;

#pragma mark - network
- (void)loginWithPhone:(NSString *)phone andPassword:(NSString *)password;
- (void)confirmAuthentication;
- (void)uploadMemberPortrait:(NSData *)portrait;
- (void)uploadMemberInfo:(MemberEntity *)member;

- (void)getVerificationCodeWithPhone:(NSString *)phone;
- (void)registerMemberWithPhone:(NSString *)phone andPassword:(NSString *)password andVerificationCode:(NSString *)verification;
- (void)resetPasswordWithPhone:(NSString *)phone andPassword:(NSString *)password andVerificationCode:(NSString *)verification;
- (void)uploadDeviceInfo;

//favorite stuff
- (void)setFavoriteWithBrandID:(NSString *)brandID;
- (void)getFavorites;

//points stuff
- (void)getOnlinePoints;
- (void)getOnlinePointsHistory;
- (void)getOfflinePoints;
- (void)getOfflinePointsHistory;
- (void)bindOfflineCardWithPhone:(NSString *)phone andName:(NSString *)name andCard:(NSString *)card andVerificationCode:(NSString *)verification;

#pragma mark - local
- (BOOL)checkMemberSync;
- (MemberEntity *)getMemberEntity;
- (BOOL)updateMemberInfo:(MemberEntity *)memberEntity;
- (BOOL)updateMemberPortrait:(MemberEntity *)memberEntity;
- (BOOL)syncMemberInfo;
- (BOOL)getLoginStatus;
- (BOOL)loginMemberAndSaveMember:(MemberEntity *)memberEntity;
- (BOOL)logoutMember;

//favorite stuff
- (NSString *)checkFavoriteSync;
- (BOOL)updateFavoriteBrandWithBrandIDs:(NSArray *)brandIDs;
- (ShopEntity *)setLocalFavoriteWithBrandID:(ShopEntity *)brand;
- (BOOL)syncFavorite;
- (BOOL)clearFavorite;

//congfig stuff
- (NSString *)getLastUpdateDate;
- (BOOL)checkAppGuideSign:(NSString *)guideSign;

- (NSString *)getMemberToken;
- (NSString *)getDeviceInfo;

@end
