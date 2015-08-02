//
//  LocationRegion.h
//  BuildNGO
//
//  Created by Robert.Hsueh on 2014/2/15.
//  Copyright (c) 2014年 Robert.Hsueh. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark Location Region Language
/**
 * LocationRegionLanguage.
 *
 * NORMAL: Means notmal language.
 * ENGLISH: Means english language.
 * CHINESE_BIG5: Means chinese_big5 language.
 * CHINESE_SM: Means chinese_sm language.
 * JAPANESE: Means japanese language.
 */
typedef NS_ENUM(NSInteger, LocationRegionLanguage) {
	NORMAL,
	ENGLISH,
	CHINESE_BIG5,
    CHINESE_SM,
    JAPANESE,
};

@interface LocationRegion : NSObject

@property (nonatomic) long locationID;
@property (nonatomic, strong) NSMutableArray *goToList;
@property (nonatomic, strong) NSMutableArray *mBoundaryVertexList;
@property (nonatomic, strong) NSString *label;
@property (nonatomic) int level;
@property (nonatomic) double fusionCoefficient;
@property (nonatomic, strong) NSString *chinese_t;
@property (nonatomic, strong) NSString *chinese_s;
@property (nonatomic, strong) NSString *english;
@property (nonatomic, strong) NSString *japanese;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *subtype;
@property (nonatomic) int locationSelf;

#pragma mark Setter Method

/**
 * Set location region language.
 *
 * @param language LocationRegionLanguage.
 */
+ (void)setFontLanguage:(LocationRegionLanguage)language;


/**
 * Set location region vertex.
 *
 * @param vertexList GeoNode in NSMutableArray.
 */
- (void)setVertexList:(NSMutableArray *)vertexList;


#pragma mark Getter Method

/**
 * Get location region's floor name.
 *
 * @return floor name in NSString.
 */
- (NSString *)getFloorName;


/**
 * Get location region's floor description.
 *
 * @return floor description in NSString.
 */
- (NSString *)getFloorDescription;


/**
 * Get location region's floor number.
 *
 * @return floor number in int.
 */
- (int)getFloorNumber;


/**
 * Get current Languaue type.
 *
 * @return languaue type in int.
 */
- (NSString *)getName;


/**
 * Get the center longitude of the location region.
 *
 * @return longitude value in double.
 */
- (double)getCenterLongitude;


/**
 * Get the center latitude of the location region.
 *
 * @return latitude value in double.
 */
- (double)getCenterLatitude;


#pragma mark Check Method

/**
 * Check if the specified location is in the location region or not.
 *
 * @param lon input longitude.
 * @param lat input latitude.
 * @return true if is in the location region.
 */
- (BOOL)isInRegion:(double)lon latitude:(double)lat;


/**
 * Check the region has routing node or not.
 *
 * @return true if region has routing nodes.
 */
- (BOOL)hasPathNode;

@end
