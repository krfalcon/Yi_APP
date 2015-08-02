//
//  FoodAPITool.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/1.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodAPITool : NSObject<NSURLConnectionDelegate>
{
    NSMutableData* queueListData;
    NSMutableData* queueDetailData;
    NSMutableData* reserveData;
    NSMutableData* cancelData;
    
    NSURLConnection* queueListConnection;
    NSURLConnection* queueDetailConnection;
    NSURLConnection* reserveConnection;
    NSURLConnection* cancelConnection;
}

#pragma mark - network
- (void)getQueueList;
- (void)getQueueDetail:(NSString *)brandID;
- (void)reserveForBrand:(NSString *)brandID andNumber:(NSString *)number;
- (void)cancelForBran:(NSString *)brandID;

#pragma mark - local
- (BOOL)checkQueueStatus:(NSArray *)brandArray;
- (BOOL)reservedWithBrand:(NSString *)brandID andNumber:(NSString *)number andTable:(NSString *)table andRemaining:(NSString *)remaining;

@end
