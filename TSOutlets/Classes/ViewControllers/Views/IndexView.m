//
//  IndexView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/3/18.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "IndexView.h"
#import "SingleCase.h"

@implementation IndexView

- (void)initView
{
    indexScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, self.frame.size.height - self.titleHeight)];
    [indexScrollView setContentSize:CGSizeMake(indexScrollView.frame.size.width, 1350 * self.scale)];
    [indexScrollView setShowsVerticalScrollIndicator:NO];
    [indexScrollView setDelegate:self];
    [self addSubview:indexScrollView];
    
    topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, indexScrollView.frame.size.width, 210 * self.scale)];
    [indexScrollView addSubview:topView];
    
    UIImageView *topImage = [[UIImageView alloc] initWithFrame:topView.bounds];
    [topImage setImage:[UIImage imageNamed:@"IndexTopImage"]];
    [topView addSubview:topImage];
    
    UIImageView *topWheel = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150 * self.scale, 150 * self.scale)];
    [topWheel setImage:[UIImage imageNamed:@"IndexTopWheel"]];
    [topWheel setCenter:CGPointMake(106.5 * self.scale, 93 * self.scale)];
    [topView addSubview:topWheel];
    
    UIImageView *topCould = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50 * self.scale, 20 * self.scale)];
    [topCould setImage:[UIImage imageNamed:@"IndexTopCould"]];
    [topCould setCenter:topImage.center];
    [topView addSubview:topCould];
    
    UIImageView *topLogo = [[UIImageView alloc] initWithFrame:topView.bounds];
    [topLogo setImage:[UIImage imageNamed:@"IndexTopLogo"]];
    [topView addSubview:topLogo];
    
    [UIView animateWithDuration:5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         topCould.transform = CGAffineTransformMakeTranslation(100, 0);
                         topWheel.transform = CGAffineTransformRotate(topWheel.transform, M_PI_4) ;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:5
                                               delay:0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              topCould.transform = CGAffineTransformMakeTranslation(0, 0);
                                              topWheel.transform = CGAffineTransformRotate(topWheel.transform, M_PI_4);
                                              
                                              //topView.transform = CGAffineTransformMakeScale(2, 2);
                                          }
                                          completion:^(BOOL finished){
                                          }];
                     }];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:topWheel forKey:@"wheel"];
    [dict setObject:topCould forKey:@"could"];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(topAnimation:) userInfo:dict repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        _indexEntity = [ArticleCoreDataHelper getIndexList];
    }];
    
    [operation setCompletionBlock:^(){
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self createButtons];
            [self createEvents];
            [self createCategories];
            [self createItems];
            [self createAdvertisements];
        }];
    }];
    
    [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshIndexView) name:@"updateInfo" object:nil];
}

- (void)refreshIndexView {
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
        _indexEntity = [ArticleCoreDataHelper getIndexList];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //mall event
            if (_indexEntity.mallEvent) {
                [[mallEventButton subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
                UILabel *mallEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 20 * self.scale, mallEventButton.frame.size.width - 10 * self.scale, (mallEventButton.frame.size.height - 20 * self.scale) / 2)];
                [mallEventLabel setBackgroundColor:AbsoluteClear];
                [mallEventLabel setText:_indexEntity.mallEvent.title];
                [mallEventLabel setTextColor:Color(43, 125, 146, 1)];
                [mallEventLabel setTextAlignment:NSTextAlignmentLeft];
                [mallEventLabel setNumberOfLines:0];
                [mallEventLabel setFont:[UIFont boldSystemFontOfSize:18 * self.scale]];
                [mallEventButton addSubview:mallEventLabel];
                
                MDIncrementalImageView *mallEventImage = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(0, (mallEventButton.frame.size.height - 20 * self.scale) / 2 + 20 * self.scale, mallEventButton.frame.size.width, (mallEventButton.frame.size.height - 20 * self.scale) / 2)];
                [mallEventImage setImageUrl:[NSURL URLWithString:_indexEntity.mallEvent.imageUrl]];
                [mallEventButton addSubview:mallEventImage];
            }
            
            if (_indexEntity.shopEvent) {
                [[shopEventButton subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
                UILabel *mallEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 0 * self.scale, 80 * self.scale, shopEventButton.frame.size.height)];
                [mallEventLabel setBackgroundColor:AbsoluteClear];
                [mallEventLabel setText:_indexEntity.shopEvent.title];
                [mallEventLabel setTextColor:Color(43, 125, 146, 1)];
                [mallEventLabel setTextAlignment:NSTextAlignmentLeft];
                [mallEventLabel setNumberOfLines:0];
                [mallEventLabel setFont:[UIFont boldSystemFontOfSize:18 * self.scale]];
                [shopEventButton addSubview:mallEventLabel];
                
                MDIncrementalImageView *mallEventImage = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(90 * self.scale, 0, shopEventButton.frame.size.width - 90 * self.scale, shopEventButton.frame.size.height)];
                [mallEventImage setImageUrl:[NSURL URLWithString:_indexEntity.shopEvent.shopEntity.logoUrl]];
                [shopEventButton addSubview:mallEventImage];
            }
            
            if (_indexEntity.shopEventTwo) {
                [[shopEventTwoButton subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
                
                UILabel *mallEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 0 * self.scale, 80 * self.scale, shopEventTwoButton.frame.size.height)];
                [mallEventLabel setBackgroundColor:AbsoluteClear];
                [mallEventLabel setText:_indexEntity.shopEventTwo.title];
                [mallEventLabel setTextColor:Color(43, 125, 146, 1)];
                [mallEventLabel setTextAlignment:NSTextAlignmentLeft];
                [mallEventLabel setNumberOfLines:0];
                [mallEventLabel setFont:[UIFont boldSystemFontOfSize:18 * self.scale]];
                [shopEventTwoButton addSubview:mallEventLabel];
                
                MDIncrementalImageView *mallEventImage = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(90 * self.scale, 0, shopEventTwoButton.frame.size.width - 90 * self.scale, shopEventTwoButton.frame.size.height)];
                [mallEventImage setImageUrl:[NSURL URLWithString:_indexEntity.shopEventTwo.shopEntity.logoUrl]];
                [shopEventTwoButton addSubview:mallEventImage];
            }
            
            [[itemScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            // add item buttons
            
            for (int i = 0; i < _indexEntity.itemArray.count; i++) {
                ItemEntity *entity = (ItemEntity *)[_indexEntity.itemArray objectAtIndex:i];
                
                UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(160 * i * self.scale, 0, 160 * self.scale, 300 * self.scale)];
                [itemScrollView addSubview:itemView];
                
                MDIncrementalImageView *itemImage = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(10 * self.scale, 42.5 * self.scale, 140 * self.scale, 195 * self.scale)];
                [itemImage setImageUrl:[NSURL URLWithString:entity.imageUrl]];
                [itemView addSubview:itemImage];
                
                UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 240 * self.scale, itemImage.frame.size.width, 20 * self.scale)];
                [itemName setText:entity.title];
                [itemName setTextColor:ThemeBlue];
                [itemName setTextAlignment:NSTextAlignmentCenter];
                [itemName setFont:[UIFont systemFontOfSize:16 * self.scale]];
                [itemView addSubview:itemName];
                
                UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(10 * self.scale, 20 * self.scale, 140 * self.scale, 45 * self.scale)];
                titleView.layer.cornerRadius = 22.5 * self.scale;
                [titleView setBackgroundColor:ThemeBlue];
                [itemView addSubview:titleView];
                
                UILabel *chName = [[UILabel alloc] initWithFrame:CGRectMake(0, 5 * self.scale, titleView.frame.size.width, 20 * self.scale)];
                [chName setText:entity.shopEntity.chName];
                [chName setTextColor:AbsoluteWhite];
                [chName setTextAlignment:NSTextAlignmentCenter];
                [chName setFont:[UIFont systemFontOfSize:20 * self.scale]];
                [titleView addSubview:chName];
                
                UILabel *enName = [[UILabel alloc] initWithFrame:CGRectMake(0, 25 * self.scale, titleView.frame.size.width, 15 * self.scale)];
                [enName setText:entity.shopEntity.enName];
                [enName setTextColor:AbsoluteWhite];
                [enName setTextAlignment:NSTextAlignmentCenter];
                [enName setFont:[UIFont systemFontOfSize:15 * self.scale]];
                [titleView addSubview:enName];
                
                UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(10 * self.scale, 42.5 * self.scale, 0.5, 235 * self.scale)];
                [leftView setBackgroundColor:ThemeBlue];
                [itemView addSubview:leftView];
                
                UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(150 * self.scale - 0.5, 42.5 * self.scale, 0.5, 237.5 * self.scale)];
                [rightView setBackgroundColor:ThemeBlue];
                [itemView addSubview:rightView];
                
                UIView *priceView = [[UIView alloc] initWithFrame:CGRectMake(30 * self.scale, 270 * self.scale, 120 * self.scale, 20 * self.scale)];
                priceView.layer.cornerRadius = 10 * self.scale;
                priceView.backgroundColor = ThemeBlue_177_231_255;
                [itemView addSubview:priceView];
                
                NSString *timeString = [NSString stringWithFormat:@"%@", entity.price];
                NSMutableAttributedString *priceStr;
                priceStr = [[NSMutableAttributedString alloc] initWithString:timeString];
                [priceStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, entity.price.length)];
                
                UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 * self.scale, 0 * self.scale, priceView.frame.size.width - 5 * self.scale, 20 * self.scale)];
                [priceLabel setBackgroundColor:AbsoluteClear];
                [priceLabel setAttributedText:priceStr];
                [priceLabel setTextColor:ThemeBlue_123_204_225];
                [priceLabel setTextAlignment:NSTextAlignmentRight];
                [priceLabel setFont:[UIFont systemFontOfSize:14 * self.scale]];
                [priceView addSubview:priceLabel];
                
                UIView *saleView = [[UIView alloc] initWithFrame:CGRectMake(10 * self.scale, 265 * self.scale, 85 * self.scale, 25 * self.scale)];
                saleView.layer.cornerRadius = 12.5 * self.scale;
                saleView.backgroundColor = ThemeBlue;
                [itemView addSubview:saleView];
                
                UILabel *saleLabel = [[UILabel alloc] initWithFrame:saleView.bounds];
                [saleLabel setBackgroundColor:AbsoluteClear];
                [saleLabel setText:entity.sale];
                [saleLabel setTextColor:AbsoluteWhite];
                [saleLabel setTextAlignment:NSTextAlignmentCenter];
                [saleLabel setFont:[UIFont systemFontOfSize:20 * self.scale]];
                [saleView addSubview:saleLabel];
                
                UIButton *itemButton = [[UIButton alloc] initWithFrame:itemView.bounds];
                [itemButton setExclusiveTouch:YES];
                [itemButton setTag:i];
                [itemButton addTarget:self action:@selector(tappedItemButton:) forControlEvents:UIControlEventTouchUpInside];
                [itemView addSubview:itemButton];
                
                [itemScrollView setContentSize:CGSizeMake(160 * (i + 1) * self.scale, itemScrollView.frame.size.height)];
            }
        });
    }];
    
    [[SingleCase singleCase].coredataOperationQueue addOperation:operation];
}

- (void)createButtons {
    UIScrollView *buttonScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 210 * self.scale, self.frame.size.width, 180 * self.scale)];
    //[buttonScrollView setBackgroundColor:[UIColor brownColor]];
    [buttonScrollView setShowsHorizontalScrollIndicator:NO];
    [buttonScrollView setPagingEnabled:YES];
    [buttonScrollView setDelegate:self];
    [buttonScrollView setContentSize:CGSizeMake(buttonScrollView.frame.size.width * 2, buttonScrollView.frame.size.height)];
    [indexScrollView addSubview:buttonScrollView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 210 * self.scale, self.frame.size.width, 2 * self.scale)];
    [line setBackgroundColor:ThemeBlue];
    [indexScrollView addSubview:line];
    
    //page one
    
    UIButton *shopButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale, 0, 90 * self.scale, 90 * self.scale)];
    //[shopButton setBackgroundColor:ThemeBlue];
    [shopButton setTag:0];
    [shopButton setExclusiveTouch:YES];
    [shopButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:shopButton];
    
    UIImageView *shopImage = [[UIImageView alloc] initWithFrame:shopButton.bounds];
    [shopImage setImage:[UIImage imageNamed:@"IndexButton_Guide"]];
    [shopButton addSubview:shopImage];
    
    UIButton *eventButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale, 0, 90 * self.scale, 90 * self.scale)];
    //[eventButton setBackgroundColor:ThemeRed];
    [eventButton setTag:1];
    [eventButton setExclusiveTouch:YES];
    [eventButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:eventButton];
    
    UIImageView *eventImage = [[UIImageView alloc] initWithFrame:eventButton.bounds];
    [eventImage setImage:[UIImage imageNamed:@"IndexButton_Brand"]];
    [eventButton addSubview:eventImage];
    
    UIButton *mallButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 2, 0, 90 * self.scale, 90 * self.scale)];
    //[eventButton setBackgroundColor:ThemeRed];
    [mallButton setTag:2];
    [mallButton setExclusiveTouch:YES];
    [mallButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:mallButton];
    
    UIImageView *mallImage = [[UIImageView alloc] initWithFrame:mallButton.bounds];
    [mallImage setImage:[UIImage imageNamed:@"IndexButton_Mall"]];
    [mallButton addSubview:mallImage];
    
    UIButton *navigationButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 3, 0, 90 * self.scale, 90 * self.scale)];
    [navigationButton setTag:3];
    [navigationButton setExclusiveTouch:YES];
    [navigationButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:navigationButton];
    
    UIImageView *navigationImage = [[UIImageView alloc] initWithFrame:navigationButton.bounds];
    [navigationImage setImage:[UIImage imageNamed:@"IndexButton_Navigation"]];
    [navigationButton addSubview:navigationImage];
    
    UIButton *saleButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 0, 90 * self.scale, 90 * self.scale, 90 * self.scale)];
    [saleButton setTag:4];
    [saleButton setExclusiveTouch:YES];
    [saleButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:saleButton];
    
    UIImageView *saleImage = [[UIImageView alloc] initWithFrame:saleButton.bounds];
    [saleImage setImage:[UIImage imageNamed:@"IndexButton_Sale"]];
    [saleButton addSubview:saleImage];
    
    UIButton *foodButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 1, 90 * self.scale, 90 * self.scale, 90 * self.scale)];
    [foodButton setTag:5];
    [foodButton setExclusiveTouch:YES];
    [foodButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:foodButton];
    
    UIImageView *foodImage = [[UIImageView alloc] initWithFrame:foodButton.bounds];
    [foodImage setImage:[UIImage imageNamed:@"IndexButton_Food"]];
    [foodButton addSubview:foodImage];
    
    UIButton *parkButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 2, 90 * self.scale, 90 * self.scale, 90 * self.scale)];
    [parkButton setTag:-1];
    [parkButton setExclusiveTouch:YES];
    [parkButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:parkButton];
    
    UIImageView *parkImage = [[UIImageView alloc] initWithFrame:parkButton.bounds];
    [parkImage setImage:[UIImage imageNamed:@"IndexButton_Park"]];
    [parkButton addSubview:parkImage];
    
    UIButton *messageButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 3, 90 * self.scale, 90 * self.scale, 90 * self.scale)];
    [messageButton setTag:7];
    [messageButton setExclusiveTouch:YES];
    [messageButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:messageButton];
    
    UIImageView *messageImage = [[UIImageView alloc] initWithFrame:messageButton.bounds];
    [messageImage setImage:[UIImage imageNamed:@"IndexButton_Message"]];
    [messageButton addSubview:messageImage];
    
    //page two
    
    UIButton *itemButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 0 + self.frame.size.width, 0, 90 * self.scale, 90 * self.scale)];
    [itemButton setTag:8];
    [itemButton setExclusiveTouch:YES];
    [itemButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:itemButton];
    
    UIImageView *itemImage = [[UIImageView alloc] initWithFrame:itemButton.bounds];
    [itemImage setImage:[UIImage imageNamed:@"IndexButton_Item"]];
    [itemButton addSubview:itemImage];
    
    UIButton *videoButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 1 + self.frame.size.width, 0, 90 * self.scale, 90 * self.scale)];
    [videoButton setTag:9];
    [videoButton setExclusiveTouch:YES];
    [videoButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:videoButton];
    
    UIImageView *videoImage = [[UIImageView alloc] initWithFrame:videoButton.bounds];
    [videoImage setImage:[UIImage imageNamed:@"IndexButton_Video"]];
    [videoButton addSubview:videoImage];
    
    UIButton *gameButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 2 + self.frame.size.width, 0, 90 * self.scale, 90 * self.scale)];
    [gameButton setTag:-2];
    [gameButton setExclusiveTouch:YES];
    [gameButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:gameButton];
    
    UIImageView *gameImage = [[UIImageView alloc] initWithFrame:gameButton.bounds];
    [gameImage setImage:[UIImage imageNamed:@"IndexButton_Game"]];
    [gameButton addSubview:gameImage];
    
    UIButton *serviceButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 3 + self.frame.size.width, 0, 90 * self.scale, 90 * self.scale)];
    [serviceButton setTag:11];
    [serviceButton setExclusiveTouch:YES];
    [serviceButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:serviceButton];
    
    UIImageView *serviceImage = [[UIImageView alloc] initWithFrame:serviceButton.bounds];
    [serviceImage setImage:[UIImage imageNamed:@"IndexButton_Service"]];
    [serviceButton addSubview:serviceImage];
    
    UIButton *onlineButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 0 + self.frame.size.width, 90 * self.scale, 90 * self.scale, 90 * self.scale)];
    [onlineButton setTag:12];
    [onlineButton setExclusiveTouch:YES];
    [onlineButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:onlineButton];
    
    UIImageView *onlineImage = [[UIImageView alloc] initWithFrame:onlineButton.bounds];
    [onlineImage setImage:[UIImage imageNamed:@"IndexButton_Online"]];
    [onlineButton addSubview:onlineImage];
    
    UIButton *offlineButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 1 + self.frame.size.width, 90 * self.scale, 90 * self.scale, 90 * self.scale)];
    [offlineButton setTag:13];
    [offlineButton setExclusiveTouch:YES];
    [offlineButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:offlineButton];
    
    UIImageView *offlineImage = [[UIImageView alloc] initWithFrame:offlineButton.bounds];
    [offlineImage setImage:[UIImage imageNamed:@"IndexButton_Offline"]];
    [offlineButton addSubview:offlineImage];
    
    UIButton *collectionButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 2 + self.frame.size.width, 90 * self.scale, 90 * self.scale, 90 * self.scale)];
    [collectionButton setTag:14];
    [collectionButton setExclusiveTouch:YES];
    [collectionButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:collectionButton];
    
    UIImageView *collectionImage = [[UIImageView alloc] initWithFrame:collectionButton.bounds];
    [collectionImage setImage:[UIImage imageNamed:@"IndexButton_Collection"]];
    [collectionButton addSubview:collectionImage];
    
    UIButton *wifiButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5 * self.scale + 90 * self.scale * 3 + self.frame.size.width, 90 * self.scale, 90 * self.scale, 90 * self.scale)];
    [wifiButton setTag:-1];
    [wifiButton setExclusiveTouch:YES];
    [wifiButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [buttonScrollView addSubview:wifiButton];
    
    UIImageView *wifiImage = [[UIImageView alloc] initWithFrame:wifiButton.bounds];
    [wifiImage setImage:[UIImage imageNamed:@"IndexButton_Wifi"]];
    [wifiButton addSubview:wifiImage];
    
    //pager
    
    pageOneView = [[UIView alloc] initWithFrame:CGRectMake(150 * self.scale, buttonScrollView.frame.origin.y + buttonScrollView.frame.size.height, 75 * self.scale, 20 * self.scale)];
    [indexScrollView addSubview:pageOneView];
    
    UIImageView *pageOneLeft = [[UIImageView alloc] initWithFrame:CGRectMake(17 * self.scale, 1.5 * self.scale, 19 * self.scale, 17 * self.scale)];
    [pageOneLeft setImage:[UIImage imageNamed:@"Page_Current"]];
    [pageOneView addSubview:pageOneLeft];
    
    UIImageView *pageOneRight = [[UIImageView alloc] initWithFrame:CGRectMake(39 * self.scale, 1.5 * self.scale, 19 * self.scale, 17 * self.scale)];
    [pageOneRight setImage:[UIImage imageNamed:@"Page_NotCurrent"]];
    [pageOneView addSubview:pageOneRight];
    
    pageTwoView = [[UIView alloc] initWithFrame:pageOneView.frame];
    [pageTwoView setAlpha:0];
    [indexScrollView addSubview:pageTwoView];
    
    UIImageView *pageTwoLeft = [[UIImageView alloc] initWithFrame:CGRectMake(17 * self.scale, 1.5 * self.scale, 19 * self.scale, 17 * self.scale)];
    [pageTwoLeft setImage:[UIImage imageNamed:@"Page_NotCurrent"]];
    [pageTwoView addSubview:pageTwoLeft];
    
    UIImageView *pageTwoRight = [[UIImageView alloc] initWithFrame:CGRectMake(39 * self.scale, 1.5 * self.scale, 19 * self.scale, 17 * self.scale)];
    [pageTwoRight setImage:[UIImage imageNamed:@"Page_Current"]];
    [pageTwoView addSubview:pageTwoRight];
}

- (void)createEvents {
    UIView *eventView = [[UIView alloc] initWithFrame:CGRectMake(0, 440 * self.scale, self.frame.size.width, 180 * self.scale)];
    [indexScrollView addSubview:eventView];
    
    UIView *eventTitle = [[UIView alloc] initWithFrame:CGRectMake(- 12.5 * self.scale, 0, 137.5 * self.scale, 25 * self.scale)];
    eventTitle.layer.cornerRadius = 12.5 * self.scale;
    eventTitle.backgroundColor = Color(83, 201, 255, 1);
    [eventView addSubview:eventTitle];
    
    UILabel *eventLabel = [[UILabel alloc] initWithFrame:eventTitle.bounds];
    [eventLabel setBackgroundColor:AbsoluteClear];
    [eventLabel setText:@"最新活动"];
    [eventLabel setTextColor:AbsoluteWhite];
    [eventLabel setTextAlignment:NSTextAlignmentCenter];
    [eventLabel setFont:[UIFont boldSystemFontOfSize:20 * self.scale]];
    [eventTitle addSubview:eventLabel];
    
    //lines
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(125 * self.scale, 12.5 * self.scale, 235 * self.scale, 0.5f)];
    [topLine setBackgroundColor:Color(83, 201, 255, 1)];
    [eventView addSubview:topLine];
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0 * self.scale, 162.5 * self.scale, 360 * self.scale, 0.5f)];
    [bottomLine setBackgroundColor:Color(83, 201, 255, 1)];
    [eventView addSubview:bottomLine];
    
    UIView *middleLine = [[UIView alloc] initWithFrame:CGRectMake(170 * self.scale, 87.5 * self.scale, 190 * self.scale, 0.5f)];
    [middleLine setBackgroundColor:Color(83, 201, 255, 1)];
    [eventView addSubview:middleLine];
    
    UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(170 * self.scale, 12.5 * self.scale, 0.5f, 150.5 * self.scale)];
    [rightLine setBackgroundColor:Color(83, 201, 255, 1)];
    [eventView addSubview:rightLine];
    
    UIView *crossLine = [[UIView alloc] initWithFrame:CGRectMake(360 * self.scale, 12.5 * self.scale, 0.5f, 150 * self.scale)];
    [crossLine setBackgroundColor:Color(83, 201, 255, 1)];
    [eventView addSubview:crossLine];
    
    //mall event
    if (_indexEntity.mallEvent) {
        mallEventButton = [[UIButton alloc] initWithFrame:CGRectMake(0 * self.scale, 12.5 * self.scale, 170 * self.scale, 150 * self.scale)];
        [mallEventButton setExclusiveTouch:YES];
        [mallEventButton addTarget:self action:@selector(tappedMallEvent) forControlEvents:UIControlEventTouchUpInside];
        [eventView addSubview:mallEventButton];
        
        UILabel *mallEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 20 * self.scale, mallEventButton.frame.size.width - 10 * self.scale, (mallEventButton.frame.size.height - 20 * self.scale) / 2)];
        [mallEventLabel setBackgroundColor:AbsoluteClear];
        [mallEventLabel setText:_indexEntity.mallEvent.title];
        [mallEventLabel setTextColor:Color(43, 125, 146, 1)];
        [mallEventLabel setTextAlignment:NSTextAlignmentLeft];
        [mallEventLabel setNumberOfLines:0];
        [mallEventLabel setFont:[UIFont boldSystemFontOfSize:18 * self.scale]];
        [mallEventButton addSubview:mallEventLabel];
        
        MDIncrementalImageView *mallEventImage = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(0, (mallEventButton.frame.size.height - 20 * self.scale) / 2 + 20 * self.scale, mallEventButton.frame.size.width, (mallEventButton.frame.size.height - 20 * self.scale) / 2)];
        [mallEventImage setImageUrl:[NSURL URLWithString:_indexEntity.mallEvent.imageUrl]];
        [mallEventButton addSubview:mallEventImage];
    }
    
    if (_indexEntity.shopEvent) {
        shopEventButton = [[UIButton alloc] initWithFrame:CGRectMake(170 * self.scale, 12.5 * self.scale, 190 * self.scale, 75 * self.scale)];
        [shopEventButton setExclusiveTouch:YES];
        [shopEventButton addTarget:self action:@selector(tappedShopEvent) forControlEvents:UIControlEventTouchUpInside];
        [eventView addSubview:shopEventButton];
        
        UILabel *mallEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 0 * self.scale, 80 * self.scale, shopEventButton.frame.size.height)];
        [mallEventLabel setBackgroundColor:AbsoluteClear];
        [mallEventLabel setText:_indexEntity.shopEvent.title];
        [mallEventLabel setTextColor:Color(43, 125, 146, 1)];
        [mallEventLabel setTextAlignment:NSTextAlignmentLeft];
        [mallEventLabel setNumberOfLines:0];
        [mallEventLabel setFont:[UIFont boldSystemFontOfSize:18 * self.scale]];
        [shopEventButton addSubview:mallEventLabel];
        
        MDIncrementalImageView *mallEventImage = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(90 * self.scale, 0, shopEventButton.frame.size.width - 90 * self.scale, shopEventButton.frame.size.height)];
        [mallEventImage setImageUrl:[NSURL URLWithString:_indexEntity.shopEvent.shopEntity.logoUrl]];
        [shopEventButton addSubview:mallEventImage];
    }
    
    if (_indexEntity.shopEventTwo) {
        shopEventTwoButton = [[UIButton alloc] initWithFrame:CGRectMake(170 * self.scale, 87.5 * self.scale, 190 * self.scale, 75 * self.scale)];
        [shopEventTwoButton setExclusiveTouch:YES];
        [shopEventTwoButton addTarget:self action:@selector(tappedShopEventTwo) forControlEvents:UIControlEventTouchUpInside];
        [eventView addSubview:shopEventTwoButton];
        
        UILabel *mallEventLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 * self.scale, 0 * self.scale, 80 * self.scale, shopEventTwoButton.frame.size.height)];
        [mallEventLabel setBackgroundColor:AbsoluteClear];
        [mallEventLabel setText:_indexEntity.shopEventTwo.title];
        [mallEventLabel setTextColor:Color(43, 125, 146, 1)];
        [mallEventLabel setTextAlignment:NSTextAlignmentLeft];
        [mallEventLabel setNumberOfLines:0];
        [mallEventLabel setFont:[UIFont boldSystemFontOfSize:18 * self.scale]];
        [shopEventTwoButton addSubview:mallEventLabel];
        
        MDIncrementalImageView *mallEventImage = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(90 * self.scale, 0, shopEventTwoButton.frame.size.width - 90 * self.scale, shopEventTwoButton.frame.size.height)];
        [mallEventImage setImageUrl:[NSURL URLWithString:_indexEntity.shopEventTwo.shopEntity.logoUrl]];
        [shopEventTwoButton addSubview:mallEventImage];
    }
}

- (void)createCategories {
    UIView *categoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 650 * self.scale, self.frame.size.width, 120 * self.scale)];
    [indexScrollView addSubview:categoryView];
    
    UIView *categoryTitle = [[UIView alloc] initWithFrame:CGRectMake(- 12.5 * self.scale, 0, 137.5 * self.scale, 25 * self.scale)];
    categoryTitle.layer.cornerRadius = 12.5 * self.scale;
    categoryTitle.backgroundColor = Color(83, 201, 255, 1);
    [categoryView addSubview:categoryTitle];
    
    UILabel *categoryLabel = [[UILabel alloc] initWithFrame:categoryTitle.bounds];
    [categoryLabel setBackgroundColor:AbsoluteClear];
    [categoryLabel setText:@"商场导购"];
    [categoryLabel setTextColor:AbsoluteWhite];
    [categoryLabel setTextAlignment:NSTextAlignmentCenter];
    [categoryLabel setFont:[UIFont boldSystemFontOfSize:20 * self.scale]];
    [categoryTitle addSubview:categoryLabel];
    
    //side scroll view
    
    UIScrollView *sideView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25 * self.scale, self.frame.size.width, 80 * self.scale)];
    [sideView setShowsHorizontalScrollIndicator:NO];
    [categoryView addSubview:sideView];
    
    NSArray *sideArray = @[@"Clothes",@"Casual",@"Sport",@"Outdoors",@"Kid",@"Sweater",@"Underwear",@"Shoes",@"Bags",@"Bedding",@"Ornament",@"Makeup",@"Cooking",@"Food"];
    
    NSArray *catagoryArray = @[@"9",@"10",@"39",@"8",@"11",@"14",@"12",@"13",@"15",@"40",@"16",@"42",@"41",@"17"];
    float h = 0;
    for (int i=0;i<catagoryArray.count;i++){
        [sideView addSubview:[self createCategoryButtonWithFrame:CGRectMake(h, 0, 80 * self.scale, 80 * self.scale) andCategoryType:sideArray[i] andTag:[catagoryArray[i] intValue]]];
        h += 80 * self.scale;
    }
    [sideView setContentSize:CGSizeMake(h, sideView.frame.size.height)];
    
    /*NSArray *sideArray = @[@"Clothes",@"Casual",@"Sport",@"Outdoors",@"Kid",@"Sweater",@"Underwear",@"Shoes",@"Bags",@"Bedding",@"Ornament",@"Makeup",@"Cooking",@"Food"];
    float h = 0;
    int i = 8;
    //NSLog(@"%f", sideView.frame.size.height);
    
    for (NSString *str in sideArray) {
        
        [sideView addSubview:[self createCategoryButtonWithFrame:CGRectMake(h, 0, 80 * self.scale, 80 * self.scale) andCategoryType:str andTag:i]];
        
        i++;
        h += 80 * self.scale;
    }
    [sideView setContentSize:CGSizeMake(h, sideView.frame.size.height)];
    
   */
}

- (void)createItems {
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 800 * self.scale, self.frame.size.width, 330 * self.scale)];
    [indexScrollView addSubview:itemView];
    
    UIView *itemTitle = [[UIView alloc] initWithFrame:CGRectMake(- 12.5 * self.scale, 0, 137.5 * self.scale, 25 * self.scale)];
    itemTitle.layer.cornerRadius = 12.5 * self.scale;
    itemTitle.backgroundColor = Color(83, 201, 255, 1);
    [itemView addSubview:itemTitle];
    
    UILabel *itemLabel = [[UILabel alloc] initWithFrame:itemTitle.bounds];
    [itemLabel setBackgroundColor:AbsoluteClear];
    [itemLabel setText:@"新品推荐"];
    [itemLabel setTextColor:AbsoluteWhite];
    [itemLabel setTextAlignment:NSTextAlignmentCenter];
    [itemLabel setFont:[UIFont boldSystemFontOfSize:20 * self.scale]];
    [itemTitle addSubview:itemLabel];
    
    itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 25 * self.scale, self.frame.size.width, 300 * self.scale)];
    [itemScrollView setShowsHorizontalScrollIndicator:NO];
    [itemView addSubview:itemScrollView];
    
    // add item buttons
    
    for (int i = 0; i < _indexEntity.itemArray.count; i++) {
        ItemEntity *entity = (ItemEntity *)[_indexEntity.itemArray objectAtIndex:i];
        
        UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(160 * i * self.scale, 0, 160 * self.scale, 300 * self.scale)];
        [itemScrollView addSubview:itemView];
        
        MDIncrementalImageView *itemImage = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(10 * self.scale, 42.5 * self.scale, 140 * self.scale, 195 * self.scale)];
        [itemImage setImageUrl:[NSURL URLWithString:entity.imageUrl]];
        [itemImage setUserInteractionEnabled:NO];
        [itemView addSubview:itemImage];
        
        UILabel *itemName = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 240 * self.scale, itemImage.frame.size.width, 20 * self.scale)];
        [itemName setText:entity.title];
        [itemName setTextColor:ThemeBlue];
        [itemName setTextAlignment:NSTextAlignmentCenter];
        [itemName setFont:[UIFont systemFontOfSize:16 * self.scale]];
        [itemView addSubview:itemName];
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(10 * self.scale, 20 * self.scale, 140 * self.scale, 45 * self.scale)];
        titleView.layer.cornerRadius = 22.5 * self.scale;
        [titleView setBackgroundColor:ThemeBlue];
        [itemView addSubview:titleView];
        
        UILabel *chName = [[UILabel alloc] initWithFrame:CGRectMake(0, 5 * self.scale, titleView.frame.size.width, 20 * self.scale)];
        [chName setText:entity.shopEntity.chName];
        [chName setTextColor:AbsoluteWhite];
        [chName setTextAlignment:NSTextAlignmentCenter];
        [chName setFont:[UIFont systemFontOfSize:20 * self.scale]];
        [titleView addSubview:chName];
        
        UILabel *enName = [[UILabel alloc] initWithFrame:CGRectMake(0, 25 * self.scale, titleView.frame.size.width, 15 * self.scale)];
        [enName setText:entity.shopEntity.enName];
        [enName setTextColor:AbsoluteWhite];
        [enName setTextAlignment:NSTextAlignmentCenter];
        [enName setFont:[UIFont systemFontOfSize:15 * self.scale]];
        [titleView addSubview:enName];
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(10 * self.scale, 42.5 * self.scale, 0.5, 235 * self.scale)];
        [leftView setBackgroundColor:ThemeBlue];
        [itemView addSubview:leftView];
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(150 * self.scale - 0.5, 42.5 * self.scale, 0.5, 237.5 * self.scale)];
        [rightView setBackgroundColor:ThemeBlue];
        [itemView addSubview:rightView];
        
        UIView *priceView = [[UIView alloc] initWithFrame:CGRectMake(30 * self.scale, 270 * self.scale, 120 * self.scale, 20 * self.scale)];
        priceView.layer.cornerRadius = 10 * self.scale;
        priceView.backgroundColor = ThemeBlue_177_231_255;
        [itemView addSubview:priceView];
        
        NSString *timeString = [NSString stringWithFormat:@"%@", entity.price];
        NSMutableAttributedString *priceStr;
        priceStr = [[NSMutableAttributedString alloc] initWithString:timeString];
        [priceStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, entity.price.length)];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 * self.scale, 0 * self.scale, priceView.frame.size.width - 5 * self.scale, 20 * self.scale)];
        [priceLabel setBackgroundColor:AbsoluteClear];
        [priceLabel setAttributedText:priceStr];
        [priceLabel setTextColor:ThemeBlue_123_204_225];
        [priceLabel setTextAlignment:NSTextAlignmentRight];
        [priceLabel setFont:[UIFont systemFontOfSize:14 * self.scale]];
        [priceView addSubview:priceLabel];
        
        UIView *saleView = [[UIView alloc] initWithFrame:CGRectMake(10 * self.scale, 265 * self.scale, 85 * self.scale, 25 * self.scale)];
        saleView.layer.cornerRadius = 12.5 * self.scale;
        saleView.backgroundColor = ThemeBlue;
        [itemView addSubview:saleView];
        
        UILabel *saleLabel = [[UILabel alloc] initWithFrame:saleView.bounds];
        [saleLabel setBackgroundColor:AbsoluteClear];
        [saleLabel setText:entity.sale];
        [saleLabel setTextColor:AbsoluteWhite];
        [saleLabel setTextAlignment:NSTextAlignmentCenter];
        [saleLabel setFont:[UIFont systemFontOfSize:20 * self.scale]];
        [saleView addSubview:saleLabel];
        
        UIButton *itemButton = [[UIButton alloc] initWithFrame:itemView.bounds];
        [itemButton setExclusiveTouch:YES];
        [itemButton setTag:i];
        [itemButton addTarget:self action:@selector(tappedItemButton:) forControlEvents:UIControlEventTouchUpInside];
        [itemView addSubview:itemButton];
        
        [itemScrollView setContentSize:CGSizeMake(160 * (i + 1) * self.scale, itemScrollView.frame.size.height)];
    }
}

- (void)createAdvertisements {
    UIView *advertisementView = [[UIView alloc] initWithFrame:CGRectMake(0, 1160 * self.scale, self.frame.size.width, 180 * self.scale)];
    [indexScrollView addSubview:advertisementView];
    
    UIImageView *advertisementImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12.5 * self.scale, self.frame.size.width, 167.5 * self.scale)];
    [advertisementImage setImage:[UIImage imageNamed:@"IndexTravel"]];
    [advertisementView addSubview:advertisementImage];
    
    UIView *advertisementTitle = [[UIView alloc] initWithFrame:CGRectMake(- 12.5 * self.scale, 0, 137.5 * self.scale, 25 * self.scale)];
    advertisementTitle.layer.cornerRadius = 12.5 * self.scale;
    advertisementTitle.backgroundColor = Color(83, 201, 255, 1);
    [advertisementView addSubview:advertisementTitle];
    
    UILabel *advertisementLabel = [[UILabel alloc] initWithFrame:advertisementTitle.bounds];
    [advertisementLabel setBackgroundColor:AbsoluteClear];
    [advertisementLabel setText:@"汤山旅游"];
    [advertisementLabel setTextColor:AbsoluteWhite];
    [advertisementLabel setTextAlignment:NSTextAlignmentCenter];
    [advertisementLabel setFont:[UIFont boldSystemFontOfSize:20 * self.scale]];
    [advertisementTitle addSubview:advertisementLabel];
    
    UIButton *advertisementButton = [[UIButton alloc] initWithFrame:advertisementView.bounds];
    [advertisementButton setExclusiveTouch:YES];
    [advertisementButton setTag:15];
    [advertisementButton addTarget:self action:@selector(tappedButton:) forControlEvents:UIControlEventTouchUpInside];
    [advertisementView addSubview:advertisementButton];
}

#pragma mark - Category

- (UIView *)createCategoryButtonWithFrame:(CGRect)frame andCategoryType:(NSString *)type andTag:(int)tag{
    UIView *categoryView = [[UIView alloc] initWithFrame:frame];
    
    UIButton *categoryButton = [[UIButton alloc] initWithFrame:categoryView.bounds];
    [categoryButton setExclusiveTouch:YES];
    [categoryButton setTag:tag];
    [categoryButton addTarget:self action:@selector(tappedCategoryButton:) forControlEvents:UIControlEventTouchUpInside];
    [categoryView addSubview:categoryButton];
    
    UIImageView *categoryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_NotSelected", type]]];
    [categoryImage setFrame:CGRectMake(0, 0, 60 * self.scale, 60 * self.scale)];
    [categoryImage setContentMode:UIViewContentModeScaleAspectFit];
    [categoryImage setCenter:CGPointMake(categoryView.frame.size.width / 2, 35 * self.scale)];
    [categoryButton addSubview:categoryImage];
    
    switch (tag) {
        case 9:
            type = @"服装";
            break;
        case 10:
            type = @"休闲";
            break;
        case 39:
            type = @"运动";
            break;
        case 8:
            type = @"户外";
            break;
        case 11:
            type = @"童装";
            break;
        case 14:
            type = @"针织";
            break;
        case 12:
            type = @"内衣";
            break;
        case 13:
            type = @"鞋类";
            break;
        case 15:
            type = @"箱包";
            break;
        case 40:
            type = @"床品";
            break;
        case 16:
            type = @"饰品";
            break;
        case 42:
            type = @"美妆";
            break;
        case 41:
            type = @"厨具";
            break;
        case 17:
            type = @"餐饮";
            break;
            
        default:
            break;
    }
    
    UILabel *categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 65 * self.scale, 60 * self.scale, 15 * self.scale)];
    [categoryLabel setText:type];
    [categoryLabel setTextColor:ThemeBlue];
    [categoryLabel setTextAlignment:NSTextAlignmentCenter];
    [categoryLabel setFont:[UIFont systemFontOfSize:16 * self.scale]];
    [categoryButton addSubview:categoryLabel];
    
    return categoryView;
}

#pragma mark - Button Events

- (void)tappedButton:(UIButton*)button
{
    switch (button.tag) {
        case 0:
            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeShopList andParameter:nil];
            }
            break;
        case 1:
            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeEventShopList andParameter:nil];
            }
            break;
        case 2:
            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeEventMallList andParameter:nil];
            }
            break;
        case 3:
            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeLocation andParameter:nil];
            }
            break;
//        case 4:
//            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:)]) {
//                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeSale];
//            }
//            break;
        case 5:
            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeFood andParameter:nil];
            }
            break;
        case 7:
            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeMessage andParameter:nil];
            }
            break;
        case 8:
            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeItemList andParameter:nil];
            }
            break;
        case 9:
            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeVideo andParameter:nil];
            }
            break;
        case 11:
            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeService andParameter:nil];
            }
            break;
        case 12:
            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeOnline andParameter:nil];
            }
            break;
        case 13:
            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeOffline andParameter:nil];
            }
            break;
        case 14:
            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeCollection andParameter:nil];
            }
            break;
        case 15:
            if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
                [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeBrowser andParameter:nil];
            }
            break;
        default:
        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"敬请期待" message:@"对不起，该功能暂未开放。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"该功能暂未开放，敬请期待！"];
            break;
        }
    }
}

- (void)tappedCategoryButton:(UIButton *)button {
    NSDictionary *parameter = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld", (long)button.tag] forKey:@"category"];
    if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
        [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeShopList andParameter:parameter];
    }
}

- (void)tappedItemButton:(UIButton *)button {
    NSDictionary *parameter = [NSDictionary dictionaryWithObject:[_indexEntity.itemArray objectAtIndex:button.tag] forKey:@"entity"];
    if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
        [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeItemInfo andParameter:parameter];
    }
}

- (void)tappedMallEvent {
    NSDictionary *parameter = [NSDictionary dictionaryWithObject:_indexEntity.mallEvent forKey:@"entity"];
    if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
        [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeEventTheme andParameter:parameter];
    }
}

- (void)tappedShopEvent {
    NSDictionary *parameter = [NSDictionary dictionaryWithObject:_indexEntity.shopEvent forKey:@"entity"];
    if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
        [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeEventInfo andParameter:parameter];
    }
}

- (void)tappedShopEventTwo {
    NSDictionary *parameter = [NSDictionary dictionaryWithObject:_indexEntity.shopEventTwo forKey:@"entity"];
    if (_delegate && [_delegate respondsToSelector:@selector(indexViewDidTappedButton:withType:andParameter:)]) {
        [_delegate indexViewDidTappedButton:self withType:ViewControllerTypeEventInfo andParameter:parameter];
    }
}

#pragma mark - Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:indexScrollView]) {
        if (scrollView.contentOffset.y < 0) {
            topView.transform = CGAffineTransformMake(1 - scrollView.contentOffset.y / (210 * self.scale / 1), 0, 0, 1 - scrollView.contentOffset.y / (210 * self.scale / 1), 0, scrollView.contentOffset.y / 2);
            
            if (scrollView.contentOffset.y < -80) {
                [scrollView setContentOffset:CGPointMake(0, - 80)];
            }
            //NSLog(@"height:%f, y:%f, scale:%f", topView.frame.size.height, topView.frame.origin.y, 1 - scrollView.contentOffset.y / (topView.frame.size.height / 1));
        } else {
            topView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
        }
    } else {
        [pageOneView setAlpha:(1 - scrollView.contentOffset.x / scrollView.frame.size.width)];
        [pageTwoView setAlpha:(scrollView.contentOffset.x / scrollView.frame.size.width)];
    }
}
                      
#pragma mark - Top Animation 

- (void)topAnimation:(id)sender
{
    NSDictionary* data = [sender userInfo];
    UIImageView* topWheel = [data objectForKey:@"wheel"];
    UIImageView* topCould = [data objectForKey:@"could"];
    
    [UIView animateWithDuration:5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         topCould.transform = CGAffineTransformMakeTranslation(100, 0);
                         topWheel.transform = CGAffineTransformRotate(topWheel.transform, M_PI_4) ;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:5
                                               delay:0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              topCould.transform = CGAffineTransformMakeTranslation(0, 0);
                                              topWheel.transform = CGAffineTransformRotate(topWheel.transform, M_PI_4) ;
                                          }
                                          completion:^(BOOL finished){
                                          }];
                     }];
}

@end
