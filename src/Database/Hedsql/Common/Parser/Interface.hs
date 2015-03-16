{-# LANGUAGE GADTs           #-}
{-# LANGUAGE TemplateHaskell #-}

{-|
Module      : Database/Hedsql/Common/Parser/Interface.hs
Description : SQL parser interface.
Copyright   : (c) Leonard Monnier, 2014
License     : GPL-3
Maintainer  : leonard.monnier@gmail.com
Stability   : experimental
Portability : portable

Define the high level functionalities of a SQL Parser.

The Parser definition is very generic as more specialized parts can later
be defined for each component thanks to currying.

For example, for parseSelect we could define a function with the following
type signature:

> parseSelectFunc :: QueryParser a -> Select a b -> String

Then, when constructing a parser, we can provide to that function 
a dedicated QueryParser. This parser can then have specialized functions
for each element of a SELECT statement such as:

> data QueryParser a = QueryParser
>    { _parseFrom  :: From a  -> String
>    , _parseWhere :: Where a -> String
>    , etc.
>    }
-}
module Database.Hedsql.Common.Parser.Interface
    ( Parser(Parser)
    , parseStmt
    ) where

--------------------------------------------------------------------------------
-- IMPORTS
--------------------------------------------------------------------------------

import Database.Hedsql.Common.DataStructure

import Control.Lens

--------------------------------------------------------------------------------
-- PUBLIC
--------------------------------------------------------------------------------

{-|
Interface which defines the top level functions of a SQL Parser.
-}
data Parser a = Parser
    { _parseStmt :: Statement a -> String
    }
    
makeLenses ''Parser