// DO NOT EDIT.
// swift-format-ignore-file
// swiftlint:disable all
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: MobileCoinExternal.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

// Copyright (c) 2018-2022 The MobileCoin Foundation

// Copied from MobileCoin-Swift/Vendor/libmobilecoin/Vendor/mobilecoin/api/proto/external.proto

// MUST BE KEPT IN SYNC WITH RUST CODE!

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

//// A 32-byte compressed Ristretto curve point (public key)
struct External_CompressedRistretto: @unchecked Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var data: Data = Data()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

//// A public address, used to identify recipients.
struct External_PublicAddress: @unchecked Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  //// View public key
  var viewPublicKey: External_CompressedRistretto {
    get {return _viewPublicKey ?? External_CompressedRistretto()}
    set {_viewPublicKey = newValue}
  }
  /// Returns true if `viewPublicKey` has been explicitly set.
  var hasViewPublicKey: Bool {return self._viewPublicKey != nil}
  /// Clears the value of `viewPublicKey`. Subsequent reads from it will return its default value.
  mutating func clearViewPublicKey() {self._viewPublicKey = nil}

  //// Spend public key
  var spendPublicKey: External_CompressedRistretto {
    get {return _spendPublicKey ?? External_CompressedRistretto()}
    set {_spendPublicKey = newValue}
  }
  /// Returns true if `spendPublicKey` has been explicitly set.
  var hasSpendPublicKey: Bool {return self._spendPublicKey != nil}
  /// Clears the value of `spendPublicKey`. Subsequent reads from it will return its default value.
  mutating func clearSpendPublicKey() {self._spendPublicKey = nil}

  //// Optional url of fog report server.
  //// Empty string when not in use, i.e. for accounts that don't have fog service.
  //// Indicates the place at which the fog report server should be contacted.
  var fogReportURL: String = String()

  //// Optional fog report id.
  //// The fog report server may serve multiple reports, this id disambiguates
  //// which one to use when sending to this account.
  var fogReportID: String = String()

  //// View key signature over the fog authority subjectPublicKeyInfo.
  ////
  //// This must be parseable as a RistrettoSignature.
  var fogAuthoritySig: Data = Data()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _viewPublicKey: External_CompressedRistretto? = nil
  fileprivate var _spendPublicKey: External_CompressedRistretto? = nil
}

/// A hash of the shared secret of a transaction output.
///
/// Can be used by the recipient of a transaction output to verify that the
/// bearer of this number knew the shared secret of the transaction output,
/// thereby providing evidence that they are the sender.
struct External_TxOutConfirmationNumber: @unchecked Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var hash: Data = Data()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

/// MaskedAmount.
struct External_MaskedAmount: @unchecked Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// A Pedersen commitment `v*G + s*H`
  var commitment: External_CompressedRistretto {
    get {return _commitment ?? External_CompressedRistretto()}
    set {_commitment = newValue}
  }
  /// Returns true if `commitment` has been explicitly set.
  var hasCommitment: Bool {return self._commitment != nil}
  /// Clears the value of `commitment`. Subsequent reads from it will return its default value.
  mutating func clearCommitment() {self._commitment = nil}

  /// `masked_value = value XOR_8 Blake2B("value_mask" || shared_secret)`
  var maskedValue: UInt64 = 0

  /// `masked_token_id = token_id XOR_8 Blake2B("token_id_mask" || shared_secret)`
  var maskedTokenID: Data = Data()

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _commitment: External_CompressedRistretto? = nil
}

/// Given to the recipient of a transaction output by the sender so that the
/// recipient may verify that the other party is indeed the sender.
///
/// Often given to the recipient before the transaction is finalized so that
/// the recipient may know to anticipate the arrival of a transaction output,
/// as well as know who it's from, when to consider it as having surpassed
/// the tombstone block, and the expected amount of the output.
struct External_Receipt: Sendable {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// Public key of the TxOut.
  var publicKey: External_CompressedRistretto {
    get {return _publicKey ?? External_CompressedRistretto()}
    set {_publicKey = newValue}
  }
  /// Returns true if `publicKey` has been explicitly set.
  var hasPublicKey: Bool {return self._publicKey != nil}
  /// Clears the value of `publicKey`. Subsequent reads from it will return its default value.
  mutating func clearPublicKey() {self._publicKey = nil}

  /// Confirmation number of the TxOut.
  var confirmation: External_TxOutConfirmationNumber {
    get {return _confirmation ?? External_TxOutConfirmationNumber()}
    set {_confirmation = newValue}
  }
  /// Returns true if `confirmation` has been explicitly set.
  var hasConfirmation: Bool {return self._confirmation != nil}
  /// Clears the value of `confirmation`. Subsequent reads from it will return its default value.
  mutating func clearConfirmation() {self._confirmation = nil}

  /// Tombstone block of the Tx that produced the TxOut.
  /// Note: This value is self-reported by the sender and is unverifiable.
  var tombstoneBlock: UInt64 = 0

  /// Amount of the TxOut.
  /// Note: This value is self-reported by the sender and is unverifiable.
  var maskedAmount: External_Receipt.OneOf_MaskedAmount? = nil

  var maskedAmountV1: External_MaskedAmount {
    get {
      if case .maskedAmountV1(let v)? = maskedAmount {return v}
      return External_MaskedAmount()
    }
    set {maskedAmount = .maskedAmountV1(newValue)}
  }

  var maskedAmountV2: External_MaskedAmount {
    get {
      if case .maskedAmountV2(let v)? = maskedAmount {return v}
      return External_MaskedAmount()
    }
    set {maskedAmount = .maskedAmountV2(newValue)}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  /// Amount of the TxOut.
  /// Note: This value is self-reported by the sender and is unverifiable.
  enum OneOf_MaskedAmount: Equatable, Sendable {
    case maskedAmountV1(External_MaskedAmount)
    case maskedAmountV2(External_MaskedAmount)

  }

  init() {}

  fileprivate var _publicKey: External_CompressedRistretto? = nil
  fileprivate var _confirmation: External_TxOutConfirmationNumber? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "external"

extension External_CompressedRistretto: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".CompressedRistretto"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "data"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.data) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.data.isEmpty {
      try visitor.visitSingularBytesField(value: self.data, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: External_CompressedRistretto, rhs: External_CompressedRistretto) -> Bool {
    if lhs.data != rhs.data {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension External_PublicAddress: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".PublicAddress"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "view_public_key"),
    2: .standard(proto: "spend_public_key"),
    3: .standard(proto: "fog_report_url"),
    4: .standard(proto: "fog_report_id"),
    5: .standard(proto: "fog_authority_sig"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._viewPublicKey) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._spendPublicKey) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.fogReportURL) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.fogReportID) }()
      case 5: try { try decoder.decodeSingularBytesField(value: &self.fogAuthoritySig) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._viewPublicKey {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._spendPublicKey {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    if !self.fogReportURL.isEmpty {
      try visitor.visitSingularStringField(value: self.fogReportURL, fieldNumber: 3)
    }
    if !self.fogReportID.isEmpty {
      try visitor.visitSingularStringField(value: self.fogReportID, fieldNumber: 4)
    }
    if !self.fogAuthoritySig.isEmpty {
      try visitor.visitSingularBytesField(value: self.fogAuthoritySig, fieldNumber: 5)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: External_PublicAddress, rhs: External_PublicAddress) -> Bool {
    if lhs._viewPublicKey != rhs._viewPublicKey {return false}
    if lhs._spendPublicKey != rhs._spendPublicKey {return false}
    if lhs.fogReportURL != rhs.fogReportURL {return false}
    if lhs.fogReportID != rhs.fogReportID {return false}
    if lhs.fogAuthoritySig != rhs.fogAuthoritySig {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension External_TxOutConfirmationNumber: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".TxOutConfirmationNumber"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "hash"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularBytesField(value: &self.hash) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.hash.isEmpty {
      try visitor.visitSingularBytesField(value: self.hash, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: External_TxOutConfirmationNumber, rhs: External_TxOutConfirmationNumber) -> Bool {
    if lhs.hash != rhs.hash {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension External_MaskedAmount: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".MaskedAmount"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "commitment"),
    2: .standard(proto: "masked_value"),
    3: .standard(proto: "masked_token_id"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._commitment) }()
      case 2: try { try decoder.decodeSingularFixed64Field(value: &self.maskedValue) }()
      case 3: try { try decoder.decodeSingularBytesField(value: &self.maskedTokenID) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._commitment {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    if self.maskedValue != 0 {
      try visitor.visitSingularFixed64Field(value: self.maskedValue, fieldNumber: 2)
    }
    if !self.maskedTokenID.isEmpty {
      try visitor.visitSingularBytesField(value: self.maskedTokenID, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: External_MaskedAmount, rhs: External_MaskedAmount) -> Bool {
    if lhs._commitment != rhs._commitment {return false}
    if lhs.maskedValue != rhs.maskedValue {return false}
    if lhs.maskedTokenID != rhs.maskedTokenID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension External_Receipt: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = _protobuf_package + ".Receipt"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "public_key"),
    2: .same(proto: "confirmation"),
    3: .standard(proto: "tombstone_block"),
    4: .standard(proto: "masked_amount_v1"),
    5: .standard(proto: "masked_amount_v2"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._publicKey) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._confirmation) }()
      case 3: try { try decoder.decodeSingularUInt64Field(value: &self.tombstoneBlock) }()
      case 4: try {
        var v: External_MaskedAmount?
        var hadOneofValue = false
        if let current = self.maskedAmount {
          hadOneofValue = true
          if case .maskedAmountV1(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.maskedAmount = .maskedAmountV1(v)
        }
      }()
      case 5: try {
        var v: External_MaskedAmount?
        var hadOneofValue = false
        if let current = self.maskedAmount {
          hadOneofValue = true
          if case .maskedAmountV2(let m) = current {v = m}
        }
        try decoder.decodeSingularMessageField(value: &v)
        if let v = v {
          if hadOneofValue {try decoder.handleConflictingOneOf()}
          self.maskedAmount = .maskedAmountV2(v)
        }
      }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._publicKey {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try { if let v = self._confirmation {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    if self.tombstoneBlock != 0 {
      try visitor.visitSingularUInt64Field(value: self.tombstoneBlock, fieldNumber: 3)
    }
    switch self.maskedAmount {
    case .maskedAmountV1?: try {
      guard case .maskedAmountV1(let v)? = self.maskedAmount else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    }()
    case .maskedAmountV2?: try {
      guard case .maskedAmountV2(let v)? = self.maskedAmount else { preconditionFailure() }
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    }()
    case nil: break
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: External_Receipt, rhs: External_Receipt) -> Bool {
    if lhs._publicKey != rhs._publicKey {return false}
    if lhs._confirmation != rhs._confirmation {return false}
    if lhs.tombstoneBlock != rhs.tombstoneBlock {return false}
    if lhs.maskedAmount != rhs.maskedAmount {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
