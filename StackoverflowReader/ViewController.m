//
//  ViewController.m
//  StackoverflowReader
//
//  Created by Igor Nabokov on 28/01/2018.
//  Copyright © 2018 Igor Nabokov. All rights reserved.
//

#import "ViewController.h"
#import "QuestionsTableDataManager.h"

@interface ViewController () <UISearchResultsUpdating>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) QuestionsTableDataManager *tableDataManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSearchController];


    [self setupTableView];
}

#pragma mark Setup UI

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;

    self.tableDataManager = [[QuestionsTableDataManager alloc] init];
    self.tableView.delegate = self.tableDataManager;
    self.tableView.dataSource = self.tableDataManager;

    [self.view addSubview:self.tableView];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    [NSLayoutConstraint activateConstraints:@[
            [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
            [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
            [self.tableView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor],
            [self.tableView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor]

    ]];
}

- (void)setupSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.navigationItem.searchController = self.searchController;
}



- (void)performSearchWithText:(NSString *)text {
    [self.tableDataManager prepareDataForText:text completionHandler:^(BOOL completed) {
        if (!completed) {
            // TODO present error
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    NSString *searchText = searchController.searchBar.text;
    if (searchText == nil || searchText.length < 3) {
        return;
    }
    [self performSelector:@selector(performSearchWithText:)
               withObject:searchController.searchBar.text
               afterDelay:0.5];
}


@end
