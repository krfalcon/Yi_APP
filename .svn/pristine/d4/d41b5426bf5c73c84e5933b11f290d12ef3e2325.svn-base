//
//  ItemInfoView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/7.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ItemInfoView.h"

@implementation ItemInfoView

- (void)getInfo {
    
    UIView *upperView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, 125 * self.scale)];
    [self addSubview:upperView];
    
    //name
    
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(160 * self.scale, 5 * self.scale, self.frame.size.width - 140 * self.scale, 40 * self.scale)];
    nameView.layer.cornerRadius = 20.f * self.scale;
    [nameView setBackgroundColor:ThemeBlue];
    [upperView addSubview:nameView];
    
    UILabel *chNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 0 * self.scale, nameView.frame.size.width - 40 * self.scale, 25 * self.scale)];
    [chNameLabel setBackgroundColor:[UIColor clearColor]];
    [chNameLabel setText:_itemEntity.shopEntity.chName];
    [chNameLabel setTextColor:AbsoluteWhite];
    [chNameLabel setTextAlignment:NSTextAlignmentLeft];
    [chNameLabel setFont:[UIFont boldSystemFontOfSize:22 * self.scale]];
    [nameView addSubview:chNameLabel];
    
    UILabel *enNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 25 * self.scale, nameView.frame.size.width - 42 * self.scale, 15 * self.scale)];
    [enNameLabel setBackgroundColor:[UIColor clearColor]];
    [enNameLabel setText:_itemEntity.shopEntity.enName];
    [enNameLabel setTextColor:AbsoluteWhite];
    [enNameLabel setTextAlignment:NSTextAlignmentRight];
    [enNameLabel setFont:[UIFont boldSystemFontOfSize:13 * self.scale]];
    [nameView addSubview:enNameLabel];
    
    UIButton *nameButton = [[UIButton alloc] initWithFrame:nameView.bounds];
    [nameButton setExclusiveTouch:YES];
    [nameButton addTarget:self action:@selector(tappedNameButton) forControlEvents:UIControlEventTouchUpInside];
    [nameView addSubview:nameButton];
    
    //tele
    
    UIButton *telButton = [[UIButton alloc] initWithFrame:CGRectMake(155 * self.scale, 85 * self.scale, 160 * self.scale, 30 * self.scale)];
    [telButton addTarget:self action:@selector(tappedTelButton) forControlEvents:UIControlEventTouchUpInside];
    [upperView addSubview:telButton];
    
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
    [tel setText:_itemEntity.shopEntity.telephone];
    [tel setTextColor:ThemeBlue];
    [tel setFont:[UIFont systemFontOfSize:19.f * self.scale]];
    [telButton addSubview:tel];
    
    UIImageView *telTri = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShopInfoView_TelTri"]];
    [telTri setFrame:CGRectMake(0, 0, 8 * self.scale, 12 * self.scale)];
    [telTri setCenter:CGPointMake(9 * self.scale, 17.5 * self.scale)];
    [telButton addSubview:telTri];
    
    //location
    
    UIButton *locationButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 100 * self.scale, 50 * self.scale, 100 * self.scale, 30 * self.scale)];
    //[locationButton setBackgroundColor:[UIColor yellowColor]];
    [upperView addSubview:locationButton];
    
    UIImageView *locationIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ShopInfoView_LocationIcon"]];
    [locationIcon setFrame:CGRectMake(- 10.5f * self.scale, 0 * self.scale, 21 * self.scale, 30 * self.scale)];
    [locationButton addSubview:locationIcon];
    
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 * self.scale, 0, 80 * self.scale, 30 * self.scale)];
    NSMutableAttributedString *str;
    if (_itemEntity.shopEntity.locationArea.length > 0) {
        str = [[NSMutableAttributedString alloc] initWithString:_itemEntity.shopEntity.locationArea];
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
    
    MDIncrementalImageView *imageView = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(5 * self.scale, 5 * self.scale, 150 * self.scale, 110 * self.scale)];
    //imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setImageUrl:[NSURL URLWithString:_itemEntity.shopEntity.logoUrl]];
    [imageView setShowLoadingIndicatorWhileLoading:YES];
    //[imageView setDelegate:self];
    //[imageView setTag:(int)avc];
    [upperView addSubview:imageView];
    
    /////////lower
    
    UIView *lowerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight + upperView.frame.size.height, self.frame.size.width, self.frame.size.height - self.titleHeight - upperView.frame.size.height)];
    [self addSubview:lowerView];
    
    UIScrollView *itemScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, lowerView.frame.size.width, lowerView.frame.size.height)];
    //[eventScrollView setDelegate:self];
    [lowerView addSubview:itemScrollView];
    
//    if (_eventEntity.imageUrl) {
//        MDIncrementalImageView *bigImage = [[MDIncrementalImageView alloc] initWithFrame:CGRectMake(0, 0, lowerView.frame.size.width, lowerView.frame.size.width * 270.f / 750.f)];
//        //bigImage.contentMode = UIViewContentModeScaleAspectFill;
//        [bigImage setImageUrl:[NSURL URLWithString:_eventEntity.imageUrl]];
//        [bigImage setShowLoadingIndicatorWhileLoading:YES];
//        [lowerView addSubview:bigImage];
//    }
    
    UIView *priceView = [[UIView alloc] initWithFrame:CGRectMake(0 * self.scale, 60 * self.scale, self.frame.size.width - 10 * self.scale, 40 * self.scale)];
    priceView.layer.cornerRadius = 20 * self.scale;
    priceView.backgroundColor = ThemeBlue_177_231_255;
    [itemScrollView addSubview:priceView];

    NSString *timeString = [NSString stringWithFormat:@"%@", _itemEntity.price];
    NSMutableAttributedString *priceStr;
    priceStr = [[NSMutableAttributedString alloc] initWithString:timeString];
    [priceStr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, _itemEntity.price.length)];

    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0 * self.scale, 0 * self.scale, priceView.frame.size.width - 10 * self.scale, 40 * self.scale)];
    [priceLabel setBackgroundColor:AbsoluteClear];
    [priceLabel setAttributedText:priceStr];
    [priceLabel setTextColor:ThemeBlue_123_204_225];
    [priceLabel setTextAlignment:NSTextAlignmentRight];
    [priceLabel setFont:[UIFont systemFontOfSize:22 * self.scale]];
    [priceView addSubview:priceLabel];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(- 40 * self.scale, 20 * self.scale, 300 * self.scale, 80 * self.scale)];
    titleView.layer.cornerRadius = 40 * self.scale;
    titleView.backgroundColor = ThemeBlue;
    [itemScrollView addSubview:titleView];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50 * self.scale, 0, titleView.frame.size.width - 80 * self.scale, 40 * self.scale)];
    [titleLabel setBackgroundColor:AbsoluteClear];
    [titleLabel setText:_itemEntity.title];
    [titleLabel setTextColor:AbsoluteWhite];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:26 * self.scale]];
    [titleView addSubview:titleLabel];
    
    UILabel *saleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50 * self.scale, 40 * self.scale, titleView.frame.size.width - 80 * self.scale, 40 * self.scale)];
    [saleLabel setBackgroundColor:AbsoluteClear];
    [saleLabel setText:_itemEntity.sale];
    [saleLabel setTextColor:AbsoluteWhite];
    [saleLabel setTextAlignment:NSTextAlignmentRight];
    [saleLabel setFont:[UIFont systemFontOfSize:30 * self.scale]];
    [titleView addSubview:saleLabel];
    
    CarouselScrollView *bigImage = [[CarouselScrollView alloc] initWithFrame:CGRectMake(0, 100 * self.scale, lowerView.frame.size.width, lowerView.frame.size.width * 400.f / 750.f) andImages:_itemEntity.carouselArray andTheme:@"Blue"];
    [itemScrollView addSubview:bigImage];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_itemEntity.content ];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft ;
    paragraphStyle.lineSpacing = 3.f * self.scale;
    [paragraphStyle setFirstLineHeadIndent:32 * self.scale];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange (0 ,[_itemEntity.content length])];
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(12.5 * self.scale, 300 * self.scale, self.frame.size.width - 25 * self.scale, lowerView.frame.size.height - 230 * self.scale)];
    [contentLabel setAttributedText:attributedString];
    [contentLabel setBackgroundColor:AbsoluteClear];
    [contentLabel setTextColor:Color(0, 160, 233, 1)];
    [contentLabel setNumberOfLines:0];
    [contentLabel setFont:[UIFont systemFontOfSize:18 * self.scale]];
    [contentLabel sizeToFit];
    [contentLabel setFrame:(CGRect){contentLabel.frame.origin, CGSizeMake(self.frame.size.width - 25 * self.scale, contentLabel.frame.size.height)}];
    [itemScrollView addSubview:contentLabel];
    
    [itemScrollView setContentSize:CGSizeMake(itemScrollView.frame.size.width, 320 * self.scale + contentLabel.frame.size.height)];
}

- (void)tappedTelButton {
    UIWebView *callPhoneWebVw = [[UIWebView alloc] init];
    //NSLog(@"%@", [NSString stringWithFormat:@"tel://%@", _shopEntity.telephone]);
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", _itemEntity.shopEntity.telephone]]];
    [callPhoneWebVw loadRequest:request];
    
    [self.superview addSubview:callPhoneWebVw];
}


- (void)tappedNameButton {
    if (_delegate && [_delegate respondsToSelector:@selector(itemInfoViewDidTapShopEntity:)]) {
        [_delegate itemInfoViewDidTapShopEntity:nil];
    }
}

@end
