//
//  PathRoutingManager.h
//  BuildNGO
//
//  Created by Robert.Hsueh on 2014/5/8.
//  Copyright (c) 2014年 Robert.Hsueh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - PathRoutingManager Enum
#pragma mark Path Routing Mode
/**
 * Path Routing Mode
 */
typedef NS_ENUM(NSInteger, PathRoutingMode) {
    /**
     * Routing Mode: normal 3D routing, take all stair, escalator, and elevator into account.
     *
     */
    NormalRoutingMode = 0,
    /**
     * Routing Mode: only take stair into 3D routing account.
     *
     */
    StairOnlyMode = 1,
    /**
     * Routing Mode: only take escalator into 3D routing account.
     *
     */
    EscalatorOnlyMode = 2,
    /**
     * Routing Mode: only take elevator into 3D routing account.
     *
     */
    ElevatorOnlyMode = 3,
    /**
     * Routing Mode: only take elevator and escalator into 3D routing account.
     *
     */
    ElevatorAndEscalatorMode = 4
};

#pragma mark Path Routing Node Type
/**
 * Path Routing Node Type
 */
typedef NS_ENUM(NSInteger, PathRoutingNodeType) {
    /**
     * Node Type ID: stair.
     */
    StairType = 1,
    /**
     * Node Type ID: escalator.
     */
    EscalatorType = 2,
    /**
     * Node Type ID: elevator.
     */
    ElevatorType = 3,
    /**
     * Node Type ID: destination.
     */
    DestinationType = 4
};

#pragma mark Path Routing Direction
/**
 * Path Routing Direction
 */
typedef NS_ENUM(NSInteger, PathRoutingDirection) {
    /**
     * Node Type ID: stair.
     */
    UpDirection = 1,
    /**
     * Node Type ID: escalator.
     */
    DownDirection = 2,
    /**
     * Node Type ID: elevator.
     */
    GoTargetDirection = 3
};


#pragma mark - PathRoutingManager Class

@class LocationRegion, Paint;

@interface PathRoutingManager : NSObject

#pragma mark Switch Method

/**
 * Begin to route. (Note: start & end point must be set before going to route)
 */
- (void)enableRouting;


/**
 * Stop route.
 */
- (void)disableRouting;


#pragma mark Setter Method

/**
 * Set Route mode.
 *
 * @param mode PathRoutingMode value of mode.
 */
- (void)setRoutingMode:(PathRoutingMode)mode;


/**
 * Define routing start point marker icon.
 *
 * @param image input icon resource.
 */
- (void)setStartMakerImage:(UIImage *)image;


/**
 * Define routing end point marker icon.
 *
 * @param image input icon resource.
 */
- (void)setTargetMakerImage:(UIImage *)image;


/**
 * Define routing start point marker icon frame.
 *
 * @param frame input icon frame.
 */
- (void)setStartMakerFrame:(CGFloat)frame;


/**
 * Define routing end point marker icon frame.
 *
 * @param frame input icon frame.
 */
- (void)setTargetMakerFrame:(CGFloat)frame;


/**
 * Set start point location region.
 *
 * @param start input a LocationRegion object. if start is nil, use user location to route
 */
- (void)setStartRegion:(LocationRegion *)start;


/**
 * Set end point location region.
 *
 * @param target input a LocationRegion object.
 */
- (void)setTargetRegion:(LocationRegion *)target;


#pragma mark Set Routing Update Callback Block Method

/**
 * Call back when routing status is arrived.
 */
- (void)setOnRoutingUpdateArrivedBlock:(void (^)(LocationRegion *targetRegion))block;


/**
 * Call back when routing status is success.
 */
- (void)setOnRoutingUpdateRouteSuccessBlock:(void (^)(void))block;


/**
 * Call back when routing status is fail.
 */
- (void)setOnRoutingUpdateRouteFailBlock:(void (^)(void))block;


/**
 * Call back when draw routing path task finish in every routing process.
 */
- (void)setOnRoutingUpdatePathDrawFinishBlock:(void (^)(void))block;


/**
 * In routing, call back total distance if it has change.
 */
- (void)setOnRoutingUpdateTotalDistanceRefreshBlock:(void (^)(int distance))block;


/**
 * Call back path distance to current nearest transfer in the same floor.
 * (function work only when location engine is turn on)
 *
 * @param distance path distance
 * @param nodeType  nearest transfer type.
 */
- (void)setOnRoutingUpdateReachNearestTransferDistanceRefreshBlock:(void (^)(int distance, PathRoutingNodeType nodeType))block;


/**
 * Update each floor change information. (function work only when location engine is turn on)
 *
 * @param infoList return info list.
 * @param nearestIndex return the index position which is corresponding to current nearest transfer node.
 */
- (void)setOnRoutingUpdateSwitchFloorInfoRefreshBlock:(void (^)(NSArray *infoList, int nearestIndex))block;


#pragma mark Getter Method

/**
 * Get current route mode.
 *
 * @return PathRoutingMode value of current mode.
 */
+ (PathRoutingMode)getRoutingMode;


/**
 * Get current start point setting.
 *
 * @return start point location region.
 */
- (LocationRegion *)getStartRegion;


/**
 * Get current end point setting.
 *
 * @return ending point location region.
 */
- (LocationRegion *)getTargetRegion;


/**
 * Get path fill style definition resource.
 *
 * @return Paint object.
 */
- (Paint *)getPathPaint;


/**
 * Get path stroke style definition resource.
 *
 * @return Paint object.
 */
- (Paint *)getPathStrokePaint;

/**
 * Get current routing path total calculated distance. (Unit: meter)
 *
 * @return int distance value
 */
- (int)getPathDistance;


/**
 * Get current routing path nodes in current brows floor.
 *
 * @return GeoPoint list.
 */
- (NSArray *)getCurrentFloorRoutingPathNodes;


#pragma mark Check Method

/**
 * Check if routing engine is enable or not.
 *
 * @return true if routing engine is enable.
 */
- (BOOL)isRoutingEnable;


/**
 * Check a route routine is successful or not.
 *
 * @return true if success.
 */
- (BOOL)isRoutingSuccess;


/**
 * Check user is arrive the end point or not. (Location engine is already start)
 *
 * @return true if arrived
 */
- (BOOL)isArriveTarget;

@end


#pragma mark - SwitchFloorInfo Class

@class GeoNode;

@interface SwitchFloorInfo : NSObject

/**
 * Transfer type.
 * PathRoutingNodeType StairType
 * PathRoutingNodeType EscalatorType
 * PathRoutingNodeType ElevatorType
 * PathRoutingNodeType DestinationType
 */
@property (assign) PathRoutingNodeType nodeType;

/**
 * Change floor direction.
 * PathRoutingDirection UpDirection
 * PathRoutingDirection DownDirection
 * PathRoutingDirection GoTargetDirection
 */
@property (assign) PathRoutingDirection direction;

/**
 * longitude of position where to change floor.
 */
@property (nonatomic) double lon;

/**
 * latitude of position where to change floor.
 */
@property (nonatomic) double lat;

/**
 * The floor name belongs to head-transfer.
 */
@property (nonatomic, strong) NSString *fromFloorName;

/**
 * The floor name belongs to tail-transfer.
 */
@property (nonatomic, strong) NSString *toFloorName;

/**
 * The belong LocationRegion of head-transfer.
 */
@property (nonatomic, strong) LocationRegion *fromBelongsRegion;

- (id)initWithGeoNode:(GeoNode *)geonode nodeType:(PathRoutingNodeType)nodetype direction:(PathRoutingDirection)nodedirection toFloorName:(NSString *)tofloorname;

@end


