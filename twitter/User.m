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
    
    if(self){
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicURL = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
    }
    
    return self;
}

@end
