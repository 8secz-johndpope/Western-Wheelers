import UIKit
import Amplify
import AmplifyPlugins
import AWSAppSync

//https://aws-amplify.github.io/docs/ios/api
//https://aws-amplify.github.io/docs/sdk/ios/start?ref=amplify-iOS-btn
//https://aws-amplify.github.io/docs/sdk/ios/start

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var appSyncClient: AWSAppSyncClient?
    
    func do_init() {
         do {
            // API Key authorization
            let serviceConfigAPIKey = try AWSAppSyncServiceConfig()
            let cacheConfigAPIKey = try AWSAppSyncCacheConfiguration(useClientDatabasePrefix: true, appSyncServiceConfig: serviceConfigAPIKey)
            let clientConfigAPIKey = try AWSAppSyncClientConfiguration(appSyncServiceConfig: serviceConfigAPIKey, cacheConfiguration: cacheConfigAPIKey)
            appSyncClient = try AWSAppSyncClient(appSyncConfig: clientConfigAPIKey)
            
            // IAM authorization
//            let serviceConfigIAM = try AWSAppSyncServiceConfig(forKey: "friendly_name_AWS_IAM")
//            let cacheConfigIAM = try AWSAppSyncCacheConfiguration(useClientDatabasePrefix: true, appSyncServiceConfig: serviceConfigIAM)
//            let clientConfigIAM = try AWSAppSyncClientConfiguration(appSyncServiceConfig: serviceConfigIAM,cacheConfiguration: cacheConfigIAM)
//            clients[AppSyncClientMode.private] = try AWSAppSyncClient(appSyncConfig: clientConfigIAM)
            print("AppDelegate:inited client")
            
            //delegate client
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let cl1 = appDelegate.appSyncClient
            
            // mutation   
            let mutationInput = CreateBlogInput(name: "Daviuuuuuu BLog")
            appSyncClient?.perform(mutation: CreateBlogMutation(input: mutationInput)) { (result, error) in
                if let error = error as? AWSAppSyncClientError {
                    print("Error occurred: \(error.localizedDescription )")
                }
                if let resultError = result?.errors {
                    print("Error saving the item on server: \(resultError)")
                    return
                }
                print("Mutation complete.")
            }
            
        } catch {
            print("AppDelegate:Error initializing appsync client. \(error)")
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.do_init()
//        do {
//
//            // You can choose the directory in which AppSync stores its persistent cache databases
//            let cacheConfiguration = try AWSAppSyncCacheConfiguration()
//            //print("CACHE CONFIG \(cacheConfiguration)")
//            // AppSync configuration & client initialization
//            let a = try? AWSAppSyncServiceConfig()
//            let appSyncServiceConfig = try AWSAppSyncServiceConfig()
//            print("CONFIG \(appSyncServiceConfig)")
//            let appSyncConfig = try AWSAppSyncClientConfiguration(appSyncServiceConfig: appSyncServiceConfig,
//                                                                  cacheConfiguration: cacheConfiguration)
//            appSyncClient = try AWSAppSyncClient(appSyncConfig: appSyncConfig)
//            print("Initialized appsync client.")
//        } catch {
//            print("Error initializing appsync client. \(error)")
//        }
//        // other methods
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


}

