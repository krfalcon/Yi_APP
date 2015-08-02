//
//  SailsMapCommon.h
//  SailsMapView
//
//  Created by Robert.Hsueh on 13/9/12.
//  Copyright (c) 2013年 Robert.Hsueh. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#pragma mark - GeoPoint Class

 /**
  @brief A Point represents an immutable pair of double coordinates.(Longitude and Latitude)
  */
@interface GeoPoint : NSObject

@property (nonatomic) double longitude;
@property (nonatomic) double latitude;

 /**
  *  Initialization GeoPint
  *
  *  @param lon Longitude of GeoPoint
  *
  *  @param lat Latitude of GeoPoint
  *
  *  @return id
  */
- (id)initWithLogitude:(double)lon latitude:(double)lat;

@end


#pragma mark - PixelPoint Class

 /**
  @brief A Point represents an immutable pair of double coordinates.(X and Y)
  */
@interface PixelPoint : NSObject

@property (nonatomic) double x;
@property (nonatomic) double y;

 /**
  *  Initialization PixelPoint
  *
  *  @param Pointx X of PixelPoint
  *
  *  @param Pointy Y of PixelPoint
  *
  *  @return id
  */
- (id)initWithPointX:(double)pointx andPointY:(double)pointy;
@end


#pragma mark - BoundingBox Class

/**
 @brief A BoundingBox represents an immutable set of two latitude and two longitude coordinates.
 */
@interface BoundingBox : NSObject

/// The minimum latitude coordinate of this BoundingBox in degrees.
@property (nonatomic) double minLatitude;
/// The minimum longitude coordinate of this BoundingBox in degrees.
@property (nonatomic) double minLongitude;
/// The maximum latitude coordinate of this BoundingBox in degrees.
@property (nonatomic) double maxLatitude;
/// The maximum longitude coordinate of this BoundingBox in degrees.
@property (nonatomic) double maxLongitude;

/**
 *  Initialization BoundingBox
 *
 *  @param maxLon The maximum longitude coordinate of this BoundingBox in degrees.
 *
 *  @param maxLat The maximum latitude coordinate of this BoundingBox in degrees.
 *
 *  @param minLon The minimum longitude coordinate of this BoundingBox in degrees.
 *
 *  @param minLat The minimum latitude coordinate of this BoundingBox in degrees.
 *
 *  @return id
 */
- (id)initWithMaxLongitude:(double)maxLon andMaxLatitude:(double)maxLat andMinLongitude:(double)minLon andMinLatitude:(double)minLat;
/**
 *  Get a new GeoPoint at the horizontal and vertical center of this BoundingBox.
 *
 *  @return a new GeoPoint at the horizontal and vertical center of this BoundingBox.
 */
- (GeoPoint *)getCenterPoint;
@end


#pragma mark - Paint Class
/**
 * Paint is a object for drawing style.
 *
 */
@interface Paint : NSObject

@property (strong, nonatomic) UIColor *fillColor;
@property (strong, nonatomic) UIColor *strokeColor;
@property (nonatomic) float strokeWidth;
@property (nonatomic) float fillAlpha;
@property (nonatomic) float strokeAlpha;
@property (strong, nonatomic) UIColor *textFillColor;
@property (strong, nonatomic) UIColor *textStrokeColor;
@property (nonatomic) float textStrokeWidth;
@property (nonatomic) int textSize;

@end


#pragma mark - ---------------------------MapOverlays---------------------------

#pragma mark ListOverlay
/**
 * An ListOverlay is a geographical object which can draw itself on a canvas.
 *
 */
@interface ListOverlay : NSObject

- (NSMutableArray *)getOverlayItems;

@end


#pragma mark TextListOverlay
/**
 * An TextListOverlay is a geographical object which can draw itself on a canvas.
 *
 */
@interface TextListOverlay : NSObject

- (NSMutableArray *)getOverlayItems;

@end


#pragma mark PolygonalChain
/**
 * An PolygonalChain is a geographical object which can draw itself on a canvas.
 *
 */
@interface PolygonalChain : NSObject

- (id)initWithVertexList:(NSArray *) geopointlist;
- (NSMutableArray *)getGeoPoints;

@end


#pragma mark Polygon
/**
 * An Polygon is a geographical object which can draw itself on a canvas.
 *
 */
@interface Polygon : NSObject

- (id)initWithPolygonalChains:(NSMutableArray *)polygonalchains andPolygonPaint:(Paint *)polygonpaint;
- (void)setPolygonPaint:(Paint *)polygonpaint;
- (Paint *)getPolygonPaint;
- (NSMutableArray *)getPolygonalChains;

@end


#pragma mark Polyline
/**
 * An Polygon is a geographical object which can draw itself on a canvas.
 *
 */
@interface Polyline : NSObject

- (id)initWithPolygonalChain:(PolygonalChain *)polygonalchain andPolylinePaint:(Paint *)polylinepaint;
- (void)setPolylinePaint:(Paint *)polylinepaint;
- (void)setPolygonalChain:(PolygonalChain *)polygonalchain;
- (Paint *)getPolylinePaint;
- (PolygonalChain *)getPolygonalChain;

@end


#pragma mark Circle
/**
 * An Circle is a geographical object which can draw itself on a canvas.
 *
 */
@interface Circle : NSObject

- (id)initWithGeoPoint:(GeoPoint *)geopoint andPaint:(Paint *)circlepaint andRadius:(float)radius;
- (GeoPoint *)getCircleGeoPoint;
- (Paint *)getCirclePaint;
- (float)getCircleRadius;
- (void)setCircleGeoPoint:(double)longitude andLatitude:(double)latitude;
- (void)setCirclePaint:(Paint *) paint;
- (void)setCircleRadius:(float) radius;

@end


#pragma mark Marker
/**
 * An Marker is a geographical object which can draw itself on a canvas.
 *
 */
@interface Marker : NSObject

- (id)initWithGeoPoint:(GeoPoint *)geopoint andImage:(UIImage *)image andMarkerFrame:(CGFloat)markerframe andIsBoundCenter:(BOOL)isboundcenter;
- (GeoPoint *)getMarkerGeoPoint;
- (UIImage *)getImage;
- (void)setMarkerGeoPoint:(GeoPoint *)aGeoPoint;
- (void)setImage:(UIImage *)image;
- (void)setMarkerFrame:(int)frame;
- (BOOL)isInMarker:(double)xFromCenter andY:(double)yFromCenter;

@end


#pragma mark OrientationMarker
/**
 * An OrientationMarker is a geographical object which can draw itself on a canvas.
 *
 */
@interface OrientationMarker : NSObject

- (id)initWithGeoPoint:(GeoPoint *)geopoint andImage:(UIImage *)image andMarkerFrame:(CGFloat)markerframe;
- (GeoPoint *)getMarkerGeoPoint;
- (double)getRotationAngle;//in radians
- (UIImage *)getImage;
- (void)setMarkerGeoPoint:(GeoPoint *)aGeoPoint;
- (void)setRotationAngle:(double)angle;//in radians
- (void)setImage:(UIImage *)image;
- (void)setMarkerFrame:(int)frame;

@end


#pragma mark TextOverlay
/**
 * An TextOverlay is a geographical object which can draw itself on a canvas.
 *
 */
@interface TextOverlay : NSObject

- (id)initWithGeoPoint:(GeoPoint *)geopoint andString:(NSString *)textstring andPaint:(Paint *)paint;
- (NSMutableArray *)getTextOverlayList;
- (void)setTextOverlayList:(NSMutableArray *)textOverlayListArray;
- (BOOL)getIsDrawed;

@end


#pragma mark MapPhotoOverlay
/**
 * An MapPhotoOverlay is a geographical object which can draw itself on a canvas.
 *
 */
@interface MapPhotoOverlay : NSObject

- (id)initWithImage:(UIImage *)image;

@end

#pragma mark - -------------------------MapOverlays-End-------------------------


#pragma mark SailsMapView Class

/**
 @brief SailsMapView: display map
 */
@interface SailsMapView : UIView

@end


#pragma mark SailsLocationMapView Class

#pragma mark MapFormat
/**
 * MapFormat.
 * <p/>
 * Vector: means vector type map.
 * JPG: means use JPG graphic to be a map.
 * VOID: means map is not exist.
 */
typedef NS_ENUM(NSInteger, SAILSMapFormat) {
	Vector,
	JPG,
	VOID
};


#pragma mark Map Control Mode
/**
 * Map Control mode
 */
typedef NS_ENUM(NSInteger, SailsMapControlMode) {
    /**
     * Map Control mode :  GENERAL (binary: 0000)
     *
     * means the mode which not have any control function.
     */
    GeneralMode = 0,
    /**
     * Map Control mode :  LocationCenterLockMode (binary: 0001)
     *
     * means the mode which let the user position always on the center of the map.
     */
    LocationCenterLockMode = 1,
    /**
     * Map Control mode :  FollowPhoneHeagingMode (binary: 0010)
     *
     * means the mode which let the map auto rotate to make the heading of the phone always in map north direction.
     */
    FollowPhoneHeagingMode = 2,
    /**
     * Map Control mode :  AutoFloorSwitchMode (binary: 0100)
     *
     * means the mode which can let the map auto switch to different map
     * when the location engine change the user's locating floor.
     */
    AutoFloorSwitchMode = 4,
    /**
     * Map Control mode :  AlwaysLockMapMode (binary: 1000)
     *
     * Lock current mode setting and user cannot unlock mode by finger slide the map.
     */
    AlwaysLockMapMode = 8
};


@class MarkerManager, PinMarkerManager, PathRoutingManager;
@interface SailsLocationMapView : SailsMapView

#pragma mark Operation Method

/**
 * Load the calculated floor's map into the map view.
 *
 * @return true if loading process is successful.
 */
- (BOOL)loadCurrentLocationFloorMap;


/**
 * Load map into map view depends on specify floor name.
 *
 * @param floorName : input the floor name.
 * @return true if loading process is successful.
 */
- (BOOL)loadFloorMap:(NSString *)floorName;


/**
 * Auto Adjust suitable map zoom level and position to let the user can see the hold map.
 */
- (void)autoSetMapZoomAndView;


/**
 * Auto Adjust suitable map zoom level and position to let the user can see the hold routing path.
 *
 * @param geoPointList GeoPoints of routing path nodes.
 */
- (void)autoSetMapZoomAndView:(NSArray *)geoPointList;


/**
 * Triggers a redraw process of the map.
 */
- (void)reDrawManager;


/**
 * Remove map.
 */
- (void)clearMap;


/**
 * Move the map to specified focus location with animation.
 *
 * @param target input location by GeoPoint format.
 */
- (BOOL)startMoveMapAnimationWithTarget:(GeoPoint *)targetpoint;


/**
 * Set map rotation angle with animation.
 *
 * @param angle input angle value by degree. (Note 0 degree is the phone view north)
 */
- (BOOL)startRotateMapAnimationWithTarget:(float)targetangle;


/**
 * Set zoom level with animation.
 *
 * @param level input zoom level value (0~22)
 */
- (void)startAnimationToZoom:(Byte)level;


/**
 * Zoom in the map.
 */
- (void)zoomIn;


/**
 * Zoom out the map.
 */
- (void)zoomOut;


#pragma mark Setter Method

/**
 * Set or unset center lock.
 *
 * @param lock set true to set center lock, false to release center lock.
 */
- (void)setCenterLock:(BOOL)lock;


/**
 * Set location marker visible or invisible.
 *
 * @param visible : true for visible, false for invisible.
 */
- (void)setLocatorMarkerVisible:(BOOL)visible;


/**
 * Set location indicator icon. You can see the icon you set when the location engine turn on.
 *
 * @param circle              set icon when heading is not stable yet.
 * @param arrow               set icon when heading is stable.
 * @param accuracyPaint       set accuracy circle area show. set null if you don't need to show it.
 * @param frame               set icon size.
 */
- (void)setLocationMarker:(UIImage *)circle arrowImage:(UIImage *)arrow accuracyCirclePaint:(Paint *)accuracyPaint iconFrame:(int)frame;


/**
 * Set mode to specify value.
 *
 * {GeneralMode = 0000, LocationCenterLockMode = 0001, FollowPhoneHeagingMode = 0010, AutoFloorSwitchMode = 0100, AlwaysLockMapMode = 1000}
 *
 * Note: it is a logic-sensed mode setting.
 *
 * Usage 1 (set simple mode): To change different simple mode you want. For example, to set FollowPhoneHeagingMode (binary:0010).
 *
 * You can set like this: 
 *
 * @code
 * [YourSailsLocationMapViewObject setMapControlMode:FollowPhoneHeagingMode].
 * @endcode
 *
 * Usage 2 (set combination mode): To set mode in combination format you want. For example, to set both LocationCenterLockMode & FollowPhoneHeagingMode (binary: 0011).
 *
 * You can set like this: 
 *
 * @code
 * [YourSailsLocationMapViewObject setMapControlMode:LocationCenterLockMode | FollowPhoneHeagingMode].
 * @endcode
 *
 * Usage 3 (add mode): If you want to keep current mode setting and enable addition modes. For example, to add enable LocationCenterLockMode & FollowPhoneHeagingMode modes (binary: 0011).
 *
 * You can set like this: 
 *
 * @code
 * [YourSailsLocationMapViewObject setMapControlMode:[YourSailsLocationMapViewObject getMapControlMode] | LocationCenterLockMode | FollowPhoneHeagingMode].
 * @endcode
 *
 * Usage 4 (Discard mode): If you want to keep current mode setting and disable some modes. For example, to disable both AutoFloorSwitchMode & FollowPhoneHeagingMode (binary: 0101).
 *
 * You can set like this: 
 *
 * @code
 * [YourSailsLocationMapViewObject setMapControlMode:[YourSailsLocationMapViewObject getMapControlMode] & ~(AutoFloorSwitchMode | FollowPhoneHeagingMode)].
 * @endcode
 *
 * @param mode input mode value
 */
- (void)setMapControlMode:(SailsMapControlMode)mode;


/**
 * Set map rotation angle without animation.
 *
 * @param angle input angle value by degree. (Note 0 degree is the phone view north)
 */
- (void)setTotalRotationAngle:(float)angle;


#pragma mark Set Sails Location Map View Callback Block Method

/**
 * Call back block when map control mode is changed.
 */
- (void)setOnModeChangedBlock:(void (^)(void))block;


/**
 * Call back when user touch on the map.
 */
- (void)setOnMapClickBlock:(void (^)(CGPoint tapPoint))block;


/**
 * Call back when user move the map.
 */
- (void)setOnMapMoveEventBlock:(void (^)(void))block;


/**
 * Call back when user scale the map.
 */
- (void)setOnMapScaleEventBlock:(void (^)(void))block;


/**
 * Call back when user rotate the map.
 */
- (void)setOnMapRotateEventBlock:(void (^)(void))block;


/**
 * Call back when user touch nothing on the map.
 */
- (void)setOnClickNothingBlock:(void (^)(void))block;


/**
 * Call back when user touch location region on the map.
 */
- (void)setOnRegionClickBlock:(void (^)(NSArray *locationRegions))block;


/**
 * Call back when user long touch location region on the map.
 */
- (void)setOnRegionLongClickBlock:(void (^)(NSArray *locationRegions))block;


/**
 * Call back before change to different map.
 */
- (void)setOnFloorChangedBeforeBlock:(void (^)(NSString *floorName))block;


/**
 * Call back after change to different map.
 */
- (void)setOnFloorChangedAfterBlock:(void (^)(NSString *floorName))block;


#pragma mark Getter Method

/**
 * Get current mode setting.
 *
 * @return mode setting value.
 */
- (SailsMapControlMode)getMapControlMode;


/**
 * get floor name that user browsed currently.
 *
 * @return floor name in NSString.
 */
- (NSString *)getCurrentBrowseFloorName;


/**
 * Get current map rotation angle. Note 0 degree is the phone view north, Clockwise to increse and Counterclockwise to decrease.
 *
 * @return angle by radians.(Maximum = PI, Minimum = -PI)
 */
- (float)getTotalRotationAngle;


/**
 * @return the current center position of the map.
 */
- (GeoPoint *)getViewCenter;


/**
 * @return the current zoom level of the map.
 */
- (int)getZoomLevel;


/**
 * @return the currently visible boundaries of the map.
 */
- (BoundingBox *)getBoundingBox;


/**
 * @return the currently visible boundaries of the map.
 */
- (BoundingBox *)getBoundingBox:(Byte)zoomlevel;


/**
 * @return the currently visible boundaries of the map.
 */
- (BoundingBox *)getBoundingBox:(double) longitude andLatitude:(double) latitude andZoomLevel:(Byte) zoomlevel;


/**
 * @return A NSMutableArray of overlays for this MapView.
 */
- (NSMutableArray *)getOverlays;


/**
 * @return A NSMutableArray of DynamicOverlays for this MapView.
 */
- (NSMutableArray *)getDynamicOverlays;


/**
 * Get marker control resource.
 *
 * @return MakerManager object.
 */
- (MarkerManager *)getMarkerManager;


/**
 * Get Pin marker control resource.
 *
 * @return PinMarkerManager object.
 */
- (PinMarkerManager *)getPinMarkerManager;


/**
 * Get routing control resource.
 *
 * @return PathRoutingManager object.
 */
- (PathRoutingManager *)getRoutingManager;


#pragma mark Check Method

/**
 * Check if the map is in center lock mode (Mode: LocationCenterLockMode) or not.
 *
 * @return true if map is in cencter lock mode.
 */
- (BOOL)isCenterLock;


/**
 * Check if the locating floor recognized by SAILS engine is the same as
 * the floor that user browsed currently.
 *
 * @return true if the floor in view is the same as the locating floor.
 */
- (BOOL)isInLocationFloor;

@end

