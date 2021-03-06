//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public enum AuthError {
    case identity(ErrorName, ErrorDescription, RecoverySuggestion, Error? = nil)
    case notAuthenticated(ErrorDescription, RecoverySuggestion, Error? = nil)
    case notAuthorized(ErrorDescription, RecoverySuggestion, Error? = nil)
    case unknown(ErrorDescription, Error? = nil)
}

extension AuthError: AmplifyError {
    public var errorDescription: ErrorDescription {
        switch self {
        case .identity(let errorName, let errorDescription, _, _):
            return "Could not get IdentityId due to [\(errorName)] with message: \(errorDescription)"
        case .notAuthenticated(let errorDescription, _, _):
            return "The user is not authenticated: \(errorDescription)"
        case .notAuthorized(let errorDescription, _, _):
            return "The user is not authorized: \(errorDescription)"
        case .unknown(let errorDescription, _):
            return "Unexpected error occurred with message: \(errorDescription)"
        }
    }

    public var recoverySuggestion: RecoverySuggestion {
        switch self {
        case .identity(_, _, let recoverySuggestion, _):
            return recoverySuggestion
        case .notAuthenticated(_, let recoverySuggestion, _):
            return recoverySuggestion
        case .notAuthorized(_, let recoverySuggestion, _):
            return recoverySuggestion
        case .unknown:
            return AmplifyErrorMessages.shouldNotHappenReportBugToAWS()
        }
    }

    public var underlyingError: Error? {
        switch self {
        case .identity(_, _, _, let underlyingError),
             .notAuthenticated(_, _, let underlyingError),
             .notAuthorized(_, _, let underlyingError),
             .unknown(_, let underlyingError):
            return underlyingError
        }
    }
}
