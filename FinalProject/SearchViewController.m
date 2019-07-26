//
//  SearchViewController.m
//  FinalProject
//
//  Created by Дмитрий Рощин on 25/07/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.definesPresentationContext = YES;
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _searchController = [[UISearchController alloc] initWithSearchResultsController: nil];
    _searchController.searchBar.delegate = self;
    [_searchController.searchBar sizeToFit];
    _searchController.obscuresBackgroundDuringPresentation = NO;
    _searchController.searchBar.placeholder = @"Search";
    self.navigationItem.searchController = _searchController;
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    self.navigationItem.title = @"Stocks";
    [self.view addSubview:_tableView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [NetworkService sharedInstance].delegate = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntradayViewController *intradayViewController = [[IntradayViewController alloc] init];
    [intradayViewController setSymbol:_searchResults[indexPath.row][APIDictionaryKeySymbol]];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back to search" style:UIBarButtonItemStylePlain target:self.navigationController action:@selector(backButtonDidPress)];
    [self.navigationController pushViewController:intradayViewController animated:YES];
}

- (void)backButtonDidPress
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)saveSearchResults:(NSArray *)searchResults
{
    _searchResults = [[NSArray alloc] initWithArray:searchResults];
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"identifier"];
    }
    if (_searchResults != nil)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", _searchResults[indexPath.row][APIDictionaryKeySymbol], _searchResults[indexPath.row][APIDictionaryKeyName]];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchResults.count;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [[NetworkService sharedInstance] searchData:searchBar.text];
    [searchBar endEditing:(YES)];
}

@end
