import UIKit
import Amplify
import AmplifyPlugins
import AWSAppSync

//https://aws-amplify.github.io/docs/ios/api
//https://aws-amplify.github.io/docs/sdk/ios/start?ref=amplify-iOS-btn
//https://aws-amplify.github.io/docs/sdk/ios/start

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    public static var app_sync_client: AWSAppSyncClient?
    public static var app_user = AppUser()
    
    func init_app_sync() {
        //TODO should be background thread after app is running?
         do {
            // API Key authorization
            let serviceConfigAPIKey = try AWSAppSyncServiceConfig()
            let cacheConfigAPIKey = try AWSAppSyncCacheConfiguration(useClientDatabasePrefix: true, appSyncServiceConfig: serviceConfigAPIKey)
            let clientConfigAPIKey = try AWSAppSyncClientConfiguration(appSyncServiceConfig: serviceConfigAPIKey, cacheConfiguration: cacheConfigAPIKey)
            AppDelegate.app_sync_client = try AWSAppSyncClient(appSyncConfig: clientConfigAPIKey)
            
            // IAM authorization
//            let serviceConfigIAM = try AWSAppSyncServiceConfig(forKey: "friendly_name_AWS_IAM")
//            let cacheConfigIAM = try AWSAppSyncCacheConfiguration(useClientDatabasePrefix: true, appSyncServiceConfig: serviceConfigIAM)
//            let clientConfigIAM = try AWSAppSyncClientConfiguration(appSyncServiceConfig: serviceConfigIAM,cacheConfiguration: cacheConfigIAM)
//            clients[AppSyncClientMode.private] = try AWSAppSyncClient(appSyncConfig: clientConfigIAM)
            
            //delegate client
            //let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //let client = appDelegate.appSyncClient
            print("AppDelegate::created AppSync client")
        } catch {
            AppDelegate.report_error(class_type: type(of: self), error: "Cannot init AppSync client\(error)")
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.init_app_sync()
        AppDelegate.app_user.save()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    static func report_error(class_type: CFTypeRef, error: String) {
        print ("\n\n********* \(class_type):: \(error)\n")
    }

}

