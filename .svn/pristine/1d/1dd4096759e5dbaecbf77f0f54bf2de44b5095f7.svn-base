//
//  ItemEntity.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/22.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ItemEntity.h"

@implementation ItemEntity

@synthesize itemID;
@synthesize title;
@synthesize price;
@synthesize sale;
@synthesize rate;
@synthesize content;
@synthesize category;
@synthesize carouselArray;
@synthesize brandID;
@synthesize imageUrl;

#pragma mark - shop property

@synthesize shopEntity;

+ (ItemEntity *)article2ItemEntity:(NSManagedObject *)article {
    ItemEntity *itemEntity = [[ItemEntity alloc] init];
    
    [itemEntity setContent:[article valueForKey:@"content"]];
    [itemEntity setItemID:[article valueForKey:@"id"]];
    [itemEntity setTitle:[[article valueForKey:@"title"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    if ([article valueForKey:@"files"]) {
        //NSLog(@"%@", [article valueForKey:@"files"]);
        NSMutableArray *file = [[NSMutableArray alloc] init];
        
        NSArray *fileArray = [article valueForKey:@"files"];
        for (NSString *fileDic in fileArray) {
            [itemEntity setImageUrl:[NSString stringWithFormat:@"%@%@", APIAddr, fileDic]];
            
            [file addObject:[NSString stringWithFormat:@"%@%@", APIAddr, fileDic]];
        }
        [itemEntity setCarouselArray:file];
    }
    
    if ([article valueForKey:@"customField"]) {
        //NSLog(@"%@", [article valueForKey:@"customField"]);
        
        NSError *error;
        NSString *str = [JSONHelper clearReturn:[article valueForKey:@"customField"]];
        NSDictionary *res = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&error];
        
        itemEntity.category = [[res valueForKey:@"Type"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        itemEntity.sale = [NSString stringWithFormat:@"￥%@", [[res valueForKey:@"DiscountPrice"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        itemEntity.price = [NSString stringWithFormat:@"￥%@", [[res valueForKey:@"Price"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        itemEntity.brandID = [[res valueForKey:@"BrandId"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        itemEntity.rate = [NSString stringWithFormat:@"%f", [itemEntity.sale floatValue] / [itemEntity.price floatValue]];
    }
    
    return itemEntity;
}

+ (NSArray *)getItemArray {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 20; i++) {
        ItemEntity *entity = [[ItemEntity alloc] init];
        [entity setItemID:@"0"];
        [entity setTitle:@"这是一个商品"];
        [entity setPrice:@"￥3000"];
        [entity setSale:@"￥300"];
        [entity setContent:@"今年最新款，走过路过不要错过，八星八箭，独此一家。这里你买不了吃亏，这里你买不了上当，限量888件，仅售998。对！你没有听错，不是9999998，也不是999998，更不是99998，当然不会是9998，只要998，等等，大总裁又来电话说前100名买家再降110元，只售888！你还在等什么，888买不了吃亏！888买不了上当！快来抢购吧！\n今年最新款，走过路过不要错过，八星八箭，独此一家。这里你买不了吃亏，这里你买不了上当，限量888件，仅售998。对！你没有听错，不是9999998，也不是999998，更不是99998，当然不会是9998，只要998，等等，大总裁又来电话说前100名买家再降110元，只售888！你还在等什么，888买不了吃亏！888买不了上当！快来抢购吧！\n今年最新款，走过路过不要错过，八星八箭，独此一家。这里你买不了吃亏，这里你买不了上当，限量888件，仅售998。对！你没有听错，不是9999998，也不是999998，更不是99998，当然不会是9998，只要998，等等，大总裁又来电话说前100名买家再降110元，只售888！你还在等什么，888买不了吃亏！888买不了上当！快来抢购吧！\n重要的事情要写三遍！"];
        [entity setCarouselArray:@[@"http://blyyc.dgshare.cn/Uploads/2015/4/22/5ec803ce-ae53-40a7-a1f7-39fa0f1542de.jpg", @"http://blyyc.dgshare.cn/Uploads/2015/4/22/5ec803ce-ae53-40a7-a1f7-39fa0f1542de.jpg", @"http://blyyc.dgshare.cn/Uploads/2015/4/22/5ec803ce-ae53-40a7-a1f7-39fa0f1542de.jpg"]];
        [entity setShopEntity:[[ShopEntity alloc] init]];
        
        [entity.shopEntity setChName:@"贝蒂"];
        [entity.shopEntity setEnName:@"Betty Boop"];
        [entity.shopEntity setTelephone:@"021-55529900"];
        [entity.shopEntity setLocation:@"40"];
        [entity.shopEntity setLocationArea:@"A111"];
        [entity.shopEntity setLogoUrl:@"http://blyyc.dgshare.cn/Uploads/2015/2/28/88667962-5fb1-4c49-9d1e-2130e99c99cf.png"];
        
        [array addObject:entity];
    }
    
    return array;
}

@end