module List.Signal where
{-| Shorthands for all of the standard list operations lifted onto signals

# Basics
@docs sigIsEmpty, sigLength, sigReverse, sigMember, sig2Member

# Sub-lists
@docs sigHead, sigFilter, sigTake, sigDrop

# Putting Lists Together
@docs sigRepeat, sigCons, (:::), sigAppend, (+++), sigConcat, sigIntersperse

# Taking Lists Apart
@docs sigPartition, sigUnzip

# Mapping
@docs sigMap, sig2Map2, sig3Map3, sig4Map4, sig5Map5

# Special Maps
@docs sigFilterMap, sigConcatMap, sigIndexedMap

# Folding
@docs sigFoldr, sigFoldl

# Special Folds
@docs sigSum, sigProduct, sigMaximum, sigMinimum, sigAll, sigAny, sigScanl

# Sorting
@docs sigSort, sigSortBy, sigSortWith

-}
import Signal (Signal)
import Signal
import List (..)

{-| Lifted version of `isEmpty`
-}
sigIsEmpty : Signal (List a) -> Signal Bool
sigIsEmpty = Signal.map isEmpty

{-| Lifted version of `length`
-}
sigLength : Signal (List a) -> Signal Int
sigLength = Signal.map length

{-| Lifted version of `reverse`
-}
sigReverse : Signal (List a) -> Signal (List a)
sigReverse = Signal.map reverse

{-| Unary-lifted version of `member`
-}
sigMember : a -> Signal (List a) -> Signal Bool
sigMember x = Signal.map (member x)

{-| Binary-lifted version of `member`
-}
sig2Member : Signal a -> Signal (List a) -> Signal Bool
sig2Member = Signal.map2 member

{-| Lifted version of `map`

    sigMap = Signal.map << List.map
-}
sigMap : (a -> b) -> Signal (List a) -> Signal (List b)
sigMap f = Signal.map (map f)

{-| Lifted version of `indexedMap`

    sigIndexedMap = Signal.map << List.indexedMap
-}
sigIndexedMap : (Int -> a -> b) -> Signal (List a) -> Signal (List b)
sigIndexedMap f = Signal.map (indexedMap f)

{-| Lifted version of `foldl`
-}
sigFoldl : (a -> b -> b) -> b -> Signal (List a) -> Signal b
sigFoldl f x = Signal.map (foldl f x)

{-| Lifted version of `foldr`
-}
sigFoldr : (a -> b -> b) -> b -> Signal (List a) -> Signal b
sigFoldr f x = Signal.map (foldr f x)

{-| Lifted version of `scanl`
-}
sigScanl : (a -> b -> b) -> b -> Signal (List a) -> Signal (List b)
sigScanl f x = Signal.map (scanl f x)

{-| Lifted version of `filter`
-}
sigFilter : (a -> Bool) -> Signal (List a) -> Signal (List a)
sigFilter pred = Signal.map (filter pred)

{-| Lifted version of `filterMap`
-}
sigFilterMap : (a -> Maybe b) -> Signal (List a) -> Signal (List b)
sigFilterMap f = Signal.map (filterMap f)

{-| Lifted version of `all`
-}
sigAll : (a -> Bool) -> Signal (List a) -> Signal Bool
sigAll pred = Signal.map (all pred)

{-| Lifted version of `any`
-}
sigAny : (a -> Bool) -> Signal (List a) -> Signal Bool
sigAny pred = Signal.map (any pred)

{-| Unary-lifted version of `(::)`
-}
sigCons : a -> Signal (List a) -> Signal (List a)
sigCons x = Signal.map ((::) x)

{-| Binary-lifted version of `(::)`
-}
(:::) : Signal a -> Signal (List a) -> Signal (List a)
(:::) = Signal.map2 (::)

infixr 5 :::

{-| Lifted version of `head`
-}
-- sigHead : Signal (List a) -> Signal (Maybe a)
sigHead : Signal (List a) -> Signal a
sigHead = Signal.map head

{-| Unary-lifted version of `append` and (++)
-}
sigAppend : List a -> Signal (List a) -> Signal (List a)
sigAppend xs = Signal.map (append xs)

{-| Binary-lifted version of `(++)`
-}
(+++) : Signal (List a) -> Signal (List a) -> Signal (List a)
(+++) = Signal.map2 (++)

infixr 5 +++

{-| Lifted version of `concat`
-}
sigConcat : Signal (List (List a)) -> Signal (List a)
sigConcat = Signal.map concat

{-| Lifted version of `concatMap`
-}
sigConcatMap : (a -> List b) -> Signal (List a) -> Signal (List b)
sigConcatMap f = Signal.map (concatMap f)

{-| Lifted version of `sum`
-}
sigSum : Signal (List number) -> Signal number
sigSum = Signal.map sum

{-| Lifted version of `product`
-}
sigProduct : Signal (List number) -> Signal number
sigProduct = Signal.map product

{-| Lifted version of `maximum`
-}
-- sigMaximum : Signal (List comparable) -> Signal (Maybe comparable)
sigMaximum : Signal (List comparable) -> Signal comparable
sigMaximum = Signal.map maximum

{-| Lifted version of `minimum`
-}
-- sigMinimum : Signal (List comparable) -> Signal (Maybe comparable)
sigMinimum : Signal (List comparable) -> Signal comparable
sigMinimum = Signal.map minimum

{-| Lifted version of `partition`
-}
sigPartition : (a -> Bool) -> Signal (List a) -> Signal (List a, List a)
sigPartition pred = Signal.map (partition pred)

{-| Binary-, ternary-, etc-, lifted versions of `map2`, `map3`, `map4`, `map5`
-}
sig2Map2 : (a -> b -> result) -> Signal (List a) -> Signal (List b) -> Signal (List result)
sig2Map2 f = Signal.map2 (map2 f)

sig3Map3 : (a -> b -> c -> result) -> Signal (List a) -> Signal (List b) -> Signal (List c) -> Signal (List result)
sig3Map3 f = Signal.map3 (map3 f)

sig4Map4 : (a -> b -> c -> d -> result) -> Signal (List a) -> Signal (List b) -> Signal (List c) -> Signal (List d) -> Signal (List result)
sig4Map4 f = Signal.map4 (map4 f)

sig5Map5 : (a -> b -> c -> d -> e -> result) -> Signal (List a) -> Signal (List b) -> Signal (List c) -> Signal (List d) -> Signal (List e) -> Signal (List result)
sig5Map5 f = Signal.map5 (map5 f)

{-| Lifted version of `unzip`
-}
sigUnzip : Signal (List (a,b)) -> Signal (List a, List b)
sigUnzip = Signal.map unzip

{-| Lifted version of `intersperse`
-}
sigIntersperse : a -> Signal (List a) -> Signal (List a)
sigIntersperse sep = Signal.map (intersperse sep)

{-| Lifted version of `take`
-}
sigTake : Int -> Signal (List a) -> Signal (List a)
sigTake k = Signal.map (take k)

{-| Lifted version of `drop`
-}
sigDrop : Int -> Signal (List a) -> Signal (List a)
sigDrop k = Signal.map (drop k)

{-| Lifted version of `repeat`
-}
sigRepeat : Int -> Signal a -> Signal (List a)
sigRepeat k = Signal.map (repeat k)

{-| Lifted version of `sort`
-}
sigSort : Signal (List comparable) -> Signal (List comparable)
sigSort = Signal.map sort

{-| Lifted version of `sortBy`
-}
sigSortBy : (a -> comparable) ->  Signal (List a) -> Signal (List a)
sigSortBy f = Signal.map (sortBy f)

{-| Lifted version of `sortWith`
-}
sigSortWith : (a -> a -> Order) -> Signal (List a) -> Signal (List a)
sigSortWith f = Signal.map (sortWith f)
