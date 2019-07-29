//
//  PresentViewController.h
//  FinalProject
//
//  Created by Дмитрий Рощин on 26/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "NetworkService.h"
#import "CoreDataService.h"
#import "CurrentStockDataModelDelegate.h"
#import "CurrentStockDataModel.h"


NS_ASSUME_NONNULL_BEGIN


@interface IntradayViewController : UIViewController <CurrentStockDataModelDelegate>

- (void)setSymbol:(NSString *)symbol;

@end

NS_ASSUME_NONNULL_END
