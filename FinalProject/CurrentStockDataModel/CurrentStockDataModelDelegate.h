//
//  CurrentStockDataModelDelegate.h
//  FinalProject
//
//  Created by Дмитрий Рощин on 29/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CurrentStockDataModelDelegate <NSObject>

@optional

- (void)updateTableView;
- (void)updateView;

@end

NS_ASSUME_NONNULL_END
