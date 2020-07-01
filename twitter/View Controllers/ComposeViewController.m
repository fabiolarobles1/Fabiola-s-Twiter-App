//
//  ComposeViewController.m
//  twitter
//
//  Created by Fabiola E. Robles Vega on 6/30/20.
//  Copyright © 2020 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *composeTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *composeTweetButton;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)onCloseTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)onTweetTap:(id)sender {
    [[APIManager shared] postStatusWithText:self.composeTextView.text completion: ^(Tweet *tweet, NSError *error){
        
        if(error != nil){
            NSLog(@"Error: %@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error posting tweet" message:@"There appears to be an error with your tweet. Please, try again later." preferredStyle:(UIAlertControllerStyleAlert)];
            
            //creating OK action
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                 [self dismissViewControllerAnimated:YES completion:nil];
            }];
            
            //adding OK action to the alertController
            [alert addAction:okAction];
            
            [self presentViewController:alert animated:YES completion:^{
             //space for what happens after the controller finishes presenting
            }];
            
        }else{
            NSLog(@"Succesfully posted tweet.");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
           
       }  ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
