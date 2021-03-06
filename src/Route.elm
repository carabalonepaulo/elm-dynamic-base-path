module Route exposing
    ( Route(..)
    , fromUrl
    , toString
    )

import Url exposing (Url)
import Url.Parser as Parser exposing (Parser)


type Route
    = Home
    | Projects
    | Tasks
    | Configuration
    | NotFound


parser : Parser (Route -> b) b
parser =
    Parser.oneOf
        [ Parser.map Home Parser.top
        , Parser.map Projects (Parser.s "projects")
        , Parser.map Tasks (Parser.s "tasks")
        , Parser.map Configuration (Parser.s "configuration")
        ]


fromUrl : String -> Url -> Route
fromUrl basePath url =
    { url | path = String.replace basePath "" url.path }
        |> Parser.parse parser
        |> Maybe.withDefault NotFound


toString : Route -> String
toString route =
    case route of
        Home ->
            ""

        Projects ->
            "projects"

        Tasks ->
            "tasks"

        Configuration ->
            "configuration"

        NotFound ->
            "not-found"
