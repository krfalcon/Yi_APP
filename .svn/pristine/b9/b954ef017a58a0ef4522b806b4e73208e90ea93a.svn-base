//
//  JSONHelper.m
//  deepoint
//
//  Created by Stego Kinney on 13-10-25.
//  Copyright (c) 2013年 Stego Kinney. All rights reserved.
//

#import "JSONHelper.h"

@implementation JSONHelper

+ (NSString *)getJSONFromXML:(NSString *)xml
{
    @try {
        /*NSRange startR = [xml rangeOfString:@">{"];
         NSRange endR = [xml rangeOfString:@"}<"];
         
         NSRange jsonRange;
         jsonRange.location = startR.location + 1;
         jsonRange.length = endR.location - startR.location;
         
         NSString *json = [xml substringWithRange:jsonRange];
         return json;*/
        return xml;
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
        return @"{\"resCode\":\"1\"}";
    }
}

+ (NSString *)clearReturn:(NSString *)json
{
    @try {
        NSString *newJson = json;
        newJson = [newJson stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\\n"];
        newJson = [newJson stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        return newJson;
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception.description);
        return @"{\"resCode\":\"1\"}";
    }
}

+ (NSDictionary *)dataToDictionary:(NSData *)data {
    NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",receiveStr);
    receiveStr = [self clearReturn:receiveStr];
    NSError *error;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:[receiveStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    
    if (![[NSString stringWithFormat:@"%@", res[@"status"][@"resCode"]] isEqualToString:@"0"]) {
        //NSLog(@"%@",res[@"status"][@"message"]);
        if ([[NSString stringWithFormat:@"%@", res[@"status"][@"resCode"]] isEqualToString:@"902"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"needLoginAgain" object:nil];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:res[@"status"][@"message"]];
        res = nil;
    } else {
        res = [self stringToDictionary:res[@"data"]];
    }
    return res;
}

+ (NSDictionary *)stringToDictionary:(NSString *)string {
    string = [self clearReturn:string];
    NSError *error;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    
    return res;
}

+ (NSArray *)dataToArray:(NSData *)data{
    NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",receiveStr);
    receiveStr = [self clearReturn:receiveStr];
    NSError *error;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:[receiveStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    
    return res;
}

+ (NSArray *)stringToArray:(NSString *)string {
    string = [self clearReturn:string];
    NSError *error;
    NSArray *res = [NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
    
    return res;
}

@end
