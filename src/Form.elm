module Form exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)



-- MAIN


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    }


init : Model
init =
    Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewIsSame model.password model.passwordAgain
        , viewInputLength model.password
        , viewUsingLowercase model.password
        , viewUsingUppercase model.password
        , viewUsingNumber model.password
        ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
    input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewIsSame : String -> String -> Html msg
viewIsSame a b =
    if a == b then
        div [ style "color" "green" ] [ text "Password Re-enter: OK" ]

    else
        div [ style "color" "red" ] [ text "Password Re-enter: NG" ]


viewInputLength : String -> Html msg
viewInputLength p =
    div [] [ text ("password length: " ++ String.fromInt (String.length p)) ]


viewUsingLowercase : String -> Html msg
viewUsingLowercase model =
    if String.length model == 0 then
        div [ style "color" "red" ] [ text "Using Lowercase: NG" ]

    else if containsLowercase model then
        div [ style "color" "green" ] [ text "Using Lowercase: OK" ]

    else
        div [ style "color" "red" ] [ text "Using Lowercase: NG" ]


containsLowercase : String -> Bool
containsLowercase p =
    List.any (\s -> String.toLower s == s) (String.split "" p)


viewUsingUppercase : String -> Html msg
viewUsingUppercase model =
    if String.length model == 0 then
        div [ style "color" "red" ] [ text "Using Uppercase: NG" ]

    else if containsUppercase model then
        div [ style "color" "green" ] [ text "Using Uppercase: OK" ]

    else
        div [ style "color" "red" ] [ text "Using Uppercase: NG" ]


containsUppercase : String -> Bool
containsUppercase p =
    List.any (\s -> String.toUpper s == s) (String.split "" p)


viewUsingNumber : String -> Html msg
viewUsingNumber p =
    if containsNumber p then
        div [ style "color" "green" ] [ text "Using Number: OK" ]

    else
        div [ style "color" "red" ] [ text "Using Number: NG" ]


containsNumber : String -> Bool
containsNumber p =
    List.any (\s -> List.any (\t -> s == t) (String.split "" "1234567890")) (String.split "" p)
