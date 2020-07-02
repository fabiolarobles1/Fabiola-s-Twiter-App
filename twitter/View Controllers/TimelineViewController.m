//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "ComposeViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)  UIRefreshControl *refreshControl;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //calling  tweets
    [self fetchTweets];
    
    //setting pulll to refresh
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(fetchTweets) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 125;
    
}

- (void) fetchTweets{
    
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.tweets = [tweets mutableCopy];
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tw in tweets) {
                NSString *text = tw.text;
                User *user = tw.user;
                NSLog(@"Text is %@", text);
                NSLog(@"Name is %@", user.name);
                NSLog(@"Username is %@", user.screenName);
            }
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            NSLog(@"GETTING NEW TWEETS");
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //segue to compose tweet
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController *) navigationController.topViewController;
    composeController.delegate = self;
    
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" ];
    Tweet *tweet = self.tweets[indexPath.row];
    User *user = tweet.user;
    
    //adding all the tweet info to the cell
    cell.tweet = tweet;
    cell.tweetTextLabel.text = tweet.text;
    cell.dateLabel.text = tweet.createdAtString;
    cell.nameLabel.text = user.name;
    cell.usernameLabel.text = user.screenName;
    cell.dateLabel.text = tweet.createdAtString;
    cell.favoriteCountLabel.text = [@(tweet.favoriteCount) stringValue];
    cell.retweetCountLabel.text = [@(tweet.retweetCount) stringValue];
    
    //if favorited show as already favorited
    if(tweet.favorited == YES){
        [cell.favoriteButton setSelected:YES];
    }
    //if retweeted show as already retweeted
    if(tweet.retweeted == YES){
        [cell.retweetButton setSelected:YES];
    }
    
    //setting profile picture
    if(user.profilePicURL != nil)
        [cell.profilePictureView setImageWithURL:user.profilePicURL];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

-(void)didTweet:(Tweet *)tweet{
    [self.tweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}

@end
