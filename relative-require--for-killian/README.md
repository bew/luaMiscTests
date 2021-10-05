## Working relative package require for Lua :heart:

Works without the debug module (no unsafe operations) and without global,
so it can be used in a concurent system like coroutines.

A toplevel require uses the format `dir_prefix://module.name`
Then all modules required by `dir_prefix.module.name` will have
`./dir_prefix` as a valid package path.

So `dir_prefix.module.name` can require `dir_prefix.module.other_name`
by doing `require "module.other_name"`
