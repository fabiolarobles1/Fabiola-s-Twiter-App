//
//  Tweets.m
//  twitter
//
//  Created by Fabiola E. Robles Vega on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "Tweets.h"
#import "User.h"

@implementation Tweets

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {

        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];

            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
    
        //initialize user
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];

        // TODO: Format and set createdAtString
        
        //Format createdAt date string
        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        
        //Configure the input format to parse the date string
        formatter.dateFormat = @"E MM d HH:mm Z y";
        
        //Convert string to date
        NSDate *date = [formatter dateFromString:createdAtOriginalString];
        
        //configure output format
        formatter.dateStyle = NSDateFormatterNoStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        
        //Convert Date to String
        self.createdAtString = [formatter stringFromDate:date];
        
    }
    return self;
}

+ (NSMutableArray *)tweetsWithArray : (NSArray *) dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries){
        Tweets *tweet = [[Tweets alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}
@end
