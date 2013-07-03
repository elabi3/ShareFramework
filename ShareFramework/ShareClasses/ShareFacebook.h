//
//  Created by elabi3.
//

#import <UIKit/UIKit.h>

@interface ShareFacebook : NSObject

+(ShareFacebook *) getInstance;
-(void) postToFacebookText:(NSString *) stringText  foto:(UIImage *) foto urlString:(NSString *) stringURL viewController:(UIViewController *) viewController;

@end
