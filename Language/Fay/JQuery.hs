{-# LANGUAGE EmptyDataDecls #-}
{-# LANGUAGE NoImplicitPrelude #-}

module Language.Fay.JQuery  where

import Language.Fay.Prelude
import Language.Fay.FFI

data JQuery
instance Foreign JQuery
instance Show JQuery

ready :: Fay () -> Fay ()
ready = ffi "window['jQuery'](%1)"
