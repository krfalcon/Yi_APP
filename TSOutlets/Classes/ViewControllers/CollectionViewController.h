//
//  CollectionViewController.h
//  TSOutlets
//
//  Created by 奚潇川 on 15/5/12.
//  Copyright (c) 2015年 奚潇川. All rights reserved.
//

#import "MotherViewController.h"

#import "CollectionView.h"

@interface CollectionViewController : MotherViewController<CollectionViewDelegate>
{
    CollectionView              *collectionView;
    
    NSArray                     *originArray;
    
    NSString                    *currentString;
    SortType                    currentType;
}

@end
