//
//  User.m
//  twitter
//
//  Created by Fabiola E. Robles Vega on 6/29/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype)initWithDictionary:(NSDictionary *) dictionary {
    self = [super init];
    NSLog(@"User  %@", dictionary);
    if(self){
        self.name = dictionary[@"name"];
        NSLog(@"NAME  %@", self.name);
        self.screenName = dictionary[@"screen_name"];
        NSLog(@"SCREENNAME  %@", self.screenName);
        self.profilePicURL = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
    }
    
    return self;
}

@end
