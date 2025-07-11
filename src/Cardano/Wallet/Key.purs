module Cardano.Wallet.Key
  ( KeyWallet(KeyWallet)
  , DataSignature
  , PrivateDrepKey(PrivateDrepKey)
  , PrivatePaymentKey(PrivatePaymentKey)
  , PrivateStakeKey(PrivateStakeKey)
  , privateKeyToPkh
  , privateKeyToPkhCred
  , privateKeysToAddress
  , privateKeysToKeyWallet
  , getPrivateDrepKey
  , getPrivatePaymentKey
  , getPrivateStakeKey
  ) where

import Prelude

import Aeson
  ( class DecodeAeson
  , class EncodeAeson
  )
import Cardano.Types.Address (Address)
import Cardano.Types.CborBytes (CborBytes)
import Cardano.Types.Coin (Coin)
import Cardano.Types.Credential (Credential)
import Cardano.Types.Ed25519KeyHash (Ed25519KeyHash)
import Cardano.Types.NetworkId (NetworkId)
import Cardano.Types.PrivateKey (PrivateKey)
import Cardano.Types.RawBytes (RawBytes)
import Cardano.Types.Transaction (Transaction)
import Cardano.Types.TransactionUnspentOutput (TransactionUnspentOutput)
import Cardano.Types.TransactionWitnessSet (TransactionWitnessSet)
import Cardano.Types.UtxoMap (UtxoMap)
import Data.Maybe (Maybe)
import Data.Newtype (class Newtype)
import Effect.Aff (Aff)

import Partial.Unsafe (unsafeCrashWith)

-------------------------------------------------------------------------------
-- Key backend
-------------------------------------------------------------------------------

-- | An interface that wraps `PrivateKey`s. Used in CTL.
-- | Technically, can be implemented with remote calls, e.g. over HTTP,
-- | to provide signing services without revealing the private key.
newtype KeyWallet = KeyWallet
  { address :: NetworkId -> Aff Address
  , selectCollateral ::
      Coin
      -- ^ Minimum required collateral
      -> Coin
      -- ^ Lovelace per UTxO byte parameter
      -> Int
      -- ^ Maximum number of collateral inputs (use 3)
      -> UtxoMap
      -- ^ UTxOs to select from
      -> Aff (Maybe (Array TransactionUnspentOutput))
  , signTx :: Transaction -> Aff TransactionWitnessSet
  , signData :: Address -> RawBytes -> Aff (Maybe DataSignature)
  , paymentKey :: Aff PrivatePaymentKey
  , stakeKey :: Aff (Maybe PrivateStakeKey)
  , drepKey :: Aff (Maybe PrivateDrepKey)
  }

derive instance Newtype KeyWallet _

type DataSignature =
    { key :: CborBytes
    , signature :: CborBytes
    }


newtype PrivatePaymentKey = PrivatePaymentKey PrivateKey

derive instance Newtype PrivatePaymentKey _

instance Show PrivatePaymentKey where
  show _ = "(PrivatePaymentKey <hidden>)"

instance EncodeAeson PrivatePaymentKey where
  encodeAeson (PrivatePaymentKey _) = unsafeCrashWith "not implemented"

instance DecodeAeson PrivatePaymentKey where
  decodeAeson _ = unsafeCrashWith "not implemented"

newtype PrivateStakeKey = PrivateStakeKey PrivateKey

derive instance Newtype PrivateStakeKey _

instance Show PrivateStakeKey where
  show _ = "(PrivateStakeKey <hidden>)"

instance EncodeAeson PrivateStakeKey where
  encodeAeson (PrivateStakeKey _) = unsafeCrashWith "not implemented"

instance DecodeAeson PrivateStakeKey where
  decodeAeson _ = unsafeCrashWith "not implemented"

newtype PrivateDrepKey = PrivateDrepKey PrivateKey

derive instance Newtype PrivateDrepKey _

instance Show PrivateDrepKey where
  show _ = "(PrivateDrepKey <hidden>)"

instance EncodeAeson PrivateDrepKey where
  encodeAeson (PrivateDrepKey _) = unsafeCrashWith "not implemented"

instance DecodeAeson PrivateDrepKey where
  decodeAeson _ = unsafeCrashWith "not implemented"

privateKeyToPkh :: forall t. Newtype t PrivateKey => t -> Ed25519KeyHash
privateKeyToPkh _ = unsafeCrashWith "privateKeyToPkh: not implemented"

privateKeyToPkhCred :: forall t. Newtype t PrivateKey => t -> Credential
privateKeyToPkhCred _ = unsafeCrashWith "privateKeyToPkhCred: not implemented"

getPrivatePaymentKey :: KeyWallet -> Aff PrivatePaymentKey
getPrivatePaymentKey _ = unsafeCrashWith "getPrivatePaymentKey: not implemented"

getPrivateStakeKey :: KeyWallet -> Aff (Maybe PrivateStakeKey)
getPrivateStakeKey _ = unsafeCrashWith "getPrivateStakeKey: not implemented"

getPrivateDrepKey :: KeyWallet -> Aff (Maybe PrivateDrepKey)
getPrivateDrepKey _ = unsafeCrashWith "getPrivateDrepKey: not implemented"

privateKeysToAddress
  :: PrivatePaymentKey -> Maybe PrivateStakeKey -> NetworkId -> Address
privateKeysToAddress _ _ _ = unsafeCrashWith "privateKeysToAddress: not implemented"

privateKeysToKeyWallet
  :: PrivatePaymentKey
  -> Maybe PrivateStakeKey
  -> Maybe PrivateDrepKey
  -> KeyWallet
privateKeysToKeyWallet _ _ _ = unsafeCrashWith "privateKeysToAddress: not implemented"

