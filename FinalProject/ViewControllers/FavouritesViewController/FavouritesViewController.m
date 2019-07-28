//
//  DailyViewController.m
//  FinalProject
//
//  Created by Дмитрий Рощин on 26/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import "FavouritesViewController.h"

@interface FavouritesViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation FavouritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 16.f;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(100.f, 70.f);
    layout.minimumInteritemSpacing = 16.f;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[FavouritesCollectionViewCell class] forCellWithReuseIdentifier:@"cvidentifier"];
    _collectionView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:_collectionView];
    [self setupConstraints];
    
    self.navigationItem.title = @"Your favourite stocks";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_collectionView reloadData];
}

- (void)setupConstraints
{
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [_collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    [_collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-100].active = YES;
    [_collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [_collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[CoreDataService sharedInstance] countItemsSavedForEntityName:@"Stock"];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FavouritesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvidentifier" forIndexPath:indexPath];
    Stock *stock = [[CoreDataService sharedInstance] loadItemsFromCoreDataForEntityName:@"Stock"][indexPath.row];
    cell.label.text = stock.symbol;
    cell.label.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.intradayViewController == nil)
    {
        appDelegate.intradayViewController = [[IntradayViewController alloc] init];
    }
    Stock *stock = [[CoreDataService sharedInstance] loadItemsFromCoreDataForEntityName:@"Stock"][indexPath.row];
    [appDelegate.intradayViewController setSymbol:stock.symbol];
    [self.navigationController pushViewController:appDelegate.intradayViewController animated:YES];
}

@end
