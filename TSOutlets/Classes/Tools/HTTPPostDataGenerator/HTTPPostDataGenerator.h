//
//  HTTPPostDataGenerator.h
//  NiceLife
//
//  Created by Stego Kinney on 13-11-26.
//  Copyright (c) 2013年 Stego Kinney. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NOTIFY_AND_LEAVE(X) {[self cleanup:X]; return;}
#define DATA(X) [X dataUsingEncoding:NSUTF8StringEncoding]

#define IMAGE_CONTENT @"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\nContent-Type: image/jpeg\r\n\r\n"
#define STRING_CONTENT @"Content-Disposition: form-data; name=\"%@\"\r\n\r\n"
#define MULTIPART @"multipart/form-data; boundary=------------0x0x0x0x0x0x0x0x"

@interface HTTPPostDataGenerator : NSObject

+ (NSData*)generateFormDataFromPostDictionary:(NSDictionary*)dict;

@end
