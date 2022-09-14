module Control.Decode exposing
  ( Decoder, string, bool, int, float
  , nullable, list, array, dict, keyValuePairs, oneOrMore
  , field, at, index
  , maybe, oneOf
  , decodeString, decodeValue, Value, Error(..), errorToString
  , map, map2, map3, map4, map5, map6, map7, map8
  , lazy, value, null, succeed, fail, andThen
  )

import Array exposing (Array)
import Dict exposing (Dict)
import Control.Encode
import Json.Decode as JD


type Decoder a = Decoder

string : Decoder String
string = JD.string

bool : Decoder Bool
bool = JD.bool

int : Decoder Int
int = JD.int

float : Decoder Float
float = JD.float



-- DATA STRUCTURES

nullable : Decoder a -> Decoder (Maybe a)
nullable decoder =
  oneOf
    [ null Nothing
    , map Just decoder
    ]

list : Decoder a -> Decoder (List a)
list = JD.list

array : Decoder a -> Decoder (Array a)
array = JD.array

dict : Decoder a -> Decoder (Dict String a)
dict decoder =
  map Dict.fromList (JD.keyValuePairs decoder)

oneOrMore : (a -> List a -> value) -> Decoder a -> Decoder value
oneOrMore toValue decoder =
  list decoder
    |> andThen (oneOrMoreHelp toValue)

oneOrMoreHelp : (a -> List a -> value) -> List a -> Decoder value
oneOrMoreHelp toValue xs =
  case xs of
    [] ->
      fail "a ARRAY with at least ONE element"

    y :: ys ->
      succeed (toValue y ys)

field : String -> Decoder a -> Decoder a
field = JD.field

at : List String -> Decoder a -> Decoder a
at fields decoder =
    List.foldr field decoder fields

index : Int -> Decoder a -> Decoder a
index = JD.index

maybe : Decoder a -> Decoder (Maybe a)
maybe decoder =
  oneOf
    [ map Just decoder
    , succeed Nothing
    ]

oneOf : List (Decoder a) -> Decoder a
oneOf = JD.oneOf

map : (a -> value) -> Decoder a -> Decoder value
map = JD.map

map2 : (a -> b -> value) -> Decoder a -> Decoder b -> Decoder value
map2 = JD.map2

map3 : (a -> b -> c -> value) -> Decoder a -> Decoder b -> Decoder c -> Decoder value
map3 = JD.map3

decodeString : Decoder a -> String -> Result Error a
decodeString = JD.decodeString

decodeValue : Decoder a -> Value -> Result Error a
decodeValue = JD.decodeValue

type alias Value = Json.Encode.Value

type Error
  = Field String Error
  | Index Int Error
  | OneOf (List Error)
  | Failure String Value