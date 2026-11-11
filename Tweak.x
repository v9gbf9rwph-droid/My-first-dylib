#import <UIKit/UIKit.h>

%hook UIWindow

- (void)makeKeyAndVisible {
    %orig;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Success!"
                                                                           message:@"Your custom dylib is working."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Awesome" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:ok];
            [self.rootViewController presentViewController:alert animated:YES completion:nil];
        });
    });
}

%end
