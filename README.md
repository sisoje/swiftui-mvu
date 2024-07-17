# MVU Framework
### Introduction
This repository demonstrates an implementation of the Model-View-Update (MVU) architectural pattern in SwiftUI, inspired by the Elm architecture. The MVU pattern is known for its simplicity, predictability, and ease of testing, making it an excellent choice for managing state and handling user interactions in modern front-end applications.

### What is MVU?
The Model-View-Update (MVU) pattern is a simple and effective way to structure applications. It divides the application logic into three distinct parts:

- Model: Represents the state of the current view. It typically includes data structures that hold all the necessary information about the current state. In SwiftUI, views and their state are managed using immutable structs, ensuring a clear and predictable data flow.
- View: A function that takes the current state (model) and returns a user interface representation.
- Update: A function that takes the current state (model) and a message (an action or event) and returns a new state. The update function defines how the state changes in response to different messages. It may also trigger side effects, such as network requests, which are handled asynchronously.

### Example: LoginModel in SwiftUI
Below is an example of how the MVU pattern can be implemented in SwiftUI using a LoginModel component.

```swift
// MARK: - model (state)
struct LoginModel {
    @Environment(\.backendService) private var backendService
    @LoadableValue private var user: User?
    @State private var username = ""
    @State private var password = ""
}

// MARK: - update (actions)
private extension LoginModel {
    func loginAction() {
        _user.loadSync {
            try await backendService.getUser(username, password)
        }
    }
}

// MARK: - view (body function)
extension LoginModel: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextField("Username", text: $username)

                SecureField("Password", text: $password)

                Button("Login", action: loginAction)
                
                if _user.state.error != nil {
                    Text("Error logging in")
                }
            }
            .overlay {
                if _user.state.isLoading {
                    ProgressView()
                }
            }
            .navigationDestination(item: $user) { user in
                UserDetailsView(user: user)
            }
        }
        .taskLoadable(_user.loadable)
    }
}
```
