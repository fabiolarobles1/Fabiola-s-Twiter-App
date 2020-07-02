//
//  TweetCell.m
//  twitter
//
//  Created by Fabiola E. Robles Vega on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    if(self.tweet.favorited == NO){
        self.tweet.favorited = YES;
        self.tweet.favoriteCount +=1;
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
        
    }else{
         self.tweet.favorited = NO;
               self.tweet.favoriteCount -=1;
        
        [[APIManager shared] unFavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self refreshData];

}
- (IBAction)didTapRetweet:(id)sender {
    if(self.tweet.retweeted == NO){
        self.tweet.retweeted = YES;
        self.tweet.retweetCount +=1;
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
        
    }else{
         self.tweet.retweeted = NO;
               self.tweet.retweetCount -=1;
        
        [[APIManager shared] unRetweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self refreshData];

}

-(void)refreshData {
    
    if(self.tweet.favorited == YES){
        [self.favoriteButton setSelected:YES];
    }else {
         [self.favoriteButton setSelected:NO];
    }
    
    if(self.tweet.retweeted == YES){
        [self.retweetButton setSelected:YES];
    }else{
        [self.retweetButton setSelected:NO];
    }
    
    self.favoriteCountLabel.text = [@(self.tweet.favoriteCount) stringValue];
    self.retweetCountLabel.text = [@(self.tweet.retweetCount) stringValue];
}

@end
