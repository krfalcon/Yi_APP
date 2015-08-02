//
//  LogAPITool.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/1.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "LogAPITool.h"
#import "Reachability.h"
#import "LogCoreDataHelper.h"
#import "JSONHelper.h"
#import "WsAddrHelper.h"
#import "HTTPPostDataGenerator.h"
#import "MemberCoreDataHelper.h"

@implementation LogAPITool

#pragma mark - network

- (void)startUploadLog {
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NSArray *log = [self getLogRecordArray];
    
    if (r.currentReachabilityStatus == ReachableViaWiFi) {
        [self continueUploadLog:log];
    } else {
        NSLog(@"不在WIFI就先不传了");
    }
}

- (void)continueUploadLog:(NSArray *)log {
    NSString *logJson = @"[";
        
    for (NSArray* record in log) {
        logJson = [logJson stringByAppendingString:[NSString stringWithFormat:@"{\"OccurrenceTime\":\"%@\",\"UrlMemo\":\"%@\"},", record[0], record[1]]];
    }
    
    if (logJson.length == 1) {
        logJson = @"[]";
        return;
    } else {
        logJson = [[logJson substringToIndex:logJson.length - 1] stringByAppendingString:@"]"];
    }
    
    NSString *wsAddress = [NSString stringWithFormat:@"%@Log/RecordOperation?token=%@&operation=%@", APIAddr, [MemberCoreDataHelper getMemberToken], logJson];
    wsAddress = [wsAddress stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    uploadConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (uploadConnection) {
    }
}

#pragma mark - Connection Delegate Method

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([connection isEqual:uploadConnection]) { uploadData = [NSMutableData data]; }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if ([connection isEqual:uploadConnection]) { [uploadData appendData:data]; }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([connection isEqual:uploadConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:uploadData];
        if (resDic) {
            [self clearLogRecord];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^(){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"网络异常！请检查网络连接状况！"];
    }];
}


#pragma mark - local

- (NSString *)addLogRecordWithModule:(NSString *)module {
    return [LogCoreDataHelper addLogRecordWithModule:module];
}

- (NSArray *)getLogRecordArray {
    return [LogCoreDataHelper getLogRecordArray];
}

- (BOOL)clearLogRecord {
    return [LogCoreDataHelper clearLogRecord];
}

@end
