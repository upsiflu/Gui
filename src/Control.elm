module Control exposing (Face(..), grow, sheet, form, button, fieldset, group, trigger,column, row, raster, mergedGroup, togglebutton)





import Html exposing (Html)
import Html.Attributes exposing (class, attribute, title)
import Html.Events exposing (onClick)




type Face
    = Iconic String
    | Textual String





-- VIEW --

raster : Html msg
raster = Html.div [class "raster"] []

face : Face -> Html msg
face f =
    case f of   
        Iconic t ->
            Html.div [class "face iconic"] 
                [Html.span [class "material-symbols-sharp"] [Html.text t]]
        Textual t ->
            Html.span [class "face textual"]
             [Html.span [class ""] [Html.text t]]
        


button : Face -> Html msg
button f =
    Html.button []
        [ face f ]

trigger : Face -> Result String msg -> Html msg
trigger f m =
    
        case m of
            Ok mm -> Html.button  [onClick mm] [ face f ]
            Err str -> Html.button [attribute "aria-disabled" "true", title str]
                [ face f, Html.span [class "tooltip"] [Html.text str] ]
        
        

togglebutton : Face -> Bool -> Bool -> Html msg
togglebutton f isPressed isDisabled =
    Html.button [attribute "aria-pressed" (if isPressed then "true" else "false"), attribute "aria-disabled" (if isDisabled then "true" else "false")]
        [face f]


fieldset : Face -> List (Html msg) -> Html msg
fieldset f cc =
    Html.fieldset [class "dense chrome"]
        ( Html.legend [] [face f]
        :: cc )

group : List (Html msg) -> Html msg
group =
    Html.div [class "group"]

mergedGroup : List (Html msg) -> Html msg
mergedGroup =
    Html.div [class "group merged"]


row : List (Html msg) -> Html msg
row =
    Html.div [class "row"]

column : List (Html msg) -> Html msg
column =
    Html.div [class "column"]

grow : List (Html msg) -> Html msg
grow =
    Html.div [class "grow"]

form : List (Html msg) -> Html msg
form =
    Html.form []

sheet : List (Html msg) -> Html msg
sheet =
    Html.div [class "sheet"]