//
//  JSONHelper.h
//  deepoint
//
//  Created by Stego Kinney on 13-10-25.
//  Copyright (c) 2013年 Stego Kinney. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONHelper : NSObject

+ (NSString *)getJSONFromXML:(NSString *)xml;
+ (NSString *)clearReturn:(NSString *)json;

+ (NSDictionary *)dataToDictionary:(NSData *)data;
+ (NSDictionary *)stringToDictionary:(NSString *)string;
+ (NSArray *)dataToArray:(NSData *)data;
+ (NSArray *)stringToArray:(NSString *)string;

@end
