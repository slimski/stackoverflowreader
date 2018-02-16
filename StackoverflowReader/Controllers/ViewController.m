//
//  ViewController.m
//  StackoverflowReader
//
//  Created by Igor Nabokov on 28/01/2018.
//  Copyright © 2018 Igor Nabokov. All rights reserved.
//

#import "ViewController.h"
#import "QuestionsTableDataManager.h"
#import "QuestionTableViewCell.h"
#import "Constants.h"
#import "UILayoutGuide+Extensions.h"

@interface ViewController () <UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic) QuestionsTableDataManager *tableDataManager;
@property (strong, nonatomic) NSString *searchText;

@property (weak, nonatomic) UITableView *tableView;
@property (weak, nonatomic) UIActivityIndicatorView *indicator;

@end

@implementation ViewController

- (void)performSearchWithText:(NSString *)text {
    if ([self.searchText isEqualToString:text]) {
        return;
    }

    self.searchText = text;
    [self.indicator startAnimating];
    [self.tableDataManager prepareDataForText:text completionHandler:^(BOOL completed) {
        if (!completed) {
            // TODO present error
            return;
        }
        [self.indicator stopAnimating];
        self.tableView.hidden = text.length == 0;
        [self.tableView reloadData];
    }];
}


#pragma mark ViewController lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.lightGrayColor;
    self.title = MainTitle;

    [self setupSearchController];
    [self setupPlaceholder];
    [self setupTableView];
    [self setupIndicator];
}


#pragma mark Setup UI

- (void)setupTableView {
    // TODO: add page loading on scroll
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    self.tableDataManager = [[QuestionsTableDataManager alloc] init];
    tableView.delegate = self.tableDataManager;
    tableView.dataSource = self.tableDataManager;

    [self.view addSubview:tableView];

    [tableView registerClass:[QuestionTableViewCell class] forCellReuseIdentifier:[QuestionTableViewCell cellIdentifier]];
    [self.view.safeAreaLayoutGuide bindViewToEdges:tableView];
    tableView.hidden = YES;

    self.tableView = tableView;
}


- (void)setupSearchController {
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.searchBar.delegate = self;
    self.navigationItem.searchController = searchController;
}

- (void)setupIndicator {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:indicator];
    [self.view.safeAreaLayoutGuide bindViewToCenter:indicator];

    self.indicator = indicator;
}


- (void)setupPlaceholder {
    UILabel *placeholder = [[UILabel alloc] init];
    placeholder.text = PlaceholderText;
    placeholder.textAlignment = NSTextAlignmentCenter;
    placeholder.translatesAutoresizingMaskIntoConstraints = NO;

    [self.view addSubview:placeholder];
    [self.view.safeAreaLayoutGuide bindViewToEdges:placeholder];
}


#pragma mark UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    NSString *searchText = searchController.searchBar.text;
    if (searchText == nil || (searchText.length > 0 && searchText.length < MinimalCountOfLetters)) {
        return;
    }
    [self performSelector:@selector(performSearchWithText:)
               withObject:searchController.searchBar.text
               afterDelay:0.5];
}


#pragma mark UISearchBarDelegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    searchBar.text = self.searchText;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
}

@end
