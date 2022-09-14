# Restrictive UI - Example app

The Restrictive Gui separates the Ui state from the Model and persists it in a query.

To integrate it into your app, you can convert your views to output `Ui` and compose them to a single global Gui. In your main view function, you can map the composed Ui into Html by providing

- the current `Query` part of the `Url`
- a message of type `Query -> msg` that will override the query in your global `update`.

Since the Url persists throughout the session, the Ui tree doesn't need to store state. Instead, each change of Ui state will bubble upwards in the tree, accumulating its position as a list of hexadecimal values. These are stored in the query.


## Unit
```elm
type Ui
    = Ui Face (List Item)
```
## State
```elm
type Handle
    = Toggle Ui     --Bool
    | Switch Ui Ui  --Either
    | One (List Ui) Ui (List Ui) --One-hole zipper
```

## Composing
```elm
type alias Item
    = { state : Handle
      , scene : (String, Html msg)
      , snack : Html msg
      , sheet : Html msg
      }
```
|       | Information       | Persistence
|-|-|-|-
| State | User location     | Url  | separate from your model
| Scene | Objects/Document  | Sync | Model
| Snack | Tipps/Feedback    | -    | (Volatile)
| Sheet | Properties/Config | Sync | User-Config, Tool or Model

# Features

1. Separate the state of the Ui from the state of the model
2. Select and compose controls according to type:
    - Exhaustive
    - Predictable
    - Conventional

The latter feature should be in a separate library probably.