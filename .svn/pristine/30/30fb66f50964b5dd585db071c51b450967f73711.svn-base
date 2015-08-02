//
//  MemberAPITool.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/1.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MemberAPITool.h"
#import "JSONHelper.h"
#import "WsAddrHelper.h"
#import "SingleCase.h"
#import "HTTPPostDataGenerator.h"

@implementation MemberAPITool

#pragma mark - network
- (void)loginWithPhone:(NSString *)phone andPassword:(NSString *)password {
    NSString *wsAddress = [NSString stringWithFormat:@"%@CRM/Login?mobilePhone=%@&password=%@&mobileField=%@&clientId=%@", APIAddr, phone, password, [MemberCoreDataHelper getDeviceInfo], [SingleCase singleCase].clientID];
    if ([SingleCase singleCase].deviceToken) { wsAddress = [wsAddress stringByAppendingString:[NSString stringWithFormat:@"&deviceToken=%@", [SingleCase singleCase].deviceToken]]; }
    //NSLog(@"%@", wsAddress);
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    loginConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (loginConnection) {
    }
}

- (void)confirmAuthentication {
    NSString *wsAddress = [NSString stringWithFormat:@"%@CRM/Authentication?token=%@", APIAddr, [MemberCoreDataHelper getMemberToken]];
    //NSLog(@"%@", wsAddress);
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    confirmConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (confirmConnection) {
    }
}

- (void)uploadMemberPortrait:(NSData *)portrait {
    NSString *wsAddress = [NSString stringWithFormat:@"%@CRM/UploadPortraitTest", APIAddr];
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    NSMutableDictionary* post_dict = [[NSMutableDictionary alloc] init];
    [post_dict setObject:[MemberCoreDataHelper getMemberToken] forKey:@"token"];
    [post_dict setObject:portrait forKey:@"filedata"];
    
    NSData *postData = [HTTPPostDataGenerator generateFormDataFromPostDictionary:post_dict];
    [request setValue:MULTIPART forHTTPHeaderField: @"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    uploadPortraitConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (uploadPortraitConnection) {
    }
}

- (void)uploadMemberInfo:(MemberEntity *)member {
    NSString *wsAddress = [NSString stringWithFormat:@"%@CRM/ModifyCustomer?token=%@", APIAddr, [MemberCoreDataHelper getMemberToken]];
    if (member.gender && member.gender.length != 0)         wsAddress = [wsAddress stringByAppendingString:[NSString stringWithFormat:@"&gender=%@", member.gender]];
    //if (member.name && member.name.length != 0)             wsAddress = [wsAddress stringByAppendingString:[NSString stringWithFormat:@"&name=%@", member.name]];
    if (member.nickName && member.nickName.length != 0)     wsAddress = [wsAddress stringByAppendingString:[NSString stringWithFormat:@"&nickname=%@", member.nickName]];
    if (member.province && member.province.length != 0)     wsAddress = [wsAddress stringByAppendingString:[NSString stringWithFormat:@"&province=%@", member.province]];
    if (member.city && member.city.length != 0)             wsAddress = [wsAddress stringByAppendingString:[NSString stringWithFormat:@"&city=%@", member.city]];
    if (member.area && member.area.length != 0)             wsAddress = [wsAddress stringByAppendingString:[NSString stringWithFormat:@"&area=%@", member.area]];
    if (member.address && member.address.length != 0)       wsAddress = [wsAddress stringByAppendingString:[NSString stringWithFormat:@"&address=%@", member.address]];
    if (member.zipcode && member.zipcode.length != 0)       wsAddress = [wsAddress stringByAppendingString:[NSString stringWithFormat:@"&zipcode=%@", member.zipcode]];
    if (member.receiver && member.receiver.length != 0)     wsAddress = [wsAddress stringByAppendingString:[NSString stringWithFormat:@"&receiver=%@", member.receiver]];
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    uploadInfoConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (uploadInfoConnection) {
    }
}

- (void)getVerificationCodeWithPhone:(NSString *)phone {
    NSString *wsAddress = [NSString stringWithFormat:@"%@CRM/GetVerificationCode?token=%@&mobilePhone=%@", APIAddr, [MemberCoreDataHelper getMemberToken], phone];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    verificationConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (verificationConnection) {
    }
}

- (void)registerMemberWithPhone:(NSString *)phone andPassword:(NSString *)password andVerificationCode:(NSString *)verification {
    NSString *wsAddress = [NSString stringWithFormat:@"%@CRM/Registered?token=%@&mobilePhone=%@&password=%@&code=%@&mobileField=%@&clientId=%@", APIAddr, [MemberCoreDataHelper getMemberToken], phone, password, verification, [MemberCoreDataHelper getDeviceInfo], [SingleCase singleCase].clientID];
    if ([SingleCase singleCase].deviceToken) { wsAddress = [wsAddress stringByAppendingString:[NSString stringWithFormat:@"&deviceToken=%@", [SingleCase singleCase].deviceToken]]; }
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    registerConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (registerConnection) {
    }
}

- (void)resetPasswordWithPhone:(NSString *)phone andPassword:(NSString *)password andVerificationCode:(NSString *)verification {
    NSString *wsAddress = [NSString stringWithFormat:@"%@CRM/ResetPwd?token=%@&mobilePhone=%@&newPwd=%@&code=%@&mobileField=%@&clientId=%@", APIAddr, [MemberCoreDataHelper getMemberToken], phone, password, verification, [MemberCoreDataHelper getDeviceInfo], [SingleCase singleCase].clientID];
    if ([SingleCase singleCase].deviceToken) { wsAddress = [wsAddress stringByAppendingString:[NSString stringWithFormat:@"&deviceToken=%@", [SingleCase singleCase].deviceToken]]; }
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    resetConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (resetConnection) {
    }
}

- (void)uploadDeviceInfo {
    NSString *wsAddress = [NSString stringWithFormat:@"%@CRM/SetOtherInfo?token=%@&mobileField=%@&clientId=%@", APIAddr, [MemberCoreDataHelper getMemberToken], [MemberCoreDataHelper getDeviceInfo], [SingleCase singleCase].clientID];
    if ([SingleCase singleCase].deviceToken) { wsAddress = [wsAddress stringByAppendingString:[NSString stringWithFormat:@"&deviceToken=%@", [SingleCase singleCase].deviceToken]]; }
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    deviceConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (deviceConnection) {
    }
}

//favorite stuff
- (void)setFavoriteWithBrandID:(NSString *)brandID {
    NSString *wsAddress = [NSString stringWithFormat:@"%@CRM/SetFavorites?token=%@&brandId=%@", APIAddr, [MemberCoreDataHelper getMemberToken], brandID];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    setFaveriteConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (setFaveriteConnection) {
    }
}

- (void)getFavorites {

}

//points stuff
- (void)getOnlinePoints {
    
}

- (void)getOnlinePointsHistory {
    
}

- (void)getOfflinePoints {
    
}

- (void)getOfflinePointsHistory {
    
}

- (void)bindOfflineCardWithPhone:(NSString *)phone andName:(NSString *)name andCard:(NSString *)card andVerificationCode:(NSString *)verification {
    
}

#pragma mark Connection Delegate Method

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if ([connection isEqual:loginConnection]) { loginData = [NSMutableData data]; }
    
    if ([connection isEqual:confirmConnection]) { confirmData = [NSMutableData data]; }
    
    if ([connection isEqual:uploadPortraitConnection]) { uploadPortraitData = [NSMutableData data]; }
    
    if ([connection isEqual:uploadInfoConnection]) { uploadInfoData = [NSMutableData data]; }
    
    if ([connection isEqual:verificationConnection]) { verificationData = [NSMutableData data]; }
    
    if ([connection isEqual:registerConnection]) { registerData = [NSMutableData data]; }
    
    if ([connection isEqual:resetConnection]) { resetData = [NSMutableData data]; }
    
    if ([connection isEqual:setFaveriteConnection]) { setFaveriteData = [NSMutableData data]; }
    
    if ([connection isEqual:getFaveriteConnection]) { getFaveriteData = [NSMutableData data]; }
    
    if ([connection isEqual:onlinePointsConnection]) { onlinePointsData = [NSMutableData data]; }
    
    if ([connection isEqual:onlineHistoryConnection]) { onlineHistoryData = [NSMutableData data]; }
    
    if ([connection isEqual:offlinePointsConnection]) { offlinePointsData = [NSMutableData data]; }
    
    if ([connection isEqual:offlineHistoryConnection]) { offlineHistoryData = [NSMutableData data]; }
    
    if ([connection isEqual:offlineBindConnection]) { offlineBindData = [NSMutableData data]; }
    
    if ([connection isEqual:deviceConnection]) { deviceData = [NSMutableData data]; }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if ([connection isEqual:loginConnection]) { [loginData appendData:data]; }
    
    if ([connection isEqual:confirmConnection]) { [confirmData appendData:data]; }
    
    if ([connection isEqual:uploadPortraitConnection]) { [uploadPortraitData appendData:data]; }
    
    if ([connection isEqual:uploadInfoConnection]) { [uploadInfoData appendData:data]; }
    
    if ([connection isEqual:verificationConnection]) { [verificationData appendData:data]; }
    
    if ([connection isEqual:registerConnection]) { [registerData appendData:data]; }
    
    if ([connection isEqual:resetConnection]) { [resetData appendData:data]; }
    
    if ([connection isEqual:setFaveriteConnection]) { [setFaveriteData appendData:data]; }
    
    if ([connection isEqual:getFaveriteConnection]) { [getFaveriteData appendData:data]; }
    
    if ([connection isEqual:onlinePointsConnection]) { [onlinePointsData appendData:data]; }
    
    if ([connection isEqual:onlineHistoryConnection]) { [onlineHistoryData appendData:data]; }
    
    if ([connection isEqual:offlinePointsConnection]) { [offlinePointsData appendData:data]; }
    
    if ([connection isEqual:offlineHistoryConnection]) { [offlineHistoryData appendData:data]; }
    
    if ([connection isEqual:offlineBindConnection]) { [offlineBindData appendData:data]; }
    
    if ([connection isEqual:deviceConnection]) { [deviceData appendData:data]; }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([connection isEqual:loginConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:loginData];
        if (resDic) {
            //NSLog(@"%@", resDic);
            MemberEntity *memberEntity = [MemberEntity getDefaultMemberEntity];
            memberEntity.token = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"Token"]];
            memberEntity.phone = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"MobilePhone"]];
            memberEntity.name = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"Name"]];
            memberEntity.nickName = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"Nickname"]];
            memberEntity.gender = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"Gender"]];
            memberEntity.image = [[NSString stringWithFormat:@"%@", resDic[@"customer"][@"HeadImgUrl"]] length] > 0 ? [NSString stringWithFormat:@"%@%@", APIAddr, resDic[@"customer"][@"HeadImgUrl"]] : nil;
            if ([self loginMemberAndSaveMember:memberEntity]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"memberLogin" object:nil];
            }
            
            [[SingleCase singleCase].coredataOperationQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
                if (![self checkFavoriteSync]) {
                    [self updateFavoriteBrandWithBrandIDs:resDic[@"brandIds"]];
                }
            }]];
        }
    }
    
    if ([connection isEqual:confirmConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:confirmData];
        if (resDic) {
            //NSLog(@"%@", resDic);
            if ([self checkMemberSync]) {
                MemberEntity *memberEntity = [self getMemberEntity];
                memberEntity.token = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"Token"]];
                memberEntity.phone = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"MobilePhone"]];
                memberEntity.name = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"Name"]];
                memberEntity.nickName = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"Nickname"]];
                memberEntity.gender = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"Gender"]];
                memberEntity.image = [[NSString stringWithFormat:@"%@", resDic[@"customer"][@"HeadImgUrl"]] length] > 0 ? [NSString stringWithFormat:@"%@%@", APIAddr, resDic[@"customer"][@"HeadImgUrl"]] : nil;
                if ([self loginMemberAndSaveMember:memberEntity]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"memberLogin" object:nil];
                }
            }
            
            [[SingleCase singleCase].coredataOperationQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
                if (![self checkFavoriteSync]) {
                    [self updateFavoriteBrandWithBrandIDs:resDic[@"brandIds"]];
                }
            }]];
        }
    }
    
    if ([connection isEqual:uploadPortraitConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:uploadPortraitData];
        if (resDic) {
            [self syncMemberInfo];
        }
    }
    
    if ([connection isEqual:uploadInfoConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:uploadInfoData];
        if (resDic) {
            [self syncMemberInfo];
        }
    }
    
    if ([connection isEqual:verificationConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:verificationData];
        NSLog(@"%@", resDic);
    }
    
    if ([connection isEqual:registerConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:registerData];
        if (resDic) {
            MemberEntity *memberEntity = [MemberEntity getDefaultMemberEntity];
            memberEntity.token = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"Token"]];
            memberEntity.phone = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"MobilePhone"]];
            memberEntity.name = [NSString stringWithFormat:@"%@", @""];
            memberEntity.nickName = [NSString stringWithFormat:@"%@", @""];
            memberEntity.gender = [NSString stringWithFormat:@"%@", @""];
            memberEntity.image = nil;
            memberEntity.portrait = nil;
            [self loginMemberAndSaveMember:memberEntity];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"memberLogin" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"注册成功！"];
        }
    }
    
    if ([connection isEqual:resetConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:resetData];
        if (resDic) {
            MemberEntity *memberEntity = [MemberEntity getDefaultMemberEntity];
            memberEntity.token = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"Token"]];
            memberEntity.phone = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"MobilePhone"]];
            memberEntity.name = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"Name"]];
            memberEntity.nickName = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"Nickname"]];
            memberEntity.gender = [NSString stringWithFormat:@"%@", resDic[@"customer"][@"Gender"]];
            memberEntity.image = [[NSString stringWithFormat:@"%@", resDic[@"customer"][@"HeadImgUrl"]] length] > 0 ? [NSString stringWithFormat:@"%@%@", APIAddr, resDic[@"customer"][@"HeadImgUrl"]] : nil;
            [self loginMemberAndSaveMember:memberEntity];
            
            [[SingleCase singleCase].coredataOperationQueue addOperation:[NSBlockOperation blockOperationWithBlock:^{
                if (![self checkFavoriteSync]) {
                    [self updateFavoriteBrandWithBrandIDs:resDic[@"brandIds"]];
                }
            }]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"memberLogin" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"重置成功！"];
        }
    }
    
    if ([connection isEqual:setFaveriteConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:setFaveriteData];
        if (resDic) {
            [BrandCoreDataHelper syncFavorite];
        }
    }
    
    if ([connection isEqual:deviceConnection]) {
        
    }
    
    if ([connection isEqual:getFaveriteConnection]) {
    }
    
    if ([connection isEqual:onlinePointsConnection]) {
    }
    
    if ([connection isEqual:onlineHistoryConnection]) {
    }
    
    if ([connection isEqual:offlinePointsConnection]) {
    }
    
    if ([connection isEqual:offlineHistoryConnection]) {
    }
    
    if ([connection isEqual:offlineBindConnection]) {
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^(){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"网络异常！请检查网络连接状况！"];
    }];
}

#pragma mark - local
- (BOOL)checkMemberSync {
    return [MemberCoreDataHelper checkSync];
}

- (MemberEntity *)getMemberEntity {
    return [MemberCoreDataHelper getMemberEntity];
}

- (BOOL)updateMemberInfo:(MemberEntity *)memberEntity {
    if (memberEntity == nil) {
        memberEntity = [self getMemberEntity];
    }
    
    if ([MemberCoreDataHelper updateMemberInfo:memberEntity]) {
        [self uploadMemberInfo:memberEntity];
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)updateMemberPortrait:(MemberEntity *)memberEntity {
    if (memberEntity == nil) {
        memberEntity = [self getMemberEntity];
    }
    
    if ([MemberCoreDataHelper updateMemberInfo:memberEntity]) {
        [self uploadMemberPortrait:memberEntity.portrait];
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)syncMemberInfo {
    return [MemberCoreDataHelper syncMemberInfo];
}

- (BOOL)getLoginStatus {
    return [MemberCoreDataHelper checkLoginStatus];
}

- (BOOL)loginMemberAndSaveMember:(MemberEntity *)memberEntity {
    return [MemberCoreDataHelper loginMemberAndSaveMember:memberEntity];
}

- (BOOL)logoutMember {
    return [MemberCoreDataHelper logoutMember];;
}


//favorite stuff
- (NSString *)checkFavoriteSync {
    return [BrandCoreDataHelper checkFavoriteSync];
}

- (BOOL)updateFavoriteBrandWithBrandIDs:(NSArray *)brandIDs {
    return [BrandCoreDataHelper setFavorite:brandIDs];
}

- (ShopEntity *)setLocalFavoriteWithBrandID:(ShopEntity *)brand {
    return [BrandCoreDataHelper setFavoriteBrandWithBrandID:brand];
}

- (BOOL)syncFavorite {
    return [BrandCoreDataHelper syncFavorite];
}

- (BOOL)clearFavorite {
    return [BrandCoreDataHelper clearFavorite];
}

//congfig stuff
- (NSString *)getLastUpdateDate {
    return [ConfigCoreDataHelper getUpdateDate];
}

- (BOOL)checkAppGuideSign:(NSString *)guideSign {
    return [ConfigCoreDataHelper checkAppGuideSign:guideSign];
}

- (NSString *)getMemberToken {
    return [MemberCoreDataHelper getMemberToken];
}

- (NSString *)getDeviceInfo {
    return [MemberCoreDataHelper getDeviceInfo];
}

@end
