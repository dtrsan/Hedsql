{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-} 

{-|
Module      : Database/Hedsql/Common/Constructor/Statements.hs
Description : Constructor functions for statements.
Copyright   : (c) Leonard Monnier, 2014
License     : GPL-3
Maintainer  : leonard.monnier@gmail.com
Stability   : experimental
Portability : portable

Constructor functions for SQL statements which can then be parsed.
-}
module Database.Hedsql.Common.Constructor.Statements
    ( CoerceToStmt
    , statement
    , statements
    ) where

import Database.Hedsql.Common.DataStructure

-- private functions.

class CoerceToStmt a b where
    coerceToStmt :: a c -> b c

instance CoerceToStmt Table Statement where
    coerceToStmt = CreateTableStmt

instance CoerceToStmt CreateView Statement where
    coerceToStmt = CreateViewStmt

instance CoerceToStmt Delete Statement where
    coerceToStmt = DeleteStmt

instance CoerceToStmt DropTable Statement where
    coerceToStmt = DropTableStmt

instance CoerceToStmt DropView Statement where
    coerceToStmt = DropViewStmt

instance CoerceToStmt Insert Statement where
    coerceToStmt = InsertStmt

instance CoerceToStmt Select Statement where
    coerceToStmt = SelectStmt
    
instance CoerceToStmt Update Statement where
    coerceToStmt = UpdateStmt

-- public functions.

-- | Create a statement.
statement :: CoerceToStmt a Statement => a b -> Statement b
statement = coerceToStmt

statements :: CoerceToStmt a Statement => [a b] -> [Statement b]
statements = map statement