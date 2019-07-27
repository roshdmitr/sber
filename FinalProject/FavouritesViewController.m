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
@property (nonatomic, strong) NSFetchRequest *fetchRequest;
@property (nonatomic, strong) NSManagedObjectContext *coreDataContext;
@property (nonatomic, assign) NSInteger numberOfItems;
@property (nonatomic, strong) NSArray *favourites;

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

    _coreDataContext = [CoreDataController sharedInstance].persistentContainer.viewContext;
}

- (void)setupConstraints
{
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [_collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    [_collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-100].active = YES;
    [_collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20].active = YES;
    [_collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20].active = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _numberOfItems = [self countNumberOfItems];
    [self loadFromCoreData];
    [_collectionView reloadData];
}

- (NSInteger)countNumberOfItems
{
    if (_fetchRequest == nil)
    {
        _fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Stock"];
    }
    NSError *error = nil;
    NSArray *fetchedResults = [_coreDataContext executeFetchRequest:_fetchRequest error:&error];
    return [fetchedResults count];
}

- (void)loadFromCoreData
{
    if (_fetchRequest == nil)
    {
        _fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Stock"];
    }
    NSError *error = nil;
    _favourites = [_coreDataContext executeFetchRequest:_fetchRequest error:&error];
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_numberOfItems == 0)
    {
        _numberOfItems = [self countNumberOfItems];
    }
    return _numberOfItems;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FavouritesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cvidentifier" forIndexPath:indexPath];
    if (_favourites == nil || _favourites.count == 0)
    {
        [self loadFromCoreData];
    }
    if (_favourites != nil && _favourites.count != 0)
    {
        Stock *stock = _favourites[indexPath.row];
        cell.label.text = stock.symbol;
        cell.label.textAlignment = NSTextAlignmentCenter;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.intradayViewController == nil)
    {
        appDelegate.intradayViewController = [[IntradayViewController alloc] init];
    }
    Stock *stock = _favourites[indexPath.row];
    [appDelegate.intradayViewController setSymbol:stock.symbol];
    [self.navigationController pushViewController:appDelegate.intradayViewController animated:YES];
}

@end
