//
//  BasicInfoAPITool.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/26.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "BasicInfoAPITool.h"
#import "JSONHelper.h"
#import "WsAddrHelper.h"
#import "HTTPPostDataGenerator.h"
#import "ZipArchive.h"
#import "SingleCase.h"

#import "ArticleCoreDataHelper.h"
#import "BrandCoreDataHelper.h"
#import "MemberCoreDataHelper.h"
#import "ConfigCoreDataHelper.h"

@implementation BasicInfoAPITool

- (void)getBasicInfoWithDeviceInfo:(NSString *)deviceInfo {
    NSString *wsAddress = [NSString stringWithFormat:@"%@Article/GetJsonZipUrl", APIAddr];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    getBasicInfoConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (getBasicInfoConnection) {
    }
}

- (void)getBasicInfoZipWithUrl:(NSString *)str {
    NSString *wsAddress = [NSString stringWithFormat:@"%@%@", APIAddr, str];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    getBasicInfoZipConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (getBasicInfoZipConnection) {
    }
}

- (void)updateBasicInfoByDate:(NSString *)dateTime {
    if ([dateTime isEqual:@"(null)"]) { dateTime = @"2015-01-01"; }
    NSString *wsAddress = [NSString stringWithFormat:@"%@Article/UpdateArticle?DateTime=%@&Token=%@", APIAddr, dateTime, [MemberCoreDataHelper getMemberToken]];
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    updateBasicInfoConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (updateBasicInfoConnection) {
    }
}

#pragma mark - Connection Delegate Method

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([connection isEqual:getBasicInfoConnection]) {
        getBasicInfoData = [NSMutableData data];
    }
    
    if ([connection isEqual:getBasicInfoZipConnection]) {
        getBasicInfoZipData = [NSMutableData data];
    }
    
    if ([connection isEqual:updateBasicInfoConnection]) {
        updateBasicInfoData = [NSMutableData data];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if ([connection isEqual:getBasicInfoConnection]) {
        [getBasicInfoData appendData:data];
    }
    
    if ([connection isEqual:getBasicInfoZipConnection]) {
        [getBasicInfoZipData appendData:data];
    }
    
    if ([connection isEqual:updateBasicInfoConnection]) {
        [updateBasicInfoData appendData:data];
    }

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([connection isEqual:getBasicInfoConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:getBasicInfoData];
        if (resDic) {
            NSLog(@"%@", resDic);
            [self getBasicInfoZipWithUrl:resDic[@"ZipUrl"]];
            MemberEntity *memberEntity = [[MemberEntity alloc] init];
            memberEntity.token = resDic[@"Token"];
            [MemberCoreDataHelper updateMemberInfo:memberEntity];
        }
        
    } else if ([connection isEqual:getBasicInfoZipConnection]) {
        [[SingleCase singleCase].coredataOperationQueue addOperationWithBlock:^{
            NSError *error = nil;
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *path = [paths objectAtIndex:0];
            NSString *zipPath = [path stringByAppendingPathComponent:@"zipfile.zip"];
            
            if ([getBasicInfoZipData writeToFile:zipPath options:0 error:&error]) {
                //NSLog(@"保存成功. %@", zipPath);
            }
            ZipArchive *za = [[ZipArchive alloc] init];
            if ([za UnzipOpenFile: zipPath]) {
                BOOL ret = [za UnzipFileTo: path overWrite: YES];
                if (NO == ret){} [za UnzipCloseFile];
                NSString *textFilePath = [path stringByAppendingPathComponent:@"Json.txt"];
                NSString *textString = [NSString stringWithContentsOfFile:textFilePath encoding:NSUTF8StringEncoding error:nil];
                textString = [JSONHelper clearReturn:textString];
                NSError *error;
                NSDictionary *res = [NSJSONSerialization JSONObjectWithData:[textString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
                
                NSLog(@"%@",textString);
                
                if ([ArticleCoreDataHelper addBasicInfoWithInfoArray:res]) {
                    if (_delegate && [_delegate respondsToSelector:@selector(didGetBasicInfo)]) {
                        [_delegate didGetBasicInfo];
                    }
                    [ConfigCoreDataHelper setUpdateDate:[NSString stringWithFormat:@"%@", res[@"Datetime"]]];
                }
                
            }
        }];
    } else if ([connection isEqual:updateBasicInfoConnection]) {
        [[SingleCase singleCase].coredataOperationQueue addOperationWithBlock:^{
            NSDictionary *resDic = [JSONHelper dataToDictionary:updateBasicInfoData];
            
            if ([ArticleCoreDataHelper updateBasicInfoWithInfoArray:resDic]) {
                if (_delegate && [_delegate respondsToSelector:@selector(didUpdateBasicInfo)]) {
                    [_delegate didUpdateBasicInfo];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateInfo" object:nil];
                [ConfigCoreDataHelper setUpdateDate:[NSString stringWithFormat:@"%@", resDic[@"Datetime"]]];
            }
        }];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
    
    if ([connection isEqual:getBasicInfoConnection]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"网络异常！重新尝试初始化……"];
        [self getBasicInfoWithDeviceInfo:@""];
    } else if ([connection isEqual:updateBasicInfoConnection]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateInfo" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"网络异常！请检查网络连接状况！"];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"网络异常！请检查网络连接状况！"];
    }
}

@end
