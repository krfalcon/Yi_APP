//
//  Sails.h
//  BuildNGO
//
//  Created by Robert.Hsueh on 2014/3/7.
//  Copyright (c) 2014年 Robert.Hsueh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SailsMapCommon.h"

@class LocationRegion;

@interface Sails : NSObject

#pragma mark Switch Method
/**
 * Call for begin to locate. engine will be start.
 */
- (void)startLocatingEngine;


/**
 * Call for stop locate. engine will be turn off.
 */
- (void)stopLocatingEngine;


#pragma mark Operation Method
/**
 * Clear current opened engine. You can use it when you want to load another location project.
 */
- (void)clear;


/**
 * Clear Routing Cache. You can use this API when restart a route process.
 */
- (void)clearRouteCache;


/**
 * Lock location in specified floor by the specified floorName.
 *
 * @param floorName specified floor name.
 */
- (void)lockFloor:(NSString *)floorName;


/**
 * Switch to auto-floor determine.
 */
- (void)unlockFloor;


/**
 * Load building project from cloud.
 *
 * @param token developer's token. (To get the token, you should get SAILS developer identity on our cloud.)
 * @param buildingId building id (can get building id on our cloud)
 * @param success is called when procedure is completed.
 * @param failure is called when load building failed, see the response for detailed information.
 */
- (void)loadCloudBuilding:(NSString *)token buildingID:(NSString *)buildingid success:(void (^)(void))success failure:(void (^)(NSError *error))failure;


#pragma mark Setter Method
/**
 * Initialize map view, must include when do initialization.
 *
 * @param mapView SailsLocationMapView object.
 */
- (void)setSailsLocationMapView:(SailsLocationMapView *)mapView;


/**
 * change floor number sort rule from descending to ascending.
 *
 * @param reverse true to make effect.
 */
- (void)setReverseFloorList:(BOOL)reverse;


/**
 * Direct assign current longitude and latitude from original floor to the new floor when user's located floor is changed.
 *
 * @param smooth true to become effective.
 */
- (void)setSmoothChangeFloor:(BOOL)smooth;


/**
 * define location region floor by the specified floor name.
 *
 * @param region location region to be define.
 *
 * @param floorName specified floor name to define floor.
 */
- (void)setLocationRegionFloor:(LocationRegion *)region andFloorName:(NSString *)floorName;


#pragma mark Set Sails Callback Block Method

/**
 * Call back when user's location change.
 */
- (void)setOnLocationChangeEventBlock:(void (^)(void))block;


/**
 * Call back when User's located floor is switched.
 */
- (void)setOnLocationFloorChangedBlock:(void (^)(NSString *floorName))block;


#pragma mark Getter Method

/**
 * Get SDK version.
 *
 * @return version number in NSString.
 */
+ (NSString *)getSDKVersion;


/**
 * Get building name.
 *
 * @return nil if building name not found or unset.
 */
- (NSString *)getBuildingName;


/**
 * Get current floor name which the user located.
 *
 * @return floorname string.(nil if user is not inside the building.)
 */
- (NSString *)getFloor;


/**
 * Get current floor number which the user located.
 *
 * @return floornumber with Int.(INT MAX if user is not inside the building.)
 */
- (int)getFloorNumber;


/**
 * Get floor description by the specified floor name.
 *
 * @param floorName name of the specified floor.
 * @return description of NSString.
 */
- (NSString *)getFloorDescription:(NSString *)floorName;


/**
 * Get Entire floor name (floor name + floor description) by the specified floor name.
 *
 * @param floorName name of the specified floor.
 * @return name of NSString.
 */
- (NSString *)getFloorEntireName:(NSString *)floorName;


/**
 * Get the building's all floor names.(NSString)
 *
 * @return nil if user is not inside the building.
 */
- (NSArray *)getFloorNameList;


/**
 * Get the building's all floor numbers.(NSNumber with Int)
 *
 * @return null if user is not inside the building.
 */
- (NSArray *)getFloorNumberList;


/**
 * Get the building's all floor descriptions.(NSString)
 *
 * @return null if user is not inside the building.
 */
- (NSArray *)getFloorDescList;


/**
 * Identify map format of the specified floor.
 *
 * @param floorName
 *          floor name which want to be checked.
 * @return Vector for vector map, JPG for jpg map, VOID for none of map exist,
 */
- (SAILSMapFormat)getMapFormat:(NSString *)floorName;


/**
 * Get the predict distance error of the current fix location.
 *
 * @return doubel value of error in meter.
 */
- (double)getAccuracy;


/**
 * Get map scale.
 * MapScale is defined as the ratio of "distance from latitude and longitude system"
 * and "real distance from user define".
 *
 * @return scale value.
 */
- (double)getMapScale;


/**
 * Calculate the angle between two vector: one is map's north degree and the other one formed by two specified (lon,lat) locations.
 *
 * @param lon1 start location's longitude.
 * @param lat1 start location's latitude.
 * @param lon2 end location's longitude.
 * @param lat2 end location's latitude.
 * @return
 */
- (double)getBearDegree:(double)lon1 latitude1:(double)lat1 longitude2:(double)lon2 latitude2:(double)lat2;


/**
 * Calculate two different (lat,lon) distance.
 *
 * @param lng1 start location's longitude.
 * @param lat1 start location's latitude.
 * @param lng2 end location's longitude.
 * @param lat2 end location's latitude.
 *
 * @return calculated distance in meters.
 */
- (double)getMapDistanceByLngLat:(double)lon1 latitude1:(double)lat1 longitude2:(double)lon2 latitude2:(double)lat2;


/**
 * Get all of the LocationRegions for the specified floor.
 *
 * @param floorName name of the specified floor.
 * @return NSArray of LocationRegion.
 */
- (NSArray *)getLocationRegionList:(NSString *)floorName;


/**
 * Get all of the categories of LocationRegions for the specified floor.
 *
 * @param floorName name of the specified floor.
 * @return NSArray of NSString.
 */
- (NSArray *)getLocationRegionTypeList:(NSString *)floorName;


/**
 * Get filtered LocationRegions for the specified floor by user specified type or subtype.
 *
 * @param floorName name of the specified floor.
 * @param type value in "type" tag in JOSM tag setting.
 * @param subtype value in "subtype" tag in JOSM tag setting. (must be null when type param is also set to null)
 * @return a filtered location region NSArray.
 */
- (NSArray *)getFilteredLocationRegionList:(NSString *)floorName type:(NSString *)aType subtype:(NSString *)aSubtype;


/**
 * Get all regions that enclosure user current calculated location.
 *
 * @return locationRegion in NSArray.
 */
- (NSArray *)getCurrentInRegions;


/**
 * Find the corresponding Regions by a specified region label name.
 *
 * @param label specified region label string
 *
 * @return all LocationRegions which the label name is the same as user specify label name in NSArray.
 */
- (NSArray *)findRegionByLabel:(NSString *)label;


/**
 * Get Linear Distance between current locating position and the assigned LocationRegion.
 *
 * @param locationRegion assigned LocationRegion.
 * @return integer value of distance in meters. Integer max value if invalid result.
 */
- (int)getLinearDistance:(LocationRegion *)locationRegion;


/**
 * Get Linear Distance between assigned start LocationRegion and the assigned end LocationRegion.
 *
 * @param startLocationRegion assigned start LocationRegion.
 * @param endLocationRegion assigned end LocationRegion.
 * @return integer value of distance in meters. Integer max value if invalid result.
 */
- (int)getLinearDistance:(LocationRegion *)startLocationRegion end:(LocationRegion *)endLocationRegion;


/**
 * Get Routing Distance between current locating position and the assigned LocationRegion.
 *
 * @param locationRegion assigned LocationRegion.
 * @return integer value of distance in meters. Integer max value if invalid result.
 */
- (int)getSingleRouteDistance:(LocationRegion *)locationRegion;


/**
 * Get Routing Distance between assigned start LocationRegion and the assigned end LocationRegion.
 *
 * @param startLocationRegion assigned start LocationRegion.
 * @param endLocationRegion assigned end LocationRegion.
 * @return integer value of distance in meters. Integer max value if invalid result.
 */
- (int)getSingleRouteDistance:(LocationRegion *)startLocationRegion end:(LocationRegion *)endLocationRegion;


#pragma mark Convert Method

/**
 * Converts a longitude coordinate (in degrees) to a pixel X coordinate.
 *
 * @param lon : the longitude coordinate that should be converted.
 *
 * @return the pixel X coordinate of the longitude value.
 */
+ (double)convertLongitudeToPixelX:(double)lon;


/**
 * Converts a latitude coordinate (in degrees) to a pixel Y coordinate.
 *
 * @param lat : the latitude coordinate that should be converted.
 *
 * @return the pixel Y coordinate of the latitude value.
 */
+ (double)convertLatitudeToPixelY:(double)lat;


/**
 * Converts a pixel X coordinate at a certain zoom level to a longitude coordinate.
 *
 * @param pixelX : the pixel X coordinate that should be converted.
 *
 * @return the longitude value of the pixel X coordinate.
 */
+ (double)convertPixelXToLongitude:(double)pixelX;


/**
 * Converts a pixel Y coordinate at a certain zoom level to a latitude coordinate.
 *
 * @param pixelY : the pixel Y coordinate that should be converted.
 *
 * @return the latitude value of the pixel Y coordinate.
 */
+ (double)convertPixelYToLatitude:(double)pixelY;


#pragma mark Check Method
/**
 * Check the user is in the building or not
 *
 * @return true if user is in the building.
 */
- (BOOL)isInThisBuilding;


/**
 * Check user device has BLE function or not.
 *
 * @return true if device has support BLE.
 */
- (BOOL)isBLEAvailable;


/**
 * Check Bluetooth is enable or not.
 *
 * @return true if Bluetooth is turn on.(if user device not support BLE will be false.)
 */
- (BOOL)isBluetoothTurnOn;


/**
 * Check if user's heading is stable or not.
 *
 * @return true if fix.
 */
- (BOOL)isHeadingStable;


/**
 * Check if locating engine is turn on. On the other hand, check if system is
 * currently use indoor locating process.
 *
 * @return true if engine is on.
 */
- (BOOL)isLocationEngineStarted;


/**
 * Check the location is begin keep fixing or not
 *
 * @return true if location is begin keep fixing.
 */
- (BOOL)isLocationFix;


/**
 * Check current fix location is in the region or not.
 *
 * @param region : the location region object.
 *
 * @return true if fix location is in location region.
 */
- (BOOL)amIHere:(LocationRegion *)region;

@end


#pragma mark - Public-GeoNode Class

@interface GeoNode : NSObject

@property (nonatomic) double longitude;
@property (nonatomic) double latitude;
@property (nonatomic) int floorNumber;
@property (nonatomic, strong) NSString *floorName;
@property (nonatomic, strong) LocationRegion *belongsRegion;

- (id)initWithLogitude:(double)lon latitude:(double)lat;
@end


