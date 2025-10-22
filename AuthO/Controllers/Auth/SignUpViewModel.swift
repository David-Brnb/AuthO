//
//  SignUpViewModel.swift
//  AuthO
//
//  Created by Leoni Bernabe on 22/10/25.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
}
