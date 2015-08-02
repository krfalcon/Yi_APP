//
//  PinMarkerManager.h
//  BuildNGO
//
//  Created by Robert.Hsueh on 2014/5/15.
//  Copyright (c) 2014年 Robert.Hsueh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LocationRegionMarker;

@interface PinMarkerManager : NSObject

#pragma mark Switch Method

/**
 * Invisible all pin marker.
 */
- (void)makeAllPinMarkerInvisible;

/**
 * Visible all pin marker.
 */
- (void)makeAllPinMarkerVisible;


#pragma mark Operation Method

/**
 * Clear all pin markers.
 */
- (void)clearPinMarkers;


/**
 * Refresh all pin markers.
 */
- (void)refreshPinMarker;


#pragma mark Setter Method

/**
 * Set call back when PinMarker is generated.
 */
- (void)setOnPinMarkerGenerateCallbackBlockWithMarkerImage:(UIImage *)image markerFrame:(CGFloat)frame isBoundCenter:(BOOL)isboundcenter callbackBlock:(void (^)(LocationRegionMarker *locationRegionMarker))block;

/**
 * Set call back when PinMarker is clicked.
 */
- (void)setOnPinMarkerClickCallbackBlock:(void (^)(LocationRegionMarker *locationRegionMarker))block;


#pragma mark Getter Method

/**
 * Get LocationRegion on give a xy point.
 *
 * @param pointX X of point.
 * @param pointY Y of point.
 * @return LocationRegion in NSArray.
 */
- (NSArray *)getLocationRegionByMarkerXY:(double)pointX andPointY:(double)pointY;

@end
