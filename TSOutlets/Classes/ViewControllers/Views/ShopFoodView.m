//
//  ShopFoodView.m
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/8.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "ShopFoodView.h"
#import "MemberAPITool.h"

@implementation ShopFoodView

- (void)getInfo {
    
    UIView *upperView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight, self.frame.size.width, 160 * self.scale)];
    [self addSubview:upperView];
    
    [upperView addSubview:[[[ShopTitleView alloc] initWithFrame:self.bounds] getShopTitleViewWithShopEntity:_shopEntity]];
    
    UIView *lowerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.titleHeight + upperView.frame.size.height, self.frame.size.width, self.frame.size.height - self.titleHeight - upperView.frame.size.height)];
    [self addSubview:lowerView];
    
    reservedScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, lowerView.frame.size.width, lowerView.frame.size.height)];
    [reservedScrollView setDelegate:self];
    [reservedScrollView setShowsVerticalScrollIndicator:NO];
    [reservedScrollView setAlpha:0];
    [reservedScrollView setContentSize:CGSizeMake(foodScrollView.frame.size.width, 410 * self.scale)];
    [lowerView addSubview:reservedScrollView];
    
    foodScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, lowerView.frame.size.width, lowerView.frame.size.height)];
    [foodScrollView setDelegate:self];
    [foodScrollView setShowsVerticalScrollIndicator:NO];
    [lowerView addSubview:foodScrollView];
    
    foodStepScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(lowerView.frame.size.width, 0, lowerView.frame.size.width, lowerView.frame.size.height)];
    [foodStepScrollView setDelegate:self];
    [foodStepScrollView setShowsVerticalScrollIndicator:NO];
    [foodStepScrollView setContentSize:CGSizeMake(foodScrollView.frame.size.width, 410 * self.scale)];
    [lowerView addSubview:foodStepScrollView];
    
    MemberAPITool *memberAPI = [[MemberAPITool alloc] init];
    
    //whether has reservation
    if (_shopEntity.tableSet && _shopEntity.tableSet.count > 0 && _shopEntity.open && [memberAPI getLoginStatus]) {
        //有预约的餐厅
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(80 * self.scale, 5 * self.scale, self.frame.size.width - 160 * self.scale, 30 * self.scale)];
        titleView.layer.cornerRadius = 15 * self.scale;
        titleView.backgroundColor = ThemeBlue;
        [foodScrollView addSubview:titleView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleView.bounds];
        [titleLabel setText:@"请选择桌号"];
        [titleLabel setTextColor:AbsoluteWhite];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont systemFontOfSize:24 * self.scale]];
        [titleView addSubview:titleLabel];
        
        UIScrollView *reserveScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40 * self.scale, self.frame.size.width, 180 * self.scale)];
        [foodScrollView addSubview:reserveScrollView];
        
        //NSArray *array = @[@[@"小桌", @"1-2人", @"7"], @[@"中桌", @"3-4人", @"110"], @[@"大桌", @"5-6人", @"14"], @[@"特大桌", @"7人以上", @"0"]];
        
        for (int i = 0; i < _shopEntity.tableSet.count; i++) {
            TableType *table = [_shopEntity.tableSet objectAtIndex:i];
            
            float w = 0;
            
            if (_shopEntity.tableSet.count == 1) {
                w = (self.frame.size.width - self.frame.size.width / 4) / 2;
            } else if (_shopEntity.tableSet.count == 2) {
                w = (self.frame.size.width - self.frame.size.width / 4 * 2) / 2;
            } else if (_shopEntity.tableSet.count == 3) {
                w = (self.frame.size.width - self.frame.size.width / 4 * 3) / 2;
            }
            
            UIButton *reserveButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width / 4 * i + w, 0, self.frame.size.width / 4, 120 * self.scale)];
            reserveButton.clipsToBounds = NO;
            reserveButton.exclusiveTouch = YES;
            reserveButton.tag = i;
            [reserveButton addTarget:self action:@selector(tappedReserveOptionButton:) forControlEvents:UIControlEventTouchUpInside];
            [reserveScrollView addSubview:reserveButton];
            
            UILabel *reserveTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, reserveButton.frame.size.width, 30 * self.scale)];
            [reserveTitle setText:table.tableName];
            [reserveTitle setTextColor:ThemeBlue];
            [reserveTitle setTextAlignment:NSTextAlignmentCenter];
            [reserveTitle setFont:[UIFont systemFontOfSize:20 * self.scale]];
            [reserveButton addSubview:reserveTitle];
            
            UIView *reserveView = [[UIView alloc] initWithFrame:CGRectMake(5 * self.scale, 30 * self.scale, reserveButton.frame.size.width - 10 * self.scale, reserveButton.frame.size.width - 10 * self.scale)];
            reserveView.layer.cornerRadius = (reserveButton.frame.size.width - 10 * self.scale) / 2.f;
            reserveView.layer.borderColor = ThemeBlue.CGColor;
            reserveView.layer.borderWidth = 2.f * self.scale;
            reserveView.userInteractionEnabled = NO;
            //reserveView.tag = 999;
            [reserveButton addSubview:reserveView];
            
            NSMutableAttributedString *people = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@-%@人", table.minNumber, table.maxNumber]];
            
            for (int j = 0; j < people.length; j++) {
                NSScanner* scan = [NSScanner scannerWithString:[NSString stringWithFormat:@"%@", [people attributedSubstringFromRange:NSMakeRange(j, 1)]]];
                int val;
                if  ([scan scanInt:&val]) {
                    [people addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:36.0 * self.scale] range:NSMakeRange(j, 1)];
                } else {
                    [people addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:24.0 * self.scale] range:NSMakeRange(j, 1)];
                }
            }
            
            UILabel *reservePeople = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, reserveView.frame.size.width - 30 * self.scale, 0)];
            [reservePeople setAttributedText:people];
            //[reservePeople setText:[reserveArray objectAtIndex:1]];
            [reservePeople setTextColor:ThemeBlue];
            [reservePeople setTextAlignment:NSTextAlignmentCenter];
            //[reservePeople setFont:[UIFont systemFontOfSize:25 * self.scale]];
            [reservePeople setNumberOfLines:0];
            [reservePeople sizeToFit];
            [reservePeople setCenter:reserveView.center];
            //[reservePeople setTag:998];
            [reserveButton addSubview:reservePeople];
            
//            NSMutableAttributedString *order = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"目前等待\n%@桌", [reserveArray objectAtIndex:2]]];
//            [order addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0 * self.scale] range:NSMakeRange(0, 4)];
//            [order addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:38.0 * self.scale] range:NSMakeRange(5, order.length - 6)];
//            [order addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22.0 * self.scale] range:NSMakeRange(order.length - 1, 1)];
//            [order addAttribute:NSForegroundColorAttributeName value:ThemeBlue range:NSMakeRange(0, 4)];
//            [order addAttribute:NSForegroundColorAttributeName value:ThemeBlue range:NSMakeRange(order.length - 1, 1)];
//            [order addAttribute:NSForegroundColorAttributeName value:ThemeRed range:NSMakeRange(5, order.length - 6)];
//            
//            UILabel *reserveOrder = [[UILabel alloc] initWithFrame:CGRectMake(0, 115 * self.scale, reserveButton.frame.size.width, 65.0 * self.scale)];
//            [reserveOrder setAttributedText:order];
//            [reserveOrder setNumberOfLines:0];
//            [reserveOrder setTextAlignment:NSTextAlignmentCenter];
//            [reserveButton addSubview:reserveOrder];
            
//            if (i == 0) {
//                [reservePeople setTag:-998];
//                [reservePeople setTextColor:AbsoluteWhite];
//                [reserveView setTag:-999];
//                [reserveView setBackgroundColor:ThemeBlue];
//            }
        }
        
        [foodScrollView setContentSize:CGSizeMake(foodScrollView.frame.size.width, 410 * self.scale)];
        
        UIView *titleStepTwoView = [[UIView alloc] initWithFrame:CGRectMake(80 * self.scale, 5 * self.scale, self.frame.size.width - 160 * self.scale, 30 * self.scale)];
        titleStepTwoView.layer.cornerRadius = 15 * self.scale;
        titleStepTwoView.backgroundColor = ThemeBlue;
        [foodStepScrollView addSubview:titleStepTwoView];
        
        UILabel *titleStepTwoLabel = [[UILabel alloc] initWithFrame:titleView.bounds];
        [titleStepTwoLabel setText:@"请选择用餐人数"];
        [titleStepTwoLabel setTextColor:AbsoluteWhite];
        [titleStepTwoLabel setTextAlignment:NSTextAlignmentCenter];
        [titleStepTwoLabel setFont:[UIFont systemFontOfSize:24 * self.scale]];
        [titleStepTwoView addSubview:titleStepTwoLabel];
        
        UIButton *returnButton = [[UIButton alloc] initWithFrame:CGRectMake(0 * self.scale, 15 * self.scale, 60 * self.scale, 50 * self.scale)];
        [returnButton setExclusiveTouch:YES];
        [returnButton addTarget:self action:@selector(tappedReturnButton) forControlEvents:UIControlEventTouchUpInside];
        [foodStepScrollView addSubview:returnButton];
        
        UIImageView *returnImage = [[UIImageView alloc] initWithFrame:returnButton.bounds];
        [returnImage setImage:[UIImage imageNamed:@"ShopInfoView_Return"]];
        [returnButton addSubview:returnImage];
        
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width - 180 * self.scale) / 2, 70 * self.scale, 180 * self.scale, 90 * self.scale)];
        [numberLabel setBackgroundColor:AbsoluteClear];
        [numberLabel setText:_shopEntity.reserveNumber ? _shopEntity.reserveNumber : @"0"];
        [numberLabel setTextColor:ThemeRed];
        [numberLabel setTextAlignment:NSTextAlignmentCenter];
        [numberLabel setFont:[UIFont systemFontOfSize:90 * self.scale]];
        [numberLabel setTag:998];
        [numberLabel setUserInteractionEnabled:YES];
        [foodStepScrollView addSubview:numberLabel];
        
        UIButton *minusButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 25 * self.scale, 20 * self.scale, 40 * self.scale)];
        [minusButton setExclusiveTouch:YES];
        [minusButton setTag:-1];
        [minusButton addTarget:self action:@selector(tappedChangeButton:) forControlEvents:UIControlEventTouchUpInside];
        [numberLabel addSubview:minusButton];
        
        UIImageView *minusImage = [[UIImageView alloc] initWithFrame:minusButton.bounds];
        [minusImage setImage:[UIImage imageNamed:@"ShopInfoView_Minus"]];
        [minusButton addSubview:minusImage];
        
        UIButton *plusButton = [[UIButton alloc] initWithFrame:CGRectMake(160 * self.scale, 25 * self.scale, 20 * self.scale, 40 * self.scale)];
        [plusButton setExclusiveTouch:YES];
        [plusButton setTag:1];
        [plusButton addTarget:self action:@selector(tappedChangeButton:) forControlEvents:UIControlEventTouchUpInside];
        [numberLabel addSubview:plusButton];
        
        UIImageView *plusImage = [[UIImageView alloc] initWithFrame:minusButton.bounds];
        [plusImage setImage:[UIImage imageNamed:@"ShopInfoView_Plus"]];
        [plusButton addSubview:plusImage];
        
        UIButton *reserveButton = [[UIButton alloc] initWithFrame:CGRectMake(90 * self.scale, 200 * self.scale, self.frame.size.width - 180 * self.scale, 65 * self.scale)];
        reserveButton.layer.cornerRadius = reserveButton.frame.size.height / 2;
        reserveButton.clipsToBounds = YES;
        [reserveButton addTarget:self action:@selector(tappedReserveButton) forControlEvents:UIControlEventTouchUpInside];
        [foodStepScrollView addSubview:reserveButton];
        
        UILabel *reserveLabel = [[UILabel alloc] initWithFrame:reserveButton.bounds];
        [reserveLabel setBackgroundColor:ThemeBlue];
        [reserveLabel setText:@"取号"];
        [reserveLabel setTextColor:AbsoluteWhite];
        [reserveLabel setTextAlignment:NSTextAlignmentCenter];
        [reserveLabel setFont:[UIFont systemFontOfSize:40 * self.scale]];
        [reserveButton addSubview:reserveLabel];
        
        if (_shopEntity.valid == 0 || _shopEntity.valid == 1) {
            [self initReservedView];
        }
    } else {
        //并没有预约这个功能
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50 * self.scale, self.frame.size.width, 40 * self.scale)];
        [titleLabel setText:@"这家店好像……"];
        [titleLabel setTextColor:ThemeBlue];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont boldSystemFontOfSize:35 * self.scale]];
        [foodScrollView addSubview:titleLabel];
        
        UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(40 * self.scale, 100 * self.scale, self.frame.size.width - 40 * self.scale, 100 * self.scale)];
        [contentLabel setText:@"1、该店铺没有开启餐饮排队功能。\n2、您未登录，不能进行餐饮排队取号。\n3、您的网络开小差了，请检查网络连接情况。"];
        [contentLabel setTextColor:ThemeBlue];
        [contentLabel setNumberOfLines:0];
        [contentLabel setFont:[UIFont systemFontOfSize:18 * self.scale]];
        [foodScrollView addSubview:contentLabel];
    }
}

- (void)refreshInfo {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self getInfo];
}

- (void)initReservedView {
    
    [[reservedScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *orderView = [[UIView alloc] initWithFrame:CGRectMake(- 25 * self.scale, 0, 235 * self.scale, 50 * self.scale)];
    orderView.layer.cornerRadius = orderView.frame.size.height / 2;
    orderView.layer.borderColor = ThemeBlue.CGColor;
    orderView.layer.borderWidth = 2.f * self.scale;
    [reservedScrollView addSubview:orderView];
    
    UILabel *orderHead = [[UILabel alloc] initWithFrame:CGRectMake(35 * self.scale, 0, 75 * self.scale, orderView.frame.size.height)];
    [orderHead setText:@"已叫到"];
    [orderHead setTextColor:ThemeBlue];
    [orderHead setFont:[UIFont systemFontOfSize:22 * self.scale]];
    [orderView addSubview:orderHead];
    
    UILabel *orderTail = [[UILabel alloc] initWithFrame:CGRectMake(190 * self.scale, 0, 25 * self.scale, orderView.frame.size.height)];
    [orderTail setText:@"号"];
    [orderTail setTextColor:ThemeBlue];
    [orderTail setFont:[UIFont systemFontOfSize:20 * self.scale]];
    [orderView addSubview:orderTail];
    
    UILabel *orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(110 * self.scale, 0, 80 * self.scale, orderView.frame.size.height)];
    [orderLabel setText:_shopEntity.calling && _shopEntity.calling.length ? [_shopEntity.calling substringToIndex:_shopEntity.calling.length - 1] : @"0"];///////////号码去掉号
    [orderLabel setTextColor:ThemeRed];
    [orderLabel setTextAlignment:NSTextAlignmentCenter];
    [orderLabel setFont:[UIFont systemFontOfSize:35 * self.scale]];
    [orderLabel setTag:-100];
    [orderView addSubview:orderLabel];
    
    UIView *restView = [[UIView alloc] initWithFrame:CGRectMake(220 * self.scale, 35 * self.scale, 180 * self.scale, 50 * self.scale)];
    restView.layer.cornerRadius = restView.frame.size.height / 2;
    restView.layer.borderColor = ThemeBlue.CGColor;
    restView.layer.borderWidth = 2.f * self.scale;
    [reservedScrollView addSubview:restView];
    
    UILabel *restHead = [[UILabel alloc] initWithFrame:CGRectMake(20 * self.scale, 0, 50 * self.scale, orderView.frame.size.height)];
    [restHead setText:@"还有"];
    [restHead setTextColor:ThemeBlue];
    [restHead setFont:[UIFont systemFontOfSize:20 * self.scale]];
    [restView addSubview:restHead];
    
    UILabel *restTail = [[UILabel alloc] initWithFrame:CGRectMake(120 * self.scale, 0, 50 * self.scale, orderView.frame.size.height)];
    [restTail setText:@"桌"];
    [restTail setTextColor:ThemeBlue];
    [restTail setFont:[UIFont systemFontOfSize:20 * self.scale]];
    [restView addSubview:restTail];
    
    UILabel *restLabel = [[UILabel alloc] initWithFrame:CGRectMake(70 * self.scale, 0, 50 * self.scale, orderView.frame.size.height)];
    [restLabel setText:_shopEntity.remaining && _shopEntity.remaining.length ? _shopEntity.remaining : @"0"];
    [restLabel setTextColor:ThemeRed];
    [restLabel setTextAlignment:NSTextAlignmentCenter];
    [restLabel setFont:[UIFont systemFontOfSize:30 * self.scale]];
    [restLabel setTag:-100];
    [restView addSubview:restLabel];
    
    //Your reserve number
    
    UIView *reserveView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width - 180 * self.scale) / 2, 90 * self.scale, 180 * self.scale, 180 * self.scale)];
    reserveView.layer.cornerRadius = reserveView.frame.size.height / 2;
    reserveView.layer.borderColor = ThemeBlue.CGColor;
    reserveView.layer.borderWidth = 2.f * self.scale;
    [reservedScrollView addSubview:reserveView];
    
    NSString *size = _shopEntity.reserveTable && _shopEntity.reserveTable.length >0 ? _shopEntity.reserveTable : @"0";
    NSString *number = _shopEntity.reserveNumber && _shopEntity.reserveNumber.length ? [_shopEntity.reserveNumber substringToIndex:_shopEntity.reserveNumber.length - 1] : @"0";
    
    NSMutableAttributedString *reserveString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"您是%@\n%@\n号", size, number]];
    [reserveString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0 * self.scale] range:NSMakeRange(0, 2)];
    [reserveString addAttribute:NSForegroundColorAttributeName value:ThemeBlue range:NSMakeRange(0, 2)];
    [reserveString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25 * self.scale] range:NSMakeRange(2, size.length)];
    [reserveString addAttribute:NSForegroundColorAttributeName value:ThemeRed range:NSMakeRange(2, size.length)];
    [reserveString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0 * self.scale] range:NSMakeRange(size.length + 1, 1)];
    [reserveString addAttribute:NSForegroundColorAttributeName value:ThemeBlue range:NSMakeRange(size.length + 1, 1)];
    
    [reserveString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:90 * self.scale] range:NSMakeRange(size.length + 3, number.length)];
    [reserveString addAttribute:NSForegroundColorAttributeName value:ThemeRed range:NSMakeRange(size.length + 3, number.length)];
    [reserveString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20.0 * self.scale] range:NSMakeRange(reserveString.length - 1, 1)];
    [reserveString addAttribute:NSForegroundColorAttributeName value:ThemeBlue range:NSMakeRange(reserveString.length - 1, 1)];
    
    UILabel *reserveLabel = [[UILabel alloc] initWithFrame:reserveView.bounds];
    [reserveLabel setAttributedText:reserveString];
    [reserveLabel setNumberOfLines:0];
    [reserveLabel setTextAlignment:NSTextAlignmentCenter];
    [reserveView addSubview:reserveLabel];
    
    //取消按钮
    
    UIView *cancelView = [[UIView alloc] initWithFrame:CGRectMake(220 * self.scale, 220 * self.scale, 75 * self.scale, 75 * self.scale)];
    cancelView.layer.cornerRadius = cancelView.frame.size.height / 2;
    cancelView.layer.borderColor = ThemeBlue.CGColor;
    cancelView.layer.borderWidth = 2.f * self.scale;
    [cancelView setBackgroundColor:Color(151, 186, 202, 1)];
    [reservedScrollView addSubview:cancelView];
    
    UILabel *cancelLabel = [[UILabel alloc] initWithFrame:cancelView.bounds];
    [cancelLabel setText:@"取消\n等待"];
    [cancelLabel setTextColor:AbsoluteWhite];
    [cancelLabel setTextAlignment:NSTextAlignmentCenter];
    [cancelLabel setFont:[UIFont systemFontOfSize:22 * self.scale]];
    [cancelLabel setNumberOfLines:0];
    [cancelView addSubview:cancelLabel];
    
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:cancelView.bounds];
    [cancelButton addTarget:self action:@selector(tappedCancelButton) forControlEvents:UIControlEventTouchUpInside];
    [cancelView addSubview:cancelButton];
    
    [UIView animateWithDuration:0.2 animations:^{
        [foodScrollView setAlpha:0];
        [foodStepScrollView setAlpha:0];
        [reservedScrollView setAlpha:1];
    }];
}

- (void)tappedReserveOptionButton:(UIButton *)button {
    [(UILabel *)[self viewWithTag:998] setText:[NSString stringWithFormat:@"%@", [(TableType *)_shopEntity.tableSet[button.tag] minNumber]]];
    
    [UIView animateWithDuration:0.4f animations:^{
        foodScrollView.transform = CGAffineTransformMakeTranslation(-foodScrollView.frame.size.width, 0);
        foodStepScrollView.transform = CGAffineTransformMakeTranslation(-foodStepScrollView.frame.size.width, 0);
    }];
}

- (void)tappedReturnButton {
    [UIView animateWithDuration:0.4f animations:^{
        foodScrollView.transform = CGAffineTransformMakeTranslation(0, 0);
        foodStepScrollView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
}

- (void)tappedChangeButton:(UIButton *)button {
    int number = [[(UILabel *)[self viewWithTag:998] text] intValue];
    if (number + button.tag > 0 && number + button.tag < 100) {
        [(UILabel *)[self viewWithTag:998] setText:[NSString stringWithFormat:@"%ld", (long)(number + button.tag)]];
    }
}

- (void)tappedReserveButton {
    if (_delegate && [_delegate respondsToSelector:@selector(shopFoodViewDidTapReserveButtonWithNumber:andShopID:)]) {
        [_delegate shopFoodViewDidTapReserveButtonWithNumber:[(UILabel *)[self viewWithTag:998] text] andShopID:_shopEntity.shopID];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldShowTip" object:@"正在取号……"];
    }
}

- (void)tappedCancelButton {
    if (_delegate && [_delegate respondsToSelector:@selector(shopFoodViewDidTapCancelButtonWithShopID:)]) {
        [_delegate shopFoodViewDidTapCancelButtonWithShopID:_shopEntity.shopID];
    }
}

#pragma mark - ScrollView Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(shopFoodView:didStartDragScrollView:)]) {
        [_delegate shopFoodView:self didStartDragScrollView:scrollView ];
    }
}

@end
