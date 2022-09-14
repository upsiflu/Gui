module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text, h1, h2, h3, p, em, fieldset, legend)
import Html.Events exposing (onClick)
import Control


type alias Model =
    { count : Int }


initialModel : Model
initialModel =
    { count = 0 }


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }


view : Model -> Html Msg
view model =
    div []
    [
    h1 [] [text "Heading"]
        , p [] [text "Abra Cadabra, lorem Ipsum dolor sit amet, e pluribus nos antamaricos Primerut -- Salut!"]
        , Control.sheet
        [Control.fieldset (Control.Textual "Add numbers and count to one")
        [ Control.row
            [ Control.trigger (Control.Textual "Add one") (Ok Increment)
            , Control.grow [ Html.span [] [text <| String.fromInt model.count] ]
            , Control.trigger (Control.Textual "Decrement") (Ok Decrement)
            , Control.trigger (Control.Textual "Divide by Zero") (Err "No!")
            , Control.trigger (Control.Textual "Divide by Zero") (Err "This is very much and very long and also quite really impossible")
            ]
        , Control.row [
            Control.column [Control.raster, Control.raster, Control.raster, Control.raster, Control.raster, Control.raster, Control.raster, Control.raster]
        , Control.column [
             Control.row [Control.button (Control.Iconic "save")]
            , Control.row [Control.raster, Control.raster, Control.raster, Control.raster, Control.raster]
            , Control.row [
                Control.button (Control.Iconic "save")
                ,Control.mergedGroup 
                [ Control.button (Control.Iconic "cut")
                , Control.button (Control.Iconic "content_copy")
                , Control.button (Control.Iconic "content_paste") 
                ]
                , Control.button (Control.Iconic "delete")
            ]
            , Control.row [
                Control.button (Control.Iconic "save")
                ,Control.mergedGroup 
                [ Control.togglebutton (Control.Iconic "cut") True False
                , Control.togglebutton (Control.Iconic "content_copy") False False
                , Control.togglebutton (Control.Iconic "content_paste") False True
                , Control.togglebutton (Control.Iconic "cut") True True
                ]
                , Control.button (Control.Iconic "delete")
            ]
            , Control.row [
                Control.button (Control.Iconic "save")
                ,Control.group 
                [ Control.button (Control.Iconic "cut")
                , Control.button (Control.Iconic "content_copy")
                , Control.button (Control.Iconic "content_paste") 
                ]
                , Control.button (Control.Iconic "delete")
            ]
            , Control.row [
                Control.button (Control.Iconic "save")
                , Control.button (Control.Iconic "delete")
                , Control.button (Control.Iconic "save")
                , Control.button (Control.Iconic "delete")
                , Control.button (Control.Iconic "save")
                , Control.button (Control.Iconic "delete")
                ]
            , Control.raster, Control.raster
            ]
        ]]]]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
