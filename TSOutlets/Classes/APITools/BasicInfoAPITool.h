//
//  BasicInfoAPITool.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/26.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BasicInfoAPIToolDelegate;

@interface BasicInfoAPITool : NSObject<NSURLConnectionDelegate>
{
    NSMutableData* getBasicInfoData;
    NSMutableData* getBasicInfoZipData;
    NSMutableData* updateBasicInfoData;
    
    NSURLConnection* getBasicInfoConnection;
    NSURLConnection* getBasicInfoZipConnection;
    NSURLConnection* updateBasicInfoConnection;
}

@property (weak, nonatomic) id<BasicInfoAPIToolDelegate> delegate;

#pragma mark - network
- (void)getBasicInfoWithDeviceInfo:(NSString *)deviceInfo;
- (void)updateBasicInfoByDate:(NSString *)dateTime;

#pragma mark - local

@end


@protocol BasicInfoAPIToolDelegate <NSObject>

- (void)didGetBasicInfo;
- (void)didUpdateBasicInfo;

@end