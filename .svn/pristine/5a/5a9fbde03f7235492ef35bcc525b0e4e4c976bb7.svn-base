//
//  LogAPITool.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/1.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@interface LogAPITool : NSObject<NSURLConnectionDelegate>
{
    NSMutableData* uploadData;
    
    NSURLConnection* uploadConnection;
}

#pragma mark - network
- (void)startUploadLog;

#pragma mark - local
- (NSString *)addLogRecordWithModule:(NSString *)module;
- (NSArray *)getLogRecordArray;
- (BOOL)clearLogRecord;

@end
