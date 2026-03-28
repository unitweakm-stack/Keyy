#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <dlfcn.h>

@interface BackeerLoader : NSObject
+ (instancetype)sharedInstance;
- (void)showLoginAlert;
- (BOOL)validateKey:(NSString *)inputKey;
- (void)loadMainDylib;
@end

@implementation BackeerLoader {
    NSSet *_validKeys;
}

+ (instancetype)sharedInstance {
    static BackeerLoader *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *keysArray = @[
            @"CCZ3FGNEFP3OJMEQ", @"YU4YJA3TMJMCB9TG", @"XVC76UC73WM9A2GK",
            @"YZRLGHZVPYG9YH8D", @"9I91329OK3QIZ1Y4", @"5YIJ8KL5HGX2O3PM",
            @"RPIKPL8IQO34RTLH", @"9SWTUQFO6UW10P0L", @"MZCQ7ZDW0GRXCOLP",
            @"G9ILAJUBC9MVIJ93", @"61NG6EZIPCWEMK13", @"CL1BI3ZHPC9XVAH1",
            // ... qolgan 138 ta kalit
            @"02W3JFC5G84SF6N1"
        ];
        _validKeys = [NSSet setWithArray:keysArray];
    }
    return self;
}

- (BOOL)validateKey:(NSString *)inputKey {
    if (!inputKey || [inputKey length] == 0) return NO;
    return [_validKeys containsObject:inputKey];
}

- (void)loadMainDylib {
    NSString *dylibPath = @"/Library/MobileSubstrate/DynamicLibraries/App(1).dylib";
    void *handle = dlopen([dylibPath UTF8String], RTLD_NOW);
    if (handle) {
        NSLog(@"✅ App(1) muvaffaqiyatli yuklandi!");
    } else {
        NSLog(@"❌ App(1) yuklashda xatolik: %s", dlerror());
    }
}

// ✅ YANGI: keyWindow'siz versiya
- (void)showLoginAlert {
    dispatch_async(dispatch_get_main_queue(), ^{
        // Yangi usul — hech qachon keyWindow ishlatilmaydi
        UIWindow *window = [self getActiveWindow];
        if (!window) return;
        
        UIViewController *rootVC = [self getTopViewController:window.rootViewController];
        if (!rootVC) return;

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"🛡️ BACKEER KEY TIZIMI"
                                                                       message:@"Iltimos, 5 kunlik kalitni kiriting.\nSotib olish: @backeer"
                                                                preferredStyle:UIAlertControllerStyleAlert];

        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Kalitni kiriting...";
            textField.secureTextEntry = YES;
            textField.textAlignment = NSTextAlignmentCenter;
            textField.keyboardAppearance = UIKeyboardAppearanceDark;
        }];

        UIAlertAction *submit = [UIAlertAction actionWithTitle:@"✅ KIRISH" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSString *inputKey = alert.textFields.firstObject.text;
            if ([self validateKey:inputKey]) {
                [self loadMainDylib];
                
                UIAlertController *success = [UIAlertController alertControllerWithTitle:@"✅ Muvaffaqiyatli!"
                                                                                 message:@"Kalit qabul qilindi. Xush kelibsiz!"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
                [success addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [rootVC presentViewController:success animated:YES completion:nil];
            } else {
                UIAlertController *error = [UIAlertController alertControllerWithTitle:@"❌ Noto'g'ri kalit"
                                                                                message:@"Iltimos, to'g'ri kalitni kiriting"
                                                                         preferredStyle:UIAlertControllerStyleAlert];
                [error addAction:[UIAlertAction actionWithTitle:@"Qayta urinish" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self showLoginAlert];
                }]];
                [rootVC presentViewController:error animated:YES completion:nil];
            }
        }];

        [alert addAction:submit];
        [rootVC presentViewController:alert animated:YES completion:nil];
    });
}

// ✅ YANGI: KeyWindow'siz window topish
- (UIWindow *)getActiveWindow {
    UIWindow *activeWindow = nil;
    
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (window.isKeyWindow || window.windowLevel == UIWindowLevelNormal) {
            activeWindow = window;
            break;
        }
    }
    
    // Agar topilmasa — root window
    if (!activeWindow) {
        activeWindow = [[UIApplication sharedApplication] windows].firstObject;
    }
    
    return activeWindow;
}

// ✅ YANGI: Top ViewController topish
- (UIViewController *)getTopViewController:(UIViewController *)vc {
    if (!vc) return nil;
    
    if (vc.presentedViewController) {
        return [self getTopViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getTopViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getTopViewController:[(UITabBarController *)vc selectedViewController]];
    }
    
    return vc;
}

@end

static void __attribute__((constructor)) initialize() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[BackeerLoader sharedInstance] showLoginAlert];
    });
}
