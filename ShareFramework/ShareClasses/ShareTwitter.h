//
//  Created by elabi3.
//

#import <UIKit/UIKit.h>


@class ACAccount;
@interface ShareTwitter : NSObject 

+(ShareTwitter *) getInstance;

-(void) postToTwitterText:(NSString *) stringText  foto:(UIImage*) foto  urlString:(NSString *) stringURL  viewController:(UIViewController *) viewController;

-(void) postToTwitterBackgroundWithAccount:(ACAccount *) account text:(NSString *)stringText foto:(UIImage *)foto video:(NSString *)video latitud:(NSString *)latitud longitud:(NSString *) longitud urlString:(NSString *)stringURL;

-(void) startObtainingAccounts;

-(void) openSettingsTwitter:(UIViewController *) viewController;

-(NSArray *) getAccounts;
-(ACAccount *) getAccountFromUserName: (NSString *) userName;

@end
