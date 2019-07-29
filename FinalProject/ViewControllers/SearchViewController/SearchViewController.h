//
//  SearchViewController.h
//  FinalProject
//
//  Created by Дмитрий Рощин on 25/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "NetworkServiceDelegate.h"
#import "CurrentStockDataModelDelegate.h"
#import "NetworkService.h"
#import "APIDictionaryKeysSearch.h"
#import "CurrentStockDataModel.h"
#import "IntradayViewController.h"
#import "AppDelegate.h"


NS_ASSUME_NONNULL_BEGIN


@interface SearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CurrentStockDataModelDelegate>

@end

NS_ASSUME_NONNULL_END
