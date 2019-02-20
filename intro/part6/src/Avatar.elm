module Avatar exposing (Avatar, decoder, encode, src, toMaybeString)

import Asset
import Html exposing (Attribute)
import Html.Attributes
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)



-- TYPES


type Avatar
    = Avatar (Maybe String)



-- CREATE


decoder : Decoder Avatar
decoder =
    Decode.map Avatar (Decode.nullable Decode.string)



-- TRANSFORM


src : Avatar -> Attribute msg
src (Avatar maybeUrl) =
    Html.Attributes.src <|
        if maybeUrl == Just "" then
            resolveAvatarUrl Nothing

        else
            resolveAvatarUrl maybeUrl


resolveAvatarUrl : Maybe String -> String
resolveAvatarUrl maybeUrl =
    Maybe.withDefault "https://static.productionready.io/images/smiley-cyrus.jpg" maybeUrl



{- 👉 TODO #1 of 2: return the user's avatar from maybeUrl, if maybeUrl actually
   contains one. If maybeUrl is Nothing, return this URL instead:


-}


encode : Avatar -> Value
encode (Avatar maybeUrl) =
    case maybeUrl of
        Just url ->
            Encode.string url

        Nothing ->
            Encode.null


toMaybeString : Avatar -> Maybe String
toMaybeString (Avatar maybeUrl) =
    maybeUrl
