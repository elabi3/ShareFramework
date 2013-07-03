//
//  Created by elabi3.
//

#import "ShareClipBoard.h"

static ShareClipBoard *instance;

@implementation ShareClipBoard

+(ShareClipBoard *) getInstance {
    if (instance == nil) {
        instance = [[ShareClipBoard alloc] init];
    }
    return instance;
}

-(void) copyStringToClipBoard:(NSString *) string {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = string;
}

@end
