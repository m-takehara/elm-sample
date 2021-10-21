module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = init, update = update, view = view }


type alias Model =
    { count : Int, message : String }


init : Model
init =
    { count = 0, message = "This is empty" }


type Msg
    = Increment
    | Decrement
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { count = model.count + 1, message = "You increased." }

        Decrement ->
            { count = model.count - 1, message = "You decreased." }

        Reset ->
            { count = 0, message = "You resetted." }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Reset, style "margin" "0px 20px" ] [ text "RESET" ]
        , button [ onClick Increment, style "margin" "0px 20px" ] [ text "+" ]
        , button [ onClick Decrement, style "margin" "0px 20px" ] [ text "-" ]
        , div [] [ text (String.fromInt model.count) ]
        , div [] [ text model.message ]
        ]
