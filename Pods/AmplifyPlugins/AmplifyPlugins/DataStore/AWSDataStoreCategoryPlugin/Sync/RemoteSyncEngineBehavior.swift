//
// Copyright 2018-2020 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import Combine

enum RemoteSyncEngineEvent {
    case storageAdapterAvailable
    case subscriptionsPaused
    case mutationsPaused
    case subscriptionsInitialized
    case performedInitialSync
    case subscriptionsActivated
    case mutationQueueStarted
    case syncStarted
    case cleanedUp
    case cleanedUpForTermination
    case mutationEvent(MutationEvent)
}

/// Behavior to sync mutation events to the remote API, and to subscribe to mutations from the remote API
protocol RemoteSyncEngineBehavior: class {

    /// Start the sync process with a "delta sync" merge
    ///
    /// The order of the startup sequence is important:
    /// 1. Subscription and Mutation processing to the network are paused
    /// 1. Subscription connections are established and incoming messages are written to a queue
    /// 1. Queries are run and objects applied to the Datastore
    /// 1. Subscription processing runs off the queue and flows as normal, reconciling any items against
    ///    the updates in the Datastore
    /// 1. Mutation processor drains messages off the queue in serial and sends to the service, invoking
    ///    any local callbacks on error if necessary
    func start(api: APICategoryGraphQLBehavior)

    func stop(completion: @escaping DataStoreCallback<Void>)

    /// Submits a new mutation for synchronization to the remote API. The response will be handled by the appropriate
    /// reconciliation queue
    @available(iOS 13.0, *)
    func submit(_ mutationEvent: MutationEvent) -> Future<MutationEvent, DataStoreError>

    @available(iOS 13.0, *)
    var publisher: AnyPublisher<RemoteSyncEngineEvent, DataStoreError> { get }
}
