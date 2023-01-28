//
//  Login.swift
//  stotion
//
//  Created by Liel Machluf on 1/29/23.
//

import SwiftUI
import AuthenticationServices


struct Login: View {
    @State var email = ""
    @StateObject var loginData = LoginViewModel()
    @State var password = ""
    var body: some View {
        VStack{
            
            Text("Sign In")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                // Letter Spacing...
                .kerning(1.9)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Email And Password....
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text("User Name")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                TextField("username@gmail.com", text: $email)
                // Increasing Font Size And Changing Text Color...
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top,5)
                    .autocapitalization(.none)
                Divider()
            })
            .padding(.top,25)
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text("Password")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                SecureField("123456", text: $password)
                // Increasing Font Size And Changing Text Color...
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color("dark"))
                    .padding(.top,5)
                
                Divider()
            })
            .padding(.top,20)
            
            // Forget Password...
            Button(action: {}, label: {
                Text("Forgot password?")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            })
            // This line will reduce the use of unwanted hstack and spacers....
            // Try to use this and reduce the code in SwiftUI :)))
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top,10)
            
            // Next Button...
            Button(action: {}, label: {
                Image(systemName: "arrow.right")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("dark"))
                    .clipShape(Circle())
                // Shadow...
                    .shadow(color: Color("lightBlue").opacity(0.6), radius: 5, x: 0, y: 0)
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top,10)
            SignInWithAppleButton { (request) in
                
                // requesting paramertes from apple login...
                loginData.nonce = randomNonceString()
                request.requestedScopes = [.email,.fullName]
                request.nonce = sha256(loginData.nonce)
                
            } onCompletion: { (result) in
                
                // getting error or success...
                
                switch result{
                case .success(let user):
                    print("success")
                    // do Login With Firebase...
                    guard let credential = user.credential as? ASAuthorizationAppleIDCredential else{
                        print("error with firebase")
                        return
                    }
                    loginData.authenticate(credential: credential)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
            .signInWithAppleButtonStyle(.black)
            .frame(height: 55)
            .clipShape(Capsule())
            .padding(.horizontal,40)
            .offset(y: 0)
        }
        .padding()
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
