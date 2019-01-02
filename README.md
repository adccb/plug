# plug

this is how i track what medicine i have on hand right now. you can use this to track whatever the concept of a "dose" is for you.

## api

`usage: plug [options]`

`plug -i` will show you your `inventory` and the number of doses you have available.

required options:
`-s STRAIN, --strain=STRAIN`: specify what strain you're talking about.
`-q QUANTITY, --quantity=QUANTITY`: specify the number of doses to add or subtract

also required: one of the following.
`-r, --roll`: add to your total (as in, "rolling a joint")
`-s, --smoke`: subtract from your total

and there you have it!

`plug` will persist data on your machine, in `~/.plug/manifest.json`. if you misplace or damage `manifest.json`, `plug` will have no way to know what you have on hand.
