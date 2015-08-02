//
//  ShopTitleView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/4/7.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ShopTitleView.h"
#import "MemberAPITool.h"

@implementation ShopTitleView

- (UIView *)getShopTitleViewWithShopEntity:(ShopEntity *)shopEntity {
    entity = shopEntity;
    
    [self setFrame:CGRectMake(0, 0, 375.f * self.scale, 160 * self.scale)];
    
    //logo
    
    if (shopEntity.logoImage) {
        UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0 * self.scale, 5 * self.scale, self.frame.size.width * 0.5f, self.frame.size.height * 0.75)];
        [logoImage setImage:[UIImage imageWithData:shopEntity.logoImage]];
        [logoImage setContentMode:UIViewContentModeScaleAspectFit];
        [self addSubview:logoImage];
    } else {
        MDIncrementalImageView *imageView = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(0 * self.scale, 5 * self.scale, self.frame.size.width * 0.5f, self.frame.size.height * 0.75)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [imageView setImageUrl:[NSURL URLWithString:shopEntity.logoUrl]];
        [imageView setShowLoadingIndicatorWhileLoading:YES];
        //[imageView setDelegate:self];
        //[imageView setTag:(int)avc];
        [self addSubview:imageView];
    }
    
    //name
    
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2, 5 * self.scale, self.frame.size.width / 2 + 30 * self.scale, 60 * self.scale)];
    nameView.layer.cornerRadius = 30.f * self.scale;
    [nameView setBackgroundColor:ThemeBlue];
    [self addSubview:nameView];
    
    UILabel *chNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(-5 * self.scale, 12 * self.scale, nameView.frame.size.width, 20 * self.scale)];
    [chNameLabel setBackgroundColor:[UIColor clearColor]];
    [chNameLabel setText:shopEntity.chName];
    [chNameLabel setTextColor:AbsoluteWhite];
    [chNameLabel setTextAlignment:NSTextAlignmentCenter];
    [chNameLabel setFont:[UIFont boldSystemFontOfSize:18 * self.scale]];
    [nameView addSubview:chNameLabel];
    
    UILabel *enNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(-5 * self.scale, 30 * self.scale, nameView.frame.size.width, 20 * self.scale)];
    [enNameLabel setBackgroundColor:[UIColor clearColor]];
    [enNameLabel setText:shopEntity.enName];
    [enNameLabel setTextColor:AbsoluteWhite];
    [enNameLabel setTextAlignment:NSTextAlignmentCenter];
    [enNameLabel setFont:[UIFont boldSystemFontOfSize:13 * self.scale]];
    [nameView addSubview:enNameLabel];
    
    //tele
    
    UIButton *telButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height * 0.78, 160 * self.scale, 30 * self.scale)];
    [telButton addTarget:self action:@selector(tappedTelButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:telButton];
    
    UIView *telView = [[UIView alloc] initWithFrame:CGRectMake(-12.5 * self.scale, 5 * self.scale, 65 * self.scale, 25 * self.scale)];
    telView.layer.cornerRadius = 12.5f * self.scale;
    [telView setUserInteractionEnabled:NO];
    [telView setBackgroundColor:ThemeBlue];
    [telButton addSubview:telView];
    
    UILabel *telLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 * self.scale, 5 * self.scale, 50 * self.scale, 25 * self.scale)];
    [telLabel setBackgroundColor:[UIColor clearColor]];
    [telLabel setText:@"TEL"];
    [telLabel setTextColor:AbsoluteWhite];
    [telLabel setFont:[UIFont systemFontOfSize:17.f * self.scale]];
    [telButton addSubview:telLabel];
    
    UIView *telLine = [[UIView alloc] initWithFrame:CGRectMake(0, 30 * self.scale - 1, 180 * self.scale, 1)];
    [telLine setBackgroundColor:ThemeBlue];
    [telButton addSubview:telLine];
    
    UILabel *tel = [[UILabel alloc] initWithFrame:CGRectMake(55 * self.scale, 13 * self.scale, 125 * self.scale, 15 * self.scale)];
    [tel setBackgroundColor:[UIColor clearColor]];
    [tel setText:shopEntity.telephone];
    [tel setTextColor:ThemeBlue];
    [tel setFont:[UIFont systemFontOfSize:18.f * self.scale]];
    [telButton addSubview:tel];
    
    UIImageView *telTri = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShopInfoView_TelTri"]];
    [telTri setFrame:CGRectMake(0, 0, 8 * self.scale, 12 * self.scale)];
    [telTri setCenter:CGPointMake(9 * self.scale, 17.5 * self.scale)];
    [telButton addSubview:telTri];
    
    //category
    UIView *categoryView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width / 2 + 10 * self.scale, 70 * self.scale, 30 * self.scale * 4, 30 * self.scale)];
    [self addSubview:categoryView];
    
    NSArray *categoryArray = [shopEntity.category componentsSeparatedByString:@","];
    for (int i=0; i < categoryArray.count; i++) {
        UIImageView *categoryImage = [[UIImageView alloc] initWithFrame:CGRectMake((30 * self.scale + 2 * self.scale) * i, 0, 30 * self.scale, 30 * self.scale)];
        [categoryImage setImage:[self getCategoryImageWithCategory:[categoryArray[i] intValue]]];
        [categoryView addSubview:categoryImage];
    }
    
    //collect
    
    UIButton *collectButton =  [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 60 * self.scale, 70 * self.scale, 45 * self.scale, 45 * self.scale)];
    [collectButton setExclusiveTouch:YES];
    [collectButton addTarget:self action:@selector(tappedCollectButton) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:collectButton];
    
    if (shopEntity.hasCollected) {
        UIImageView *collectImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShopListView_Collected"]];
        [collectImage setFrame:CGRectMake(0, 0, 40 * self.scale, 40 * self.scale)];
        [collectImage setCenter:CGPointMake(22.5 * self.scale, 22.5 * self.scale)];
        [collectImage setTag:99];
        [collectButton addSubview:collectImage];
    } else {
        UIImageView *collectImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShopInfoView_UnCollected"]];
        [collectImage setFrame:CGRectMake(0, 0, 40 * self.scale, 40 * self.scale)];
        [collectImage setCenter:CGPointMake(22.5 * self.scale, 22.5 * self.scale)];
        [collectImage setTag:99];
        [collectButton addSubview:collectImage];
    }
    
    //location
    
    UIButton *locationButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 100 * self.scale, self.frame.size.height * 0.78, 100 * self.scale, 30 * self.scale)];
    //[locationButton setBackgroundColor:[UIColor yellowColor]];
    [self addSubview:locationButton];
    
    UIImageView *locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShopInfoView_LocationIcon"]];
    [locationIcon setFrame:CGRectMake(- 9 * self.scale, 0 * self.scale, 18 * self.scale, 30 * self.scale)];
    [locationButton addSubview:locationIcon];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 0, 80 * self.scale, 30 * self.scale)];
    NSMutableAttributedString *str;
    if (shopEntity.locationArea.length > 0) {
        str = [[NSMutableAttributedString alloc] initWithString:shopEntity.locationArea];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:36.0 * self.scale] range:NSMakeRange(0, 1)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22.0 * self.scale] range:NSMakeRange(1, str.length - 1)];
    } else {
        str = [[NSMutableAttributedString alloc] initWithString:@"A111"];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24.0 * self.scale] range:NSMakeRange(0, 1)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0 * self.scale] range:NSMakeRange(1, str.length - 1)];
    }
    [locationLabel setAttributedText:str];
    [locationLabel setTextColor:ThemeBlue];
    [locationButton addSubview:locationLabel];
    
    UIView *locationLine = [[UIView alloc] initWithFrame:CGRectMake(0, 30 * self.scale - 1, 100 * self.scale, 1)];
    [locationLine setBackgroundColor:ThemeBlue];
    [locationButton addSubview:locationLine];
    
    UIImageView *locationTri = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShopInfoView_LocationTri"]];
    [locationTri setFrame:CGRectMake(0, 0, 7 * self.scale, 11 * self.scale)];
    [locationTri setCenter:CGPointMake(locationButton.frame.size.width - 10 * self.scale, 20 * self.scale)];
    [locationButton addSubview:locationTri];
    
    return self;
}

- (UIImage *)getCategoryImageWithCategory:(int)category {
    switch (category) {
        case 8:
            return [UIImage imageNamed:@"Famous_Icon"];
            break;
        case 9:
            return [UIImage imageNamed:@"Clothes_Icon"];
            break;
        case 10:
            return [UIImage imageNamed:@"Casual_Icon"];
            break;
        case 11:
            return [UIImage imageNamed:@"Kid_Icon"];
            break;
        case 12:
            return [UIImage imageNamed:@"Underwear_Icon"];
            break;
        case 13:
            return [UIImage imageNamed:@"Shoes_Icon"];
            break;
        case 14:
            return [UIImage imageNamed:@"Sweater_Icon"];
            break;
        case 15:
            return [UIImage imageNamed:@"Bags_Icon"];
            break;
        case 16:
            return [UIImage imageNamed:@"Ornament_Icon"];
            break;
        case 17:
            return [UIImage imageNamed:@"Food_Icon"];
            break;
        default:
            return [UIImage imageNamed:@"Ornament_Icon"];
            break;
    }
}

- (void)tappedTelButton {
    if (entity.telephone.length > 0) {
        UIWebView *callPhoneWebVw = [[UIWebView alloc] init];
        //NSLog(@"%@", [NSString stringWithFormat:@"tel://%@", _shopEntity.telephone]);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", entity.telephone]]];
        [callPhoneWebVw loadRequest:request];
        
        [self.superview addSubview:callPhoneWebVw];
    }
}

- (void)tappedCollectButton {
    MemberAPITool *memberAPI = [[MemberAPITool alloc] init];
    if (![memberAPI getLoginStatus]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"请先登录！"];
        return;
    }
    
    entity = [memberAPI setLocalFavoriteWithBrandID:entity];
    if (entity) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"收藏成功！"];
        
        if (entity.hasCollected) {
            [(UIImageView *)[self viewWithTag:99] setImage:[UIImage imageNamed:@"ShopListView_Collected"]];
        } else {
            [(UIImageView *)[self viewWithTag:99] setImage:[UIImage imageNamed:@"ShopListView_UnCollected"]];
        }
    }
}

@end
