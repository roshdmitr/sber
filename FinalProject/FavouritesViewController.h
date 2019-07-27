//
//  DailyViewController.h
//  FinalProject
//
//  Created by Дмитрий Рощин on 26/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkService.h"
#import "CoreDataController.h"
#import "Stock+CoreDataProperties.h"
#import "FavouritesCollectionViewCell.h"
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface FavouritesViewController : UIViewController <NetworkServiceDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@end

NS_ASSUME_NONNULL_END
