//
//  HTTPPostDataGenerator.m
//  NiceLife
//
//  Created by Stego Kinney on 13-11-26.
//  Copyright (c) 2013年 Stego Kinney. All rights reserved.
//

#import "HTTPPostDataGenerator.h"

@implementation HTTPPostDataGenerator

+ (NSData*)generateFormDataFromPostDictionary:(NSDictionary*)dict
{
    id boundary = @"------------0x0x0x0x0x0x0x0x";
    NSArray* keys = [dict allKeys];
    NSMutableData* result = [NSMutableData data];
    
    for (int i = 0; i < [keys count]; i++)
    {
        id value = [dict valueForKey: [keys objectAtIndex:i]];
        [result appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        if ([value isKindOfClass:[NSData class]])
        {
            // handle image data
            NSString *formstring = [NSString stringWithFormat:IMAGE_CONTENT, [keys objectAtIndex:i]];
            [result appendData:DATA(formstring)];
            [result appendData:value];
        }
        else
        {
            // all non-image fields assumed to be strings
            NSString *formstring = [NSString stringWithFormat:STRING_CONTENT, [keys objectAtIndex:i]];
            [result appendData:DATA(formstring)];
            [result appendData:DATA(value)];
        }
        
        NSString *formstring = @"\r\n";
        [result appendData:DATA(formstring)];
    }
    
    NSString *formstring =[NSString stringWithFormat:@"--%@--\r\n", boundary];
    [result appendData:DATA(formstring)];
    return result;
}

@end
