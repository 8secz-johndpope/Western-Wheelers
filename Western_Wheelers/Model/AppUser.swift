import Foundation
import AWSAppSync

class AppUser {
    init () {

    }
    func save() {
        // mutation
        let mutationInput = CreateBlogInput(name: "AppUser")
        AppDelegate.app_sync_client?.perform(mutation: CreateBlogMutation(input: mutationInput)) { (result, error) in
            if let error = error as? AWSAppSyncClientError {
                print("Error occurred: \(error.localizedDescription )")
            }
            if let resultError = result?.errors {
                print("Error saving the item on server: \(resultError)")
                return
            }
            print("AppUser::Mutation complete.")
        }
    }
}
