//
//  MarkerManager.h
//  BuildNGO
//
//  Created by Robert.Hsueh on 2014/5/14.
//  Copyright (c) 2014年 Robert.Hsueh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Marker, LocationRegion;

#pragma mark - MarkerManager Class

@interface MarkerManager : NSObject

#pragma mark Switch Method

/**
 * Invisible all marker.
 */
- (void)makeAllMarkerInvisible;

/**
 * Visible all marker.
 */
- (void)makeAllMarkerVisible;


#pragma mark Operation Method

/**
 * Clear all markers.
 */
- (void)clearMarkers;


#pragma mark Setter Method

/**
 * Set one marker on a location region.
 *
 * @param lRegion LocationRegion object.
 * @param image marker image resource.
 * @param frame determine marker frame.
 * @param isBoundCenter determine the marker is bound center or not, ture is bound center.
 */
- (void)setLocationRegionMarker:(LocationRegion *)lRegion andImage:(UIImage *)image andMarkerFrame:(float)frame andIsBoundCenter:(BOOL)isBoundCenter;


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


#pragma mark - LocationRegionMarker Class

@interface LocationRegionMarker : NSObject

@property (nonatomic, strong) LocationRegion *locationRegion;
@property (nonatomic, strong) Marker *marker;

- (id)initWithLocationRegion:(LocationRegion *)aRegion andMarker:(Marker *)aMarker;

@end