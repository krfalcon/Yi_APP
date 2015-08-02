//
//  FoodAPITool.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/1.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "FoodAPITool.h"
#import "JSONHelper.h"
#import "WsAddrHelper.h"
#import "HTTPPostDataGenerator.h"

#import "MemberCoreDataHelper.h"
#import "ShopEntity.h"

@implementation FoodAPITool

#pragma mark - network
- (void)getQueueList {
    NSString *wsAddress = [NSString stringWithFormat:@"%@Event/GetQueueList?token=%@", APIAddr, [MemberCoreDataHelper getMemberToken]];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    queueListConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (queueListConnection) {
    }
}

- (void)getQueueDetail:(NSString *)brandID {
    NSString *wsAddress = [NSString stringWithFormat:@"%@Event/GetQueueDetail?token=%@&brandId=%@", APIAddr, [MemberCoreDataHelper getMemberToken], brandID];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    queueDetailConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (queueDetailConnection) {
    }
}

- (void)reserveForBrand:(NSString *)brandID andNumber:(NSString *)number {
    NSString *wsAddress = [NSString stringWithFormat:@"%@Event/Reservation?token=%@&brandId=%@&count=%@", APIAddr, [MemberCoreDataHelper getMemberToken], brandID, number];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    reserveConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (reserveConnection) {
    }
}

- (void)cancelForBran:(NSString *)brandID {
    NSString *wsAddress = [NSString stringWithFormat:@"%@Event/CancelQueue?token=%@&brandId=%@", APIAddr, [MemberCoreDataHelper getMemberToken], brandID];
    NSURL *url = [NSURL URLWithString:wsAddress];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    
    cancelConnection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    if (cancelConnection) {
    }
}

#pragma mark - Connection Delegate Method

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    if ([connection isEqual:queueListConnection]) { queueListData = [NSMutableData data]; }
    
    if ([connection isEqual:queueDetailConnection]) { queueDetailData = [NSMutableData data]; }
    
    if ([connection isEqual:reserveConnection]) { reserveData = [NSMutableData data]; }
    
    if ([connection isEqual:cancelConnection]) { cancelData = [NSMutableData data]; }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if ([connection isEqual:queueListConnection]) { [queueListData appendData:data]; }
    
    if ([connection isEqual:queueDetailConnection]) { [queueDetailData appendData:data]; }
    
    if ([connection isEqual:reserveConnection]) { [reserveData appendData:data]; }
    
    if ([connection isEqual:cancelConnection]) { [cancelData appendData:data]; }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if ([connection isEqual:queueListConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:queueListData];
        if (resDic) {
            NSMutableArray *shopArray = [[NSMutableArray alloc] init];
            
            for (NSDictionary *dic in resDic[@"queues"]) {
                ShopEntity *shopEntity = [ShopEntity queue2ShopEntity:dic];
                
                [shopArray addObject:shopEntity];
            }
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSArray *newArray = [shopArray sortedArrayUsingComparator:^NSComparisonResult(ShopEntity *obj1, ShopEntity *obj2) {
                    NSComparisonResult result = [[NSString stringWithFormat:@"%d", obj2.open] compare:[NSString stringWithFormat:@"%d", obj1.open] options:NSCaseInsensitiveSearch];
                    if(NSOrderedSame == result){
                        result=[obj1.reserveNumber compare:obj2.reserveNumber options:NSCaseInsensitiveSearch];
                    }
                    return result;
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"getReserveList" object:newArray];
                });
            });
        
        }
    }
    
    if ([connection isEqual:queueDetailConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:queueDetailData];
        if (resDic) {
            ShopEntity *shopEntity = [ShopEntity queue2ShopEntity:resDic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getReserveInfo" object:shopEntity];
            
            [self getQueueList];
        }
    }
    
    if ([connection isEqual:reserveConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:reserveData];
        if (resDic) {
            ShopEntity *shopEntity = [ShopEntity queue2ShopEntity:resDic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getReserveInfo" object:shopEntity];
            
            [self getQueueList];
        }
    }
    
    if ([connection isEqual:cancelConnection]) {
        NSDictionary *resDic = [JSONHelper dataToDictionary:cancelData];
        if (resDic) {
            ShopEntity *shopEntity = [ShopEntity queue2ShopEntity:resDic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getReserveInfo" object:shopEntity];
            
            [self getQueueList];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^(){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"网络异常！请检查网络连接状况！"];
    }];
    
    if ([connection isEqual:queueListConnection]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getReserveListFailed" object:nil];
    }
}

#pragma mark - local
- (BOOL)checkQueueStatus:(NSArray *)brandArray {
    return YES;
}

- (BOOL)reservedWithBrand:(NSString *)brandID andNumber:(NSString *)number andTable:(NSString *)table andRemaining:(NSString *)remaining {
    return YES;
}


@end
