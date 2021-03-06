//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public protocol PredictionsSpeechToTextOperation: AmplifyOperation<PredictionsSpeechToTextRequest,
Void, SpeechToTextResult, PredictionsError> { }

public extension HubPayload.EventName.Predictions {
    static let speechToText = "Predictions.speechToText"
}
