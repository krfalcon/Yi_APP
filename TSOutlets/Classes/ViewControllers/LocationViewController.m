//
//  LocationViewController.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/6/29.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "LocationViewController.h"
#import "Sails.h"
#import "SailsMapCommon.h"
#import "LocationRegion.h"
#import "MarkerManager.h"
#import "PinMarkerManager.h"
#import "PathRoutingManager.h"
#import <AudioToolbox/AudioToolbox.h>

typedef NS_ENUM(NSInteger, UIActionSheetMode) {
    FloorSheetMode,
    RoutingSheetMode
};

@interface LocationViewController ()<UIActionSheetDelegate, UITableViewDelegate, UITableViewDataSource>
{
    SailsLocationMapView *sailsMapView;
    MarkerManager *sailsMarkerManager;
    PinMarkerManager *sailsPinMarkerManager;
    PathRoutingManager *sailsPathRoutingManager;
    Sails *sails;
    NSArray *floorNameList;
    UIBarButtonItem *mBarButtonPOI;
    UIBarButtonItem *mBarButtonFloor;
    UIBarButtonItem *mBarButtonSwitch;
    UIBarButtonItem *mBarButtonRoutinMode;
    UITableView *poiTableView;
    NSDictionary *allLocationRegionOfFloors;
    UIButton *zoomInButton;
    UIButton *zoomOutButton;
    UIButton *lockCenterButton;
    UIButton *stopRoutingButton;
    UIButton *pinMarkerButton;
    UIView *naviView;
    UILabel *totalDistanceLabel;
    UILabel *currentDistanceLabel;
    UILabel *naviLabel;
    LocationRegion *startTest;
    LocationRegion *endTest;
    UIActionSheetMode actionSheetMode;
}

@end

@implementation LocationViewController

- (void)initFirstViewWithParameter:(NSDictionary *)parameter {
    self.view.backgroundColor = AbsoluteWhite;
    self.enableGesture = NO;
    
    [self initSails];
    //[self initUI];
}

#pragma mark - Initialization Method

//init No.1
- (void)initSails
{
    //Create map view
    sailsMapView = [[SailsLocationMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:sailsMapView];

    //Create sails object
    sails = [[Sails alloc] init];
    
    //set map view to sails object
    [sails setSailsLocationMapView:sailsMapView];
    
    //get marker manager
    sailsMarkerManager = [sailsMapView getMarkerManager];
    //get pin marker manager
    sailsPinMarkerManager = [sailsMapView getPinMarkerManager];
    //get path routing manager
    sailsPathRoutingManager = [sailsMapView getRoutingManager];
    
    //set floor number sort rule from descending to ascending.
    [sails setReverseFloorList:true];
    
    //load location data
    __weak SailsLocationMapView *weakSailsMapView = sailsMapView;
    __weak LocationViewController *weakSelf = self;
    
    [sails loadCloudBuilding:@"16d42e7e84384d20b166ad7748046ce5"
                  buildingID:@"557a76461bd2173d390002e0"
                     success:^(void){
                         floorNameList = [sails getFloorNameList];
                         [weakSailsMapView loadFloorMap:[floorNameList firstObject]];
                         weakSelf.navigationItem.title = [sails getFloorDescription:[floorNameList firstObject]];
                         allLocationRegionOfFloors = [weakSelf getAllLocationRegionOfFloors];
                         [poiTableView reloadData];
                         
                         NSLog(@"success");
                     }
                     failure:^(NSError *error) {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"SailsSDK" message:error.localizedDescription delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
                         [alertView show];
                     }];
}

//init No.2
- (void)initUI
{
    NSMutableArray *leftItems = [[NSMutableArray alloc] init];
    NSMutableArray *rightItems = [[NSMutableArray alloc] init];
    
    //init POI button
    mBarButtonPOI = [[UIBarButtonItem alloc] initWithTitle:@"POIs" style:UIBarButtonItemStylePlain target:self action:@selector(onNaviBarButtonPOIClick:)];
    [leftItems addObject:mBarButtonPOI];
    
    //init floor button
    mBarButtonFloor = [[UIBarButtonItem alloc] initWithTitle:@"Floor" style:UIBarButtonItemStylePlain target:self action:@selector(onNaviBarButtonFloorClick:)];
    [leftItems addObject:mBarButtonFloor];
    self.navigationItem.leftBarButtonItems = leftItems;
    
    //init switch button
    mBarButtonSwitch = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(onNaviBarButtonSwitchClick:)];
    [rightItems addObject:mBarButtonSwitch];
    
    //init routing mode button
    mBarButtonRoutinMode = [[UIBarButtonItem alloc] initWithTitle:@"Mode" style:UIBarButtonItemStylePlain target:self action:@selector(onNaviBarButtonRoutingModeClick:)];
    [rightItems addObject:mBarButtonRoutinMode];
    self.navigationItem.rightBarButtonItems = rightItems;
    
    //init zoom in button
    zoomInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [zoomInButton addTarget:self action:@selector(zoomInButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [zoomInButton setImage:[UIImage imageNamed:@"zoomin"] forState: UIControlStateNormal];
    [zoomInButton setImage:[UIImage imageNamed:@"zoomin_p"] forState: UIControlStateHighlighted];
    zoomInButton.frame = CGRectMake(0, 0, 45, 45);
    zoomInButton.center = CGPointMake(290, [UIScreen mainScreen].bounds.size.height*19/24);
    [self.view addSubview:zoomInButton];
    
    //init zoom out button
    zoomOutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [zoomOutButton addTarget:self action:@selector(zoomOutButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [zoomOutButton setImage:[UIImage imageNamed:@"zoomout"] forState: UIControlStateNormal];
    [zoomOutButton setImage:[UIImage imageNamed:@"zoomout_p"] forState: UIControlStateHighlighted];
    zoomOutButton.frame = CGRectMake(0, 0, 45, 45);
    zoomOutButton.center = CGPointMake(290, [UIScreen mainScreen].bounds.size.height*19/24+45);
    [self.view addSubview:zoomOutButton];
    
    //init lock center button
    lockCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lockCenterButton addTarget:self action:@selector(lockCenterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [lockCenterButton setImage:[UIImage imageNamed:@"lockCenter1"] forState:UIControlStateNormal];
    lockCenterButton.frame = CGRectMake(0, 0, 45, 45);
    lockCenterButton.center = CGPointMake(30, [UIScreen mainScreen].bounds.size.height*19/24+45);
    lockCenterButton.tag = 1;
    [self.view addSubview:lockCenterButton];
    lockCenterButton.hidden = true;
    
    //init stop routing button
    stopRoutingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopRoutingButton addTarget:self action:@selector(stopRoutingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [stopRoutingButton setImage:[UIImage imageNamed:@"stop_icon"] forState:UIControlStateNormal];
    //    stopRoutingButton.frame = CGRectMake(0, 0, 36, 36);
    //    stopRoutingButton.center = CGPointMake(290, 84);
    stopRoutingButton.frame = CGRectMake(0, 0, 42, 42);
    stopRoutingButton.center = CGPointMake(30, [UIScreen mainScreen].bounds.size.height*19/24);
    stopRoutingButton.tag = 2;
    [self.view addSubview:stopRoutingButton];
    stopRoutingButton.hidden = true;
    
    //init place a pin marker button
    pinMarkerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [pinMarkerButton addTarget:self action:@selector(pinMarkerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [pinMarkerButton setTitle:@"Place a PinMarker" forState:UIControlStateNormal];
    pinMarkerButton.frame = CGRectMake(0, 0, 160, 40);
    pinMarkerButton.center = CGPointMake(80, 84);
    pinMarkerButton.tag = 3;
    [self.view addSubview:pinMarkerButton];
    
    //init navi view
    naviView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    naviView.center = CGPointMake(160, 124);//164
    naviView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    [self.view addSubview:naviView];
    
    totalDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    totalDistanceLabel.center = CGPointMake(160, 15);
    totalDistanceLabel.text = @"Total Routing Distance :";
    totalDistanceLabel.textAlignment = NSTextAlignmentRight;
    totalDistanceLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:181.0/255.0 blue:229.0/255.0 alpha:255.0/255.0];
    [naviView addSubview:totalDistanceLabel];
    
    currentDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    currentDistanceLabel.center = CGPointMake(160, 45);
    currentDistanceLabel.text = @"Current Routing Distance :";
    currentDistanceLabel.textAlignment = NSTextAlignmentRight;
    currentDistanceLabel.textColor = [UIColor colorWithRed:255.0/255.0 green:187.0/255.0 blue:51.0/255.0 alpha:255.0/255.0];
    [naviView addSubview:currentDistanceLabel];
    
    naviLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
    naviLabel.center = CGPointMake(160, 90);
    naviLabel.text = @"導航提示";
    naviLabel.numberOfLines = 2;
    naviLabel.textAlignment = NSTextAlignmentLeft;
    naviLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:204.0/255.0 blue:0.0/255.0 alpha:255.0/255.0];
    [naviView addSubview:naviLabel];
    
    [self animateFunctionViewHorizontal:naviView Hidden:YES];
    [self animateNaviViewLarge:NO];
    
    //init poi table view
    CGSize frameSize = self.view.frame.size;
    const float fNaviBarMaxY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGRect frameRect = CGRectMake(0, fNaviBarMaxY, frameSize.width, frameSize.height - fNaviBarMaxY);
    poiTableView = [[UITableView alloc] initWithFrame:frameRect style:UITableViewStyleGrouped];
    poiTableView.delegate = self;
    poiTableView.dataSource = self;
    [self.view addSubview:poiTableView];
    [self animateFunctionViewVertical:poiTableView Hidden:YES];
    
    __weak SailsLocationMapView *weakSailsMapView = sailsMapView;
    __weak UIButton *weakLockCenterButton = lockCenterButton;
    
    //create mode change call back block
    [sailsMapView setOnModeChangedBlock:^(void){
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if ((([weakSailsMapView getMapControlMode] & LocationCenterLockMode) == LocationCenterLockMode) && (([weakSailsMapView getMapControlMode] & FollowPhoneHeagingMode) == FollowPhoneHeagingMode)) {
                [weakLockCenterButton setImage:[UIImage imageNamed:@"lockCenter3"] forState:UIControlStateNormal];
            }else if (([weakSailsMapView getMapControlMode] & LocationCenterLockMode) == LocationCenterLockMode) {
                [weakLockCenterButton setImage:[UIImage imageNamed:@"lockCenter2"] forState:UIControlStateNormal];
            }else {
                [weakLockCenterButton setImage:[UIImage imageNamed:@"lockCenter1"] forState:UIControlStateNormal];
            }
        });
    }];
    
    __weak MarkerManager *weakSailsMarkerManager = sailsMarkerManager;
    __weak PathRoutingManager *weakRoutingManager = sailsPathRoutingManager;
    __weak Sails *weakSails = sails;
    __weak UIButton *weakStopRoutingButton = stopRoutingButton;
    __weak LocationViewController *weakSelf = self;
    __weak UIView *weakNaviView = naviView;
    __weak UIButton *weakPinMarkerButton = pinMarkerButton;
    
    //create location change call back block
    [sails setOnLocationChangeEventBlock:^{
        if ([weakSailsMapView isCenterLock] && ![weakSailsMapView isInLocationFloor] && ![[weakSails getFloor] isEqualToString:@""] && [weakSails isLocationFix]) {
            [weakSailsMapView loadCurrentLocationFloorMap];
            [weakSailsMapView startAnimationToZoom:19];
        }
    }];
    
    //create region long click call back block
    [sailsMapView setOnRegionLongClickBlock:^(NSArray *locationRegions) {
        [weakSailsMarkerManager clearMarkers];
        [weakRoutingManager setStartRegion:[locationRegions firstObject]];
        [weakSailsMarkerManager setLocationRegionMarker:[locationRegions firstObject] andImage:[UIImage imageNamed:@"start_point"] andMarkerFrame:48 andIsBoundCenter:true];
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }];
    
    //create region click call back block
    [sailsMapView setOnRegionClickBlock:^(NSArray *locationRegions) {
        //begin to routing
        if ([weakSails isLocationEngineStarted]) {
            
            //set routing start point to current user location
            [weakRoutingManager setStartRegion:nil];
            
            //set routing end point marker icon image
            [weakRoutingManager setTargetMakerImage:[UIImage imageNamed:@"destination"]];
            
            //set routing end point marker icon frame
            [weakRoutingManager setTargetMakerFrame:48];
            
            //set routing path's color
            Paint *routingPathPaint = [weakRoutingManager getPathPaint];
            routingPathPaint.strokeColor = [UIColor colorWithRed:53.0/255.0 green:179.0/255.0 blue:229.0/255.0 alpha:255.0/255.0];
            
            weakStopRoutingButton.hidden = false;
            
            [weakSelf animateNaviViewLarge:true];
            
        }else {
            //set routing end point marker icon image
            [weakRoutingManager setTargetMakerImage:[UIImage imageNamed:@"map_destination"]];
            
            //set routing end point marker icon frame
            [weakRoutingManager setTargetMakerFrame:48];
            
            //set routing path's color
            Paint *routingPathPaint = [weakRoutingManager getPathPaint];
            routingPathPaint.strokeColor = [UIColor colorWithRed:133.0/255.0 green:176.0/255.0 blue:56.0/255.0 alpha:255.0/255.0];
            
            if ([weakRoutingManager getStartRegion] != nil) {
                weakStopRoutingButton.hidden = false;
            }
        }
        
        //set routing end point location
        [weakRoutingManager setTargetRegion:[locationRegions firstObject]];
        
        //begin to route
        if (([weakSails isLocationEngineStarted] && [weakRoutingManager getStartRegion] == nil) || (![weakSails isLocationEngineStarted] && [weakRoutingManager getStartRegion] != nil)) {
            [weakRoutingManager enableRouting];
            [weakSelf animateFunctionViewHorizontal:weakNaviView Hidden:false];
            weakPinMarkerButton.hidden = true;
        }
        
    }];
    
    //design some action in floor change call back.
    [sailsMapView setOnFloorChangedBeforeBlock:^(NSString *floorName) {
        
    }];
    
    [sailsMapView setOnFloorChangedAfterBlock:^(NSString *floorName) {
        weakSelf.navigationItem.title = [weakSails getFloorDescription:floorName];
    }];
    
    [self configRouting];
}

- (void)configRouting
{
    [sailsPathRoutingManager setStartMakerImage:[UIImage imageNamed:@"start_point"]];
    [sailsPathRoutingManager setStartMakerFrame:48];
    [sailsPathRoutingManager setTargetMakerImage:[UIImage imageNamed:@"map_destination"]];
    [sailsPathRoutingManager setTargetMakerFrame:48];
    __weak PathRoutingManager *weakSailsPathRoutingManager = sailsPathRoutingManager;
    __weak SailsLocationMapView *weakSailsMapView = sailsMapView;
    __weak LocationViewController *weakSelf = self;
    __weak MarkerManager *weakSailsMarkerManager = sailsMarkerManager;
    __weak UILabel *weakTotalDistanceLabel = totalDistanceLabel;
    __weak UILabel *weakCurrentDistanceLabel = currentDistanceLabel;
    __weak UILabel *weakNaviLabel = naviLabel;
    __weak Sails *weakSails = sails;
    __weak UIButton *weakStopRoutingButton = stopRoutingButton;
    [sailsPathRoutingManager setOnRoutingUpdateRouteSuccessBlock:^{
        NSArray *gpList = [weakSailsPathRoutingManager getCurrentFloorRoutingPathNodes];
        [weakSailsMapView autoSetMapZoomAndView:gpList];
    }];
    [sailsPathRoutingManager setOnRoutingUpdateArrivedBlock:^(LocationRegion *targetRegion) {
        [weakSelf stopRoutingButtonClicked:weakStopRoutingButton];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"SailsSDK" message:[NSString stringWithFormat:@"已到達 : %@" ,[targetRegion getName]] delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [alertView show];
    }];
    [sailsPathRoutingManager setOnRoutingUpdateRouteFailBlock:^{
        [weakSelf stopRoutingButtonClicked:weakStopRoutingButton];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"SailsSDK" message:@"Route Fail" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [alertView show];
    }];
    [sailsPathRoutingManager setOnRoutingUpdateTotalDistanceRefreshBlock:^(int distance) {
        weakTotalDistanceLabel.text = [NSString stringWithFormat:@"Total Routing Distance : %d (m)" ,distance];
    }];
    [sailsPathRoutingManager setOnRoutingUpdateReachNearestTransferDistanceRefreshBlock:^(int distance, PathRoutingNodeType nodeType) {
        switch (nodeType) {
            case ElevatorType:
                weakCurrentDistanceLabel.text = [NSString stringWithFormat:@"To Nearest Elevator Distance : %d (m)" ,distance];
                break;
                
            case EscalatorType:
                weakCurrentDistanceLabel.text = [NSString stringWithFormat:@"To Nearest Escalator Distance : %d (m)" ,distance];
                break;
                
            case StairType:
                weakCurrentDistanceLabel.text = [NSString stringWithFormat:@"To Nearest Stair Distance : %d (m)" ,distance];
                break;
                
            case DestinationType:
                weakCurrentDistanceLabel.text = [NSString stringWithFormat:@"To Destination Distance : %d (m)" ,distance];
                break;
        }
    }];
    [sailsPathRoutingManager setOnRoutingUpdateSwitchFloorInfoRefreshBlock:^(NSArray *infoList, int nearestIndex) {
        //set markers for every transfer location
        for (SwitchFloorInfo *mS in infoList) {
            if (mS.direction != GoTargetDirection) {
                [weakSailsMarkerManager setLocationRegionMarker:mS.fromBelongsRegion andImage:[UIImage imageNamed:@"transfer_point"] andMarkerFrame:48 andIsBoundCenter:true];
            }
        }
        //when location engine not turn,there is no current switch floor info.
        if (nearestIndex == -1) {
            return;
        }
        
        SwitchFloorInfo *sfInfo = [infoList objectAtIndex:nearestIndex];
        
        switch (sfInfo.nodeType) {
            case ElevatorType:
                if (sfInfo.direction == UpDirection) {
                    weakNaviLabel.text = [NSString stringWithFormat:@"導航提示 : \n請搭電梯上樓至%@" ,[weakSails getFloorDescription:sfInfo.toFloorName]];
                }else if (sfInfo.direction == DownDirection) {
                    weakNaviLabel.text = [NSString stringWithFormat:@"導航提示 : \n請搭電梯下樓至%@" ,[weakSails getFloorDescription:sfInfo.toFloorName]];
                }
                break;
                
            case EscalatorType:
                if (sfInfo.direction == UpDirection) {
                    weakNaviLabel.text = [NSString stringWithFormat:@"導航提示 : \n請搭手扶梯上樓至%@" ,[weakSails getFloorDescription:sfInfo.toFloorName]];
                }else if (sfInfo.direction == DownDirection) {
                    weakNaviLabel.text = [NSString stringWithFormat:@"導航提示 : \n請搭手扶梯下樓至%@" ,[weakSails getFloorDescription:sfInfo.toFloorName]];
                }
                break;
                
            case StairType:
                if (sfInfo.direction == UpDirection) {
                    weakNaviLabel.text = [NSString stringWithFormat:@"導航提示 : \n請走樓梯上樓至%@" ,[weakSails getFloorDescription:sfInfo.toFloorName]];
                }else if (sfInfo.direction == DownDirection) {
                    weakNaviLabel.text = [NSString stringWithFormat:@"導航提示 : \n請走樓梯下樓至%@" ,[weakSails getFloorDescription:sfInfo.toFloorName]];
                }
                break;
                
            case DestinationType:
                weakNaviLabel.text = [NSString stringWithFormat:@"導航提示 : \n請前往%@" ,[sfInfo.fromBelongsRegion getName]];
                break;
        }
    }];
}


#pragma mark - Button Method

- (IBAction)onNaviBarButtonPOIClick:(id)sender
{
    if ([poiTableView isHidden]) {
        [poiTableView reloadData];
        [self animateFunctionViewVertical:poiTableView Hidden:NO];
    }else {
        [self animateFunctionViewVertical:poiTableView Hidden:YES];
    }
}

- (IBAction)onNaviBarButtonFloorClick:(id)sender
{
    NSArray *floorDescList = [sails getFloorDescList];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.delegate = self;
    actionSheetMode = FloorSheetMode;
    for (NSString *floorName in floorDescList) {
        [actionSheet addButtonWithTitle:floorName];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet showInView:self.view];
}

- (IBAction)onNaviBarButtonRoutingModeClick:(id)sender
{
    NSArray *routingModeList = @[@"NormalRoutingMode", @"StairOnlyMode", @"EscalatorOnlyMode", @"ElevatorOnlyMode", @"ElevatorAndEscalatorMode"];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.delegate = self;
    actionSheetMode = RoutingSheetMode;
    for (NSString *routingMode in routingModeList) {
        [actionSheet addButtonWithTitle:routingMode];
    }
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    [actionSheet showInView:self.view];
}

- (IBAction)onNaviBarButtonSwitchClick:(id)sender
{
    if ([sails isLocationEngineStarted]) {
        [sails stopLocatingEngine];
        [sailsMapView setLocatorMarkerVisible:false];
        [sailsMapView setMapControlMode:GeneralMode];
        [sailsPathRoutingManager disableRouting];
        stopRoutingButton.hidden = true;
        [self animateNaviViewLarge:false];
        [self animateFunctionViewHorizontal:naviView Hidden:true];
        lockCenterButton.hidden = true;
        mBarButtonSwitch.title = @"Start";
        pinMarkerButton.hidden = false;
    }else {
        if ([sailsPathRoutingManager isRoutingEnable]) {
            [sailsPathRoutingManager disableRouting];
            stopRoutingButton.hidden = true;
            pinMarkerButton.hidden = false;
            [self animateNaviViewLarge:false];
            [self animateFunctionViewHorizontal:naviView Hidden:true];
        }
        [sails startLocatingEngine];
        [sailsMapView setLocatorMarkerVisible:true];
        [sailsMapView setMapControlMode:LocationCenterLockMode | FollowPhoneHeagingMode];
        lockCenterButton.hidden = false;
        mBarButtonSwitch.title = @"Stop";
        pinMarkerButton.hidden = true;
        [sailsPinMarkerManager clearPinMarkers];
    }
}

- (IBAction)zoomInButtonClicked:(UIButton *)sender
{
    [sailsMapView zoomIn];
}

- (IBAction)zoomOutButtonClicked:(UIButton *)sender
{
    [sailsMapView zoomOut];
}

- (IBAction)lockCenterButtonClicked:(UIButton *)sender
{
    if ([sailsMapView isCenterLock]) {
        if (([sailsMapView getMapControlMode] & FollowPhoneHeagingMode) == FollowPhoneHeagingMode) {
            [sailsMapView setMapControlMode:([sailsMapView getMapControlMode] & ~FollowPhoneHeagingMode)];
        }else {
            [sailsMapView setMapControlMode:([sailsMapView getMapControlMode] | FollowPhoneHeagingMode)];
        }
    }else {
        [sailsMapView setMapControlMode:([sailsMapView getMapControlMode] | LocationCenterLockMode)];
    }
}

- (IBAction)stopRoutingButtonClicked:(UIButton *)sender
{
    [sailsPathRoutingManager disableRouting];
    [self animateNaviViewLarge:false];
    [self animateFunctionViewHorizontal:naviView Hidden:true];
    stopRoutingButton.hidden = true;
    if ([sails isLocationEngineStarted]) {
        pinMarkerButton.hidden = true;
    }else {
        pinMarkerButton.hidden = false;
    }
}

- (IBAction)pinMarkerButtonClicked:(UIButton *)sender
{
    [sailsPinMarkerManager setOnPinMarkerGenerateCallbackBlockWithMarkerImage:[UIImage imageNamed:@"parking_target"] markerFrame:48 isBoundCenter:NO callbackBlock:^(LocationRegionMarker *locationRegionMarker) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"SailsSDK" message:@"One PinMarker Generated" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [alertView show];
    }];
}


#pragma mark - Operation Method

- (NSDictionary *)getAllLocationRegionOfFloors
{
    NSMutableDictionary *resultsOfFloors = [NSMutableDictionary dictionary];
    if (floorNameList != nil && [floorNameList count]) {
        for (NSString *floorName in floorNameList) {
            NSArray *tmp = [sails getLocationRegionList:floorName];
            resultsOfFloors[floorName] = tmp;
        }
    }
    return resultsOfFloors;
}

- (LocationRegion *)locationRegionAtIndexPath:(NSIndexPath *)indexPath
{
    LocationRegion *locationRegion;
    if (floorNameList != nil && allLocationRegionOfFloors != nil) {
        NSArray *result = allLocationRegionOfFloors[floorNameList[indexPath.section]];
        if (result != nil && [result count] > indexPath.row) {
            locationRegion = [result objectAtIndex:indexPath.row];
        }
    }
    return locationRegion;
}

- (void)setSailsRoutingMode:(NSString *)mode
{
    if ([mode isEqualToString:@"NormalRoutingMode"]) {
        [sailsPathRoutingManager setRoutingMode:NormalRoutingMode];
    }else if ([mode isEqualToString:@"StairOnlyMode"]) {
        [sailsPathRoutingManager setRoutingMode:StairOnlyMode];
    }else if ([mode isEqualToString:@"EscalatorOnlyMode"]) {
        [sailsPathRoutingManager setRoutingMode:EscalatorOnlyMode];
    }else if ([mode isEqualToString:@"ElevatorOnlyMode"]) {
        [sailsPathRoutingManager setRoutingMode:ElevatorOnlyMode];
    }else if ([mode isEqualToString:@"ElevatorAndEscalatorMode"]) {
        [sailsPathRoutingManager setRoutingMode:ElevatorAndEscalatorMode];
    }
}


#pragma mark - Animation Method

- (void)animateFunctionViewVertical:(UIView*)view Hidden:(BOOL)bHidden
{
    CGRect rcOutside = view.frame;
    rcOutside.origin.y = -rcOutside.size.height;
    if (bHidden) {
        if (![view isHidden]) {
            //Hide
            [UIView animateWithDuration:0.2f
                             animations:^{
                                 view.frame = rcOutside;
                             }
                             completion:^(BOOL finished) {
                                 [view setHidden:YES];
                             }];
        }
    } else {
        if ([view isHidden]) {
            //show
            [view setHidden:NO];
            [UIView animateWithDuration:0.2f
                             animations:^{
                                 CGSize frameSize = self.view.frame.size;
                                 const float fNaviBarMaxY = CGRectGetMaxY(self.navigationController.navigationBar.frame);
                                 CGRect frameRect = CGRectMake(0, fNaviBarMaxY, frameSize.width, frameSize.height - fNaviBarMaxY);
                                 view.frame = frameRect;
                             }];
        }
    }
}

- (void)animateFunctionViewHorizontal:(UIView*)view Hidden:(BOOL)bHidden
{
    CGRect rcOutside = view.frame;
    if (bHidden) {
        if (![view isHidden]) {
            //Hide
            rcOutside.origin.x = -rcOutside.size.width;
            [UIView animateWithDuration:0.2f
                             animations:^{
                                 view.frame = rcOutside;
                             }
                             completion:^(BOOL finished) {
                                 [view setHidden:YES];
                             }];
        }
    } else {
        if ([view isHidden]) {
            //show
            rcOutside.origin.x += rcOutside.size.width;
            [view setHidden:NO];
            [UIView animateWithDuration:0.2f
                             animations:^{
                                 view.frame = rcOutside;
                             }];
        }
    }
}

- (void)animateNaviViewLarge:(BOOL)large
{
    CGRect newFrame = naviView.frame;
    if (large) {
        if (naviView.frame.size.height < 40) {
            newFrame.size.height = 120.0;
            [UIView animateWithDuration:0.2f
                             animations:^{
                                 naviView.frame = newFrame;
                                 currentDistanceLabel.hidden = NO;
                                 naviLabel.hidden = NO;
                             }];
        }
    }else {
        if (naviView.frame.size.height > 40) {
            newFrame.size.height = 30.0;
            [UIView animateWithDuration:0.2f
                             animations:^{
                                 naviView.frame = newFrame;
                                 currentDistanceLabel.hidden = YES;
                                 naviLabel.hidden = YES;
                             }];
        }
    }
}


#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheetMode == FloorSheetMode) {
        NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
        NSArray *floorDescList = [sails getFloorDescList];
        NSInteger index = [floorDescList indexOfObject:title];
        if (index != NSNotFound) {
            [sailsMapView loadFloorMap:[floorNameList objectAtIndex:index]];
            self.navigationItem.title = title;
        }
    }else if (actionSheetMode == RoutingSheetMode) {
        [self setSailsRoutingMode:[actionSheet buttonTitleAtIndex:buttonIndex]];
    }
}


#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (allLocationRegionOfFloors != nil)? [allLocationRegionOfFloors count] : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *result;
    if (floorNameList != nil && [floorNameList count] > section) {
        result = allLocationRegionOfFloors[floorNameList[section]];
    }
    return (result != nil) ? [result count] : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"poiCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"poiCell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    LocationRegion *locationRegion = [self locationRegionAtIndexPath:indexPath];
    if (locationRegion != nil) {
        NSString *strName = [locationRegion getName];
        if (strName != nil && [strName length]) {
            cell.textLabel.text = strName;
        } else {
            cell.textLabel.text = locationRegion.chinese_t;
        }
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (floorNameList != nil && [floorNameList count] > 0) {
        return [sails getFloorEntireName:floorNameList[section]];
    }
    return @"";
}


#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationRegion *locationRegion = [self locationRegionAtIndexPath:indexPath];
    if (locationRegion != nil) {
        [self animateFunctionViewVertical:poiTableView Hidden:YES];
        if (![sails isLocationEngineStarted]) {
            if (![[locationRegion getFloorName] isEqualToString:[sailsMapView getCurrentBrowseFloorName]]) {
                [sailsMapView loadFloorMap:[locationRegion getFloorName]];
            }
            if (19 > [sailsMapView getZoomLevel]) {
                [sailsMapView startAnimationToZoom:19];
            }
            GeoPoint *mapNewCenter = [[GeoPoint alloc] initWithLogitude:[locationRegion getCenterLongitude] latitude:[locationRegion getCenterLatitude]];
            [sailsMapView startMoveMapAnimationWithTarget:mapNewCenter];
            [sailsMarkerManager clearMarkers];
            [sailsMarkerManager setLocationRegionMarker:locationRegion andImage:[UIImage imageNamed:@"map_destination"] andMarkerFrame:48 andIsBoundCenter:false];
        }else {
            //set routing start point to current user location
            [sailsPathRoutingManager setStartRegion:nil];
            
            //set routing end point marker icon image
            [sailsPathRoutingManager setTargetMakerImage:[UIImage imageNamed:@"destination"]];
            
            //set routing end point marker icon frame
            [sailsPathRoutingManager setTargetMakerFrame:48];
            
            //set routing path's color
            Paint *routingPathPaint = [sailsPathRoutingManager getPathPaint];
            routingPathPaint.strokeColor = [UIColor colorWithRed:53.0/255.0 green:179.0/255.0 blue:229.0/255.0 alpha:255.0/255.0];
            
            stopRoutingButton.hidden = false;
            
            [self animateNaviViewLarge:true];
            
            //set routing end point location
            [sailsPathRoutingManager setTargetRegion:locationRegion];
            
            //begin to route
            if (([sails isLocationEngineStarted] && [sailsPathRoutingManager getStartRegion] == nil) || (![sails isLocationEngineStarted] && [sailsPathRoutingManager getStartRegion] != nil)) {
                [sailsPathRoutingManager enableRouting];
                [self animateFunctionViewHorizontal:naviView Hidden:false];
                pinMarkerButton.hidden = true;
            }
        }
    }
}

@end
